import { closeSync, openSync, writeSync } from "node:fs";
import type {
	ExtensionCommandHandler,
	HunkExtensionAPI,
} from "hunkdiff/extension";

/**
 * Extracts one hunk's raw text, from its `@@` header through its last body line, from a file's
 * patch.
 *
 * Hunk ordinals follow the `@@` lines in the file patch, which is the same order the parsed
 * `metadata.hunks` array uses.
 */
export function extractHunk(
	filePatch: string,
	hunkIndex: number,
): string | undefined {
	if (!Number.isInteger(hunkIndex) || hunkIndex < 0) {
		return undefined;
	}

	const lines = filePatch.replaceAll("\r\n", "\n").split("\n");
	while (lines.length > 0 && lines[lines.length - 1] === "") {
		lines.pop();
	}

	// Body lines always carry a ` `, `+`, `-`, or `\` prefix, so only hunk headers start with `@@`.
	const hunkStarts = lines.flatMap((line, index) =>
		line.startsWith("@@") ? [index] : [],
	);
	const start = hunkStarts[hunkIndex];
	if (start === undefined) {
		return undefined;
	}

	const end = hunkStarts[hunkIndex + 1] ?? lines.length;
	return `${lines.slice(start, end).join("\n")}\n`;
}

/**
 * Extensions cannot reach Hunk's renderer, so write the OSC 52 sequence that
 * `renderer.copyToClipboardOSC52` would send straight to the terminal instead.
 */
function copyToClipboardOSC52(text: string) {
	const payload = Buffer.from(text, "utf8").toString("base64");
	const tty = openSync("/dev/tty", "w");
	try {
		writeSync(tty, `\x1b]52;c;${payload}\x07`);
	} finally {
		closeSync(tty);
	}
}

/** Copy the selected hunk's raw diff text to the clipboard. */
const copySelectedHunk: ExtensionCommandHandler = (ctx) => {
	const { file, hunkIndex } = ctx.selection;
	const hunkText =
		file && hunkIndex !== null ? extractHunk(file.patch, hunkIndex) : undefined;
	if (!hunkText) return;

	try {
		copyToClipboardOSC52(hunkText);
	} catch {
		ctx.notify(
			"Clipboard copy unsupported in this terminal (enable OSC 52)",
			"warning",
		);
		return;
	}
	ctx.notify("Copied hunk to clipboard");
};

export default function registerCopySelectedHunk(hunk: HunkExtensionAPI) {
	hunk.registerCommand(
		{ id: "copySelectedHunk", title: "Copy the selected hunk", key: "Y" },
		copySelectedHunk,
	);
}

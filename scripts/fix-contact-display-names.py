#!/usr/bin/env python3
"""Fix Fastmail contacts with incorrectly derived display names.

Cyrus IMAP has a bug where the derived FN (formatted name) is built in
vCard N field order (family first) instead of display order (given first).
This script sets name/full explicitly on affected contacts.
"""

import argparse
import json
import sys
import urllib.error
import urllib.request

JMAP_SESSION_URL = "https://api.fastmail.com/jmap/session"
JMAP_USING = ["urn:ietf:params:jmap:core", "urn:ietf:params:jmap:contacts"]
DISPLAY_ORDER = [
    "title",
    "given",
    "given2",
    "surname",
    "surname2",
    "credential",
    "generation",
]


def jmap_request(url, token, payload):
    headers = {"Authorization": f"Bearer {token}", "Content-Type": "application/json"}
    req = urllib.request.Request(url, json.dumps(payload).encode(), headers)
    try:
        with urllib.request.urlopen(req) as resp:
            return json.loads(resp.read())
    except urllib.error.HTTPError as e:
        print(f"HTTP {e.code}: {e.read().decode()}", file=sys.stderr)
        sys.exit(1)


def get_session(token):
    headers = {"Authorization": f"Bearer {token}"}
    req = urllib.request.Request(JMAP_SESSION_URL, headers=headers)
    with urllib.request.urlopen(req) as resp:
        return json.loads(resp.read())


def expected_full_name(comps):
    return " ".join(
        c["value"]
        for kind in DISPLAY_ORDER
        for c in comps
        if c.get("kind") == kind and c.get("value")
    )


def main():
    parser = argparse.ArgumentParser(
        description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter
    )
    parser.add_argument(
        "--token", required=True, help="Fastmail app password (Bearer token)"
    )
    parser.add_argument(
        "--apply", action="store_true", help="Apply fixes (default is dry run)"
    )
    args = parser.parse_args()

    session = get_session(args.token)
    account_id = session["primaryAccounts"]["urn:ietf:params:jmap:contacts"]
    api_url = session["apiUrl"]

    cards = jmap_request(
        api_url,
        args.token,
        {
            "using": JMAP_USING,
            "methodCalls": [
                [
                    "ContactCard/get",
                    {"accountId": account_id, "properties": ["id", "name"]},
                    "R1",
                ]
            ],
        },
    )["methodResponses"][0][1]["list"]

    patches = {}
    for card in cards:
        name = card.get("name")
        if not name or not name.get("components") or name.get("isOrdered"):
            continue

        expected = expected_full_name(name["components"])
        full = name.get("full")

        if not full or full != expected:
            patches[card["id"]] = {"name/full": expected}
            if full:
                print(f"  {full!r} -> {expected!r}")
            else:
                print(f"  [derived] -> {expected!r}")

    if not patches:
        print("No contacts need fixing.")
        return

    print(f"\n{len(patches)} contact(s) affected.")

    if not args.apply:
        print("Dry run. Pass --apply to fix.")
        return

    res = jmap_request(
        api_url,
        args.token,
        {
            "using": JMAP_USING,
            "methodCalls": [
                ["ContactCard/set", {"accountId": account_id, "update": patches}, "R1"]
            ],
        },
    )

    errors = res["methodResponses"][0][1].get("notUpdated")
    if errors:
        print(f"Errors: {json.dumps(errors, indent=2)}", file=sys.stderr)
        sys.exit(1)
    print("Done.")


if __name__ == "__main__":
    main()

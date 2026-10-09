---Ask devenv for the nixd settings of the project at `root_dir`
---@param root_dir string
---@return table?
local function devenv_settings(root_dir)
  local ok, res = pcall(function()
    return vim.system({ "devenv", "lsp", "--print-config" }, { cwd = root_dir, text = true }):wait()
  end)

  if not ok or res.code ~= 0 then
    vim.notify(
      "devenv lsp --print-config failed: " .. (ok and res.stderr or res),
      vim.log.levels.WARN
    )
    return nil
  end

  local decoded, settings = pcall(vim.json.decode, res.stdout)
  if not decoded then
    vim.notify("devenv lsp --print-config returned invalid JSON", vim.log.levels.WARN)
    return nil
  end

  return settings
end

---@type vim.lsp.Config
return {
  root_markers = {
    "devenv.nix",
    "flake.nix",
    ".git",
  },
  before_init = function(_, config)
    local root_dir = config.root_dir
    if not root_dir or vim.uv.fs_stat(vim.fs.joinpath(root_dir, "devenv.nix")) == nil then
      return
    end

    local settings = devenv_settings(root_dir)
    if settings then
      config.settings = vim.tbl_deep_extend("force", config.settings or {}, settings)
    end
  end,
  settings = {
    nixd = {
      formatting = {
        command = { "alejandra" },
      },
      nixpkgs = {
        expr = "import <nixpkgs> { }",
      },
    },
  },
}

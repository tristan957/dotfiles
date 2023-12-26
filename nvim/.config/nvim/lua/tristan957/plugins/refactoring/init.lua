local refactoring = require("refactoring")

refactoring.setup()

local function refactor(prompt_bufnr)
  local content = require("telescope.actions.state").get_selected_entry()

  require("telescope.actions").close(prompt_bufnr)
  refactoring.refactor(content.value)
end

vim.keymap.set("v", "<leader>e", function()
  local opts = require("telescope.themes").get_cursor()
  require("telescope.pickers")
    .new(opts, {
      prompt_title = "Refactors",
      finder = require("telescope.finders").new_table({
        results = require("refactoring").get_refactors(),
      }),
      sorter = require("telescope.config").values.generic_sorter(opts),
      attach_mappings = function(_, map)
        map("i", "<CR>", refactor)
        map("n", "<CR>", refactor)
        return true
      end,
    })
    :find()
end, { noremap = true, silent = true })

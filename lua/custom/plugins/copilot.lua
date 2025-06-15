return {

  {
    "github/copilot.vim",
    lazy = false,
    config = function()
      vim.g.copilot_no_tab_map = true -- Tiltsa le a Tab alapértelmezett hozzárendelését
      vim.g.copilot_assume_mapped = true
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    lazy = false,
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      -- Kulcsleképezések felülírása
      mappings = {
        reset = false, -- Letiltja a Ctrl-l reset funkciót
      },
    },
    keys = {
      { "<C-r>", "<cmd>CopilotChatReset<cr>", desc = "Reset Copilot Chat" },
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
}

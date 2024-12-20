return {
{
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- Example plugin configuration
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    'goolord/alpha-nvim',
    lazy = false, -- Ensure it loads immediately
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require("configs.alpha")  -- Update this line to match your path
    end
  },
  {"nvim-tree/nvim-tree.lua", enabled = false},
  {
    'nvim-telescope/telescope.nvim',
    lazy = false, -- Ensure it loads immediatel
    config = function()
      require("configs.telescope")  -- Update this line to match your path
    end
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    lazy = false,
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
},
  {"VonHeikemen/searchbox.nvim", lazy = false},
  {'brenoprata10/nvim-highlight-colors'},
  { 'rasulomaroff/reactive.nvim' },
  { "elentok/format-on-save.nvim" },
  {'Vigemus/iron.nvim'},
  {"MunifTanjim/nui.nvim", lazy = false},
  { 'mrjones2014/smart-splits.nvim', build = './kitty/install-kittens.bash' },
  {"ggandor/flit.nvim"},
  {"averms/black-nvim"},
  {"xiyaowong/transparent.nvim"},
  {"lambdalisue/vim-suda", lazy = false},
  {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    "rcarriga/nvim-notify",
    }

},
  {"ggandor/leap.nvim", lazy = false,
config = function()
local leap = require('leap')
leap.add_default_mappings()
leap.opts.case_sensitive = true
    end,
},
  {
  "declancm/cinnamon.nvim",
  version = "*", -- use latest release
  opts = {
    -- change default options here
  },
},
  {"VonHeikemen/fine-cmdline.nvim",enabled = false,
   lazy = false},
  {"yamatsum/nvim-cursorline"},
  {"tpope/vim-fugitive", lazy = false},
{
  "ibhagwan/fzf-lua",
    lazy = false,
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- calling `setup` is optional for customization
    require("fzf-lua").setup({"telescope",winopts={preview={default="bat"}}}, { fzf_colors = true })
  end
  },
{
  "olimorris/persisted.nvim",
  lazy = false, -- make sure the plugin is always loaded at startup
  config = true
},
    {
  "shellRaining/hlchunk.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("hlchunk").setup({})

    end
},
  {
  "gbprod/yanky.nvim",
    lazy = false,
    opts = {
      highlight = {
      on_yank = true,
      on_put = true,
      timer = 120,
  },
      {
  "williamboman/mason.nvim",
  opts = function(_, opts)
    table.insert(opts.ensure_installed, "black")
  end,
}
  },
},  {"nvim-lua/plenary.nvim"},
  -- Neo-tree plugin configuration

  -- Uncomment to use nvim-treesitter
  -- {
  --   "nvim-treesitter/nvim-treesitter",
  --   opts = {
  --     ensure_installed = {
  --       "vim", "lua", "vimdoc",
  --       "html", "css"
  --     },
  --   },
  -- },
}


-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  -- 1. THEMES
  {
    'sainnhe/everforest',
    priority = 1000,
    config = function()
      -- Optional: Set configuration before loading
      vim.g.everforest_background = 'hard'
      vim.g.everforest_enable_italic = 1
      -- vim.cmd.colorscheme("everforest") -- Uncomment to make default
    end,
  },
  {
    'rebelot/kanagawa.nvim',
    priority = 1000,
    opts = {
      transparent = false,
      theme = 'wave',
    },
    config = function(_, opts)
      require('kanagawa').setup(opts)
      vim.cmd.colorscheme 'kanagawa' -- Currently set as default
    end,
  },

  -- 2. TMUX INTEGRATION (Best Practice)
  -- This allows you to use Ctrl-h/j/k/l to move between Neovim splits
  -- AND Alacritty/Tmux panes seamlessly.
  {
    'christoomey/vim-tmux-navigator',
    cmd = {
      'TmuxNavigateLeft',
      'TmuxNavigateDown',
      'TmuxNavigateUp',
      'TmuxNavigateRight',
      'TmuxNavigatePrevious',
    },
    keys = {
      { '<c-h>', '<cmd><C-U>TmuxNavigateLeft<cr>' },
      { '<c-j>', '<cmd><C-U>TmuxNavigateDown<cr>' },
      { '<c-k>', '<cmd><C-U>TmuxNavigateUp<cr>' },
      { '<c-l>', '<cmd><C-U>TmuxNavigateRight<cr>' },
    },
  },

  -- 3. FILE EXPLORER (Yazi)
  {
    'mikavilpas/yazi.nvim',
    event = 'VeryLazy',
    keys = {
      -- 👇 e.g. open yazi with <leader>-
      { '<leader>-', '<cmd>Yazi<cr>', desc = 'Open Yazi File Manager' },
      {
        -- Open in the current working directory
        '<leader>cw',
        '<cmd>Yazi cwd<cr>',
        desc = 'Open Yazi in CWD',
      },
    },
    opts = {
      open_for_directories = true,
      keymaps = {
        show_help = '<f1>',
      },
    },
  },

  -- 4. SNACKS.NVIM
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      indent = { enabled = true },
      input = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
    },
    keys = {
      {
        '<leader>.',
        function()
          Snacks.scratch()
        end,
        desc = 'Toggle Scratch Pad',
      },
      {
        '<leader>S',
        function()
          Snacks.scratch.select()
        end,
        desc = 'Select Scratch Pad',
      },
      {
        '<leader>n',
        function()
          Snacks.notifier.show_history()
        end,
        desc = 'Notification History',
      },
      {
        '<leader>bd',
        function()
          Snacks.bufdelete()
        end,
        desc = 'Delete Buffer',
      },
      {
        '<leader>rf',
        function()
          Snacks.rename.rename_file()
        end,
        desc = 'Rename File',
      },
      {
        '<leader>gB',
        function()
          Snacks.gitbrowse()
        end,
        desc = 'Git Browse',
      },
      {
        '<leader>gb',
        function()
          Snacks.git.blame_line()
        end,
        desc = 'Git Blame Line',
      },
      {
        '<leader>gf',
        function()
          Snacks.lazygit.log_file()
        end,
        desc = 'Lazygit Current File History',
      },
      {
        '<leader>gg',
        function()
          Snacks.lazygit()
        end,
        desc = 'Lazygit',
      },
      {
        '<leader>gl',
        function()
          Snacks.lazygit.log()
        end,
        desc = 'Lazygit Log (cwd)',
      },
    },
  },
  -- 1. SURROUND (Modern equivalent to tpope/vim-surround)
  {
    'kylechui/nvim-surround',
    version = '*', -- Use for stability; omit to use `main` branch
    event = 'VeryLazy',
    config = function()
      require('nvim-surround').setup {}
    end,
  },

  -- 2. COMMENTING (Modern equivalent to tpope/vim-commentary)
  {
    'numToStr/Comment.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      padding = true,
      sticky = true,
    },
  },

  -- 3. FLASH (Navigation)
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts = {},
    keys = {
      {
        's',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').jump()
        end,
        desc = 'Flash',
      },
      {
        'S',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').treesitter()
        end,
        desc = 'Flash Treesitter',
      },
    },
  },

  -- 4. ZEN MODE (Configured for Alacritty + Status Line)
  {
    'folke/zen-mode.nvim',
    cmd = 'ZenMode',
    keys = {
      { '<leader>z', '<cmd>ZenMode<cr>', desc = 'Toggle Zen Mode' },
    },
    opts = {
      window = {
        backdrop = 0.95, -- Shade the background
        width = 120, -- Width of the zen window
        height = 1, -- Height of the zen window
        options = {
          signcolumn = 'no',
          number = true,
          relativenumber = true,
          -- CRITICAL: This keeps the status line visible!
          laststatus = 3,
        },
      },
      plugins = {
        options = {
          enabled = true,
          ruler = false,
          showcmd = false,
        },
        twilight = { enabled = true }, -- Dim inactive code (requires twilight.nvim, usually installed auto)
        -- ALACRITTY INTEGRATION
        alacritty = {
          enabled = true,
          font = '+2', -- Zoom font size by 2px when entering Zen Mode
        },
      },
    },
  },

  -- DISABLE OTHER EXPLORERS (Best Practice since you want Yazi only)
  {
    'nvim-neo-tree/neo-tree.nvim',
    enabled = false, -- Disable Neo-tree if it came with Kickstart
  },
}

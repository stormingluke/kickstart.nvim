-- ~/.config/nvim/lua/custom/autocmd/cmd.lua

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- ==========================================================
-- 1. COMMON: Highlight on Yank
-- ==========================================================
-- This creates a brief visual highlight when you copy (yank) text.
-- It's incredibly useful to know exactly what you copied.
autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- ==========================================================
-- 2. INTEGRATION: Auto-Hide Tmux Status Bar
-- ==========================================================
-- Hides the Tmux bottom bar when entering Neovim to reduce visual noise.
-- Restores it when you leave Neovim or suspend it (Ctrl+z).
local tmux_group = augroup('TmuxStatus', { clear = true })

autocmd({ 'VimEnter', 'VimResume' }, {
  group = tmux_group,
  callback = function()
    if os.getenv 'TMUX' then
      -- Turn status off
      vim.fn.system 'tmux set status off'
      -- Force refresh to clean up the empty space immediately
      vim.fn.system 'tmux refresh-client -S'
    end
  end,
})

autocmd({ 'VimLeave', 'VimSuspend' }, {
  group = tmux_group,
  callback = function()
    if os.getenv 'TMUX' then
      -- Turn status back on
      vim.fn.system 'tmux set status on'
      vim.fn.system 'tmux refresh-client -S'
    end
  end,
})

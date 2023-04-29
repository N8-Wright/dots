vim.opt.smarttab = true
vim.opt.showmatch = true
vim.opt.ruler = true

-- Set tabs to 4 spaces
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Always indent using spaces
vim.opt.expandtab = true 

-- Show line numbers
vim.opt.number = true

-- Disable highlight results of previous search
vim.opt.hlsearch = false

vim.g.mapleader = ','

local lazy = {}

function lazy.install(path)
  if not vim.loop.fs_stat(path) then
    print('Installing lazy.nvim....')
    vim.fn.system({
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      '--branch=stable', -- latest stable release
      path,
    })
  end
end

function lazy.setup(plugins)
  -- You can "comment out" the line below after lazy.nvim is installed
  lazy.install(lazy.path)

  vim.opt.rtp:prepend(lazy.path)
  require('lazy').setup(plugins, lazy.opts)
end

lazy.path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
lazy.opts = {}

lazy.setup({
  ---
  -- List of plugins
  ---
  {'folke/tokyonight.nvim'},
})

vim.opt.termguicolors = true
vim.cmd.colorscheme('tokyonight')

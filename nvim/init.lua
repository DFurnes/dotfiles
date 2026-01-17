-- Load lazy.nvim bootstrap + plugins
require("lazy_bootstrap")
require("plugins")

-- Close after auto-installing plugins
if vim.o.filetype == "lazy" then
  vim.cmd.close()
end

-- Configure status line
require('lualine').setup({
  options = {
    theme = 'onelight',
    component_separators = { left = ' ', right = ' ' },
    section_separators = { left = '', right = ' ' },
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
})

local config = vim.fn.stdpath("config")
vim.cmd("source " .. config .. "/vimrc")

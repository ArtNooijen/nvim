require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'rose-pine', -- Set to Catppuccin theme
        component_separators = { left = '', right = ''},  -- Tech-style separators
        section_separators = { left = '󱩅', right = ''},    -- Circuit-like separators
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        }
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {
            { 'branch', icon = '' },
            'diff',
            { 'diagnostics', sources = {'nvim_diagnostic'}, symbols = {error = ' ', warn = ' ', info = ' '} },
        },
        lualine_c = {
            { 'filename', file_status = true, path = 1 },  -- Corrected this line
            { 'nvim-gps', cond = require('nvim-gps').is_available }
        },
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = { 'nvim-tree', 'fugitive' ,'mason'}
}

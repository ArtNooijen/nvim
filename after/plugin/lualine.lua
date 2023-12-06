-- Custom function to show buffer saved status
local function isBufferSaved()
    if vim.bo.modified then
        return ""  -- Icon for unsaved/modified buffer
    else
        return ""  -- Icon for saved buffer
    end
end

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
            { 'diagnostics', sources = {'nvim_diagnostic'}, symbols = {error = ' ', warn = ' ', info = ' '},
            {
                -- Function to get and display the current session name
                function()
                    return require('auto-session.lib').current_session_name()
                end,
                icon = '📁', -- Optional: add an icon or text to indicate the session
            }
        },
        },
        lualine_c = {
            { 'filename', file_status = true, path = 1 },
            { isBufferSaved },  -- Custom buffer saved status component
            -- ... Add other components here if needed ...
        },
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },
    inactive_sections = {
        lualine_a = {
            -- Add components here if needed
        },
        lualine_b = {},
        lualine_c = {
            {
                'filename', icon = '',
                color = { fg = "#ffffff", bg = "#F33A6A" } -- Set text color to white
            }
        },
        lualine_x = {
            {
                'location',
                color = { fg = "#ffffff", bg = "#783af3" } -- Set text color to white
            }
        },
        lualine_y = {
            {
                'branch', 'diff',
                color = { fg = "#ffffff", bg = "#F33A6A" } -- Set text color to white
            }
        },
        lualine_z = {
            {
                'progress',
                color = { fg = "#ffffff", bg = "#ff2e4a" } -- Set text color to white
            }
        },
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = { 'nvim-tree', 'fugitive' ,'mason'}
}

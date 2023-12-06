-- Custom function to show buffer saved status
local function isBufferSaved()
    if vim.bo.modified then
        return "----"  -- Icon for unsaved/modified buffer
    else 
        return ""  -- Icon for saved buffer
    end
end

local function isBufferNotSaved()
    if not vim.bo.modified then
        return "----"  -- Icon for unsaved/modified buffer
    else
        return ""  -- Icon for saved buffer
    end

end

local function lsp_status()
  local clients = vim.lsp.buf_get_clients()
  if next(clients) ~= nil then
    return 'LSP'
  else
    return 'No LSP'
  end
end


local function current_session_name()
    local session_name = require('auto-session-library').current_session_name()
    if session_name and session_name ~= "" then
        -- Format the session name as you like, e.g., extract basename
        local basename = vim.fn.fnamemodify(session_name, ":t:r")
        return basename
    else
        return "No Session"
    end
end


local function git_status()
    local handle = io.popen("git status -sb --porcelain")
    if not handle then return "" end
    local git_status = handle:read("*a")
    handle:close()

    local to_push = string.find(git_status, "ahead")
    local to_pull = string.find(git_status, "behind")
    local not_staged = string.find(git_status, "^%s*[^ ]")
    local is_clean = git_status == ""

    if to_push then
        return " Push"
    elseif to_pull then
        return " Pull"
    elseif not_staged then
        return " Stage then Commit"
    elseif is_clean then
        return " Clean"
    else
        return ""
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
            {git_status},
            'diff',
            { 'diagnostics', sources = {'nvim_diagnostic'}, symbols = {error = ' ', warn = ' ', info = ' '},
            { current_session_name, icon = '📁'},  -- Updated session name component
        },
        },
        lualine_c = {
            { 'filename'},
            { isBufferSaved , color = { fg = "#ffffff", bg = "#F33A6A" }},
            { isBufferNotSaved, color = { fg = "#ffffff", bg = "#32CD32"}}, -- Custom buffer saved status component
        },

        
        lualine_x = {'encoding', 'fileformat', 'filetype', lsp_status},
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

local lsp = require('lsp-zero')

require'lspconfig'.pylsp.setup{}

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
})

  local cmp = require('cmp')
  local cmp_action = require('lsp-zero').cmp_action()

  cmp.setup({
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-<leader>'] = cmp.mapping.complete(),
      ['<C-f>'] = cmp_action.luasnip_jump_forward(),
      ['<C-b>'] = cmp_action.luasnip_jump_backward(),
      ['<C-u>'] = cmp.mapping.scroll_docs(-4),
      ['<C-d>'] = cmp.mapping.scroll_docs(4),
      ['<CR>'] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
        }),
    })
  })
lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}
  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

cmp_mappings['<Tab>'] = nil

vim.keymap.set('n', '<leader>f', '<cmd>Lspsaga finder<CR>', {silent = true, noremap = true})
vim.keymap.set('n', '<leader>i', '<cmd>Lspsaga finder imp<CR>', {silent = true, noremap = true})
vim.keymap.set('n', '<leader>pd', '<cmd>Lspsaga peek_definition<CR>', {silent = true, noremap = true})
vim.keymap.set('n', '<leader>ca', '<cmd>Lspsaga code_action<CR>', {silent = true, noremap = true})
vim.keymap.set('n', '<leader>o', '<cmd>Lspsaga outline<CR>', {silent = true, noremap = true})
vim.keymap.set('n', '<leader>rn', '<cmd>Lspsaga rename<CR>', {silent = true, noremap = true})
vim.keymap.set('t', '<leader>t', '<cmd>Lspsaga term_toggle<CR>', {silent = true, noremap = true})
vim.keymap.set('n', '<leader>t', '<cmd>Lspsaga term_toggle<CR>', {silent = true, noremap = true})



require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {},
  handlers = {
    lsp.default_setup,
  },
})


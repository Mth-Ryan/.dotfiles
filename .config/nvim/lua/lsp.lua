local lsp = {}

local lspconfig = require('lspconfig')
local home = os.getenv("HOME")
local pid = vim.fn.getpid()

local on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap=true, silent=true }

    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
    buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- Language Servers

lsp.enable_omnisharp = function()
    lspconfig.omnisharp.setup {
        on_attach = on_attach,
        cmd = { 
            "omnisharp", "--languageserver" , "--hostPID", tostring(pid)
        },
    }
end

lsp.enable_pyright = function()
    lspconfig.pyright.setup {
        on_attach = on_attach,
    }
end

lsp.enable_gopls = function()
    lspconfig.gopls.setup {
        on_attach = on_attach,
    }
end

lsp.enable_rust_analyzer = function()
    lspconfig.rust_analyzer.setup {
        on_attach = on_attach,
        cmd = {
            "rustup", "run", "nightly", "rust-analyzer"
        },
    }
end

lsp.enable_tsserver = function()
    lspconfig.tsserver.setup {
        on_attach = on_attach,
        cmd = {
            "typescript-language-server", "--stdio"
        },
        filetypes = { 
            "javascript", "javascriptreact", "javascript.jsx",
            "typescript", "typescriptreact", "typescript.tsx"
        },
        init_options = {
            hostInfo = "neovim",
        },
    }
end

lsp.enable_ccls = function()
    lspconfig.ccls.setup {
        on_attach = on_attach,
        init_options = {
            compilationDatabaseDirectory = "/tmp",
            index = { threads = 0; },
            clang = {
                excludeArgs = { "-frounding-math"},
            },
        }
    }
end

lsp.enable_clangd = function()
    require('lspconfig').clangd.setup {
        on_attach = on_attach,
    }
end

lsp.utils_setup = function()
    vim.lsp.handlers['workspace/symbol'] = require('lsputil.symbols').workspace_handler
    vim.lsp.handlers['textDocument/codeAction']  = require('lsputil.codeAction').code_action_handler
    vim.lsp.handlers['textDocument/references']  = require('lsputil.locations').references_handler
    vim.lsp.handlers['textDocument/definition']  = require('lsputil.locations').definition_handler
    vim.lsp.handlers['textDocument/declaration'] = require('lsputil.locations').declaration_handler
    vim.lsp.handlers['textDocument/typeDefinition'] = require('lsputil.locations').typeDefinition_handler
    vim.lsp.handlers['textDocument/implementation'] = require('lsputil.locations').implementation_handler
    vim.lsp.handlers['textDocument/documentSymbol'] = require('lsputil.symbols').document_handler
end


return lsp

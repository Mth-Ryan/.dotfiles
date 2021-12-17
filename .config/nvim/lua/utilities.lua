local utilities = {}

local remap = vim.api.nvim_set_keymap

utilities.enable_autopairs = function()
    local npairs = require('nvim-autopairs')
    _G.MUtils= {}

    vim.g.completion_confirm_key = ""

    MUtils.completion_confirm=function()
        if vim.fn.pumvisible() ~= 0  then
            if vim.fn.complete_info()["selected"] ~= -1 then
                require('completion').confirmCompletion()
                return npairs.esc("<c-y>")
            else
                vim.api.nvim_select_popupmenu_item(0 , false , false ,{})
                require('completion').confirmCompletion()
                return npairs.esc("<c-n><c-y>")
            end
        else
            return npairs.autopairs_cr()
        end
    end

    -- Keybindings
    local ft_opts = {expr = true , noremap = true}
    remap(
        'i' , '<CR>',
        'v:lua.MUtils.completion_confirm()',
        ft_opts
    )

    npairs.setup{}
end

utilities.enable_telescope = function()
    local actions = require('telescope.actions')
    require('telescope').setup {
        defaults = {
            file_sorter = require('telescope.sorters').get_fzy_sorter,
            prompt_prefix = 'λ ',
            selection_caret = '❯ ',
            borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
            colors_devicons = true,

            file_previewer =
                require('telescope.previewers').vim_buffer_cat.new,
            grep_previewer =
                require('telescope.previewers').vim_buffer_vimgrep.new,
            qflist_previewer =
                require('telescope.previewers').vim_buffer_qflist.new,

            mappings = {
                i = {
                    ['<C-x>'] = false,
                    ['<C-q>'] = actions.send_to_qflist,
                },
            },
        },
        extensions = {
            fzy_native = {
                override_generic_sorter = false,
                override_file_sorter = true,
            },
        },
    }

    -- Keybindings
    local ft_opts = { noremap = true, silent = true }
    remap(
        'n', '<C-f>',
        ':Telescope find_files theme=get_dropdown<CR>',
        ft_opts
    )
end

utilities.enable_fterm = function()
    require('FTerm').setup({
        border = 'rounded',
        dimensions  = {
            height = 0.7,
            width = 0.7,
        },
    })

    -- Keybindings
    local ft_opts = { noremap = true, silent = true }
    remap(
        'n', '<A-i>',
        '<CMD>lua require("FTerm").toggle()<CR>',
        ft_opts
    )
    remap(
        't', '<Esc>',
        '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>',
        ft_opts
    )
end

utilities.enable_lua_tree = function()
    require('nvim-tree').setup {
        disable_netrw       = true,
        hijack_netrw        = true,
        open_on_setup       = false,
        ignore_ft_on_setup  = {},
        auto_close          = false,
        open_on_tab         = false,
        hijack_cursor       = false,
        update_cwd          = false,
        update_to_buf_dir   = {
            enable = true,
            auto_open = true,
        },
        diagnostics = {
            enable = false,
            icons = {
                hint = "",
                info = "",
                warning = "",
                error = "",
            }
        },
        update_focused_file = {
            enable      = false,
            update_cwd  = false,
            ignore_list = {}
        },
        system_open = {
            cmd  = nil,
            args = {}
        },
        filters = {
            dotfiles = false,
            custom = {}
        },
        view = {
            width = 30,
            height = 30,
            hide_root_folder = false,
            side = 'left',
            auto_resize = false,
            mappings = {
                custom_only = false,
                list = {}
            }
        }
    }

    -- Keybindings
    local ft_opts = { noremap = true, silent = true }
    remap(
        'n', '<C-n>',
        ':NvimTreeToggle<CR>',
        ft_opts
    )
    remap(
        'n', '<leader>r',
        ':NvimTreeRefresh',
        ft_opts
    )
    remap(
        'n', '<leader>n',
        ':NvimTreeFindFile',
    ft_opts
    )
end

utilities.enable_wilder = function()
    vim.cmd([[
    call wilder#setup({
        \ 'modes': [':', '/', '?'],
        \ 'next_key': '<Tab>',
        \ 'previous_key': '<S-Tab>',
        \ 'accept_key': '<Down>',
        \ 'reject_key': '<Up>',
    \})

    call wilder#set_option('renderer', wilder#popupmenu_renderer(wilder#popupmenu_border_theme({
        \ 'highlights': {
        \   'border': 'Normal',
        \ },
        \ 'border': 'rounded',
    \})))
    ]])
end

utilities.enable_coq = function()
    vim.cmd([[
    let g:coq_settings = {
        \ 'auto_start': 'shut-up',
        \ 'display': {
            \ 'preview': {
                \'border': ["╭", "─", "╮", "│", "╯", "─", "╰", "│"]
            \}
        \}
    \}
    ]])
    require('coq')
end

return utilities

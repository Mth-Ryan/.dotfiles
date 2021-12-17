local visual = {}

visual.colorscheme = function(name)
    vim.cmd(
        'colorscheme ' .. name
    )
end

visual.enable_colorizer = function()
    require('colorizer').setup(
        {'*';},
        {
            RRGGBBAA = true;
            rgb_fn = true;
            hsl_fn = true;
        }
    )
end

visual.enable_treesitter = function()
    require('nvim-treesitter.configs').setup {
        ensure_installed = "maintained",
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
    }
end

visual.enable_indent_blankline = function()
    require("indent_blankline").setup {
        char = "┆",
        buftype_exclude = {"terminal"},
        filetype_exclude = {'scheme', 'lisp'},
    }
end

visual.enable_galaxyline = function()
    require("status-line")
end

visual.enable_bufferline = function()
    require("buffer-line")
end

return visual

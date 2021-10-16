local colors = {
    bg     = '#1B1C24',
    fg     = '#D4D2CF',
    fg2    = '#c3c1be',
    bg2    = '#111116',
    bg3    = '#262833',
    bg4    = '#32343F',
    cyan   = '#9BC5AF',
    green  = '#bfd066',
}

require("bufferline").setup {
    options = {
        always_show_bufferline = false,
        show_tab_indicators = false,
        diagnostics = false,
        show_close_icon = false,
        indicator_icon = '▎',
        buffer_close_icon = 'x',
        modified_icon = '●',
        separator_style = { '', '' },
        offsets = {
            {
                filetype = "NvimTree",
                text = "",
                highlight = "Directory",
                text_align = "center"
            },
        },
    },
    highlights = {
        fill = {
            guifg = colors.bg4,
            guibg = colors.bg,
        },
        background = {
            guifg = colors.bg4,
            guibg = colors.bg,
        },
        buffer_selected = {
            guifg = colors.fg2,
            guibg = colors.bg3,
            gui = '',
        },
        buffer_visible = {
            guifg = colors.fg2,
            guibg = colors.bg2,
        },
        close_button = {
            guifg = colors.bg4,
            guibg = colors.bg,
        },
        close_button_selected = {
            guifg = colors.fg2,
            guibg = colors.bg3,
        },
        close_button_visible = {
            guifg = colors.fg2,
            guibg = colors.bg2,
        },
        modified = {
            guifg = colors.fg4,
            guibg = colors.bg,
        },
        modified_selected = {
            guifg = colors.green,
            guibg = colors.bg3,
        },
        modified_visible = {
            guifg = colors.green,
            guibg = colors.bg2,
        },
        indicator_selected = {
            guifg = colors.cyan,
            guibg = colors.bg3,
        },
        separator_visible = {
            guifg = colors.bg2,
            guibg = colors.bg,
        },
        separator_selected = {
            guifg = colors.bg2,
            guibg = colors.bg,
        },
        separator = {
            guifg = colors.bg3,
            guibg = colors.bg,
        },
    },
}

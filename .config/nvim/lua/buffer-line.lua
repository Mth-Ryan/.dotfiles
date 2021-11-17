local colors = {
    bg     = '#1B1C24',
    fg     = '#D4D2CF',
    fg2    = '#c3c1be',
    bg2    = '#14151b',
    bg3    = '#262833',
    bg4    = '#32343F',
    cyan   = '#9BC5AF',
    green  = '#bfd066',
}

require("bufferline").setup {
    options = {
        always_show_bufferline = true,
        show_tab_indicators = false,
        diagnostics = false,
        show_close_icon = false,
        indicator_icon = ' ',
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
            guibg = colors.bg2,
        },
        background = {
            guifg = colors.bg4,
            guibg = colors.bg2,
        },
        buffer_selected = {
            guifg = colors.fg2,
            guibg = colors.bg,
            gui = '',
        },
        buffer_visible = {
            guifg = colors.fg2,
            guibg = colors.bg,
        },
        close_button = {
            guifg = colors.bg4,
            guibg = colors.bg2,
        },
        close_button_selected = {
            guifg = colors.fg2,
            guibg = colors.bg,
        },
        close_button_visible = {
            guifg = colors.fg2,
            guibg = colors.bg2,
        },
        modified = {
            guifg = colors.fg4,
            guibg = colors.bg2,
        },
        modified_selected = {
            guifg = colors.green,
            guibg = colors.bg,
        },
        modified_visible = {
            guifg = colors.green,
            guibg = colors.bg2,
        },
        indicator_selected = {
            guifg = colors.bg,
            guibg = colors.bg,
        },
        separator_visible = {
            guifg = colors.bg,
            guibg = colors.bg2,
        },
        separator_selected = {
            guifg = colors.bg,
            guibg = colors.bg2,
        },
        separator = {
            guifg = colors.bg,
            guibg = colors.bg2,
        },
    },
}

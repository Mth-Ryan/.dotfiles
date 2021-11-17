from libqtile import widget
from libqtile import qtile
from os.path import expanduser

fade_colors = [
    '#14151B',
    '#1B1C24',
    '#262833',
]

colors = {
    "blue": "#679DCB" 
}

def init():
    return [
        widget.CurrentLayoutIcon(
            custom_icon_paths = [expanduser("~/.config/qtile/icons")],
            background = fade_colors[0],
            padding = 4
        ),
        widget.TextBox(
            text = '',
            foreground = fade_colors[0],
            background = fade_colors[1],
            padding = 0,
            fontsize = 20
        ),
        widget.GroupBox(
            disable_drag = True,
            highlight_method = "block",
            background=fade_colors[1],
            this_current_screen_border = colors["blue"],
            this_screen_border = colors["blue"],
            other_current_screen_border = fade_colors[2],
            other_screen_border = fade_colors[2],
        ),
        widget.TextBox(
            text = '',
            foreground = fade_colors[1],
            background = fade_colors[2],
            padding = 0,
            fontsize = 20
        ),
        widget.Image(
            filename = '~/.config/qtile/icons/cpu.png',
            background = fade_colors[2],
            scale = False,
            margin_x = 0,
        ),
        widget.CPU(
            background=fade_colors[2],
            format='{freq_current}GHz'
        ),
        widget.Sep(
            padding = 4,
            background = fade_colors[2],
            foreground = fade_colors[2],
        ),
        widget.Image(
            filename = '~/.config/qtile/icons/mem.png',
            background = fade_colors[2],
            scale = False,
            margin_x = 0,
        ),
        widget.Memory(
            background=fade_colors[2],
            format='{MemUsed: .0f}{mm}'
        ),
        widget.Sep(
            padding = 4,
            background = fade_colors[2],
            foreground = fade_colors[2],
        ),
        widget.Image(
            filename = '~/.config/qtile/icons/nvidia.png',
            background = fade_colors[2],
            scale = False,
            margin_x = 0,
        ),
        widget.Sep(
            padding = 2,
            background = fade_colors[2],
            foreground = fade_colors[2],
        ),
        widget.TextBox(
            text = '',
            foreground = fade_colors[2],
            padding = 0,
            fontsize = 20
        ),
        widget.WindowName(
            max_chars=30,
            padding=15
        ),
        widget.Systray(),
        widget.TextBox(
            text = '',
            foreground = fade_colors[2],
            padding = 0,
            fontsize = 20
        ),
        widget.Sep(
            padding = 2,
            background = fade_colors[2],
            foreground = fade_colors[2],
        ),
        widget.Image(
            filename = '~/.config/qtile/icons/audio.png',
            background = fade_colors[2],
            scale = False,
            margin_x = 0,
        ),
        widget.PulseVolume(
            background = fade_colors[2],
            padding = 1,
        ),
        widget.Sep(
            padding = 2,
            background = fade_colors[2],
            foreground = fade_colors[2],
        ),
        widget.Image(
            filename = '~/.config/qtile/icons/wifi.png',
            background = fade_colors[2],
            scale = False,
            margin_x = 0,
            mouse_callbacks = {
                'Button1': lambda: qtile.cmd_spawn(expanduser("~/.config/rofi/wifi.sh"))
            },
        ),
        widget.Wlan(
            format = '{essid}',
            disconnected_message = 'Disc',
            interface = 'wlp3s0',
            background = fade_colors[2],
            mouse_callbacks = {
                'Button1': lambda: qtile.cmd_spawn(expanduser("~/.config/rofi/wifi.sh"))
            },
        ),
        widget.Sep(
            padding = 2,
            background = fade_colors[2],
            foreground = fade_colors[2],
        ),
        widget.Image(
            filename = '~/.config/qtile/icons/battery.png',
            background = fade_colors[2],
            scale = False,
            margin_x = 0,
        ),
        widget.Battery(
            format='{percent:2.0%}',
            background = fade_colors[2]
        ),
        widget.TextBox(
            text = '',
            background = fade_colors[2],
            foreground = fade_colors[1],
            padding = 0,
            fontsize = 20
        ),
        widget.Sep(
            padding = 2,
            background = fade_colors[1],
            foreground = fade_colors[1],
        ),
        widget.Image(
            filename = '~/.config/qtile/icons/date.png',
            background = fade_colors[1],
            scale = False,
            margin_x = 0,
        ),
        widget.Clock(
            format='%a %I:%M %p',
            background=fade_colors[1]
        ),
        widget.TextBox(
            text = '',
            background = fade_colors[1],
            foreground = fade_colors[0],
            padding = 0,
            fontsize = 20
        ),
        widget.Image(
            filename = '~/.config/qtile/icons/power.png',
            background = fade_colors[0],
            scale = False,
            margin_x = 4,
            mouse_callbacks = {
                'Button1': lambda: qtile.cmd_spawn(expanduser("~/.config/rofi/powermenu.sh"))
            },
        ),
    ]

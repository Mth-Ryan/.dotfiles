# vim:fdm=marker

import subprocess
import os
from typing import List

from keybindings import set_keys, mod
import bar_widgets

from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy

# Groups and Layouts {{{

groups = [Group(i) for i in "12345"]

layouts = [
    layout.MonadTall(
        border_width=0,
        margin=13,
        ratio=0.55 
    ),
    layout.Max(),
    layout.Matrix(
        border_width=0,
        margin=10
    ),
]

# }}}

# Bindings {{{

keys = set_keys()

mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]


for i in groups:
    keys.extend([
        Key([mod], i.name, lazy.group[i.name].toscreen(),
            desc="Switch to group {}".format(i.name)),

        Key([mod, "shift"], i.name, lazy.window.togroup(i.name, switch_group=True),
            desc="Switch to & move focused window to group {}".format(i.name)),
    ])

# }}}

# Screens {{{

# Screen Count
xrandr_process = subprocess.Popen(
    'xrandr | grep "\*" | cut -d" " -f4',
    shell=True,
    stdout=subprocess.PIPE
)
xrandr_output = xrandr_process.communicate()[0].decode('utf-8')
screens_cout  = len(xrandr_output.strip().split('\n'))

widget_defaults = dict(
    font='sans',
    fontsize=12,
    padding=3
)
extension_defaults = widget_defaults.copy()

screens = [
        Screen(
            top = bar.Bar(
                bar_widgets.init(),
                20,
                background='#32343F',
                opacity=0.65
            )
        )
        for s in range(screens_cout)
]

# }}}

# General Config {{{

dgroups_key_binder = None
dgroups_app_rules = []
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    *layout.Floating.default_float_rules,
    Match(wm_class='confirmreset'), # gitk
    Match(wm_class='makebranch'),   # gitk
    Match(wm_class='maketag'),      # gitk
    Match(wm_class='ssh-askpass'),  # ssh-askpass
    Match(title='branchdialog'),    # gitk
    Match(title='pinentry'),        # GPG key password entry
])
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True
auto_minimize = True
wmname = "LG3D"

# }}}

# AutoStart {{{

@hook.subscribe.startup_once
def autostart():
    cmd = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.call([cmd])

# }}}

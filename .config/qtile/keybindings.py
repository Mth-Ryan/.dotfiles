# vim:fdm=marker

from libqtile.config import Key
from libqtile.lazy   import lazy
from libqtile.utils  import guess_terminal
from os.path import expanduser

mod     = "mod4"
control = "control"
shift   = "shift"

terminal = guess_terminal()

keybindings = [
    # Focus Moviment {{{
    {
        "desc": "Move focus to left",
        "mods": [mod],
        "key": "h",
        "function": lazy.layout.left()
    },
    {
        "desc": "Move focus to right",
        "mods": [mod],
        "key": "l",
        "function": lazy.layout.right()
    },
    {
        "desc": "Move focus to down",
        "mods": [mod],
        "key": "j",
        "function": lazy.layout.down()
    },
    {
        "desc": "Move focus to up",
        "mods": [mod],
        "key": "k",
        "function": lazy.layout.up()
    }, # }}}

    # Window Movement {{{
    {
        "desc": "Move window to the left",
        "mods": [mod, shift],
        "key": "h",
        "function": lazy.layout.shuffle_left()
    },
    {
        "desc": "Move window to the right",
        "mods": [mod, shift],
        "key": "l",
        "function": lazy.layout.shuffle_right()
    },
    {
        "desc": "Move window to the down",
        "mods": [mod, shift],
        "key": "j",
        "function": lazy.layout.shuffle_down()
    },
    {
        "desc": "Move window to the up",
        "mods": [mod, shift],
        "key": "k",
        "function": lazy.layout.shuffle_up()
    }, # }}}

    # Window resize {{{
    {
        "desc": "Grow window to the left",
        "mods": [mod, control],
        "key": "h",
        "function": lazy.layout.grow_left()
    },
    {
        "desc": "Grow window to the right",
        "mods": [mod, control],
        "key": "l",
        "function": lazy.layout.grow_right()
    },
    {
        "mods": [mod, control],
        "key": "j",
        "function": lazy.layout.grow_down(),
        "desc": "Grow window to the down"
    },
    {
        "desc": "Grow window to the up",
        "mods": [mod, control],
        "key": "k",
        "function": lazy.layout.grow_up()
    },
    {
        "desc": "Reset all window sizes",
        "mods": [mod],
        "key": "n",
        "function": lazy.layout.normalize()
    }, # }}}

    # Layouts commands {{{
    {
        "desc": "Toggle between split and unsplit sides of stack",
        "mods": [mod, shift],
        "key": "Return",
        "function": lazy.layout.toggle_split()
    },
    {
        "desc": "Toggle between layouts",
        "mods": [mod],
        "key": "Tab",
        "function": lazy.next_layout(),
    }, # }}}

    # Qtile Commands {{{
    {
        "desc": "Kill focused window",
        "mods": [mod],
        "key": "w",
        "function": lazy.window.kill()
    },
    {
        "desc": "Restart Qtile",
        "mods": [mod, control],
        "key": "r",
        "function": lazy.restart(),
    },
    {
        "desc": "Shutdown Qtile",
        "mods": [mod, control],
        "key": "q",
        "function": lazy.spawn(
            expanduser("~/.config/rofi/powermenu.sh")
        )
    }, # }}}

    # Launchers {{{
    {
        "desc": "Launch terminal",
        "mods": [mod],
        "key": "Return",
        "function": lazy.spawn(terminal)
    },
    {
        "desc": "Spawn a command using a prompt widget",
        "mods": [mod],
        "key": "r",
        "function": lazy.spawncmd()
    },
    {
        "desc": "Rofi application launcher",
        "mods": [mod],
        "key": "space",
        "function": lazy.spawn(
            expanduser("~/.config/rofi/launcher.sh")
        )
    }, # }}}
]

def set_keys():
    return [Key(bind["mods"], bind["key"], bind["function"], desc=bind["desc"])
            for bind in keybindings]

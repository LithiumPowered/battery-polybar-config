#!/usr/bin/env python3

from i3ipc import Connection, Event
import subprocess

i3 = Connection()

get_window_props = 'xdotool getwindowfocus getwindowgeometry | rg -o Position.*$ | choose 1'
set_stack_hook_0 = 'polybar-msg action "#stack.hook.0"'
set_stack_hook_1 = 'polybar-msg action "#stack.hook.1"'
set_stack_hook_2 = 'polybar-msg action "#stack.hook.2"'

def set_tiled_indicator(i3, e):
    focused = i3.get_tree().find_focused()

    direct_output = subprocess.check_output(get_window_props, shell=True)
    window_pos = direct_output.decode().replace("\n", "").split(',')

    if focused == None: 
        subprocess.check_output(set_stack_hook_0, shell=True)
    else:
        if int(window_pos[0]) <= 20: 
            subprocess.check_output(set_stack_hook_1, shell=True)
        else: 
            subprocess.check_output(set_stack_hook_2, shell=True)

def reset_indicator(i3, e):
    subprocess.check_output(set_stack_hook_0, shell=True)

i3.on('workspace::focus', reset_indicator)
i3.on('window::close', reset_indicator)
i3.on('window::focus', set_tiled_indicator)

# Main Loop
i3.main()

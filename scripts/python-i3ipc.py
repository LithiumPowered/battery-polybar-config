#!/usr/bin/env python3

from i3ipc import Connection, Event
import subprocess

i3 = Connection()

def get_window_pos():
    get_window_props = 'xdotool getwindowfocus getwindowgeometry | rg -o Position.*$ | choose 1'
    direct_output = subprocess.check_output(get_window_props, shell=True)
    window_pos = direct_output.decode().replace("\n", "").split(',')
    return int(window_pos[0])

def set_stack_hook(n):
    subprocess.check_output('polybar-msg action "#stack.hook.{}"'.format(n), shell=True)

def set_indicator(i3, e):
    focused = i3.get_tree().find_focused()

    if focused == None: 
        set_stack_hook(0)
    else:
        if get_window_pos() <= 20: 
            set_stack_hook(1)
            i3.command('mark Primary')

        else: 
            set_stack_hook(2)
            i3.command('mark Secondary')

def reset_indicator(i3, e):
    set_stack_hook(0)
    for mark in [ 'Primary', 'Secondary' ]:
        [i3.command('unmark {}'.format(mark))]

i3.on('workspace::focus', reset_indicator)
i3.on('window::close', reset_indicator)
i3.on('workspace::move', set_indicator)
i3.on('window::focus', set_indicator)

# Main Loop
i3.main()

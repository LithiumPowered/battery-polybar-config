#!/usr/bin/env python3

from i3ipc import Connection, Event
import subprocess

i3 = Connection()
i3_marks = [ "Primary", "Secondary" ]

def set_stack_hook(n):
    try: subprocess.check_output('polybar-msg action "#stack.hook.{}"'.format(n), shell=True)
    except: pass

def set_i3_mark(m):
    try: i3.command("mark {}".format(m))
    except: pass

def set_indicator(i3, e):
    focused = i3.get_tree().find_focused()

    if e.container.floating == "user_on":
        window_floating = 1
    else:
        window_floating = 0

    if focused == None: 
        set_stack_hook(0)
    else:
        window_cords = [ e.container.rect.x + 1, e.container.rect.y ]
        primary_zone = 400 + focused.workspace().gaps.inner + 1

        if window_cords[0] <= primary_zone and window_cords[1] <= primary_zone and not window_floating:
            set_stack_hook(1)
            set_i3_mark(i3_marks[0])
        else: 
            set_stack_hook(2)
            set_i3_mark(i3_marks[1])

def reset_indicator(i3, e):
    set_stack_hook(0)
    for mark in i3_marks:
        [i3.command('unmark {}'.format(mark))]

if __name__ == "__main__":
    i3.on('workspace::focus', reset_indicator)
    i3.on('window::close', reset_indicator)
    i3.on('workspace::move', set_indicator)
    i3.on('window::focus', set_indicator)
    i3.main()



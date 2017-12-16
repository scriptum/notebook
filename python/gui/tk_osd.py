#!/usr/bin/env python
#-*- coding:utf-8 -*-
# Simple OSD (On Screen Display) using only standard python GUI library

from __future__ import print_function
import Tkinter as tk


def main():
    root = tk.Tk()
    # borderless window
    root.overrideredirect(1)

    # avoid window blinking (move )
    root.geometry("+99999+99999")

    txt = "Hello world!"
    fnt = "Sans 45 bold"
    tk.Label(root, text=txt, font=fnt, bg="#000033", fg="#ddddff").pack()

    root.update_idletasks()

    screen_w, screen_h = root.winfo_screenwidth(), root.winfo_screenheight()
    # centering
    x = screen_w // 2 - root.winfo_width() // 2
    y = screen_h // 2 - root.winfo_height() // 2

    # corner
    # x = screen_w - root.winfo_width()
    # y = screen_h - root.winfo_height()

    root.geometry("+{}+{}".format(x, y))
    # show message in 2 seconds
    root.after(2000, root.destroy)
    root.mainloop()


if __name__ == "__main__":
    main()

#!/usr/bin/env python
#-*- coding:utf-8 -*-
# Python GUI application with header bar and command line argument

import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk, GLib, Gio
import sys


class MyApplication(Gtk.Application):
    def __init__(self, *args, **kwargs):
        super(MyApplication, self).__init__(*args, application_id="org.myapplication",
            flags=Gio.ApplicationFlags.HANDLES_COMMAND_LINE,
            **kwargs)
        self.window = None
        self.logo = None
        self.title = "My app"
        self.add_main_option("test", ord("t"), GLib.OptionFlags.NONE,
                             GLib.OptionArg.NONE, "Command line test", None)


    def do_startup(self):
        Gtk.Application.do_startup(self)


    def do_activate(self):
        if not self.window:
            self.window = Gtk.ApplicationWindow(application=self)
            
            action = Gio.SimpleAction.new("quit", None)
            action.connect("activate", self.on_quit)
            self.add_action(action)
            
            action = Gio.SimpleAction.new("about", None)
            action.connect("activate", self.on_about)
            self.add_action(action)

            menu = Gio.Menu()
            menu.append('About', 'app.about')
            menu.append("Exit", "app.quit")
            self.set_app_menu(menu)

            icon_theme = Gtk.IconTheme.get_default()
            self.logo = icon_theme.load_icon("applications-other", 128, 0)
            self.window.set_icon(self.logo)

            hb = Gtk.HeaderBar()
            hb.set_show_close_button(True)
            hb.props.title = self.title
            self.window.set_titlebar(hb)
            
            self.window.set_default_size(640, 480)
            
            sw = Gtk.ScrolledWindow()
            self.window.add(sw)
            self.window.show_all()

        self.window.present()

    def do_command_line(self, command_line):
        options = command_line.get_options_dict()

        if options.contains("test"):
            print("Test argument recieved")

        self.activate()
        return 0

    def on_about(self, action, param):
        about = Gtk.AboutDialog(transient_for=self.window)
        about.set_destroy_with_parent(True);
        about.set_logo(self.logo)
        about.set_authors(["Pavel Roschin"])
        about.connect("response", lambda self, rid: about.hide_on_delete())
        about.present()

    def on_quit(self, action, param):
        self.quit()

if __name__ == "__main__":
    app = MyApplication()
    app.run(sys.argv)

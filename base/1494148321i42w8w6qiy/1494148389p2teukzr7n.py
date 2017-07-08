#!/usr/bin/env python
# --*-- coding:utf-8 --*--
# example packbox.py

import gi
gi.require_version('Gtk', '3.0')
#from gi.repository.Gtk import *

import gi.repository.Gtk as gtk


def xpm_label_box(parent, xpm_filename, label_text):
    # Создаём коробку для картинки и надписи
    box1 = gtk.HBox(False, 0)
    box1.set_border_width(2)

    # Создаём картинку
    image = gtk.Image()
    image.set_from_file(xpm_filename)

    # Создаём надпись
    label = gtk.Label(label_text)

    # Размещаем надпись и картинку в HBox
    box1.pack_start(image, False, False, 3)
    box1.pack_start(label, False, False, 3)

    image.show()
    label.show()
    return box1


class Buttons:
    # Наш обычный callback
    def callback(self, widget, data=None):
        print("Привет снова - %s была нажата" % data)

    def __init__(self):
        # Создаём новое окно
        self.window = gtk.Window()

        self.window.set_title("Картинки на кнопках!")

        # Использовать это со всеми окнами будет хорошим решением.
        self.window.connect("destroy", lambda wid: gtk.main_quit())
        self.window.connect("delete_event", lambda a1, a2: gtk.main_quit())

        # Устанавливаем ширину границы окна.
        self.window.set_border_width(10)

        # Создаём новую кнопку
        button = gtk.Button()

        # Привязываем сигнал "clicked" к нашему callback
        button.connect("clicked", self.callback, "классная кнопка")

        # Это вызывает нашу функцию создания коробки
        box1 = xpm_label_box(self.window, "database.ico", "классная кнопка")

        # Размещаем окно со всеми виджетами
        button.add(box1)

        box1.show()
        button.show()

        self.window.add(button)
        self.window.show()


def main():
    gtk.main()
    return 0


if __name__ == "__main__":
    Buttons()
    main()
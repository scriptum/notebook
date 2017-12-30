#!/usr/bin/env python
#-*- coding:utf-8 -*-

import random
import cairo


def main():
    puzzles_file = "sudoku17_simple"
    puzzles_per_page = 12
    puzzles_pages = 875
    puzzles_total = puzzles_per_page * puzzles_pages
    # mm to pixel
    mm = 72 / 2.54 / 10
    with open(puzzles_file) as f:
        contents = f.read().split()
        puzzles_array = random.sample(contents, puzzles_total)
        puzzles_it = iter(puzzles_array)
    # A4 - 210mm x 297mm
    ps = cairo.PDFSurface("sudoku.pdf", 210 * mm, 297 * mm)
    cr = cairo.Context(ps)
    # scale to mm
    cr.scale(mm, mm)
    # left and right fields
    field_rl = 4
    # top and bottom fields
    field_tb = 15
    # horizontal puzzle spacing
    pad_x = 4
    # vertical puzzle spacing
    pad_y = 5
    # number of rows of puzzles
    rows = 3
    # number of cols of puzzles
    cols = 4

    step1 = float(210 - field_rl * 2 - (rows - 1) * pad_x) / rows / 9
    step2 = float(297 - field_tb * 2 - (cols - 1) * pad_y) / cols / 9
    if step1 < step2:
        step = step1
        field_tb = float(297 - 9 * step * cols -
                         (cols - 1) * pad_y) / 2
    else:
        step = step2
        field_rl = float(210 - 9 * step * rows - (rows - 1) * pad_x) / 2

    for _ in range(puzzles_pages):
        for x in range(rows):
            for y in range(cols):
                # big squares
                cr.set_line_width(0.4)
                cr.rectangle(field_rl + x * (step * 9 + pad_x),
                             field_tb + y * (step * 9 + pad_y), step * 9, step * 9)
                cr.rectangle(field_rl + x * (step * 9 + pad_x),
                             field_tb + y * (step * 9 + pad_y), step * 9, step * 9)
                cr.rectangle(field_rl + x * (step * 9 + pad_x) + step * 3,
                             field_tb + y * (step * 9 + pad_y), step * 3, step * 9)
                cr.rectangle(field_rl + x * (step * 9 + pad_x), field_tb +
                             y * (step * 9 + pad_y) + step * 3, step * 9, step * 3)
                cr.stroke()
                # small squares
                cr.set_line_width(0.1)
                cr.rectangle(field_rl + x * (step * 9 + pad_x) + step,
                             field_tb + y * (step * 9 + pad_y), step, step * 9)
                cr.rectangle(field_rl + x * (step * 9 + pad_x) + step * 4,
                             field_tb + y * (step * 9 + pad_y), step, step * 9)
                cr.rectangle(field_rl + x * (step * 9 + pad_x) + step * 7,
                             field_tb + y * (step * 9 + pad_y), step, step * 9)
                cr.rectangle(field_rl + x * (step * 9 + pad_x), field_tb +
                             y * (step * 9 + pad_y) + step, step * 9, step)
                cr.rectangle(field_rl + x * (step * 9 + pad_x), field_tb +
                             y * (step * 9 + pad_y) + step * 4, step * 9, step)
                cr.rectangle(field_rl + x * (step * 9 + pad_x), field_tb +
                             y * (step * 9 + pad_y) + step * 7, step * 9, step)
                cr.stroke()

                # numbers
                s = puzzles_it.next()
                cr.set_font_size(step * 2 / mm)
                for i in range(9):
                    for j in range(9):
                        if s[i * 9 + j] != "0":
                            cr.move_to(field_rl + x * (step * 9 + pad_x) + step / 3 + j * step,
                                       field_tb + y * (step * 9 + pad_y) + step - step / 4 + i * step)
                            cr.show_text(s[i * 9 + j])
        cr.show_page()


if __name__ == "__main__":
    main()

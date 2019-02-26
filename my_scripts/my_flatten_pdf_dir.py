#!/usr/bin/env python
from __future__ import print_function

import os
from os.path import getsize, join, splitext, isdir 
from shutil import move

class DirFlatten:
    ignore_list = [ './__classified__', './__flattened__' ]

    def __init__(self):
        self.directory = os.curdir
        self.dir_flattened = join(self.directory, '__flattened__')

        if not isdir(self.dir_flattened):
            os.makedirs(self.dir_flattened)

    def flatten(self):
        changed_folders = set()

        for root, dirs, files in os.walk(self.directory):
            for file in files:
                is_movable = splitext(file)[1].lower() \
                                in ['.pdf', '.epub', '.mobi']
                is_movable = is_movable \
                                and not any(
                                    [ root.startswith(ilist)
                                        for ilist in DirFlatten.ignore_list ])

                if not (is_movable and getsize(join(root, file)) > 1024):
                    continue

                changed_folders.add(root)

                name_without_ext, ext = splitext(file)
                name_without_ext = name_without_ext.replace('.', ' ') \
                                                   .replace('_', ' ') \
                                                   .replace('-', ' ')
                filename = name_without_ext + ext
                dest_file = join(self.dir_flattened, filename)

                print("{}/{}".format(root, file))
                print("=> {}".format(dest_file))
                move(join(root, file), dest_file)

        for folder in changed_folders:
            move(folder, self.dir_flattened)


if __name__ == "__main__":
    flattener = DirFlatten()
    flattener.flatten()



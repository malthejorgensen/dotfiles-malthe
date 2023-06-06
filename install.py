from __future__ import print_function

import argparse
from builtins import input
import json
import os
import shutil


def parse_path(path, path_app_dir):
    if path.startswith('./'):
        return os.path.join(path_app_dir, path[2:])
    elif path.startswith('~/'):
        # http://stackoverflow.com/questions/4028904/how-to-get-the-home-directory-in-python
        home_directory = os.path.expanduser('~')
        return os.path.join(home_directory, path[2:])


def ensure_dir_exists(path):
    # Make any directories that don't exist, e.g. "~/.config"
    paths = []
    for i in range(100):
        parent_dir = os.path.dirname(path)
        if parent_dir == '/':
            break
        paths.append(parent_dir)
        path = parent_dir
    paths = reversed(paths)

    for path in paths:
        if not os.path.exists(path):
            yesno = input(
                '`%s` doesn\'t exist - do you want to create it? (Yes/No) ' % path
            )
            if yesno == 'Yes':
                os.mkdir(path)
            else:
                return False

    return True


def create_symlink(source_path, target_path):
    if os.path.exists(target_path):
        yesno = input(
            '`%s` exists - do you want to overwrite it? (Yes/No) ' % target_path
        )
        if yesno == 'Yes':
            if os.path.islink(target_path):
                os.remove(target_path)
            elif os.path.isdir(target_path):
                shutil.rmtree(target_path)
            else:
                os.remove(target_path)
        else:
            return

    if ensure_dir_exists(target_path):
        print('Symlinking %s to %s' % (full_path_source, full_path_target))
        os.symlink(source_path, target_path)


parser = argparse.ArgumentParser()
parser.add_argument(
    '-a', '--all', action='store_true', help='Install dotfiles for all apps'
)
parser.add_argument('app_dirs', nargs='*')  # , default=None)
args = parser.parse_args()

if args.app_dirs == []:
    if args.all:
        app_dirs = [f.name for f in os.scandir(os.getcwd()) if f.is_dir()]
    else:
        print('Please pass one or more app directories, or pass the `--all` flag.')
        exit(5)
else:
    app_dirs = args.app_dirs


this_directory = os.path.dirname(os.path.realpath(__file__))
for app_dir in app_dirs:
    path_app_dir = os.path.join(this_directory, app_dir)
    with open(app_dir + '/dotfile.json') as dotfile:
        files = json.load(dotfile)

        for file in files:
            if file['type'] == 'symlink':
                full_path_source = parse_path(file['source'], path_app_dir)
                full_path_target = parse_path(file['target'], path_app_dir)
                assert os.path.exists(full_path_source)
                create_symlink(full_path_source, full_path_target)
            else:
                print('Unknown type: ' + file['type'])

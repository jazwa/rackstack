#!/usr/bin/env python3

import argparse
import subprocess
import os
import sys


# For actual dimensions, please see profiles.scad.
class BuildSizeConfig:
    MINI = 'mini'
    MICRO = 'micro'
    DEFAULT = 'default'


RACK_BUILD_DIR = './rack/print'
RACK_MOUNT_BUILD_DIR = './rack-mount/print'

RACK_BUILD_TARGET_DIR = './stl/rack'
RACK_MOUNT_BUILD_TARGET_DIR = './stl/rack-mount'


def main():
    if not assert_os():
        print("Linux Required for OpenSCAD CLI")
        return

    parser = argparse.ArgumentParser(
        prog='rbuild',
        description='CLI-based helper utility to build project items. '
                    'This includes both the rack and also rack-mount items',
        epilog='That\'s all folks!'
    )

    parser.add_argument(
        '-b',
        nargs='?',
        const='all',
        help='Build command. Optionally pass in a specific part name to only build that item. '
             'Defaults to building everything'
    )

    parser.add_argument(
        '-c',
        default='default',
        choices=[BuildSizeConfig.MINI, BuildSizeConfig.MICRO, BuildSizeConfig.DEFAULT],
        help='Build size config profile. This will determine the size of the rack you wish to generate. '
             'For actual dimensions, please see profiles.scad.'
    )

    args = parser.parse_args()

    build_var = args.b
    config_var = args.c

    run_build(build_var, config_var)


def run_build(build_var, config_var):
    if build_var == 'all':
        for dir_file in os.listdir(RACK_BUILD_DIR):
            build_single(RACK_BUILD_DIR, RACK_BUILD_TARGET_DIR, dir_file, config_var)

        for dir_file in os.listdir(RACK_MOUNT_BUILD_DIR):
            build_single(RACK_MOUNT_BUILD_DIR, RACK_MOUNT_BUILD_TARGET_DIR, dir_file, config_var)

        return

    filename_rack = find_rack(build_var)
    filename_rack_mount = find_rack_mount(build_var)

    if not (filename_rack or filename_rack_mount):
        print('File:', build_var, 'not found!')
        return

    if filename_rack:
        build_single(RACK_BUILD_DIR, RACK_BUILD_TARGET_DIR, filename_rack, config_var)

    if filename_rack_mount:
        build_single(RACK_MOUNT_BUILD_DIR, RACK_MOUNT_BUILD_TARGET_DIR, filename_rack, config_var)


def build_single(build_dir, target_dir, filename, config):
    print('Building:', filename, 'from', build_dir, 'to', target_dir)
    run_openscad(construct_openscad_args(build_dir, target_dir, filename, config))


def construct_openscad_args(build_dir, target_dir, filename, config):
    source = os.path.join(build_dir, filename)
    target = os.path.join(target_dir, os.path.splitext(filename)[0] + '.stl')

    return ['-o', target, source]


def find_rack(filename):
    return find_scad_file(RACK_BUILD_DIR, filename)


def find_rack_mount(filename):
    return find_scad_file(RACK_MOUNT_BUILD_DIR, filename)


def find_scad_file(directory, filename):
    for dir_file in os.listdir(directory):
        dir_file_normalized = dir_file.lower()
        filename_normalized = filename.lower()

        if dir_file_normalized.endswith("_p.scad"):
            dir_file_normalized = dir_file_normalized[:-7]

        if filename_normalized.endswith("_p.scad"):
            filename_normalized = filename_normalized[:-7]

        if dir_file_normalized == filename_normalized \
                or os.path.splitext(dir_file_normalized)[0] == filename_normalized:
            return dir_file
    return None


def run_openscad(options=['-h']):
    command = ['openscad', '-q'] + options
    try:
        subprocess.check_output(command, universal_newlines=True, stderr=subprocess.DEVNULL)

    except FileNotFoundError:
        print('OpenSCAD command not found! '
              'Please make sure that you have OpenSCAD installed and can run OpenSCAD CLI commands. '
              '(Currently need Linux for this)')


def assert_os():
    if sys.platform == 'linux':
        return True
    else:
        return False


if __name__ == '__main__':
    main()

#!/usr/bin/env python3

import argparse
import subprocess
import os
import sys


# For actual dimensions, please see profiles.scad.
class BuildSizeConfig:
    NANO = 'nano'
    MINI = 'mini'
    MICRO = 'micro'


RACK_BUILD_DIR = './rack/print'
RACK_MOUNT_BUILD_DIR = './rack-mount/print'

BUILD_PARENT_DIR = './stl'

RACK_BUILD_TARGET_SUB_DIR = 'rack'
RACK_MOUNT_BUILD_TARGET_SUB_DIR = 'rack-mount'


def main():
    if not assert_os():
        print("Linux Required for OpenSCAD CLI")
        return

    parser = argparse.ArgumentParser(
        prog='rbuild',
        description='CLI-based helper utility to build project items. '
                    'This includes both the rack and also rack-mount items'
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
        default=BuildSizeConfig.MICRO,
        choices=[BuildSizeConfig.NANO, BuildSizeConfig.MINI, BuildSizeConfig.MICRO],
        help='Build size config profile. This will determine the size of the rack you wish to generate. '
             'For actual dimensions, please see profiles.scad.'
    )

    parser.add_argument(
        '-t',
        default="",
        help='Target directory to build STLs in (is under the /stl directory). Default target directory is based on '
             'the config.'
    )

    parser.add_argument(
        '-dz',
        default=0,
        help='Override number of rail screws (ie override rail height). Defaults to profile settings.'
    )

    parser.add_argument(
        '--nightly',
        action='store_true',
        help='Use openscad-nightly command. Should result in much faster build times.'
    )

    args = parser.parse_args()
    run_build(args)


def run_build(args):

    build_var = args.b
    config_var = args.c
    target_var = args.t
    dz = args.dz
    nightly = args.nightly

    if target_var != "":
        final_target_directory_name = target_var
    else:
        final_target_directory_name = config_var

    rackBuildDirFull = os.path.join(BUILD_PARENT_DIR, final_target_directory_name, RACK_BUILD_TARGET_SUB_DIR)
    rackMountBuildDirFull = os.path.join(BUILD_PARENT_DIR, final_target_directory_name, RACK_MOUNT_BUILD_TARGET_SUB_DIR)

    if not os.path.exists(rackBuildDirFull):
        os.makedirs(rackBuildDirFull)

    if not os.path.exists(rackMountBuildDirFull):
        os.makedirs(rackMountBuildDirFull)

    if build_var == 'all':
        for dir_file in os.listdir(RACK_BUILD_DIR):
            build_single(RACK_BUILD_DIR, rackBuildDirFull, dir_file, config_var, dz, nightly)

        for dir_file in os.listdir(RACK_MOUNT_BUILD_DIR):
            build_single(RACK_MOUNT_BUILD_DIR, rackMountBuildDirFull, dir_file, config_var, dz, nightly)
        return

    filename_rack = find_rack(build_var)
    filename_rack_mount = find_rack_mount(build_var)

    if not (filename_rack or filename_rack_mount):
        print('File:', build_var, 'not found!')
        return

    if filename_rack:
        build_single(RACK_BUILD_DIR, rackBuildDirFull, filename_rack, config_var, dz, nightly)

    if filename_rack_mount:
        build_single(RACK_MOUNT_BUILD_DIR, rackMountBuildDirFull, filename_rack, config_var, dz, nightly)


def build_single(build_dir, target_dir, filename, config, dz, nightly):
    print('Building:', filename, 'from', build_dir, 'to', target_dir)
    openscad_args = construct_openscad_args(build_dir, target_dir, filename, config, dz)
    run_openscad(openscad_args, nightly)


def construct_openscad_args(build_dir, target_dir, filename, config, dz):
    source = os.path.join(build_dir, filename)
    target = os.path.join(target_dir, os.path.splitext(filename)[0] + '.stl')

    openscad_args = ['-D', 'profileName=\"' + config + '\"']

    if dz != 0:
        openscad_args += ['-D', 'numRailScrews=' + dz]

    openscad_args += ['-o', target, source]

    return openscad_args


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


def run_openscad(options, nightly):

    if nightly:
        command = ['openscad-nightly', '--enable', 'all']
    else:
        command = ['openscad']

    command += ['-q', '--export-format', 'binstl'] + options
    try:
        subprocess.check_output(command, universal_newlines=True, stderr=subprocess.DEVNULL)

    except FileNotFoundError:
        print('OpenSCAD command not found! '
              'Please make sure that you have OpenSCAD installed and can run OpenSCAD CLI commands. '
              '(Currently needs Linux for this)')


def assert_os():
    if sys.platform == 'linux':
        return True
    else:
        return False


if __name__ == '__main__':
    main()

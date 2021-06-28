import os
import sys
import re
from os import mkdir
import subprocess
from datetime import datetime
from typing import Dict, List, Union
import argparse

USER = 'omid'
PICTURES = f'/home/{USER}/Pictures'
DIR_PATH = PICTURES
SS_PATH = os.path.join(DIR_PATH, 'SS')
INDEX_ROOT = os.path.join(SS_PATH, '_Index')
BACKUP_PATH = os.path.join(DIR_PATH, 'temp_backup')
BACKUP2_PATH = os.path.join(DIR_PATH, '.Index_backup')

utils = {
    'sanityCheck': lambda x: x.replace('(', r'\(').replace(')', r'\)').replace(' ', r'\ ').replace('&', r'\&')
}
ndict = {}


def _search_dir(list) -> List:
    pass


def ss_name_fixer():
    fix_counter = 0
    for (root, dirs, files) in os.walk(SS_PATH, topdown=True):
        for directory in dirs:
            with os.scandir(os.path.join(SS_PATH, directory)) as entries:
                for entry in entries:
                    if re.match(r'\d+', entry.name):
                        fix_counter += 1
                        print(f'{fix_counter} files are Already fixed')
                        continue
                    name = entry.name
                    entry_folder = os.path.dirname(entry)

                    path = entry.path
                    path_sh = utils['sanityCheck'](path)

                    date_pattern = r'_(\d|-|_)+_(\d|:)+'
                    date_strip_part = re.search(date_pattern, name).group(0)[1:]

                    date_part = re.search(date_pattern, name).group(0)
                    name_part = name.replace(date_part, '')

                    new_name = date_strip_part + '_' + name_part
                    new_path = os.path.join(entry_folder, new_name)
                    new_path_sh = utils['sanityCheck'](new_path)

                    subprocess.run([f"mv {path_sh} {new_path_sh}"], shell=True)


def searchDict():
    print('Searching for new screenshots ...')
    with os.scandir(DIR_PATH) as entries:
        for entry in entries:
            date_pattern = r'_\d{4}-\d{2}-\d{2}_\d{2}:\d{2}:\d{2}'
            result = re.search(date_pattern, entry.name)
            if result:
                name_date_part = result.group(0)[1:]
                name_name_part = entry.name.replace(name_date_part, '')
                category = re.match(r'[a-zA-Z]+', name_name_part).group(0)
                no_head_name = entry.name.replace(category, '')

                if re.match(r'[^_]+', no_head_name):
                    print(f'{entry.name} does not have a valid Name\
                     please do something about it')
                    continue

                if not ndict.__contains__(category):
                    ndict[category] = []

                ndict[category].append(entry.name)


def move_to_ss():
    print('copy process ...')
    if len(ndict.keys()) == 0:
        print('There is noting to copy')
        raise
    for foldername, filenames in ndict.items():
        path_to_create = os.path.abspath(os.path.join(SS_PATH, foldername))
        # path_to_create_sh = utils['sanityCheck'](path_to_create)

        if not os.path.isdir(path_to_create):
            os.mkdir(path_to_create)

        for filename in filenames:
            date_pattern = r'_\d{4}-\d{2}-\d{2}_\d{2}:\d{2}:\d{2}'
            date_part = re.search(date_pattern, filename).group(0)
            date_strip_part = re.search(date_pattern, filename).group(0)[1:]

            name_part = filename.replace(date_part, '')
            new_name = date_strip_part + '_' + name_part

            if not os.path.isfile(os.path.join(path_to_create, new_name)):
                filename = utils['sanityCheck'](filename)
                new_name_path = os.path.join(path_to_create, new_name)
                new_name_path_sh = utils['sanityCheck'](new_name_path)
                subprocess.run(
                    [f"mv {os.path.join(DIR_PATH, filename)} {new_name_path_sh}"],
                    shell=True
                )
            else:
                print(f'{new_name} is already in {foldername}')


def linker():
    print('Indexing ...')
    for (root, dirs, files) in os.walk(SS_PATH, topdown=True):
        for dirname in dirs:
            if dirname == '_Index':
                continue
            with os.scandir(os.path.join(SS_PATH, dirname)) as entries:
                for entry in entries:
                    entry_name = entry.name
                    entry_folder = os.path.dirname(entry)

                    entry_path = entry.path
                    entry_path_sh = utils['sanityCheck'](entry_path)

                    date_pattern = r'\d{4}-\d{2}-\d{2}'
                    date_part = re.search(date_pattern, entry_name).group(0)
                    month_part = date_part[5:-3]
                    folder_to_create = os.path.join(INDEX_ROOT, month_part)
                    if not os.path.isdir(folder_to_create):
                        os.mkdir(folder_to_create)
                        print(f'month {month_part} is created')
                    file_to_create = os.path.join(folder_to_create, entry_name)
                    if not os.path.isfile(file_to_create):
                        file_to_create_sh = utils['sanityCheck'](file_to_create)
                        subprocess.run([f"ln -s {entry_path_sh} {file_to_create_sh}"], shell=True)
                        print(f'{entry_name} Indexed')


def main():
    try:
        searchDict()
    except Exception as err:
        print(err)
        return
    try:
        move_to_ss()
    except Exception as err:
        print(err)
        return
    try:
        linker()
    except Exception as err:
        print(err)
        return
    print('Done')


operations_dict = {
    'main': main,
    'fix_ss': ss_name_fixer,
    'fix_index': linker,
}


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('operation', help='operation to do')
    args = parser.parse_args()
    try:
        operations_dict[args.operation]()
    except Exception as err:
        print(f'something went wrong. check your input argument\n Error: {err}')

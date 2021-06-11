import os
import sys
import re
from os import mkdir
import subprocess
from datetime import datetime
import argparse

USER = 'omid'
PICTURES = f'/home/{USER}/Pictures'
DIR_PATH = PICTURES
SS_PATH = os.path.join(DIR_PATH, 'SS')
BACKUP_PATH = os.path.join(DIR_PATH, 'temp_backup')
BACKUP2_PATH = os.path.join(DIR_PATH, '.Index_backup')
INDEX_ROOT = os.path.join(DIR_PATH, 'Index')
#ORGANIZER_BOOK = os.path.join(os.path.abspath(os.path.dirname(__file__)), 'organize_book')

utils = {
    'sanityCheck': lambda x: x.replace('(', r'\(').replace(')', r'\)').replace(' ', r'\ ').replace('&', r'\&')
}
ndict = {}
idict = {}


def searchDict():
    with os.scandir(DIR_PATH) as entries:
        for entry in entries:
            date_pattern = r'_(\d|-|_)+_(\d|:)+'
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


def coppier():
    if len(ndict.keys()) == 0:
        print('There is not anything to copy')
        raise
    for foldername, filenames in ndict.items():
        path_to_create = os.path.abspath(os.path.join(SS_PATH, foldername))
        path_to_create_sh = utils['sanityCheck'](path_to_create)
        if not os.path.isdir(path_to_create):
            os.mkdir(path_to_create)
        for filename in filenames:
            if not os.path.isfile(os.path.join(path_to_create, filename)):
                name_sh = utils['sanityCheck'](filename)
                subprocess.run(
                    [f"cp {os.path.join(DIR_PATH, name_sh)} {path_to_create_sh}"],
                    shell=True
                )
            else:
                print(f'{filename} is already in {foldername}')
                # pass


def backup_photos_folder():
    if not os.path.isdir(os.path.join(DIR_PATH,'temp_backup')):
        os.mkdir(os.path.join(DIR_PATH,'temp_backup'))
    for filenames in ndict.values():
        for filename in filenames:
            if not os.path.isfile(os.path.join(DIR_PATH, f'temp_backup/{filename}')):
                name_sh = utils['sanityCheck'](filename)
                subprocess.run(
                    [f"cp {os.path.join(DIR_PATH, name_sh)} {os.path.join(DIR_PATH, 'temp_backup')}"],
                    shell=True
                )
            else:
                print('backup is already there')


def linker():
    backup_photos_folder()
    for foldername, filenames in ndict.items():
        for name in filenames:
            date_pattern = r'_(\d|-|_)+_(\d|:)+'
            date_group0 = re.search(date_pattern, name).group(0)

            name_part = name.replace(date_group0, '')
            new_name = date_group0[1:] + name_part

            new_name_sh = utils['sanityCheck'](new_name)
            name_sh = utils['sanityCheck'](name)

            sub_SS_folder = os.path.join(SS_PATH, foldername)
            month_part = re.search(r'-\d\d-', date_group0).group(0).replace('-', '')
            if not os.path.isdir(os.path.join(INDEX_ROOT, month_part)):
                os.mkdir(os.path.join(INDEX_ROOT, month_part))
            if not os.path.isfile(os.path.join(INDEX_ROOT, month_part, new_name)):
                subprocess.run(
                    [f"ln -s {os.path.join(sub_SS_folder, name_sh)}\
                    {os.path.join(INDEX_ROOT,month_part,new_name_sh)}"],
                    shell=True
                )
            else:
                print(f'{new_name} is already in {os.path.join(INDEX_ROOT,month_part)}')


def make_backup_permanent():
    date_time = re.match(r'(\d|-|\s|:)+', str(datetime.now())).group(0)
    backup_path = os.path.join(BACKUP2_PATH, date_time)
    backup_path_sh = utils['sanityCheck'](backup_path)
    os.mkdir(backup_path)
    try:
        for foldername, filenames in ndict.items():
            for filename in filenames:
                name_sh = utils['sanityCheck'](filename)
                if not os.path.isfile(os.path.join(backup_path, name_sh)):
                    subprocess.run([f'mv {os.path.join(DIR_PATH, name_sh)} {backup_path_sh}'], shell=True)
    except:
        pass


def get_month():
    str1 = ''
    with os.scandir(INDEX_ROOT) as entries:
        for entry in entries:
            str1 = str1 + f"{entry.name}\n"
    sys.stdout.write(str1)

def open_index_folder():
    with os.
    print(sys.stdin.read())

def index():
    try:
        searchDict()
    except:
        return 1
    try:
        coppier()
    except:
        return 1
    try:
        linker()
    except:
        return 1
    try:
        make_backup_permanent()
    except:
        return 1
    subprocess.run([f"rm -r {utils['sanityCheck'](BACKUP_PATH)}"], shell=True)
    print('Done')


operations_dict = {
    'index': index,
    'get_month': get_month,
    'openin': open_index_folder
}


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('operation', help='operation to do')
    args = parser.parse_args()
    try:
        operations_dict[args.operation]()
    except:
        print('the operation is not defined')
    # index()

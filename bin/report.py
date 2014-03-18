#!/usr/bin/env python

import os
import fnmatch


def get_files(pattern):
    '''Return the matching files.'''

    listing = []

    for root, dirs, files in os.walk('.'):
        for name in fnmatch.filter(files, pattern):
            listing.append(os.path.join(root, name))
    return listing


def trailing_whitespaces_report(filename):
    '''Report trailing whitespaces in a file.'''

    with open(filename) as f:
        for count, line in enumerate(f.readlines(), start=1):
            line = line.rstrip('\n').rstrip('\r')
            if line.endswith(' ') or line.endswith('\t'):
                print('Trailing whitespace at {}, line {}.\n>>> {}'.format(
                    filename, count, line))


def main(file_type):

    for f in get_files(file_type):
        trailing_whitespaces_report(f)


if __name__ == '__main__':
    import argparse
    parser = argparse.ArgumentParser(description='Trailing whitespaces report')
    parser.add_argument('--file-type', '-f', help='file type', default='*.[ch]')

    args = parser.parse_args()

    main(** vars(args))

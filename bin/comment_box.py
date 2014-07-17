#!/usr/bin/env python

import sys

EMPTY_BOX = """\
/*%(del)s-.
| %(msg)s |
`-%(del)s*/"""

DELIMITER = '-'


def get_box(msg, box=EMPTY_BOX, delimiter=DELIMITER):
    text = ' '.join(msg)
    return box % {'del': delimiter * len(text), 'msg': text}


def main():

    if len(sys.argv) < 2:
        print("Usage: {} message".format(sys.argv[0]))
        exit(1)

    print(get_box(sys.argv[1:]))
    exit(0)

if __name__ == '__main__':
    main()

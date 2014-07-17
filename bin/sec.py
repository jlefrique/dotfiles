#!/usr/bin/env python

import sys
import datetime


def second_to_time(sec):
    return datetime.timedelta(seconds=sec)


def main():

    if len(sys.argv) < 2:
        print("Usage: {} second".format(sys.argv[0]))
        exit(1)

    sec = int(sys.argv[1])
    print(second_to_time(sec))
    exit(0)

if __name__ == '__main__':
    main()

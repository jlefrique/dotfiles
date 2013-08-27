#!/usr/bin/env python

import threading
import datetime
import sys

INCREMENT_S = 1


class Stopwatch(object):

    def __init__(self):
        self.counter = 0
        self.timer = None

    def start(self):
        self.counter = 0
        sys.stdout.write("Start time: {}\n".format(datetime.datetime.now()))
        self._run()

    def stop(self):
        if self.timer:
            self.timer.cancel()
        sys.stdout.write("\nStop time: {}\n".format(datetime.datetime.now()))

    def _run(self):
        self._update(self.counter)
        self.counter += INCREMENT_S
        self.timer = threading.Timer(INCREMENT_S, self._run)
        self.timer.start()

    def _update(self, count):
        sys.stdout.write("\r{}".format(datetime.timedelta(seconds=count)))
        sys.stdout.flush()


def main():
    sw = Stopwatch()
    sw.start()

if __name__ == '__main__':
    main()

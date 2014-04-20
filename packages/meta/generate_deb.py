#!/usr/bin/env python

import yaml
import os
import subprocess


TEMPLATE = """Section: %(author)s
Priority: optional
Standards-Version: 3.9.2

Package: %(author)s-%(category)s
Depends: %(depends)s
Description: %(category)s
"""


def main():

    with open('packages.yaml', 'r') as f:
        config = yaml.load(f)

    for package in config.get('packages'):
        for category, plist in package.iteritems():
            content = TEMPLATE % {'author': config.get('author'),
                                  'category': category,
                                  'depends': ', '.join(plist)}

            fname = category
            with open(fname, 'w') as out:
                out.write(content)
            subprocess.call(['equivs-build', fname])
            os.remove(fname)


if __name__ == "__main__":
    main()

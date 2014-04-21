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


def generate_package(author, category, packages):

    content = TEMPLATE % {'author': author,
                          'category': category,
                          'depends': ', '.join(packages)}

    fname = category
    with open(fname, 'w') as f:
        f.write(content)
    subprocess.call(['equivs-build', fname])
    os.remove(fname)


def main():

    with open('packages.yaml', 'r') as f:
        config = yaml.safe_load(f)

    all_packages = []
    author = config.get('author')
    for package in config.get('packages'):
        for category, plist in package.iteritems():
            all_packages.extend(plist)
            generate_package(author, category, plist)

    generate_package(author, 'full', all_packages)

    with open('packages_list.txt', 'w') as f:
        f.write(' '.join(all_packages))


if __name__ == "__main__":
    main()

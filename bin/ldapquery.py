#!/usr/bin/env python

# LDAP Query tool for mail clients (Mutt query_command for example)
# Copyright (C) 2009 Maxime Petazzoni <maxime.petazzoni@bulix.org>
#
# Modified by Julien Lefrique
#
# Requires the python-ldap module.

import datetime
import ldap
import sys
import getpass

_FILTER = "(&(objectClass=person)(|(cn=*%(search)s*)(mail=*%(search)s*)))"
_FORMAT = '%(mail)s\t%(name)s\t%(info)s'


def get_infos(attrs, keys):
    """Returns a list of extra information extracted from the given attribute
    keys, when they are available."""

    infos = []
    for k in keys:
        if k in attrs:
            infos.append(attrs[k][0])
    return infos


def display(entry):
    """Displays a result line from the LDAP result tuple (dn, attrs)."""

    _, attrs = entry
    person = {
        'mail': attrs.get('mail', [''])[0],
        'name': attrs.get('cn', [''])[0],
        'info': ', '.join(get_infos(attrs, ['roomNumber',
                                            'telephoneNumber']))
    }

    print _FORMAT % person


def get_credentials(username):
    """Request the user password."""

    print "Requesting password for username '%s': " % username
    password = getpass.getpass()
    return password


def main(server, base, search, port, dn):
    """Perform an LDAP search on the given server with _FILTER and display the
    results using _FORMAT.

    Args:
        server (string): hostname of the LDAP server.
        base (string): the search base in the LDAP tree (ou=...,dc=...).
        search (string): the search term, may contain spaces.
        port (integer): LDAP port.
    """

    if not len(search.strip()):
        print 'Error: no search pattern.'
        return 1

    secret = get_credentials(dn)

    c = ldap.open(server, port)
    try:
        c.simple_bind_s(dn, secret)
    except ldap.INVALID_CREDENTIALS:
        print 'Error: invalid credentials.'
        return 1

    try:
        start = datetime.datetime.now()
        results = c.search_st(base, ldap.SCOPE_SUBTREE,
                              filterstr=_FILTER % {'search': search},
                              timeout=30)
        elapsed = datetime.datetime.now() - start
    except ldap.LDAPError, e:
        print 'Error:', e.desc
        return 1

    print 'Found %d matching entries (t: %s):' % (len(results), elapsed)
    map(display, results)
    return 0

if __name__ == '__main__':
    sys.exit(main(server='localhost',
                  base='ou=people',
                  port=1389,
                  dn='Debiotech\j.lefrique',
                  search=' '.join(sys.argv[1:])))

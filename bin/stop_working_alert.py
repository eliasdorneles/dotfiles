#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""Tell me to stop working when I pass the 8 hours limit
"""

from __future__ import print_function
import datetime
import os
import sqlite3
import subprocess
from collections import namedtuple


DB_PATH = '~/.local/share/hamster-applet/hamster.db'


Interval = namedtuple('Interval', 'start end')


def parse_date(s):
    return datetime.datetime.strptime(s, '%Y-%m-%d %H:%M:%S') if s else None


def fetch_today_timetable(db_file):
    conn = sqlite3.connect(os.path.expanduser(db_file))
    now = datetime.datetime.now()
    query = ("SELECT start_time,end_time FROM facts"
             " WHERE start_time >= DATETIME('%s') limit 10" % now.date())
    return [Interval(parse_date(start), parse_date(end))
            for start, end in conn.execute(query)]


def calc_duration(interval):
    end = interval.end if interval.end else datetime.datetime.now()
    return end - interval.start


def is_still_working(timetable):
    last_entry = timetable[-1]
    return last_entry[-1] is None


def notify(title, mesg, icon='emblem-art'):
    subprocess.check_output(['notify-send', '-i', icon, title, mesg])


def run(args):
    timetable = fetch_today_timetable(args.db_file)
    worked_hours = sum(calc_duration(t).total_seconds()
                       for t in timetable) / 60 / 60
    if worked_hours > args.hours_limit and is_still_working(timetable):
        extra_minutes = (worked_hours - args.hours_limit) * 60
        notify("Stop working, dude", "You've already worked %.02f hours today"
               " (%.02f min extra)" % (worked_hours, extra_minutes))


if '__main__' == __name__:
    import argparse
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--hours-limit', type=int, default=8)
    parser.add_argument('--db-file', default=DB_PATH)

    args = parser.parse_args()
    run(args)

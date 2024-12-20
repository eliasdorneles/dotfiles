#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""Plot events over a time axis
"""
# Relies on matplotlib and dateutil

from __future__ import print_function, absolute_import, division
import sys
import dateutil.parser
import datetime
from matplotlib import pyplot as plt
from matplotlib import dates as mdates


USE_DATEPARSER = False


def read_input(input_path):
    if input_path == "-":
        return list(sys.stdin)
    with open(input_path) as f:
        return list(f)


def parse_timestamp(ts):
    try:
        return datetime.datetime.fromtimestamp(ts)
    except ValueError:
        return datetime.datetime.fromtimestamp(ts / 1000)


def parse_date(dttime):
    if USE_DATEPARSER:
        import dateparser
        return dateparser.parse(dttime)

    # TODO: catch ValueError and suggest user to use delimiter if needed
    if dttime.isdigit():
        return parse_timestamp(int(dttime))
    return dateutil.parser.parse(dttime)


def _parse_line(line, delimiter):
    parsed = line.split(delimiter)
    dt = parsed[0]
    event = "no-label"
    if len(parsed) > 1:
        event = parsed[1]
        if event.strip().isdigit():
            event = int(event)
    return parse_date(dt), event


def parse_input(input_lines, delimiter):
    data = [_parse_line(l, delimiter) for l in input_lines]
    return list(zip(*data))


def main(args):
    datetimes, values = parse_input(read_input(args.input), args.delimiter)
    event_times = mdates.date2num(datetimes)
    if args.title:
        plt.title(args.title)

    if args.sum_by_date:
        import itertools
        combined = [
            (k, sum(v for _, v in group))
            for k, group in
            itertools.groupby(zip(event_times, values), key=lambda x: x[0])
        ]
        event_times, values = zip(*combined)

    # ax = plt.subplot()
    # ax.plot(event_times, values, 'o', alpha=0.5)
    # ax.xaxis_date()
    # ax.autoscale_view()
    plt.plot_date(event_times, values, alpha=0.5)

    plt.gcf().autofmt_xdate()
    plt.show()


if "__main__" == __name__:
    import argparse

    parser = argparse.ArgumentParser(description=__doc__)
    # TODO: consider making combine generic
    parser.add_argument("--sum-by-date", action='store_true')
    parser.add_argument("input", nargs='?', default="-")
    parser.add_argument("-d", "--delimiter", default="\t")
    parser.add_argument("-t", "--title")
    parser.add_argument("--use-dateparser", action='store_true')

    args = parser.parse_args()
    if args.use_dateparser:
        USE_DATEPARSER = True
    main(args)

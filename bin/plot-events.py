#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""Plot events over a time axis
"""
# Requires matplotlib and python-dateutil libraries installed

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
    # TODO: catch ValueError and suggest user to use delimiter if needed
    if dttime.isdigit():
        return parse_timestamp(int(dttime))

    if USE_DATEPARSER:
        import dateparser

        return dateparser.parse(dttime)

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

    if args.sum_by_date:
        import itertools

        combined = [
            (k, sum(v for _, v in group))
            for k, group in itertools.groupby(
                zip(event_times, values), key=lambda x: x[0]
            )
        ]
        event_times, values = zip(*combined)

    fig, ax = plt.subplots()
    if args.title:
        ax.set_title(args.title)

    ax.xaxis_date()
    ax.autoscale_view()

    # TODO: consider adding CLI option to set date format
    # ax.xaxis.set_major_formatter(mdates.DateFormatter("%Y-%m-%d %H:%M"))

    plt.plot(event_times, values, args.fmt, alpha=0.5)

    plt.gcf().autofmt_xdate()
    plt.show()


if "__main__" == __name__:
    import argparse

    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "input", nargs="?", default="-", help="Input file. Default: stdin"
    )

    # TODO: consider refactoring --sum-by-date into a more generic --aggregate-by AGGREGATE_FN option
    parser.add_argument(
        "--sum-by-date",
        action="store_true",
        help="When given, assumes input is in format 'DATE COUNT', sum up the counts for the same date and plot it.",
    )

    parser.add_argument(
        "-d",
        "--delimiter",
        default=None,
        help="Default: whitespace",
    )
    parser.add_argument("-t", "--title")
    parser.add_argument(
        "--fmt",
        default="o",
        choices=["-", "o", "x"],
        help="Matplotlib graph style. Default: 'o'",
    )
    parser.add_argument("--use-dateparser", action="store_true")

    args = parser.parse_args()
    if args.use_dateparser:
        USE_DATEPARSER = True
    main(args)

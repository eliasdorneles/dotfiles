#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import re
import glob

def find_sub_to_rename(video_id, videofile, sub_ext):
    video_dir = os.path.dirname(os.path.realpath(videofile))
    sub_files = glob.glob('%s/*%s*%s' % (video_dir, video_id, sub_ext))
    if sub_files:
        first_sub = sub_files[0]
        basename, _ = os.path.splitext(videofile)
        newfilename = '%s.%s' % (basename, sub_ext)
        if newfilename not in sub_files:
            return (sub_files[0], newfilename)
        else:
            return (newfilename, None)
    return (None, None)

def run(args):
    name_patterns = [
        re.compile(r'.*(\dx\d\d).*'),
        re.compile(r'.*(s\d\de\d\d).*')
    ]
    sub_ext = args.sub_extension
    for videofile in args.video:
        found = False
        for pattern in name_patterns:
            match = pattern.match(videofile)
            if match:
                video_id = match.group(1)
                oldname, newname = find_sub_to_rename(
                    video_id, videofile, sub_ext)
                if oldname:
                    found = True
                if newname:
                    if not args.skip_rename:
                        os.rename(oldname, newname)
                    print '%s -> %s' % (os.path.basename(oldname), os.path.basename(newname))
        if not found:
            print "Could not found subs for %s" % videofile

if '__main__' == __name__:
    import argparse
    parser = argparse.ArgumentParser(description="Script to mass-rename subtitles")
    parser.add_argument('video', nargs='+',
                        help='List of video files to seek subtitle')
    parser.add_argument('-n', dest='skip_rename', action='store_true',
                        help='Just print what it will do, does NOT rename anything')
    parser.add_argument('--sub-extension', default='srt',
                        help='Subtitle extension to use (default: srt)')
    args = parser.parse_args()
    run(args)

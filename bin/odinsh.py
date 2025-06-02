#!/usr/bin/env python
"""
A very hacky REPL for the Odin programming language.

This is mostly to help with exploring functions from the Odin standard library
and to test one-line snippets of Odin code quickly.
Anything more than a single line deserves a dedicated file.
"""

import argparse
import atexit
import os
import readline
import sys
import tempfile

odin_program_template = """
package main

import "core:fmt"
import "core:strings"
import "core:time"
import "core:c/libc"
import "core:math"
import "core:path/filepath"


main :: proc () {
    fmt.println(__INPUT_CODE_HERE__)
}
"""

history_file = os.path.join(os.path.expanduser("~"), ".odinsh_history")


def setup_readline():
    """Sets up readline for history with input()."""
    try:
        # Load history if it exists
        if os.path.exists(history_file):
            readline.read_history_file(history_file)
    except IOError:
        pass  # History file might not exist yet

    readline.set_history_length(1000)

    atexit.register(readline.write_history_file, history_file)


def run(args):
    setup_readline()
    try:
        tmp_dir = tempfile.TemporaryDirectory(prefix="odinsh_")
        print("Using temp dir", tmp_dir.name)
        os.chdir(tmp_dir.name)
        while code_line := input("> "):
            code = odin_program_template.replace("__INPUT_CODE_HERE__", code_line)
            with open("main.odin", "w") as f:
                f.write(code)
            if args.debug:
                print("Running code:", code)
            os.system("odin run main.odin -file")
    except EOFError:
        print("Bye")
        sys.exit(0)


if "__main__" == __name__:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "-d", "--debug", action="store_true", help="Print debugging info"
    )

    args = parser.parse_args()
    run(args)

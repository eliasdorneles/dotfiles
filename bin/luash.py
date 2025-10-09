#!/usr/bin/env python3
"""
A very hacky REPL for the Odin programming language.

This is mostly to help with exploring functions from the Odin standard library
and to test one-line snippets of Odin code quickly.
"""

import argparse
import atexit
import os
import readline
import sys
import tempfile

lua_program_template = """
__PREAMBLE_CODE_HERE__

print(__INPUT_CODE_HERE__)
"""

history_file = os.path.join(os.path.expanduser("~"), ".luash_history")


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
    tmp_dir = tempfile.TemporaryDirectory(prefix="luash_")
    print("Using temp dir", tmp_dir.name)
    os.chdir(tmp_dir.name)
    preamble = []
    try:
        while code_line := input("> "):
            if " = " in code_line: # Assume it's a variable assignment
                preamble.append(code_line)
                continue

            preamble_code = "\n    ".join(preamble)
            code = lua_program_template.replace(
                "__INPUT_CODE_HERE__", code_line
            ).replace("__PREAMBLE_CODE_HERE__", preamble_code)
            with open("main.lua", "w") as f:
                f.write(code)

            if args.debug:
                print("Running code:", code)

            exit_status = os.system("lua main.lua")

            if exit_status != 0 and preamble:
                print("luash: preamble code will be discarded -- please fix the error above.")
                print("--" * 20)
                print(preamble_code)
                print("--" * 20)
                preamble = []
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

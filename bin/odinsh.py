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

odin_program_template = """
package main

import "core:bytes"
import "core:fmt"
import "core:strings"
import "core:time"
import "core:time/datetime"
import "core:time/timezone"
import "core:c/libc"
import "core:math"
import "core:path/filepath"
import "core:strconv"
__EXTRA_IMPORTS_HERE__


main :: proc () {
    __PREAMBLE_CODE_HERE__
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
    tmp_dir = tempfile.TemporaryDirectory(prefix="odinsh_")
    print("Using temp dir", tmp_dir.name)
    os.chdir(tmp_dir.name)
    preamble = []
    extra_imports = []
    try:
        while code_line := input("> "):
            if "=" in code_line: # Assume it's a variable assignment
                preamble.append(code_line)
                continue
            if code_line.split()[0].endswith(":"): # Assume it's a variable decl
                preamble.append(code_line)
                continue
            if code_line.startswith("import "):
                extra_imports.append(code_line.strip())
                continue

            preamble_code = "\n    ".join(preamble)
            import_code = "\n".join(extra_imports)
            code = odin_program_template.replace(
                "__INPUT_CODE_HERE__", code_line
            ).replace("__PREAMBLE_CODE_HERE__", preamble_code).replace(
                "__EXTRA_IMPORTS_HERE__", import_code
            )
            with open("main.odin", "w") as f:
                f.write(code)

            if args.debug:
                print("Running code:", code)

            exit_status = os.system("odin run main.odin -file")

            if exit_status != 0 and preamble:
                print("odinsh: preamble and imports will be discarded -- please fix the error above.")
                print("--" * 20)
                print(import_code)
                print("--" * 20)
                print(preamble_code)
                print("--" * 20)
                preamble = []
                extra_imports = []
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

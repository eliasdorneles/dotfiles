#!/usr/bin/env python3
import os
import argparse
from PIL import Image


# Adapted from: https://29a.ch/2009/5/14/concatenating-images-using-python
def main(args):
    if os.path.exists(args.output):
        print(f"Output file {args.output} already exists. Please remove it first.")
        return
    print(f"Will spritify {len(args.src)} images")
    images = [Image.open(path) for path in args.src]
    w = sum(i.size[0] for i in images)
    mh = max(i.size[1] for i in images)

    result = Image.new("RGBA", (w, mh))

    x = 0
    for i in images:
        result.paste(i, (x, 0))
        x += i.size[0]

    result.save(args.output)
    print(f"Sprite sheet saved to {args.output}")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Combine images into a single sprite sheet."
    )
    parser.add_argument(
        "-o", "--output", default="output_sprite.png", help="Destination image file"
    )
    parser.add_argument("src", nargs="+", help="Source image files")
    args = parser.parse_args()
    main(args)

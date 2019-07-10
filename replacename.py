#!/usr/bin/env python3
"""
Usage:

```shell
$ ./replacename.py PKGNAME
```
"""
import argparse
import json
import os
import re


def rename(pkgname):
    workingdir = os.path.dirname(__file__) + "/"
    with open(workingdir + ".filelist.json") as f:
        files = json.load(f)["files"]
    for file in files:
        with open(os.path.abspath(workingdir + file), "r+") as f:
            content = f.read()
            content_new = re.sub('GitHubJuliaMITTemplate',
                                 pkgname, content)
            f.seek(0)
            f.write(content_new)
            f.truncate()  # This method is very important!
    os.rename(os.path.abspath(workingdir + "src/GitHubJuliaMITTemplate.jl"),
              os.path.abspath(workingdir + "src/{}.jl".format(pkgname)))


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('name', type=str)
    args = parser.parse_args()
    rename(args.name)

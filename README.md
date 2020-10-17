# cache-command

Run a command and cache its results. Works on Linux and Mac OSX.

`./cache-command [OPTIONS] -- COMMAND` saves the stdout, stderr, and exit code of COMMAND in a cache and
returns the same on subsequent invocations.

```bash
$ echo -e '#!/bin/bash\n echo stdout; sleep 5; echo stderr >&2; exit 1' > five-seconds
$ chmod 755 five-seconds
$ TIMEFORMAT=%R
$ time ./five-seconds ; echo "Exit code: $?"
stdout
stderr
5.004
Exit code: 1

$ time ./cache-command -- ./five-seconds ; echo "Exit code: $?"
stdout
stderr
5.012
Exit code: 1

$ time ./cache-command -- ./five-seconds ; echo "Exit code: $?"
stdout
stderr
0.010
Exit code: 1
```

**Note** that `cache-command` should not be used to run programs that output sensitive information.

Inspired by [this StackOverflow answer](https://unix.stackexchange.com/a/334568).

## Requirements

* [bash](https://www.gnu.org/software/bash/) (tested with v4.4.19)
* GNU Coreutils:
    * [tee](https://en.wikipedia.org/wiki/Tee_(command))
    * [sha256sum](https://linux.die.net/man/1/sha256sum)

## Installation

```bash
make install
```
    
## Usage

```bash
$ ./cache-command -h
Usage: cache-command [-b PATH] [-e SECONDS] [-h] [-p] [-r] [-v] -- COMMAND
```

Option|Description
---|---
`-b PATH` | Base directory for the cache (default: `${XDG_RUNTIME_DIR}/cache-command`)
`-e SECONDS` | Cache expiration in seconds
`-h` | Print help text
`-p` | Purge the cache for a particular command
`-r` | Remove the base directory (and any caches that it contains)
`-v` | Print verbose output to aid with debugging

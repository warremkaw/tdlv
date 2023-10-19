# tdlv

A shell script for viewing files from remote URLs with a user specified
program.

## Usage

See man page

## Examples

```
$ tdlv url1 url2 'sxiv -'
$ <urls tdlv 'sxiv -'
$ cat urls | tdlv 'xargs -n 1 -P 0 zathura'
```

## Install

```
make install
```
## Uninstall

```
make uninstall
```

## Dependencies
- `mktemp`
- `curl`


# Better P4 Output

A bunch of scripts to catch p4 commands, run them, and make their output better.

[![asciicast](https://asciinema.org/a/96884.png)](https://asciinema.org/a/96884)

# Colored Diffs!

BP4O will use [colordiff](http://www.colordiff.org/) to output diffs in color from commands like `p4 diff` and `p4 describe`

To get colored diffs, install [colordiff](http://www.colordiff.org/) and unset the `P4DIFF` environment variable.

# Aliases!

BP4O works with Perforce's builtin [aliasing](https://www.perforce.com/perforce/r16.1/manuals/cmdref/chapter.introduction.html#introduction.aliases)!

And BP4O provides its own aliasing:

To use BP4O aliases, add a file named `aliases` to `~/.config/bp4o/`.
Each line of `~/.config/bp4o/aliases` is treated as an alias with the syntax `<alias> = <command>`.

e.g.

```
ch = change
op = opened
su = submit
log = changes -s submitted -l
```

# How to install it

BP4O works with Bash, Zsh, and Fish shell

## Zsh Users

After installing, add this to your `~/.zshrc`:

```
autoload -Uz bp4o
bp4o
```

## macOS

```
brew tap zachwhaley/beer
brew install bp4o
```

## Ubuntu

```
sudo add-apt-repository ppa:zachwhaley/ppa
sudo apt update
sudo apt install bp4o
```

## Fedora/CentOS

```
sudo dnf copr enable zachwhaley/bp4o
sudo dnf install bp4o
```

## Manually

Use the `install.sh` script to install BP4O

### Install BP4O on the System

```
sudo ./install.sh
```

Or...

### Install BP4O in your home directory

```
./install.sh ~
```

Or...

### Install BP4O in some directory

```
./install.sh /some/dir
```

### Uninstall

Use the `-u` option in `install.sh` to uninstall BP4O

```
./install.sh -u ~
```

# How it works

It overrides the p4 command with a shell function named p4.
When a p4 command is issued, this function looks for executables in your PATH named p4-command.
It then gives the command line arguments to this executable, which runs the p4 command, parses the output, and prints better output.

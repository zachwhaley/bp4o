# Better P4 Output

A bunch of scripts to catch p4 commands, run them, and make their output better.

# What it does

## Better Ouput!

BP4O turns output like this...

![meh](http://i.imgur.com/euoNBOw.png)

Into this!

![WOW](http://i.imgur.com/atCFBp6.png)

## Colored Diffs!

BP4O will use [colordiff](http://www.colordiff.org/) to output diffs in color from commands like `p4 diff` and `p4 describe`

![colordiff](http://i.imgur.com/5jGjV7K.png)

To get colored diffs, install [colordiff](http://www.colordiff.org/) and unset `P4DIFF`.

## Aliases!

BP4O works with most basic [Perforce aliases](https://www.perforce.com/perforce/r16.1/manuals/cmdref/chapter.introduction.html#introduction.aliases)!

BP4O also provides its own aliasing for p4 clients that don't support Perforce aliases:

Add a file named `aliases` to `~/.config/bp4o/`.
Each line of `~/.config/bp4o/aliases` is treated as an alias with the syntax `<alias> = <command>`.

e.g.

```
ch = change
op = opened
su = submit
log = changes -s submitted -l
```

# How to install it

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

## Fedora

```
sudo dnf copr enable zachwhaley/bp4o
sudo dnf install bp4o
```

## Others

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

## Zsh Users

Load the BP4O Zsh function by adding this to your `~/.zshrc`:

```
autoload -Uz bp4o
bp4o
```

# How it works

It overrides the p4 command with a shell function named p4.
When a p4 command is issued, this function looks for executables in your PATH named p4-command.
It then gives the command line arguments to this executable, which runs the p4 command, parses the output, and prints better output.

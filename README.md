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

To get colored diffs, install [colordiff](http://www.colordiff.org/) and leave `P4DIFF` unset.

## Aliases!

BP4O allows you to create aliases for p4 commands

Add a file named `aliases` to `$XDG_CONFIG_HOME/bp4o/` or `~/.config/bp4o/`.
Each line of the file is treated as an alias with the syntax `<alias> = <command>`.

e.g.

```shell
ch = change
op = opened
su = submit
log = changes -s submitted -l
```

# How to install it

## macOS

```bash
brew tap zachwhaley/beer
brew install bp4o
```

## Linux

### Install BP4O on the System

```bash
sudo ./install.sh
```

Or...

### Install BP4O in your home directory

```bash
./install.sh ~
```

Or...

### Install BP4O in some directory

```bash
./install.sh /some/dir
```

## How to uninstall it

### macOS

```bash
brew uninstall bp4o
```

### Linux

Use the `-nope` option to uninstall BP4O.

Uninstall from the System

```bash
sudo ./install.sh -nope
```

Uninstall from your home directory

```bash
./install.sh -nope ~
```

Uninstall from some directory

```bash
./install.sh -nope /some/dir
```

# How it works

It overrides the p4 command with a shell function named p4.
When a p4 command is issued, this function looks for executables in your PATH named p4-command.
It then gives the command line arguments to this executable, which runs the p4 command, parses the output, and prints better output.

# Better P4 Output

A bunch of scripts to catch p4 commands, run them, and make their output better.

# What it does

It turns output like this...

![meh](http://i.imgur.com/euoNBOw.png)

Into this!

![WOW](http://i.imgur.com/atCFBp6.png)

# How to install it

```bash
# Install BP4O in /usr/local
sudo ./install.sh

# Install BP4O in your home directory
PREFIX=$HOME ./install.sh

# Install BP4O in some directory
PREFIX=/some/dir ./install.sh
```

# How it works

It overrides the p4 command with a shell function named p4.
When a p4 command is issued, this function looks for executables in your PATH named p4-command.
It then gives the command line arguments to this executable, which runs the p4 command, parses the output, and prints better output.

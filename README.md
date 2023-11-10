# ruthen1um's dotfiles

## Installation

### Requirements

`stow` is required. `git` is considered installed for the proposed installation method.

### Steps

1. Clone
[this repository](https://github.com/ruthen1um/dotfiles)
somewhere:
```shell
git clone https://github.com/ruthen1um/dotfiles.git ~/.dotfiles
```

2. `cd` to the cloned repo:
```shell
cd ~/.dotfiles
```

3. Install dotfiles in your `$HOME` using `stow`:
```shell
stow -S .
```

**NOTE**: `.` is a wildcard for everything in the stow directory

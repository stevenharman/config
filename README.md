# My config files

## Setup

The following rake tasks will set up symbolic links in your home directory for each of the included configuration files.

```bash
rake install
```

or

```bash
# Force overwriting everything
OVERWRITE_DOTFILES=true rake install
```

### Windows

The following rake task will tweak a few of the default configs to better behave on Windows.
I don't use Windows these days, so no guarantees.
If it breaks, feel free to keep both pieces.

```bash
rake install:windows
```

## Dependencies

External dependencies (e.g., `ctags`, `fzf`, etc…) are managed via [Homebrew](https://brew.sh).
To install the (currently known) dependencies,

```shell
$ brew bundle
```

# My config files

## Setup

The following rake tasks will set up symbolic links in your home directory for
each of the included configuration files.

```bash
rake install
```

or

```bash
# Force overwriting everything
OVERWRITE_DOTFILES=true rake install
```

### Windows

The following rake task will tweak a few of the default configs to better
behave on Windows

```bash
rake windows
```

## Dependencies

At least the following are required, and I'll continue to add more as I
re-discover them:

- `brew install the_silver_searcher`
- `brew install ctags`
- `gem install gem-ctags && gem ctags`


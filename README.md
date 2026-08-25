# My config files

## ⚙️ Setup

Installation is as easy as `ln -s`.
Seriously, that's about all that's going on here.
Each of these dotfiles is symlinked into your home (`~`) directory.
From there, the OS takes over.

```bash
rake install
```

If there's an existing file/symlink, you'll be prompted to _skip_, _overwrite_, or _backup_ before proceeding.
If you know you want to overwrite everything and not be prompted,

```bash
# Force overwriting everything
OVERWRITE_DOTFILES=true rake install
```

### 🚧 Windows

The following rake task will tweak a few of the default configs to better behave on Windows.
I don't use Windows these days, so no guarantees.
If it breaks, feel free to keep both pieces.

```bash
rake install:windows
```

## 🧩 Dependencies

External dependencies (e.g., `ctags`, `fzf`, etc…) are managed via [Homebrew](https://brew.sh).
To install the (currently known) dependencies,

```bash
brew bundle
```

## 🪝 Git hooks

`.git_template/hooks` holds hooks that `git` copies into a repo's `.git/hooks`
whenever you `git init` or `git clone` (via `init.templateDir` in `.gitconfig`).
They mostly keep a `ctags` index fresh and run `bundle` after a checkout that
touches the `Gemfile`.

The hooks resolve paths with `git rev-parse --git-path …` rather than hardcoding
`.git/…`, so they also work inside a linked worktree — where `.git` is a file, not
a directory.

### Refreshing existing repos

`init.templateDir` only applies at init/clone time and never overwrites hooks that
already exist, so repos you already have won't pick up hook changes. `refresh-git-hooks`
syncs the current template hooks into them:

```bash
refresh-git-hooks              # dry run against the current dir
refresh-git-hooks ~/code       # dry run against a specific root (recurses)
refresh-git-hooks --apply      # actually write the changes
```

It backs up anything it replaces to `<name>.pre-refresh`, leaves foreign hooks
(Husky, lefthook, overcommit, …) alone unless given `--force`, and skips
nested/vendored repos (submodules, Vim-Plug plugins, …).

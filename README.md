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

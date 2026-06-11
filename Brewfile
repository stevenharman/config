cask_args appdir: "/Applications"

tap "heroku/brew"
tap "universal-ctags/universal-ctags"

brew "ack"
brew "bat"
brew "fzf"
brew "universal-ctags/universal-ctags/universal-ctags", args: ["HEAD"], trusted: true
brew "pv"
brew "ripgrep"
brew "tree"
brew "wget"

brew "gh"
brew "git"
brew "git-delta"
brew "heroku/brew/heroku", trusted: true

brew "openssl"
brew "nodenv"
brew "node-build"
brew "rbenv"
brew "rbenv-bundler-ruby-version"
brew "rbenv-ctags"
brew "rbenv-default-gems"
brew "ruby-build"
brew "node"
brew "yarn"

brew "graphicsmagick"
brew "imagemagick"
brew "jq"

brew "postgresql@16"
brew "redis"

brew "shellcheck"
cask "terraform-linters/tap/tflint", trusted: true

if OS.mac?
  brew "coreutils" # Necessary to build native exensions in newer macOS's. 🤷

  cask "1password-cli"
  cask "dash"
  cask "kaleidoscope"
  cask "macvim-app"
  cask "xnapper"
end

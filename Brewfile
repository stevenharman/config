cask_args appdir: "/Applications"
tap "heroku/brew"
tap "universal-ctags/universal-ctags"

brew "ack"
brew "bat"
brew "fzf"
brew "universal-ctags", args: ["HEAD"]
brew "pv"
brew "ripgrep"
brew "tree"
brew "wget"

brew "gh"
brew "git"
brew "git-delta"
brew "heroku"

brew "openssl"
brew "nodenv"
brew "coreutils" if OS.mac? # Necessary to build native exensions in newer macOS's. 🤷
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
brew "tflint"
brew "tldr"

if OS.mac?
  cask "dash"
  cask "kaleidoscope"
  cask "macvim-app"
  cask "1password-cli"
  cask "xnapper"
end

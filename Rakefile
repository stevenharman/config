require "pathname"
require_relative "setup"

LINKABLES = %w[
  .ackrc
  .agignore
  .aprc
  .bashrc
  .bundle/config
  .config/solargraph/config.yml
  .fzf.bash
  .fzf.zsh
  .gemrc
  .git_template
  .gitconfig
  .gitignore_global
  .gvimrc
  .hgrc
  .irbrc
  .profile
  .pryrc
  .psqlrc
  .railsrc
  .rbenv/default-gems
  .rdbgrc
  .ripgreprc
  .rspec
  .screenrc
  .shellcheckrc
  .ssh/allowed_signers
  .ssh/common_config
  .vim
  .vimrc
  .zprofile
  .zsh
  .zshenv
  .zshrc
  Brewfile
].freeze

desc "Symlink dotfiles into system-standard locations."
task :install do
  Setup.install(linkables: LINKABLES,
    home_dir: Pathname(ENV.fetch("HOME")),
    working_dir: Pathname.pwd)
end

task :uninstall do
  Setup.uninstall(linkables: LINKABLES,
    home_dir: Pathname(ENV.fetch("HOME")))
end

task default: "install"

namespace :install do
  desc "Install dotfiles, and tweak a few things for Windows."
  task windows: :install do
    abort "This is for Windows, yo!" unless RUBY_PLATFORM.downcase.include?("mswin")

    system "git config --global core.autocrlf true"
    system 'git config --global gui.fontdiff "-family Consolas -size 12 -weight normal -slant roman -underline 0 -overstrike 0"'
  end
end

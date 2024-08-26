require "pathname"

module Setup
  def self.install(linkables:, home_dir:, working_dir:, overwrite_all: ENV.fetch("OVERWRITE_DOTFILES", false))
    Dotfiles.setup(
      linkables: linkables,
      home_dir: home_dir,
      working_dir: working_dir, overwrite_all: overwrite_all
    )
    Dependencies.install
  end

  def self.uninstall(linkables:, home_dir:)
    Dotfiles.remove(linkables: linkables, home_dir: home_dir)
  end

  class Dependencies
    def self.install
      new.install
    end

    def initialize(host: RbConfig::CONFIG["host"])
      @host = String(host).downcase
    end

    def install
      if mac_os?
        system("brew bundle") unless system("which brew")
      elsif windows?
        puts("🤷 This is Windows and I've not yet bothered to figure out setting up dependencies.")
      else # assumer we're on linux
        puts("🤡 FIGURE OUT A LINUX SOLUTION! Maybe just Homebrew too?")
        install_oh_my_zsh
      end
    end

    private

    attr_reader :host

    def install_oh_my_zsh
      zsh_home = Pathname(ENV.fetch("ZSH", "~/.oh-my-zsh")).expand_path

      if zsh_home.exist?
        puts("Oh my Zsh is already installed")
        return
      end

      system('/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"')
    end

    def mac_os?
      /darwin/.match?(host)
    end

    def windows?
      /cygwin|mswin|mingw|bccwin|wince|emx/.match?(host)
    end
  end

  class Dotfiles
    def self.setup(linkables:, home_dir:, working_dir:, overwrite_all:)
      dotfiles = new(home_dir: home_dir, working_dir: working_dir, overwrite_all: overwrite_all)
      dotfiles.setup(linkables: linkables)
    end

    def self.remove(linkables:, home_dir:)
      dotfiles = new(home_dir: home_dir)
      dotfiles.remove(linkables: linkables)
    end

    def initialize(home_dir:, working_dir: Pathname.pwd, overwrite_all: false)
      @home_dir = Pathname(home_dir)
      @working_dir = Pathname(working_dir)
      @overwrite_all = overwrite_all
    end

    def remove(linkables:)
      linkables.each do |linkable|
        target = home_dir.join(linkable)

        # Remove all symlinks created during installation
        if target.symlink?
          target.delete
        end

        # Replace any backups made during installation
        backup = Pathname("#{target}.backup")
        if backup.exist?
          backup.rename(target)
        end
      end
    end

    def setup(linkables:)
      retried = false
      backup_all = false
      skip_all = false

      linkables.each do |linkable|
        skip = false
        overwrite = false
        backup = false

        target = home_dir.join(linkable)

        if target.exist? || target.symlink?
          unless skip_all || overwrite_all || backup_all
            puts "File already exists: #{target}, what do you want to do? [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all"
            case $stdin.gets.chomp
            when "o" then overwrite = true
            when "b" then backup = true
            when "O" then self.overwrite_all = true
            when "B" then backup_all = true
            when "S" then skip_all = true
            when "s" then skip = true
            end
          end

          next if skip || skip_all
          target.delete if overwrite || overwrite_all

          if backup || backup_all
            bak = Pathname("#{target}.backup")
            target.rename(bak)
          end
        end

        dotfile = working_dir.join(linkable)
        begin
          target.make_symlink(dotfile)
          retried = false
        rescue Errno::ENOENT
          raise if retried
          retried = true
          dir = target.dirname
          dir.mkpath
          retry
        end
      end
    end

    attr_reader :home_dir, :working_dir
    attr_accessor :overwrite_all
  end
end

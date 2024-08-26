require "pathname"

module Setup
  def self.install(linkables:, home_dir:, working_dir:, overwrite_all: ENV.fetch("OVERWRITE_DOTFILES", false))
    home_dir = Pathname(home_dir)
    working_dir = Pathname(working_dir)
    backup_all = false
    skip_all = false
    retried = false

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
          when "O" then overwrite_all = true
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

  def self.uninstall(linkables:, home_dir:)
    home_dir = Pathname(home_dir)

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
end

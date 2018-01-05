require 'pathname'

LINKABLES = %w(.ackrc .agignore .bashrc Brewfile .bundle .gemrc .git_template .gitconfig .gitignore_global .gvimrc .hgrc .irbrc .profile .pryrc .railsrc .rspec .screenrc .ssh/common_config .vim .vimrc .zprofile .zsh .zshenv .zshrc).freeze

desc 'Hook dotfiles into system-standard positions.'
task :install do
  skip_all = false
  overwrite_all = ENV['OVERWRITE_DOTFILES'] || false
  backup_all = false

  LINKABLES.each do |linkable|
    skip = false
    overwrite = false
    backup = false

    target = Pathname(ENV.fetch('HOME')).join(linkable)

    if target.exist? || target.symlink?
      unless skip_all || overwrite_all || backup_all
        puts "File already exists: #{target}, what do you want to do? [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all"
        case STDIN.gets.chomp
        when 'o' then overwrite = true
        when 'b' then backup = true
        when 'O' then overwrite_all = true
        when 'B' then backup_all = true
        when 'S' then skip_all = true
        when 's' then skip = true
        end
      end

      next if skip || skip_all
      FileUtils.rm_rf(target) if overwrite || overwrite_all
      `mv "#{target}" "#{target}.backup"` if backup || backup_all
    end
    `ln -s "$PWD/#{linkable}" "#{target}"`
  end
end

task :uninstall do
  LINKABLES.each do |linkable|
    target = Pathname(ENV.fetch('HOME')).join(linkable)

    # Remove all symlinks created during installation
    if target.symlink?
      target.delete
    end

    # Replace any backups made during installation
    backup = "#{target}.backup"
    if backup.exist?
      `mv "#{backup}" "#{target}"`
    end
  end
end

task default: 'install'

desc 'adjust for Windows'
task :windows do
  abort 'This is for Windows, yo!' unless RUBY_PLATFORM.downcase.include?('mswin')

  system 'git config --global core.autocrlf true'
  system 'git config --global gui.fontdiff "-family Consolas -size 12 -weight normal -slant roman -underline 0 -overstrike 0"'
end

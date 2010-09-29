require 'rubygems'
require 'rake'

desc "create symbolic links to each config file"
task :symlink do
  symlink
end

namespace :symlink do
  task :force do
    symlink(true)
  end
end

desc "adjust for Windows"
task :windows do
	abort 'This is for Windows, yo!' unless RUBY_PLATFORM.downcase.include?('mswin')

	system 'git config --global core.autocrlf true'
	system 'git config --global gui.fontdiff "-family Consolas -size 12 -weight normal -slant roman -underline 0 -overstrike 0"'
end

def symlink(force = false)
  dir = File.dirname(__FILE__)
  force = force ? '-Ff' : ''

  (Dir.glob('.*') - ['.git', '.', '..']).each do |file|
    `ln -s #{force} #{File.join(dir, file)} #{File.join(File.expand_path(ENV['HOME']), file)}`
    # FileUtils.ln_s("#{File.join(dir, file)}", "#{ENV['HOME']}/#{file}", :force => force)
  end
end

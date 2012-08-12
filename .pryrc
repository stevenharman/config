require 'win32console' if RUBY_PLATFORM =~ /(mswin|mingw|cygwin)32$/i

begin
  require 'hirb'
rescue LoadError
  # no pretty console output :(
end
Hirb.enable if defined? Hirb

# Load plugins (only those I whitelist)
Pry.config.should_load_plugins = false
Pry.config.editor = 'vim'
#Pry.plugins["doc"].activate!

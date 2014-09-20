require 'win32console' if RUBY_PLATFORM =~ /(mswin|mingw|cygwin)32$/i

begin
  require 'hirb'
  Hirb.enable if defined? Hirb
rescue LoadError
  # no pretty console output :(
end

Pry.config.should_load_plugins = false
Pry.config.editor = 'vim'

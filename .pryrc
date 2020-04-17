require "win32console" if RUBY_PLATFORM.match?(/(mswin|mingw|cygwin)32$/i)

begin
  require "amazing_print"
  AmazingPrint.pry!
rescue LoadError
  # no pretty console output :(
end

Pry.config.should_load_plugins = false
Pry.config.editor = "vim"

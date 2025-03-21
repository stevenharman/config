require "rubygems"
require "rake"
require "win32console" if RUBY_PLATFORM.match?(/(mswin|mingw|cygwin)32$/i)
begin
  require "wirble"
  require "hirb"
rescue LoadError
  # no pretty console output :(
end

if defined? Wirble
  Wirble.init
  Wirble.colorize
end
Hirb.enable if defined? Hirb

IRB.conf[:PROMPT_MODE] = :SIMPLE
IRB.conf[:AUTO_INDENT] = true

IRB.conf[:IRB_RC] = proc do |conf|
  name = "irb: "
  name = "rails: " if $0 == "irb" && ENV["RAILS_ENV"]
  leader = " " * name.length
  conf.prompt_i = String(name)
  conf.prompt_s = leader + '\-" '
  conf.prompt_c = leader + '\-+ '
  conf.return_format = ("=" * (name.length - 2)) + "> %s\n"
end

# log ActiveRecord (Rails 3)
ActiveRecord::Base.logger = Logger.new(STDOUT) if defined? Rails::Console

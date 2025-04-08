IRB.conf[:AUTO_INDENT] = true

IRB.conf[:IRB_RC] = proc do |conf|
  if ENV["RAILS_ENV"]
    ActiveRecord::Base.logger = Logger.new($stdout)
  end
end

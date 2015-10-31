Pry.commands.alias_command 'c', 'continue'
Pry.commands.alias_command 's', 'step'
Pry.commands.alias_command 'n', 'next'

if defined?(ActiveRecord)
  ActiveRecord::Base.logger = Logger.new(STDOUT)
end

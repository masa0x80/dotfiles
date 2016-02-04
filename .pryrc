if defined?(PryByebug)
  Pry.commands.alias_command 'fin', 'finish'
  Pry.commands.alias_command 'c',   'continue'
  Pry.commands.alias_command 's',   'step'
  Pry.commands.alias_command 'n',   'next'
  Pry.commands.alias_command 'u',   'up'
  Pry.commands.alias_command 'd',   'down'
  Pry.commands.alias_command 'f',   'frame'
  Pry.commands.alias_command 'w',   'whereami'
end

if defined?(ActiveRecord)
  ActiveRecord::Base.logger = Logger.new(STDOUT)
end

if defined?(AwesomePrint)
  AwesomePrint.pry!
end

if defined?(PryByebug)
  Pry.commands.alias_command 'fin', 'finish'
  Pry.commands.alias_command 'cc',  'continue'
  Pry.commands.alias_command 'ss',  'step'
  Pry.commands.alias_command 'nn',  'next'
  Pry.commands.alias_command 'uu',  'up'
  Pry.commands.alias_command 'dd',  'down'
  Pry.commands.alias_command 'ff',  'frame'
  Pry.commands.alias_command 'ww',  'whereami'
end

if defined?(ActiveRecord)
  ActiveRecord::Base.logger = Logger.new(STDOUT)
end

if defined?(AwesomePrint)
  AwesomePrint.pry!
end

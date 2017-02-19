include_recipe 'lib/recipe_helper'
include_recipe 'attributes/default'

include_role File.join('os', node[:platform])

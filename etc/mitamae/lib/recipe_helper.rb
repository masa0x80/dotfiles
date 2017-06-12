define :include_cookbook, recipe: 'default' do
  root_dir = File.expand_path('../..', __FILE__)
  include_recipe File.join(root_dir, 'cookbooks', params[:name], params[:recipe])
end

define :include_role do
  root_dir = File.expand_path('../..', __FILE__)
  include_recipe File.join(root_dir, 'roles', params[:name], 'default')
end

define :include_attribute do
  root_dir = File.expand_path('../..', __FILE__)
  include_recipe File.join(root_dir, 'attributes', params[:name])
end

define :pkg do
  pkg, *options = params[:name].split(' ')
  if options.empty?
    package pkg
  else
    package pkg do
      options options.join(' ')
    end
  end
end

define :pip3 do
  pkg = params[:name]
  execute "pip[install #{pkg}]" do
    command <<-"EOF"
      #{node[:proxy_config]}
      export PATH=#{node[:env][:home]}/.anyenv/bin:$PATH
      eval "$(anyenv init -)"
      pip3 list | grep -i #{pkg} || pip3 install #{pkg}
    EOF
    user node[:user]
  end
end

define :git_clone, repository: nil, user: nil, depth: nil do
  dest_path = params[:name]
  depth_option = '-depth %d' % params[:depth] if params[:depth]
  cmd = ['git', 'clone', depth_option, params[:repository], dest_path].compact.join(' ')
  execute "git_clone[#{dest_path}]" do
    command <<-"EOF"
      #{node[:proxy_config]}
      #{cmd}
    EOF
    user user || node[:user]
    not_if "test -d #{dest_path}"
  end
end

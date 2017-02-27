package 's3cmd'

include_cookbook 'pyenv'

execute 'pip install awscli' do
  command <<-"EOF"
    #{node[:proxy_config]}
    export PATH=#{node[:home]}/.anyenv/bin:$PATH
    eval "$(anyenv init -)"
    pip list | grep awscli || pip install awscli
  EOF
  user node[:user]
end

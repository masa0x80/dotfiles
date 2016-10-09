#!/bin/bash

# setup PATH for sudo
sudo sed -i 's/Defaults    secure_path = \/sbin:\/bin:\/usr\/sbin:\/usr\/bin/Defaults    env_keep += "PATH"/' /etc/sudoers

# setup PATH for root
if [ -z "$(sudo sh -c 'grep "export PATH=" /root/.zshrc 2> /dev/null')" ]; then
  sudo sh -c "echo 'export PATH=/bin:/usr/bin:/usr/local/bin:/sbin:/usr/sbin:/usr/local/sbin' >> /root/.zshrc"
fi

# Proxy config
if [ ! -z $HTTP_PROXY ]; then
  if [ -z `grep "proxy=$HTTP_PROXY" /etc/yum.conf` ]; then
    sudo sh -c "echo 'proxy=$HTTP_PROXY' >> /etc/yum.conf"
  fi
  if [ -z `grep ".proxy" /root/.bashrc` ]; then
    sudo sh -c "echo 'test -r $HOME/.proxy && source $HOME/.proxy' >> /root/.bashrc"
  fi
fi
if [ -e $HOME/.proxy ]; then
  sudo sh -c "cp $HOME/.proxy /root/"
fi

# Use jp servers
if [ -z `grep '^include_only=.jp$' /etc/yum/pluginconf.d/fastestmirror.conf` ]; then
  sudo sh -c "echo 'include_only=.jp' >> /etc/yum/pluginconf.d/fastestmirror.conf"
fi

# Install git
if type -a git > /dev/null 2>&1; then
  echo 'skip git install'
else
  sudo -E yum install -y git which bzip2 unzip curl
fi

# Install emojify ref: https://github.com/mrowa44/emojify
sudo sh -c "curl https://raw.githubusercontent.com/mrowa44/emojify/master/emojify -o /usr/local/bin/emojify && chmod +x /usr/local/bin/emojify"

# Prepare to install ruby
sudo -E yum install -y patch readline-devel zlib-devel openssl-devel gcc-c++ bzip2-devel sqlite-devel libffi-devel libxslt-devel autoconf

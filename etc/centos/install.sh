#!/bin/bash

# Proxy設定
if [ ! -z $http_proxy ]; then
  if [ -z `grep "proxy=$http_proxy" /etc/yum.conf` ]; then
    sudo sh -c "echo 'proxy=$http_proxy' >> /etc/yum.conf"
  fi
fi

# 日本のサーバーを使うように
if [ -z `grep '^include_only=.jp$' /etc/yum/pluginconf.d/fastestmirror.conf` ]; then
  sudo sh -c "echo 'include_only=.jp' >> /etc/yum/pluginconf.d/fastestmirror.conf"
fi

# gitのインストール
if type git > /dev/null 2>&1; then
  echo 'skip git install'
else
  sudo -E yum install -y git
fi

# pythonのインストール
sudo -E yum install -y patch readline-devel zlib-devel openssl-devel gcc-c++ bzip2-devel sqlite-devel
if type anyenv > /dev/null 2>&1; then
  echo 'skip anyenv install'
else
  git clone https://github.com/riywo/anyenv $HOME/.anyenv

  echo ''                                    >> $HOME/.bashrc
  echo '# anyenv settings'                   >> $HOME/.bashrc
  echo 'export PATH=$HOME/.anyenv/bin:$PATH' >> $HOME/.bashrc
  echo 'eval "$(anyenv init -)"'             >> $HOME/.bashrc
  source $HOME/.bashrc

  if type pyenv > /dev/null 2>&1; then
    echo 'skip pyenv install'
  else
    # pyenvの設定
    anyenv install pyenv
    source $HOME/.bashrc
    pyenv install 2.7.11
    pyenv global  2.7.11
    pyenv rehash
  fi
fi

# ansibleのインストール
if type ansible > /dev/null 2>&1; then
  echo 'skip ansible install'
else
  pip install ansible
fi

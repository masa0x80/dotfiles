#!/bin/bash

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

# pyenvのインストール
sudo -E yum install -y patch readline-devel zlib-devel openssl-devel gcc-c++ bzip2-devel sqlite-devel
if type pyenv > /dev/null 2>&1; then
  echo 'skip pyenv install'
else
  git clone https://github.com/yyuu/pyenv.git            $HOME/.pyenv
  git clone https://github.com/yyuu/pyenv-virtualenv.git $HOME/.pyenv/plugins/pyenv-virtualenv.git

  echo ''                                   >> $HOME/.bashrc
  echo '# pyenv settings'                   >> $HOME/.bashrc
  echo 'export PATH=$HOME/.pyenv/bin:$PATH' >> $HOME/.bashrc
  echo 'eval "$(pyenv init -)"'             >> $HOME/.bashrc
  source $HOME/.bashrc

  # pyenvの設定
  pyenv install 2.7.6
  pyenv global  2.7.6
  pyenv rehash
fi

# ansibleのインストール
if type ansible > /dev/null 2>&1; then
  echo 'skip ansible install'
else
  pip install ansible
fi

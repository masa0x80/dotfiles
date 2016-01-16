#!/bin/bash

# Proxy設定
if [ ! -z $HTTP_PROXY ]; then
  if [ -z `grep "proxy=$HTTP_PROXY" /etc/yum.conf` ]; then
    sudo sh -c "echo 'proxy=$HTTP_PROXY' >> /etc/yum.conf"
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

# rubyのインストール
sudo -E yum install -y patch readline-devel zlib-devel openssl-devel gcc-c++ bzip2-devel sqlite-devel
if type anyenv > /dev/null 2>&1; then
  echo 'skip anyenv install'
else
  sudo -E yum install -y gcc-c++ openssl-devel readline-devel libffi-devel libxslt-devel autoconf
  git clone https://github.com/riywo/anyenv $HOME/.anyenv

  echo ''                                    >> $HOME/.bashrc
  echo '# anyenv settings'                   >> $HOME/.bashrc
  echo 'export PATH=$HOME/.anyenv/bin:$PATH' >> $HOME/.bashrc
  echo 'eval "$(anyenv init -)"'             >> $HOME/.bashrc
  source $HOME/.bashrc

  if type rbenv > /dev/null 2>&1; then
    echo 'skip rbenv install'
  else
    # rbenvの設定
    anyenv install rbenv
    source $HOME/.bashrc
    rbenv install 2.3.0
    rbenv global  2.3.0
    gem install bundler
  fi
fi

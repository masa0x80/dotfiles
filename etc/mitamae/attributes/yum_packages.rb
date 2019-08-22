node.reverse_merge!(
  yum_packages: {
    common: %w(
      epel-release

      automake
      autoconf
      bind-utils
      bzip2-devel
      clang
      cronie-anacron
      fuse-libs
      gcc-c++
      libffi-devel
      libselinux-python
      libxslt-devel
      nc
      ntp
      man
      man-pages
      openssl-devel
      patch
      readline-devel
      sqlite-devel
      tmpwatch
      tree
      wget
      xsel
      zlib-devel
    ),
    append: %w(
      s3cmd
      zsh
    ),
    nvim: %w(
    ),
  }
)

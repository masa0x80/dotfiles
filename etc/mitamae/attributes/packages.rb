node.reverse_merge!(
  packages: {
    darwin: {
      tap_list: [
        'homebrew/services'
      ],
      brew_list: [
        'autoconf',
        'automake',
        'boost',
        'cmake',
        'coreutils',
        'cpulimit',
        'curl',
        'emojify',
        'gdbm',
        'gettext',
        'less',
        'lsof',
        'rsync',
        'rust',
        'zsh --without-etcdir'
      ]
    },
    redhat: {
      yum_list: %w(
        epel-release

        automake
        autoconf
        bind-utils
        bzip2-devel
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
        zsh
      )
    }
  }
)

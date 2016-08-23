set -x HOMEBREW_CASK_OPTS '--appdir=/Applications --caskroom=/opt/homebrew-cask/Caskroom'

# Disable homebrew analytics
set -x HOMEBREW_NO_ANALYTICS 1

# ref: https://github.com/yyuu/pyenv/wiki/Common-build-problems#build-failed-error-the-python-zlib-extension-was-not-compiled-missing-the-zlib
set -x CFLAGS '-I$(xcrun --show-sdk-path)/usr/include'

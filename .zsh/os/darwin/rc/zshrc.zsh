export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# Disable analytics
export HOMEBREW_NO_ANALYTICS=1

# ref: https://github.com/yyuu/pyenv/wiki/Common-build-problems#build-failed-error-the-python-zlib-extension-was-not-compiled-missing-the-zlib
export CFLAGS="-I$(xcrun --show-sdk-path)/usr/include"

export KEYCHAIN_OPTION='--inherit any'

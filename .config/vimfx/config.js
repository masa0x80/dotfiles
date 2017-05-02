let map = (shortcuts, command, custom=false) => {
  vimfx.set(`${custom ? 'custom.' : ''}mode.normal.${command}`, shortcuts)
}

map('K gT <c-p>', 'tab_select_previous')
map('J gt <c-n>', 'tab_select_next')


vimfx.set('prevent_autofocus', true)
vimfx.set('blacklist', '*live.nicovideo.jp/* *nicovideo.jp/watch/*')
vimfx.set('config_file_directory', '~/.config/vimfx')


// ref: http://esperia.hatenablog.com/entry/2016/09/02/230021
vimfx.addCommand({
  name: 'open_hatena_bookmark_entry',
  description: 'Open Hatena Bookmark Entry',
}, ({vim}) => {
  let location = new vim.window.URL(vim.browser.currentURI.spec)
  vim.window.gBrowser.loadURI(`http://b.hatena.ne.jp/entry/${encodeURIComponent(location.href)}`)
})

map('bb', 'open_hatena_bookmark_entry', true)

// ref: https://sourceforge.net/u/thimsmith/dotfiles/ci/master/tree/vimfx/config.js
vimfx.addKeyOverrides(
  [ location => location.hostname === 'mail.google.com',
    [
        '!', '#', '*', '.', '/', ':', ';', '?',
        'A', 'F', 'I', 'N', 'R', 'U', '_',
        '[', ']', '{', '}',
        'a', 'b', 'c', 'd', 'e', 'f', 'g', 'i', 'j', 'k', 'l', 'm',
        'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'x', 'y', 'z'
    ]
  ]
)

vimfx.addKeyOverrides(
  [ location => location.hostname === 'b.hatena.ne.jp',
    [
        'j', 'k', 'o'
    ]
  ]
)

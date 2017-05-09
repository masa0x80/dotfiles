const {classes: Cc, interfaces: Ci, utils: Cu} = Components
const nsIStyleSheetService = Cc['@mozilla.org/content/style-sheet-service;1'].getService(Ci.nsIStyleSheetService)
const {Preferences} = Cu.import('resource://gre/modules/Preferences.jsm', {})

const MAPPINGS = {
  'follow': 'f <c-F>',
  'tab_select_previous': 'K gT <c-k> <s-c-tab>',
  'tab_select_next': 'J gt <c-j> <c-tab>',
  'tab_move_backward': 'gJ <c-,>',
  'tab_move_forward': 'gK <c-.>',
  'quote': 'I <c-v>',
  'exit': ['<s-escape> I', 'mode.ignore'],
}

const VIMFX_PREFS = {
  'prevent_autofocus': true,
  'blacklist': '*live.nicovideo.jp/* *nicovideo.jp/watch/*',
  'config_file_directory': '~/.config/vimfx',
}

const FIREFOX_PREFS = {
  'accessibility.blockautorefresh': true,
  'browser.ctrlTab.previews': true,
  'browser.fixup.alternate.enabled': false,
  'browser.search.suggest.enabled': false,
  'browser.startup.page': 3,
  'browser.tabs.animate': false,
  'browser.tabs.closeWindowWithLastTab': false,
  'browser.tabs.warnOnClose': false,
  'browser.urlbar.formatting.enabled': false,
  'devtools.chrome.enabled': true,
  'devtools.command-button-paintflashing.enabled': true,
  'devtools.command-button-measure.enabled': true,
  'devtools.selfxss.count': 0,
  'privacy.donottrackheader.enabled': true,
  'extensions.tabtree.new-tab-button': false,
  'general.smoothScroll.durationToIntervalRatio': 50,
}

const CUSTOM_COMMANDS = [
  // ref: http://esperia.hatenablog.com/entry/2016/09/02/230021
  [
    {
      name: 'open_hatena_bookmark_entry',
      description: 'Open Hatena Bookmark Entry',
    }, ({vim}) => {
      let location = new vim.window.URL(vim.browser.currentURI.spec)
      vim.window.gBrowser.loadURI(`http://b.hatena.ne.jp/entry/${encodeURIComponent(location.href)}`)
    },
  ],
]

const CSS = [
  `${__dirname}/style.css`,
]

CUSTOM_COMMANDS.forEach(([options, fn]) => {
  vimfx.addCommand(options, fn)
})

Object.entries(MAPPINGS).forEach(([command, value]) => {
  const [shortcuts, mode] = Array.isArray(value)
    ? value
    : [value, 'mode.normal']
  vimfx.set(`${mode}.${command}`, shortcuts)
})

Object.entries(VIMFX_PREFS).forEach(([pref, valueOrFunction]) => {
  const value = typeof valueOrFunction === 'function'
    ? valueOrFunction(vimfx.getDefault(pref))
    : valueOrFunction
  vimfx.set(pref, value)
})

Preferences.set(FIREFOX_PREFS)

CSS.forEach(uriString => {
  const uri = Services.io.newURI(uriString, null, null)
  const method = nsIStyleSheetService.AUTHOR_SHEET
  if (!nsIStyleSheetService.sheetRegistered(uri, method)) {
    nsIStyleSheetService.loadAndRegisterSheet(uri, method)
  }
  vimfx.on('shutdown', () => {
    nsIStyleSheetService.unregisterSheet(uri, method)
  })
})

let map = (shortcuts, command, custom=false) => {
  vimfx.set(`${custom ? 'custom.' : ''}mode.normal.${command}`, shortcuts)
}

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

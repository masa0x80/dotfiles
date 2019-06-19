// {{{ Settings
Hints.style('border: solid 3px #552a48; color:#efe1eb; background: initial; background-color: #552a48;')
settings.nextLinkRegex = /((?!first)(next|older|more|>|»|forward|→|次(のページ|へ))+)/i
settings.prevLinkRegex = /((?!last)(prev(ious)?|newer|back|«|less|<|←|前(のページ|へ))+)/i
settings.hintAlign = 'left'
settings.focusAfterClosed = 'right'
// }}}

// {{{ UnmapKeys
const unmapKeys = keys => keys.forEach(key => unmap(key))
unmapKeys(['ob', 'sb', 'ow', 'sw'])
const iunmapKeys = keys => keys.forEach(key => iunmap(key))
iunmapKeys(['<Ctrl-f>', '<Ctrl-e>'])
// }}}

// {{{ SearchAlias & MapKeys
removeSearchAliasX('b')
removeSearchAliasX('w')

addSearchAliasX(
  'a',
  'Amazon',
  'https://www.amazon.co.jp/s?k=',
  's',
  'https://completion.amazon.co.jp/search/complete?method=completion&search-alias=aps&mkt=6&q=',
  response => JSON.parse(response.text)[1]
)
mapkey('oa', '#8Open Search with alias A', function() {
  Front.openOmnibar({ type: 'SearchEngine', extra: 'a' })
})

addSearchAliasX(
  'alc',
  'ALC',
  'https://eow.alc.co.jp/'
)
mapkey('alc', '#8Open Search with alias a', function() {
  Front.openOmnibar({ type: 'SearchEngine', extra: 'alc' })
})
mapkey(';a', '#14ALC', () => {
  const selection = window.getSelection().toString()
  if (selection !== '') {
    tabOpenLink(
      `https://eow.alc.co.jp/${encodeURI(selection)}`
    )
  }
})

addSearchAliasX(
  'r',
  'Yahoo! Real-time search',
  'http://realtime.search.yahoo.co.jp/search?ei=UTF-8&p='
)
mapkey('or', '#8Open Search with alias r', function() {
  Front.openOmnibar({ type: 'SearchEngine', extra: 'r' })
})

addSearchAliasX(
  't',
  'Google Translation',
  'https://translate.google.com/?sl=auto&tl=ja&text='
)
mapkey('ot', '#8Open Search with alias t', function() {
  Front.openOmnibar({ type: 'SearchEngine', extra: 't' })
})
mapkey(';t', '#14Google Translate', () => {
  const selection = window.getSelection().toString()
  if (selection === '') {
    tabOpenLink(
      `http://translate.google.com/translate?u=${window.location.href}`
    )
  } else {
    tabOpenLink(
      `https://translate.google.com/?sl=auto&tl=ja&text=${encodeURI(selection)}`
    )
  }
})

addSearchAliasX(
  'tw',
  'Twitter',
  'https://twitter.com/search?q='
)
mapkey('oT', '#8Open Search with alias tw', function() {
  Front.openOmnibar({ type: 'SearchEngine', extra: 'tw' })
})

addSearchAliasX(
  'w',
  'Wikipedia',
  'https://ja.wikipedia.org/w/index.php?search='
)
mapkey('ow', '#8Open Search with alias w', function() {
  Front.openOmnibar({ type: 'SearchEngine', extra: 'w' })
})

mapkey('<Ctrl-;>', '#8Choose a tab with omnibar', () => Front.openOmnibar({ type: 'Tabs' }))

mapkey(';b', '#14Hatena Bookmark', () => {
  const { location } = window
  switch (location.protocol) {
    case 'http:': {
      tabOpenLink(
        `https://b.hatena.ne.jp/entry/${location.href.replace('http://', '')}`
      )
      break
    }
    case 'https:': {
      tabOpenLink(
        `https://b.hatena.ne.jp/entry/s/${location.href.replace('https://', '')}`
      )
      break
    }
    default: {
      throw new Error('Error')
    }
  }
})
// }}}

// {{{ qmarks
const qmarksUrls = {
  b: 'https://b.hatena.ne.jp',
  c: 'https://calendar.google.com',
  m: 'https://mail.google.com'
}
const qmarksMapKey = (prefix, urls, newTab) => {
  const openLink = (link, newTab) => () => {
    RUNTIME('openLink', {
      tab: { tabbed: newTab },
      url: link,
    })
  }
  for (const key in urls) {
    mapkey(prefix + key, `qmark: ${urls[key]}`, openLink(urls[key], newTab))
  }
}
unmap('gn')
qmarksMapKey('gn', qmarksUrls, true)
qmarksMapKey('gN', qmarksUrls, false)
// }}}

// {{{ Images
const ri = { repeatIgnore: true }
const Hint = (selector, action = Hints.dispatchMouseClick) => () =>
  Hints.create(selector, action)
mapkey('gI', '#4View image in new tab', Hint('img', i => tabOpenLink(i.src)), ri)
mapkey('yI', '#7Copy Image URL', Hint('img', i => Clipboard.write(i.src)), ri)
// }}}

// {{{ Copy
const copyTitleAndUrl = format => {
  const text = format
    .replace('%URL%', location.href)
    .replace('%TITLE%', document.title)
  Clipboard.write(text)
}
mapkey('cm', '#7Copy title and link to markdown', () => {
  copyTitleAndUrl('[%TITLE%](%URL%)')
})
mapkey('ct', '#7Copy title and link to textile', () => {
  copyTitleAndUrl('"%TITLE%":%URL%')
})
mapkey('cj', '#7Copy title and link to jira', () => {
  const title = document.title.replace(/[|[]]/g, ' ').replace(/^ +/, '')
  Clipboard.write(`[${title}|${location.href}]`)
})
mapkey('ch', '#7Copy title and link to human readable', () => {
  copyTitleAndUrl('%TITLE% - %URL%')
})
// }}}

// {{{ Settings for each service
const clickElm = selector => () => document.querySelector(selector).click()
const clickElmFr = selector => () =>
  document
    .querySelector('.speakerdeck-iframe')
    .contentWindow.document.querySelector(selector)
    .click()

if (/speakerdeck\.com/.test(window.location.hostname)) {
  mapkey(']', 'next page', clickElmFr('.sd-player-next'))
  mapkey('[', 'prev page', clickElmFr('.sd-player-previous'))
}

if (/www\.slideshare\.net/.test(window.location.hostname)) {
  mapkey(']', 'next page', clickElm('.j-next-btn'))
  mapkey('[', 'prev page', clickElm('.j-prev-btn'))
}

if (/youtube\.com/.test(window.location.hostname)) {
  mapkey(
    'T',
    'Toggle theater mode',
    clickElm('.ytp-size-button.ytp-button'))
  mapkey(
    'F',
    'Toggle fullscreen',
    clickElm('.ytp-fullscreen-button.ytp-button'))
  mapkey(']', 'Skip ad', clickElm('.ytp-ad-text.ytp-ad-skip-button-text'))
  mapkey('<Alt-x>', 'Skip ad', clickElm('.ytp-ad-overlay-close-button'))
}
// }}}

// {{{ Modify the page's URL
if (/www.amazon.co.jp/.test(window.location.hostname)) {
  mapkey('==', '#14Shorten the URL', () => {
    location.href = `https://www.amazon.co.jp/dp/${
      document.querySelectorAll("[name='ASIN'], [name='ASIN.0']")[0].value
    }`
  })
}

const shortenURL = (pattern) => location.href = location.href.replace(pattern, '')
mapkey('=?', '#14Delete query string', () => shortenURL(/\?.*/))
mapkey('=q', '#14Delete query string', () => shortenURL(/\?.*/))
mapkey('=#', '#14Delete hash', () => shortenURL(/#.*/))
mapkey('=h', '#14Delete hash', () => shortenURL(/#.*/))
// }}}

// {{{ MapKeys
map('<Ctrl-f>', 'd')
map('<Ctrl-b>', 'e')
map('<Ctrl-u>', 'e')
map('<Ctrl-d>', 'd')
map('<Ctrl-e>', 'j')
map('<Ctrl-y>', 'k')
map('<Ctrl-n>', 'R')
map('<Ctrl-p>', 'E')
map('H', 'S')
map('L', 'D')
map('d', 'x')
map('u', 'X')
map('F', 'gf')
map('P', 'sg')
map('<Ctrl-t><Ctrl-t>', '<Ctrl-6>')
map('<Ctrl-[>', '<Esc>')
// }}}

// {{{ unmapAllExcept
const commonUnmapKeys = [
  '<Ctrl-f>', '<Ctrl-b>',
  '<Ctrl-d>', '<Ctrl-u>',
  '<Ctrl-y>', '<Ctrl-e>',
  '<Ctrl-n>', '<Ctrl-p>',
  '<Ctrl-t><Ctrl-t>',
  '<Ctrl-;>',
  't',
  'oT', 'oa', 'od', 'og',
  'oh', 'oi', 'om', 'on',
  'or', 'ot', 'ox', 'oy',
  'H', 'L',
  'f', 'F',
  'x', 'X', 'd',
]

unmapAllExcept(
  commonUnmapKeys,
  /mail\.google\.com/
)

unmapAllExcept(
  commonUnmapKeys.concat(['u', 'go', 'G', 'gg']).concat(Object.keys(qmarksUrls).map(key => `gn${key}`)),
  /outlook\.office\.com|b\.hatena\.ne\.jp|twitter\.com/
)
// }}}

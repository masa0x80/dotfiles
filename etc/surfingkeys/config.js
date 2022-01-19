const {
  aceVimMap,
  mapkey,
  imap,
  iunmap,
  imapkey,
  getClickableElements,
  vmapkey,
  map,
  unmap,
  cmap,
  addSearchAlias,
  removeSearchAlias,
  searchSelectedWith,
  tabOpenLink,
  readText,
  Clipboard,
  Front,
  Hints,
  Visual,
  RUNTIME
} = api

// {{{ Setting
Hints.setCharacters('fydig;suaoenwmr')
Hints.style(' \
  font-size: 13pt; \
  font-weight: 400; \
  border: 1px solid #ffffff; \
  padding: 3px; \
  color: #fff; \
  background: #333; \
  box-shadow: 0px 3px 7px 0px rgba(0, 0, 0, 0.3); \
')
Hints.style(' \
  font-size: 13pt; \
  font-weight: 400; \
  border: 1px solid #ffffff; \
  padding: 3px; \
  color: #fff !important; \
  background: #ff4081; \
  box-shadow: 0px 3px 7px 0px rgba(0, 0, 0, 0.3); \
  ', 'text')

settings.scrollStepSize = 140
settings.hintAlign = 'left'
settings.nextLinkRegex = /((forward|>>|next|次[のへ]|→)+)/i
settings.prevLinkRegex = /((back|<<|prev(ious)?|前[のへ]|←)+)/i
settings.historyMUOrder = false
settings.theme = `
#sk_status, #sk_find {
  font-size: 12pt;
}
#sk_omnibarSearchResult .highlight {
  background: #f9ec89;
}
`
// }}}

// {{{ Utils
const unmapKeys = (keys, domain) => keys.forEach((key) => unmap(key, domain))
const iunmapKeys = (keys, domain) => keys.forEach((key) => iunmap(key, domain))
const escapeMap = {
  '&': '&amp;',
  '<': '&lt;',
  '>': '&gt;',
  '"': '&quot;',
  "'": '&#39;',
  '/': '&#x2F;',
  '`': '&#x60;',
  '=': '&#x3D;'
}
const escapeForAlias = (str) =>
  String(str).replace(/[&<>"'`=/]/g, (s) => escapeMap[s])
const createSuggestionItem = (html, props = {}) => {
  const li = document.createElement('li')
  li.innerHTML = html
  return { html: li.outerHTML, props }
}
const padZero = (txt) => `0${txt}`.slice(-2)
const formatDate = (date, format = 'YYYY/MM/DD hh:mm:ss') =>
  format
    .replace('YYYY', date.getFullYear())
    .replace('MM', padZero(date.getMonth() + 1))
    .replace('DD', padZero(date.getDate()))
    .replace('hh', padZero(date.getHours()))
    .replace('mm', padZero(date.getMinutes()))
    .replace('ss', padZero(date.getSeconds()))

const tabOpenBackground = (url) =>
  RUNTIME('openLink', {
    tab: {
      tabbed: true,
      active: false
    },
    url
  })
// }}}

// {{{ Maps
map('H', 'S') // history back
map('L', 'D') // history forward
map('<Ctrl-p>', 'E') // previousTab
map('<Ctrl-n>', 'R') // nextTab
map('<Ctrl-e>', 'j')
map('<Ctrl-y>', 'k')
map('<Ctrl-f>', 'd')
map('<Ctrl-b>', 'u')
map('<Ctrl-d>', 'd')
map('<Ctrl-u>', 'u')
map('<Ctrl-s><Ctrl-s>', '<Ctrl-6>')

map('<Ctrl-[>', '<Esc>')
map('<Ctrl-c>', '<Esc>')

unmap('go')

iunmap(':') // disable emoji
// disable vim binding in insert mode
iunmapKeys(
  [
    '<Ctrl-a>',
    '<Ctrl-e>',
    '<Ctrl-f>',
    '<Ctrl-b>',
    '<Ctrl-k>',
    '<Ctrl-y>'
  ], null)
// disable proxy
unmapKeys(['cp', ';pa', ';pb', ';pc', ';pd', ';ps', ';ap'], null)

// ---- Search ----
// g: google
// d: duckduckgo
removeSearchAlias('b') // baidu
removeSearchAlias('e') // wikipedia
removeSearchAlias('w') // bing
// s: stackoverflow
removeSearchAlias('h') // github
// y: youtube

// B! tag
addSearchAlias('bt', 'hatena tag', 'http://b.hatena.ne.jp/search/tag?q=')

// Twitter
addSearchAlias(
  'tw',
  'Twitter',
  'https://twitter.com/search?q=',
  's',
  'https://twitter.com/i/search/typeahead.json?count=10&filters=true&q=',
  (response) =>
    JSON.parse(response.text).topics.map((v) =>
      createSuggestionItem(v.topic, {
        url: `https://twitter.com/search?q=${encodeURIComponent(v.topic)}`
      })
    )
)

addSearchAlias('gh', 'github', 'https://github.com/search?q=', 's', 'https://api.github.com/search/repositories?order=desc&q=', function (response) {
  const res = JSON.parse(response.text).items
  return res
    ? res.map(function (r) {
        return {
          title: r.description,
          url: r.html_url
        }
      })
    : []
})

// Yahoo!リアルタイム検索
addSearchAlias(
  're',
  'Yahoo!リアルタイム検索',
  'http://realtime.search.yahoo.co.jp/search?ei=UTF-8&p='
)

// Wikipedia jp
addSearchAlias(
  'wi',
  'Wikipedia',
  'https://ja.wikipedia.org/w/index.php?search='
)

// MDN
addSearchAlias(
  'mdn',
  'MDN',
  'https://developer.mozilla.org/ja/search?q=',
  's',
  'https://developer.mozilla.org/api/v1/search/ja?q=',
  (response) => {
    const res = JSON.parse(response.text)
    return res.documents.map((s) =>
      createSuggestionItem(
        `
      <div>
        <div class="title"><strong>${s.title}</strong></div>
        <div style="font-size:0.8em"><em>${s.slug}</em></div>
        <div>${s.summary}</div>
      </div>
    `,
        { url: `https://developer.mozilla.org/${s.locale}/docs/${s.slug}` }
      )
    )
  }
)

// npm
addSearchAlias(
  'npm',
  'npm',
  'https://www.npmjs.com/search?q=',
  's',
  'https://api.npms.io/v2/search/suggestions?size=20&q=',
  (response) =>
    JSON.parse(response.text).map((s) => {
      let flags = ''
      let desc = ''
      let stars = ''
      let score = ''
      if (s.package.description) {
        desc = escapeForAlias(s.package.description)
      }
      if (s.score && s.score.final) {
        score = Math.round(Number(s.score.final) * 5)
        stars = '⭐'.repeat(score) + '☆'.repeat(5 - score)
      }
      if (s.flags) {
        Object.keys(s.flags).forEach((f) => {
          flags += `[<span style='color:#ff4d00'>⚑</span> ${escapeForAlias(
            f
          )}] `
        })
      }
      return createSuggestionItem(
        `
      <div>
        <style>.title>em { font-weight: bold; }</style>
        <div class="title">${s.highlight}</div>
        <div>
          <span style="font-size:1.5em;line-height:1em">${stars}</span>
          <span>${flags}</span>
        </div>
        <div>${desc}</div>
      </div>
    `,
        { url: s.package.links.npm }
      )
    })
)

// Amazon
addSearchAlias(
  'am',
  'Amazon',
  'https://www.amazon.co.jp/s?k=',
  's',
  'https://completion.amazon.co.jp/search/complete?method=completion&search-alias=aps&mkt=6&q=',
  (response) => JSON.parse(response.text)[1]
)

// Kindle
addSearchAlias(
  'ki',
  'Amazon Kindle',
  'https://www.amazon.co.jp/s?i=digital-text&k=',
  's',
  'https://completion.amazon.co.jp/search/complete?method=completion&search-alias=aps&mkt=6&q=',
  (response) => JSON.parse(response.text)[1]
)

// alc
const alcUrl = 'https://eow.alc.co.jp/search?q='
addSearchAlias('alc', 'alc', alcUrl)
mapkey(';a', '#14ALC', () => {
  searchSelectedWith(alcUrl)
})
// }}}

// {{{ Mapkeys
const formatTitle = (title) =>
  title.replace(/ (?:-|\|) [^-\|]*$/, '')
const copyTitleAndUrl = (format) => {
  const text = format
    .replace('%URL%', location.href)
    .replace('%TITLE%', formatTitle(document.title))
  Clipboard.write(text)
}
const copyHtmlLink = () => {
  const clipNode = document.createElement('a')
  const range = document.createRange()
  const sel = window.getSelection()
  const title = formatTitle(document.title)
  clipNode.setAttribute('href', location.href)
  clipNode.innerText = title
  document.body.appendChild(clipNode)
  range.selectNode(clipNode)
  sel.removeAllRanges()
  sel.addRange(range)
  document.execCommand('copy', false, null)
  document.body.removeChild(clipNode)
  Front.showBanner('Ritch Copied: ' + title)
}

mapkey('ch', '#7Copy title and link to human readable', () => {
  copyTitleAndUrl('%TITLE% %URL%')
})
mapkey('cm', '#7Copy title and link to markdown', () => {
  copyTitleAndUrl('[%TITLE%](%URL%)')
})
mapkey('ct', '#7Copy title and link to textile', () => {
  copyTitleAndUrl('"%TITLE%":%URL%')
})
mapkey('cj', '#7Copy title and link to jira', () => {
  copyTitleAndUrl('[%TITLE%|%URL%]')
})
mapkey('cb', '#7Copy title and link to scrapbox', () => {
  copyTitleAndUrl('[%TITLE% %URL%]')
})
mapkey('ca', '#7Copy title and link to href', () => {
  copyTitleAndUrl('<a href="%URL%">%TITLE%</a>')
})
mapkey('cp', '#7Copy title and link to plantuml', () => {
  copyTitleAndUrl('[[%URL% %TITLE%]]')
})
mapkey('cr', '#7Copy rich text link', () => {
  copyHtmlLink()
})
mapkey('co', '#7Copy title and link to org', () => {
  copyTitleAndUrl('[[%URL%][%TITLE%]]')
})

//  8: Omnibar
mapkey('oo', '#8Open a URL in current tab', function () {
  Front.openOmnibar({ type: 'URLs', tabbed: false })
})

mapkey('oh', '#8Open URL from history', function () {
  Front.openOmnibar({ type: 'History' })
})

//  9: Visual Mode
// 10: vim-like marks
// 11: Settings
// 12: Chrome URLs
// 13: Proxy
// 14: Misc

unmap(';t')
mapkey(';t', '#14google translate', () => {
  const selection = window.getSelection().toString()
  if (selection === '') {
    // 文字列選択してない場合はページ自体を翻訳にかける
    tabOpenLink(
      `https://translate.google.com/translate?js=n&sl=auto&tl=ja&u=${window.location.href}`
    )
  } else {
    // 選択している場合はそれを翻訳する
    tabOpenLink(
      `https://translate.google.com/?sl=auto&tl=ja&text=${encodeURI(selection)}`
    )
  }
})

mapkey(';b', '#14hatena bookmark', () => {
  const { location } = window
  const url = location.href
  if (url.startsWith('http:')) {
    tabOpenBackground(
      `http://b.hatena.ne.jp/entry/${url.replace('http://', '')}`
    )
    return
  }
  if (url.startsWith('https:')) {
    tabOpenBackground(
      `http://b.hatena.ne.jp/entry/s/${url.replace('https://', '')}`
    )
    return
  }
  throw new Error('はてなブックマークに対応していないページ')
})

mapkey(';h', '#14魚拓', () => {
  tabOpenLink(`https://megalodon.jp/?url=${location.href}`)
})

mapkey('=q', '#14Delete query', () => {
  location.href = location.href.replace(/\?.*/, '')
})
mapkey('=h', '#14Delete hash', () => {
  location.href = location.href.replace(/\#.*/, '')
})
// 15: Insert Mode

// {{{ Images
const ri = { repeatIgnore: true }
const Hint = (selector, action = Hints.dispatchMouseClick) => () =>
  Hints.create(selector, action)
mapkey('gI', '#4View image in new tab', Hint('img', i => tabOpenLink(i.src)), ri)
mapkey('ci', '#7Copy Image URL', Hint('img', i => Clipboard.write(i.src)), ri)
// }}}

// }}}

// {{{ qmarks
const qmarksMapKey = (prefix, urls, newTab) => {
  const openLink = (link, newTab) => () => {
    RUNTIME('openLink', {
      tab: { tabbed: newTab },
      url: link
    })
  }
  for (const key in urls) {
    mapkey(prefix + key, `qmark: ${urls[key]}`, openLink(urls[key], newTab))
  }
}
const qmarksUrls = {
  b: 'https://b.hatena.ne.jp/hotentry/it',
  c: 'https://calendar.google.com',
  m: 'https://mail.google.com'
}
qmarksMapKey('go', qmarksUrls, true)
qmarksMapKey('gO', qmarksUrls, false)
// }}}

// {{{ Site-specific mappings
const clickElm = (selector) => () => document.querySelector(selector).click()
const clickElmFr = (selector) => () =>
  document
    .querySelector('.speakerdeck-iframe')
    .contentWindow.document.querySelector(selector)
    .click()

const speakerDeckDomain = /speakerdeck\.com/i
mapkey(']', 'next page', clickElmFr('.sd-player-next'),
  { domain: speakerDeckDomain })
mapkey('[', 'prev page', clickElmFr('.sd-player-previous'),
  { domain: speakerDeckDomain })

const slideShareDomain = /www\.slideshare\.net/i
mapkey(']', 'next page', clickElm('#btnNext'),
  { domain: slideShareDomain })
mapkey('[', 'prev page', clickElm('#btnPrevious'),
  { domain: slideShareDomain })

mapkey('==', '#14URLを短縮',
  () => {
    location.href = `https://www.amazon.co.jp/dp/${
        document.querySelectorAll("[name='ASIN'], [name='ASIN.0']")[0].value
      }`
  },
  { domain: /www\.amazon\.co\.jp/ })

// B!
const bookmarkDomain = /b\.hatena\.ne\.jp\/.*\/hotentry\?date/i
const moveDate = (diff) => () => {
  const url = new URL(window.location.href)
  const dateTxt = url.searchParams.get('date')
  const [_, yyyy, mm, dd] = dateTxt.match(/(....)(..)(..)/)
  const date = new Date(
    parseInt(yyyy, 10),
    parseInt(mm, 10) - 1,
    parseInt(dd, 10) + diff
  )
  url.searchParams.set('date', formatDate(date, 'YYYYMMDD'))
  location.href = url.href
}
mapkey(']]', 'next date', moveDate(1),
  { domain: bookmarkDomain })
mapkey('[[', 'prev date', moveDate(-1),
  { domain: bookmarkDomain })

// youtube
const youtubeDomain = /youtube\.com/i
mapkey(
  'T',
  'Toggle theater mode',
  clickElm('.ytp-size-button.ytp-button'),
  { domain: youtubeDomain })
mapkey(
  'F',
  'Toggle fullscreen',
  clickElm('.ytp-fullscreen-button.ytp-button'),
  { domain: youtubeDomain })
mapkey(
  'gH',
  'GoTo Home',
  () => (location.href = 'https://www.youtube.com/feed/subscriptions?flow=2'),
  { domain: youtubeDomain })
mapkey(']', 'Skip ad', clickElm('.ytp-ad-text.ytp-ad-skip-button-text'),
  { domain: youtubeDomain })
mapkey('<Alt-x>', 'Skip ad', clickElm('.ytp-ad-overlay-close-button'),
  { domain: youtubeDomain })

const gmailUnmapKeys = [
  'gi', 'gs', 'gb', 'gt', 'ga', 'gc', 'gl', 'gk', 'gf',
  'u', 'k', 'j', 'o', 'p', 'n', 'gp', 'gn',
  '/', '?', 'c,', 'd', '.', 'v', 'l',
  'x', 's', 'y', 'e', 'm', '!', '#', 'r', 'a', 'f', 'z'
]
unmapKeys(
  gmailUnmapKeys,
  /mail\.google\.com/i)
unmapKeys(
  gmailUnmapKeys.concat(['U', 'G', 'gg']),
  /outlook\.office(?:365|)\.com/i)
unmapKeys(
  [
    'n', 'j', 'p', 'k', 't',
    '1', 'd', '2', 'w', '3', 'm', '4', 'x', '5', 'a', '6', 'y',
    'c', 'e', 'z', '/', '?'
  ], /calendar\.google\.com/i)
// }}}

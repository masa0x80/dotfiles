config.load_autoconfig()

config.set('content.javascript.enabled', True, 'file://*')
config.set('content.javascript.enabled', True, 'chrome://*/*')
config.set('content.javascript.enabled', True, 'qute://*/*')

c.messages.timeout = 5000
c.completion.shrink = True

c.tabs.position = 'right'
c.tabs.width = '8%'

c.colors.hints.fg = 'white'
c.colors.hints.bg = '#333333'
c.hints.border = '1px solid silver'
c.fonts.hints = 'bold 16pt monospace'

c.url.default_page = 'about:blank'
c.url.searchengines = {'DEFAULT': 'https://google.com/search?q={}'}
c.url.start_pages = 'https://google.com'

config.bind('<Ctrl-n>', 'tab-next')
config.bind('<Ctrl-p>', 'tab-prev')
config.bind('<Ctrl-w>', 'tab-give')
config.bind('<Ctrl-e>', 'scroll down')
config.bind('<Ctrl-y>', 'scroll up')
config.bind('>', 'tab-move +')
config.bind('<', 'tab-move -')
config.bind('tt', 'tab-focus last')
config.bind('gp', 'tab-pin')
config.bind('O', 'set-cmd-text :open {url:pretty}')
config.bind('t', 'set-cmd-text :open -t ')
config.bind('T', 'set-cmd-text :open -t {url:pretty}')
config.bind('b', 'set-cmd-text -s :buffer')

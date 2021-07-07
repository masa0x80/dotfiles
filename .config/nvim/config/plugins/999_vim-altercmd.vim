if globpath(&runtimepath, '') !~# 'vim-altercmd'
  finish
endif

call altercmd#load()

AlterCommand f F
AlterCommand jq Jq
AlterCommand md2c[onfluence] Md2Confluence
AlterCommand mm[ap] Markmap
AlterCommand m[emo] Memo
AlterCommand t[odo] Todo
AlterCommand r GHQ

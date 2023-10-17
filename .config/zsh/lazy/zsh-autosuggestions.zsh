# zsh-autosuggestions

# Set `ZSH_AUTOSUGGEST_MANUAL_REBIND` (it can be set to anything) to disable automatic widget re-binding on each precmd.
# This can be a big boost to performance, but you'll need to handle re-binding yourself if any of the widget lists change or if you or another plugin wrap any of the autosuggest widgets.
# To re-bind widgets, run `_zsh_autosuggest_bind_widgets`.
ZSH_AUTOSUGGEST_MANUAL_REBIND=1
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

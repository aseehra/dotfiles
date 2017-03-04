# PROMPT(S)
PS1="[%n@%m:%C]$ "
autoload -U promptinit
promptinit
prompt aseehra
#RPS1="[%?]"

# Add additional completions
fpath=($HOME/.zsh $fpath)

if [[ -f $HOME/.zsh/aliases ]] ; then
	source $HOME/.zsh/aliases
fi

# HISTORIES

HISTSIZE=1000
SAVEHIST=$HISTSIZE
HISTFILE=~/.history

setopt 				\
APPEND_HISTORY 		\
HIST_ALLOW_CLOBBER	\

# POWER
setopt 				\
NO_BEEP				\
AUTO_CD				\
CD_ABLE_VARS		\
EXTENDED_GLOB		\
MULTIOS				\
RM_STAR_SILENT		\
NO_NOMATCH			\

#COMPLETIONS
autoload -U compinit
compinit

setopt				\
BASH_AUTO_LIST		\

# DMALLOC

function dmalloc { eval `command dmalloc -b $*`; }
bindkey -e

# let OSX know about what directory we're in.
case $TERM in
	xterm*)
		precmd () { printf '\e]7;%s\a' "file://${HOST}/${PWD}" }
		;;
esac

if [[ -f $HOME/.zsh/base16-thirtyfivemm-ocean.sh ]] ; then
	source $HOME/.zsh/base16-thirtyfivemm-ocean.sh
fi

if [[ -f $HOME/.zsh/zshrc.local ]] ; then
	source "$HOME/.zsh/zshrc.local"
fi

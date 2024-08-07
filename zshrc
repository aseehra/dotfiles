# PROMPT(S)
PS1="[%n@%m:%C]$ "
autoload -U promptinit
promptinit
# if [[ -f $HOME/.zsh/prompt/git/zshrc.sh ]] ; then
	# source $HOME/.zsh/prompt/git/zshrc.sh
# fi
prompt aseehra
#RPS1="[%?]"

# Add additional completions
if [[ -d $HOME/.zsh/site-functions ]] ; then
	fpath=($HOME/.zsh/site-functions $fpath)
fi

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

# AUTO_PUSHD

DIRSTACKSIZE=10

setopt 				\
AUTO_PUSHD			\
PUSHD_IGNORE_DUPS	\

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

if [[ -f $HOME/.zsh/base16-thirtyfivemm-ocean-shell.sh ]] ; then
	source $HOME/.zsh/base16-thirtyfivemm-ocean-shell.sh
fi

if [[ -f $HOME/.zsh/zshrc.local ]] ; then
	source "$HOME/.zsh/zshrc.local"
fi

if [[ -f $HOME/.zsh/zshrc.work.local ]] ; then
	source "$HOME/.zsh/zshrc.work.local"
fi

export BAT_THEME=TwoDark

if hash rbenv 2>/dev/null ; then
	eval "$(rbenv init -)"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


# START - Managed by chef cookbook stripe_cpe_bin
alias tc='/usr/local/stripe/bin/test_cookbook'
alias cz='/usr/local/stripe/bin/chef-zero'
alias cookit='tc && cz'
# STOP - Managed by chef cookbook stripe_cpe_bin

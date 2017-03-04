if [[ $UID -ne 0 ]] ; then
	umask 002
fi

typeset -U fpath
if [[ -d $HOME/.zsh/prompt ]] ; then
	fpath=( $HOME/.zsh/prompt $fpath )
fi

# Load local path
typeset -U path
if [[ -d $HOME/.local/bin ]] ; then
	path=( $HOME/.local/bin $path )
fi

# Load ruby gems
RUBY_USER_DIR=$(ruby -rubygems -e "puts Gem.user_dir")/bin
if [[ -d $RUBY_USER_DIR ]] ; then
	path=( $RUBY_USER_DIR $path )
fi

export EDITOR=/usr/bin/vim

if [[ -f $HOME/.zsh/zshenv.local ]] ; then
	source $HOME/.zsh/zshenv.local
fi

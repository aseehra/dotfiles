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
if type "ruby" > /dev/null ; then
	RUBY_USER_DIR=$(ruby -rrubygems -e "puts Gem.user_dir")/bin
	if [[ -d $RUBY_USER_DIR ]] ; then
		path=( $RUBY_USER_DIR $path )
	fi
fi

# Load yarn path if it's in our local directory
YARN_BIN_PATH=$HOME/.config/yarn/global/node_modules/.bin
if [[ -d $YARN_BIN_PATH ]] ; then
	path=( $YARN_BIN_PATH  $path )
fi

# Load cargo path
CARGO_PATH=$HOME/.cargo/bin
if [[ -d $CARGO_PATH ]] ; then
	path=( $CARGO_PATH $path )
fi

export EDITOR=/usr/bin/vim

if [[ -f $HOME/.zsh/zshenv.local ]] ; then
	source $HOME/.zsh/zshenv.local
fi

if [[ -f $HOME/.zsh/zshenv.work.local ]] ; then
	source $HOME/.zsh/zshenv.work.local
fi

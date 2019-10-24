# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt beep extendedglob nomatch
unsetopt appendhistory autocd notify
bindkey -v
bindkey "^?" backward-delete-char
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/ellioth/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

KEYTIMEOUT=1

autoload colors; colors

# Always use menu completion, and make the colors pretty!
zstyle ':completion:*' menu select yes
zstyle ':completion:*:default' list-colors ''
zstyle ':completion:*' completer _complete _ignored _match _correct _approximate _prefix
zstyle ':completion:*' max-errors 2

# When looking for matches, first try exact matches, then case-insensiive, then
# partial word completion
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'r:|[._-]=** r:|=**'

# Turn on caching, which helps with e.g. apt
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# Show titles for completion types and group by type
zstyle ':completion:*:descriptions' format "$fg_bold[black]» %d$reset_color"
zstyle ':completion:*' group-name ''

setopt complete_in_word

REPORTTIME=5

### Prompt

PROMPT="%{%(!.$fg_bold[red].$fg_bold[green])%}%n@%m%{$reset_color%} %{$fg_bold[blue]%}%~%{$reset_color%} %(!.!!.$) "
RPROMPT_code="%(?..\$%{$fg_no_bold[red]%}%?%{$reset_color%}  )"
RPROMPT_jobs="%1(j.%%%{$fg_no_bold[cyan]%}%j%{$reset_color%}  .)"
RPROMPT_time="%{$fg_bold[black]%}%*%{$reset_color%}"
RPROMPT=$RPROMPT_code$RPROMPT_jobs$RPROMPT_time

LSOPTS=''
LLOPTS='-lAvFh'  # long mode, show all, natural sort, type squiggles, friendly sizes
case $(uname -s) in
	FreeBSD)
		LSOPTS="${LSOPTS} -G"
		;;
	Darwin)
		LSOPTS="${LSOPTS} -G"
		;;
	Linux)
		eval "$(dircolors -b)"
		LSOPTS="$LSOPTS --color=auto"
		LLOPTS="$LLOPTS --color=always"  # so | less is colored

		# Just loaded new ls colors via dircolors, so change completion colors
		# to match
		zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
		;;
esac

# unalias in case ll is already aliased, causing infinite loop
unalias ls 2>/dev/null
unalias ll 2>/dev/null

alias ls="ls $LSOPTS"
ll() { CLICOLOR_FORCE=1 ls ${=LLOPTS} $@ | less -rFX }

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

source /usr/share/nvm/init-nvm.sh

# shift-tab to reverse list selection
bindkey '^[[Z' reverse-menu-complete

# load IDF environment when entering project directory
autoload -U add-zsh-hook
load-local-conf() {
     # check sdkconfig file exists:
     if [[ -f sdkconfig && -d .git && -f $IDF_PATH/export.sh ]]; then
     	 source $IDF_PATH/export.sh
     fi
}
add-zsh-hook chpwd load-local-conf

# launch ranger
alias cd-ranger='ranger --choosedir=$HOME/.local/share/ranger/choosedir; LASTDIR=`cat $HOME/.local/share/ranger/choosedir`; cd "$LASTDIR"'

# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh/.histfile
HISTSIZE=1000
SAVEHIST=995
# setopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
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

# use history search completion on arrow up/down
bindkey '\e[A' history-search-backward
bindkey '\e[B' history-search-forward

### Set title to pwd
# case $TERM in
  # xterm*)
    precmd () {
		print -Pn "\e]0;%~ %(?..\$%?)\a"
    }
    # ;;
# esac

### Set title to command name
preexec () {
	print -Pn "\e]0;$1\a"
}

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

LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.webp=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:';
export LS_COLORS

eval "$(fnm env --use-on-cd --shell zsh)"

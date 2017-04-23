# .bashrc
#  executed by login and subshells
#
#  Dongsu Park <dpark AT posteo.net>

## Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

setxkbmap -layout us

## User permission mask for newly created files and directories
umask 002

## Some settings
ulimit -S -c 0		# Don't want any coredumps
set -o notify

## Enable options
shopt -s cdspell
shopt -s cdable_vars
shopt -s checkhash
shopt -s checkwinsize
shopt -s mailwarn
shopt -s sourcepath
shopt -s no_empty_cmd_completion
shopt -s cmdhist
shopt -s histappend histreedit
shopt -s extglob	# Necessary for programmable completion

## Aliases

psgrep() { ps aux | egrep ${1} | egrep -v egrep; }
copy(){ cp -v "$1" "$2"&watch -n 1 du -sh "$1" "$2" 2>/dev/null;}

alias crb='makecscope ; find . -name \*.[ch] -o -name \*.cpp -o -name \*.cc | xargs ctags --extra=+f --c-kinds=+px --exclude=.git --exclude=.pc'
alias crbkernel='source ~/.bashrc; makecscope ${KERNEL_DIR}/; find ${KERNEL_DIR}/ -name \*.[ch] -o -name \*.cpp | xargs ctags --extra=+f --c-kinds=+px --exclude=.git --exclude=.pc --exclude=debian --exclude=*.mod.[ch]* --exclude=Documentation/* --exclude=*/arch/[a-u]* --exclude=*/arch/xtensa*'
alias =logout
alias =clear
alias d='date +"%a, %h %d, %r"'
alias dir='ls -l --color=auto --format=vertical'
alias vdir='ls -l --color=auto --format=long'
alias euc='export LANG=ko_KR.eucKR; export LC_ALL=ko_KR.eucKR; stty -istrip -parity'
alias fch=fetchmail
alias hi=history
alias jpdfbookmarks='java -jar /usr/local/lib/jpdfbookmarks/jpdfbookmarks.jar'
alias k9='kill -9'
alias ls='ls -sF'
alias la='ls -A'
alias ll='ls -l'
alias lld='ls -ld'
alias more='less'
alias p=pwd
alias pcrop='pdfcrop --margins 10'
alias psc=psgrep
alias screen='TERM=screen screen'
alias telnet="telnet -e ''"	# or -L ?
alias up='cd ..'
alias vi=vim
alias w3m='w3m -I utf-8 -O utf-8'

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

alias gs='git status '
alias ga='git add '
alias gb='git branch '
alias gc='git commit '
alias gd='git diff '
alias gco='git checkout '
alias gk='gitk --all &'
alias gx='gitk --all'

## Environment variables

## Set variables for a warm fuzzy environment
export PATH=$HOME/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/bin:/usr/lib64/qt5/bin:/usr/libexec/openssh:/root/bin

export EDITOR=vim
export FIGNORE=".git:.o"
export HISTCONTROL=ignoredups
export HISTIGNORE="&:bg:fg:la:ll:dir:h:exit"
export PGPPATH=
export PAGER=less
export TERM=xterm-color
export TIMEFORMAT=$'\nreal %3R\tuser %3U\tsys %S\tpcpu %P\n'
export TZ="Europe/Berlin"
export VISUAL=vim

export MAILDIR=$HOME/Maildir
export MAIL=$MAILDIR

export HOSTNAME=`hostname`
export EMAIL=dpark@posteo.net
export GITPROMPT_NOCOLOR=1
export GITPROMPT_NOSTATUS=1
export GIT_COMMITTER_NAME="Dongsu Park"
export GIT_COMMITTER_EMAIL="dpark@posteo.net"
export CC="gcc"
export CXX="g++"

# other environment settings

#############################################################################
# LS_COLORS setting
#############################################################################
#
#no       0       Normal (non-filename) text
#fi       0       Regular file
#di       32      Directory
#ln       36      Symbolic link
#pi       31      Named pipe (FIFO)
#so       33      Socket
#bd       44;37   Block device
#cd       44;37   Character device
#ex       35      Executable file
#mi       (none)  Missing file (defaults to fi)
#or       (none)  Orphanned symbolic link (defaults to ln)
#lc       \e[    Left code
#rc       m       Right code
#ec       (none)  End code (replaces lc+no+rc)
#
#0     to restore default color
#1     for brighter colors
#4     for underlined text
#5     for flashing text
#30     for black foreground
#31     for red foreground
#32     for green foreground
#33     for yellow (or brown) foreground
#34     for blue foreground
#35     for purple foreground
#36     for cyan foreground
#37     for white (or gray) foreground
#40     for black background
#41     for red background
#42     for green background
#43     for yellow (or brown) background
#44     for blue background
#45     for purple background
#46     for cyan background
#47     for white (or gray) background

export LS_COLORS='*.tex=33:*.c=33:*.cc=33:*.C=33:*.java=33:*.flex=33:*.y=33:*.html=33:*.shtml=0;33:*.phtml=0;33:*.h=0;33:*.dvi=35:*.ps=35:*.jpg=35:*.gif=35:*.fig=35:*.eps=35:*.bmp=35:*.zip=31:*.Z=31:*.gz=31:*.tgz=31:*.tar=31:*.jar=31:*.rpm=31:*.o=31:*.py=1;32:*.class=31:*.log=31:*.aux=31:di=0;32:ex=1;32:ln=36:or=34'

# Locales
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_NUMERIC=en_US.UTF-8
export LC_TIME=en_GB.UTF-8
export LC_COLLATE=C
export LC_MESSAGES=en_US.UTF-8
export LINGUAS="en"
export NOMHNPROC=1

# Go
export GOOS=linux
export GOROOT=/usr/local/golang
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$GOBIN:$GOROOT/bin:$PATH
export CGO_ENABLED=1
export CGO_CPPFLAGS="-Wno-deprecated-declarations"

# Rust
export PATH=$HOME/.cargo/bin:$PATH
export RUST_SRC_PATH=$HOME/Dev/rust/rust-master/src

# git prompt
if [ -f ~/.bash_gitprompt ]; then
	. ~/.bash_gitprompt
fi

# git completion must be added AFTER running "complete -r"
complete -r	# I don't need enhanced auto-completion
if [ -f ~/.git-completion.bash ]; then
	. ~/.git-completion.bash
fi

if [ -f ~/.k8s-completion.bash ]; then
	. ~/.k8s-completion.bash
fi

if [ -f ~/.minikube-completion.bash ]; then
	. ~/.minikube-completion.bash
fi

# .bash_profile
#  Dongsu Park <dpark AT posteo.net>

# User specific environment and startup programs

if [ ! -z ${REMOTEHOST} ]; then
	export DISPLAY=${REMOTEHOST}:0.0
fi

SYSDIR=`uname -m`-`uname -r`

## Paths
export PATH=$HOME/bin:$PATH:/usr/local/sbin:/usr/local/bin:/sbin:/usr/sbin:/opt/bin
export BASH_ENV=$HOME/.bashrc

## Control history
export HISTSIZE=1000
export HISTFILESIZE=200

## Control file name completion: ignore the following suffices
export FIGNORE=:.o:.bak:.old:.aux:.toc

## Prompt
##  ex) user1@host1 ~ {41}
export PS1="\u@\h `dirs` $(parse_git_branch) {\!} "

unset USERNAME

export PKGDIR=/usr/portage/packages

xset b off
setxkbmap -model cherrycmexpert -layout us,de -variant nodeadkeys

# end of ~/.bash_profile

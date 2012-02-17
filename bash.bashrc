# System-wide .bashrc file for interactive bash(1) shells.

# To enable the settings / commands in this file for login shells as well,
# this file has to be sourced in /etc/profile.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, overwrite the one in /etc/profile)
PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '

# Commented out, don't overwrite xterm -T "title" -n "icontitle" by default.
# If this is an xterm set the title to user@host:dir
#case "$TERM" in
#xterm*|rxvt*)
#    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
#    ;;
#*)
#    ;;
#esac

# enable bash completion in interactive shells
#if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
#    . /etc/bash_completion
#fi

# sudo hint
if [ ! -e "$HOME/.sudo_as_admin_successful" ]; then
    case " $(groups) " in *\ admin\ *)
    if [ -x /usr/bin/sudo ]; then
	cat <<-EOF
	To run a command as administrator (user "root"), use "sudo <command>".
	See "man sudo_root" for details.
	
	EOF
    fi
    esac
fi

# if the command-not-found package is installed, use it
if [ -x /usr/lib/command-not-found -o -x /usr/share/command-not-found ]; then
	function command_not_found_handle {
	        # check because c-n-f could've been removed in the meantime
                if [ -x /usr/lib/command-not-found ]; then
		   /usr/bin/python /usr/lib/command-not-found -- $1
                   return $?
                elif [ -x /usr/share/command-not-found ]; then
		   /usr/bin/python /usr/share/command-not-found -- $1
                   return $?
		else
		   return 127
		fi
	}
fi

ORACLE_HOME=/usr/lib/instantclient_11_2
SQLPLUS_HOME=$ORACLE_HOME
LD_LIBRARY_PATH=$ORACLE_HOME
NLS_LANG=AMERICAN_AMERICA.WE8ISO8859P1
NLS_CHARACTERSET=WE8ISO8859P1
unset NLS_CHARACTERSET

#NLS_LANG='BRAZILIAN PORTUGUESE_BRAZIL.UTF8'
#NLS_NUMERIC_CHARACTERS='.,'
#unset NLS_CHARACTERSET

APP_BASE=/home/projetos/credishop
ANT_HOME=/home/programas/ant
CATALINA_HOME=/home/programas/tomcat

#JAVA_HOME=/home/programas/jdk1.6.0_20
JAVA_HOME=/home/programas/java
JDK_HOME=$JAVA_HOME
JRUBY_HOME=/home/programas/jruby-1.2.0
#JRUBY_HOME=/home/programas/jruby-1.6.0
CLASSPATH=.:$ORACLE_HOME

PATH="/sbin:/bin:/usr/sbin:/usr/local/lib:/home/constantino/bin:/usr/bin:/usr/X11R6/bin:/usr/local/sbin:/usr/local/bin:$JAVA_HOME/bin:$JDK_HOME/bin:$ANT_HOME/bin:$CATALINA_HOME/bin:$NLS_LANG:$LD_LIBRARY_PATH:$JRUBY_HOME/bin:$ORACLE_HOME"

export ORACLE_HOME SQLPLUS_HOME LD_LIBRARY_PATH NLS_LANG NLS_CHARACTERSET APP_BASE ANT_HOME CATALINA_HOME JAVA_HOME JDK_HOME JRUBY_HOME PATH CLASSPATH

export TERM=xterm-color

alias which="type -path"
alias where="type -all"
alias ll="ls -l"
alias l="ls -l"
alias la="ls -la"
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -iv --preserve=timestamps"

alias ..="cd .."
alias ..2="cd ../.."
alias ..3="cd ../../.."


alias gb='git branch'
alias gc='git commit -v'
alias gca='git commit -a -v'
alias gco='git checkout'
alias gd='git diff'
alias gdc='git diff --cached'
alias gdh='git diff HEAD'
alias gp='git push'
alias gl='git pull'
alias gpr='git pull --rebase'
alias gst='git status'
alias gap='git add -p'
alias glg='git log --pretty=oneline --abbrev-commit'


[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function

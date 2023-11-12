# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Added by Zach

# alias q=exit
alias tmat='matlab -nodesktop -nosplash -softwareopengl'
alias jp='julia --project'
alias jt="julia --project --color=yes -e 'using Pkg; Pkg.test()'"

echo "using Pkg; Pkg.test()" > /tmp/test.jl
alias sjt='sdo julia --project --color=yes /tmp/test.jl'

# alias homedisp='cat ~/.displayModes/4C | disper --import'
# alias delldisp='cat ~/.displayModes/Dellhusl | disper --import'
# alias acerdisp='cat ~/.displayModes/acerhusl | disper --import'

alias lsf='ls -f'

# turn off KDE crash handling
# http://forum.kde.org/brainstorm.php#idea93879_page1
export KDE_DEBUG=0

PATH=$PATH:~/scripts
export PATH

# make it like vi (doesn't appear to work with matlab-like history which is better)
# set -o vi

# make ac3d home
# export AC3D_HOME=/usr/local/ac3dlx

# matlab-like history search
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# http://mjo.tc/atelier/2009/02/arduino-cli.html
export ARDUINO_DIR=/usr/share/arduino
export ARDMK_DIR=/usr/local
export AVR_TOOLS_DIR=/usr

# export PATH="/opt/microchip/xc16/v1.11/bin":$PATH

# export PATH="/opt/microchip/xc8/v1.12/bin":$PATH

# export PYTHONPATH=/usr/local/google/home/sunberg/Quad/build/lib/python/dist-packages:/home/zach/python3:$PYTHONPATH
export PYTHONPATH=/home/zach/python3:/home/zach/Devel/gym:$PYTHONPATH

alias hreview=~/Quad/tools/code_review/hreview.py
alias cdq='cd ~/Quad'

SSHAGENT=/usr/bin/ssh-agent
SSHAGENTARGS="-s"
if [ -z "$SSH_AUTH_SOCK" -a -x "$SSHAGENT" ]; then
      eval `$SSHAGENT $SSHAGENTARGS`
      trap "kill $SSH_AGENT_PID" 0
fi

# export CPLEX_PATH=/opt/ibm/ILOG/CPLEX_Studio_Preview1261/
# export LD_LIBRARY_PATH="/opt/ibm/ILOG/CPLEX_Studio_Preview1261/cplex/lib/x86-64_linux/static_pic":$LD_LIBRARY_PATH
# export GUROBI_HOME=/opt/gurobi/gurobi604/linux64

open_gvim_in_jl_dir() {
    gvim +"cd ~/.julia/dev/$1"
}

alias jlvim=open_gvim_in_jl_dir

export VISUAL=vim
export EDITOR="$VISUAL"

export PATH="/home/zach/.pyenv/bin:$PATH"
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"

# source /opt/ros/melodic/setup.bash

# added by Anaconda3 2018.12 installer
# >>> conda init >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$(CONDA_REPORT_ERRORS=false '/home/zach/anaconda3/bin/conda' shell.bash hook 2> /dev/null)"
if [ $? -eq 0 ]; then
    \eval "$__conda_setup"
else
    if [ -f "/home/zach/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/zach/anaconda3/etc/profile.d/conda.sh"
        CONDA_CHANGEPS1=false conda activate base
    else
        \export PATH="/home/zach/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda init <<<

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
eval "$(pyenv init -)"
# Install Ruby Gems to ~/gems
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"

alias jup='jupyter notebook --NotebookApp.kernel_manager_class=notebook.services.kernels.kernelmanager.AsyncMappingKernelManager'

weylus_over_usb() {
    weylus --bind-address $(ifconfig usb0 | grep -oP 'inet \K[^ ]+')
}

weylus_over_wifi() {
    weylus --bind-address $(ifconfig wlp3s0 | grep -oP 'inet \K[^ ]+')
}

alias wifitab=weylus_over_wifi
alias usbtab=weylus_over_usb

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

case ":$PATH:" in
    *:/home/zach/.juliaup/bin:*)
        ;;

    *)
        export PATH=/home/zach/.juliaup/bin${PATH:+:${PATH}}
        ;;
esac

# <<< juliaup initialize <<<

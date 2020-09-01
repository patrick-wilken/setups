# move up
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias .......="cd ../../../../../.."

# ls
alias l="ls -lhAp"
alias ll="ls -lhp"

# cd and l subsequently
cl() {
    cd $1 && l
}

# prompt on data loss
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"

# create a backup
bak() {
    cp -r $1 $1.bak
}

# short realpath
alias rp="realpath"

# make dir and cd into it
mkcd() {
    mkdir -p -- "$1" && cd -P -- "$1"
}

# count empty lines by default with nl
alias nl="nl -ba"

# wc for gzipped files
zwc() {
    num_args=$(($#-1))
    zcat "${!#}" | wc "${@:1:$num_args}"
}

# head and tail for gzipped files
zhead() {
    num_args=$(($#-1))
    zcat "${!#}" | head "${@:1:$num_args}"
}

ztail() {
    num_args=$(($#-1))
    zcat "${!#}" | tail "${@:1:$num_args}"
}

# paste for gzipped files
zpaste() {
    paste <(zcat -f $1) <(zcat -f $2)
}

# diff for gzipped files
zdiff() {
    diff <(zcat -f $1) <(zcat -f $2)
}

# word count per line
wcwl() {
    zcat -f $1 | awk '{print NF}'
}

# character count per line
wccl() {
   zcat -f $1 | awk '{print length($0)}'
}

# count matches per line
countperline() {
    awk "{print gsub(/$1/,\"\")}"
}

# get one line from file
line() {
    head $1 | tail -1
}

# sum lines
sumlines() {
    cat $1 | awk 'BEGIN {s=0.0} {s += $1} END {printf("%.2f\n", s)}'
}


# sum lines
averagelines() {
    cat $1 | awk 'BEGIN {s=0.0} {s += $1} END {printf("%.2f\n", s / NR)}'
}

# grep in python files
alias grepy='grep -rn --include "*.py"'

# directories
alias src="cd ~/src"
alias work="cd ~/work"

# edit bash config
alias editbashrc="vim ~/.bashrc"
alias editalias="vim ~/.bash_aliases"
alias bs="source ~/.bashrc"

# nvidia
alias smi="nvidia-smi"

# git
alias gb="git branch"
alias gl="git log"
alias gls="git log -10 --oneline"
alias gll="git log -50 --oneline"
alias gs="git show"  # shadows 'gs' from ghostscript, but I don't need it
alias gd="git diff"
alias ga="git add"
alias gc="git commit"
alias gr="git rebase"
alias gch="git checkout"
alias gst="git status"


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
alias lsd='ls $(find . -maxdepth 1 -type d | sed "s/\.\///") -ld'

# cd and l subsequently
cl() {
    cd $1 && l
}

# prompt on data loss
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"

# swap two files
swap()
{
    local TMPFILE=tmp.$$
    mv "$1" $TMPFILE && mv "$2" "$1" && mv $TMPFILE "$2"
}

# create a backup
bak() {
    cp -r $1 $1.bak
}

# replace link with copy of file being linked to
replacelink() {
    if [[ -d $1 ]]; then
        >&2 echo "Error: will not replace links to directories"
        return
    fi
    command cp -T --remove-destination $(readlink $1) $1
}

# short realpath
alias rp="realpath"

# make dir and cd into it
mkcd() {
    mkdir -p -- "$1" && cd -P -- "$1"
}

# remove contents of directory
cleardir() {
    if [ -z $1 ]; then
        >&2 echo "Expected a directory as argument"
        return
    fi
    if [ ! -d $1 ]; then
        >&2 echo "'$1' is not a direcory"
        return
    fi

    cd $1 && ls | xargs rm && cd - >/dev/null
}

# count empty lines by default with nl
alias nl="nl -ba"

# less with line numbers
alias lessn="less -S -N"

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

zlessrand() {
    zcat -f $1 | head -1000000 | shuf | less
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

# get certain lines from file
lines() {
    sed -n "$(cat $1 | tr '\n' ';' | sed 's/;/p;/g' | sed 's/;$//')" $2
}

# sum lines
sumlines() {
    cat $1 | awk 'BEGIN {s=0.0} {s += $1} END {printf("%.2f\n", s)}'
}


# sum lines
averagelines() {
    cat $1 | awk 'BEGIN {s=0.0} {s += $1} END {printf("%.2f\n", s / NR)}'
}

# calculate standard deviation
stdoflines() {
    cat $1 | awk '{sum+=$1; sumsq+=$1*$1} END {printf("%.2f\n", sqrt(sumsq/NR - (sum/NR)**2))}'
}

# grep in python files
alias grepy='grep -rn --include "*.py"'

# grep in C/C++ files
alias grepc='grep -rn --include "*.c?" --include "*.cpp" --include "*.h" --include "*.h?"'

# grep in bash files
alias grepsh='grep -rn --include "*.sh"'

# JSON pretty print
alias jsonpp="python -m json.tool"

# directories
alias src="cd ~/src"
alias work="cd ~/work"

# edit bash config
alias editbashrc="vim ~/.bashrc"
alias editalias="vim ~/.bash_aliases"
alias bs="source ~/.bashrc"

# nvidia
alias smi="nvidia-smi"
alias showgpu='echo $CUDA_VISIBLE_DEVICES'
setgpu() {
    export CUDA_VISIBLE_DEVICES=$1
    if [ -z $1 ]; then
        return
    fi
    if [ $1 == -1 ]; then
        export DISABLE_CUDA=1
    elif [ ! -z $DISABLE_CUDA ] && [ $DISABLE_CUDA == 1 ]; then
        export DISABLE_CUDA=0
    fi
}

# screen
alias sls="screen -ls"
alias sr="screen -r"

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

gdb() {
    # (g)it (d)iff (b)ranches
    git log --left-right --graph --cherry-pick --oneline ${1}...${2}
}

# Docker
alias dil="docker image list"
alias dcl="docker container list"
alias dka='docker kill $(docker ps -q)'
alias dra='docker rm $(docker ps -a -q)'

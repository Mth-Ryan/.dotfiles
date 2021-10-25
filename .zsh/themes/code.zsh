source $ZSH/utils/gitstatus.sh

# Static Elements
ICON=''
FOLDER='%F{blue}%~%f'
SUFIX='%B$%b'

function branch {
    BRANCH=''
    BNAME=${(C)$(git_branch)}
    if [[ $BNAME != "" ]]; then
        BRANCH='<%F{cyan}'$BNAME'%f>'
    fi
    echo -n $BRANCH
}

function precmd {
    BRANCH=$(branch)
    RPROMPT=''
    PROMPT="${ICON} ${FOLDER}${BRANCH} ${SUFIX} "
}


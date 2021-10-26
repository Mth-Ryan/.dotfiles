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

function status {
    RAW=$(git_status)
    RAW=("${(f)RAW}")
    STATUS=''
    for s in $RAW; do
        case $s in
            'A' ) STATUS+='+' ;;
            'M' ) STATUS+='!' ;;
            'R' ) STATUS+='»' ;;
            'C' ) STATUS+='' ;;
            'D' ) STATUS+='' ;;
            '??') STATUS+='?' ;;
        esac
    done
    if [[ $STATUS != "" ]]; then
        echo -n '%F{red}['$STATUS']%f'
    else
        echo -n ""
    fi
}

function precmd {
    BRANCH=$(branch)
    PROMPT="${ICON} ${FOLDER}${BRANCH} ${SUFIX} "
    RPROMPT=$(status)
}


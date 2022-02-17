source $ZSH/utils/gitstatus.sh

# Static Elements
ICON='%K{blue}  %K{white}%F{blue}'
FOLDER='%F{black} %~ %k%F{white}%f'
SUFIX=' '

function branch {
    echo -n $(git_branch)
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
    echo -n $STATUS
}

function git_cmd {
    BRANCH=$(branch)
    STATUS=$(status)
    if [[ $BRANCH == "" ]]; then
        echo -n ""
    else
        VIEW=" $BRANCH"
        if [[ $STATUS == "" ]]; then
            echo -n " %F{green}%K{green}%F{black} $VIEW %f%k"
        else
            echo -n " %F{yellow}%K{yellow}%F{black} $VIEW $STATUS %f%k"
        fi
    fi
}

function precmd {
    PROMPT="${ICON}${FOLDER}${SUFIX}"
    RPROMPT=$(git_cmd)
}


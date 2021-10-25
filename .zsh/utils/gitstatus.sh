git_branch() {
    git branch --show-current 2> /dev/null
}

git_status() {
    git status --porcelain --ignore-submodules 2> /dev/null \
    | awk '{print $1}' \
    | sort \
    | uniq
}

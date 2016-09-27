p4() {
    typeset -a cmd
    local cmd=( $@ )

    # Search for and apply aliases from the bp4o aliases file
    local config="${XDG_CONFIG_HOME:=$HOME/.config}/bp4o"
    local alias=$(sed -n "s/$cmd[1]\s*=\s*\(.\+\)/\1/p" "$config/aliases" 2>/dev/null)
    if [ -n  "$alias" ]; then
        cmd=( ${=cmd/#$cmd[1]/$alias} )
    fi

    p4bin=$(whence -p p4)
    if command which p4-$cmd[1] &>/dev/null; then
        p4-$cmd[1] $p4bin $cmd
    else
        $p4bin $cmd
    fi
}

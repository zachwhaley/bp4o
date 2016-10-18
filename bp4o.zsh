export P4VERSION=$(command p4 -V | awk -F/ '/Rev. P4/ {print $3}')
p4() {
    typeset -a args
    local args=( $@ )
    local cmd=$args[1]

    local p4aliases=$HOME/.p4aliases
    local bp4oaliases=${XDG_CONFIG_HOME:-$HOME/.config}/bp4o/aliases
    if [ ${P4VERSION%.*} -ge 2016 ] && [ -f $p4aliases ]; then
        # Search for and apply aliases from Perforce
        local p4cmd=$(perl -n -e "print if \$_ =~ s/^$args[1]\s*.*=\s*(\w+).*/\1/" $p4aliases)
        if [ -n "$p4cmd" ]; then
            cmd=$p4cmd
        fi
    elif [ -f $bp4oaliases ]; then
        # Search for and apply aliases from BP4O
        local alias=$(perl -n -e "print if \$_ =~ s/$args[1]\s*=\s*(.+)/\1/" $bp4oaliases)
        if [ -n  "$alias" ]; then
            args=( ${=args/#$args[1]/$alias} )
            cmd=$args[1]
        fi
    fi

    p4bin=$(whence -p p4)
    if command which p4-$cmd &>/dev/null; then
        p4-$cmd $p4bin $args
    else
        $p4bin $args
    fi
}

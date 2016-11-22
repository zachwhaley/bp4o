set -x P4VERSION (command p4 -V | awk -F/ '/Rev. P4/ {print $3}')
function p4
    set args $argv
    set cmd $args[1]

    set p4aliases $HOME/.p4aliases
    set bp4oaliases $HOME/.config/bp4o/aliases
    set p4v (string split . $P4VERSION)
    if test $p4v[1] -ge 2016; and test -f $p4aliases
        # Search for and apply aliases from Perforce
        set p4cmd (perl -n -e "print if \$_ =~ s/^$args[1]\b.*=\s*(\w+).*/\1/" $p4aliases)
        if test -n "$p4cmd"
            set cmd $p4cmd
        end
    else if test -f $bp4oaliases
        # Search for and apply aliases from BP4O
        set alias (perl -n -e "print if \$_ =~ s/$args[1]\s*=\s*(.+)/\1/" $bp4oaliases)
        if test -n "$alias"
            set alias (string split " " $alias)
            if test (count $args) -gt 1
                set args $alias $args[2..-1]
            else
                set args $alias
            end
            set cmd $args[1]
        end
    end

    set p4bin (type -P p4)
    if command which p4-$cmd > /dev/null ^&1
        eval p4-$cmd $p4bin $args
    else
        eval $p4bin $args
    end
end

set -x P4VERSION (command p4 -V | awk -F/ '/Rev. P4/ {print $3}')
function p4
    set args $argv
    set cmd $args[1]

    set -l p4aliases $HOME/.p4aliases
    if set -q P4ALIASES
        set p4aliases $P4ALIASES/.p4aliases
    end

    set -l bp4oaliases $HOME/.config/bp4o/aliases
    if set -q BP4OALIASES
        set bp4oaliases $BP4OALIASES
    end

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
            set args (string replace "$args[1]" "$alias" "$args")
            set args (string split " " $args)
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

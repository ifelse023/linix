function backup --argument filename
    cp $filename $filename.bak
end

function restore --argument file
    mv $file (echo $file | sed s/.bak//)
end

function mkdir-cd --argument dir
    mkdir -p -- $dir
    and cd -- $dir
end

function clean-unzip --argument zipfile
    if not test (echo $zipfile | string sub --start=-4) = .zip
        echo (status function): argument must be a zipfile
        return 1
    end

    if is-clean-zip $zipfile
        unzip $zipfile
    else
        set folder_name (echo $zipfile | trim-right '.zip')
        set target (basename $folder_name)
        mkdir $target || return 1
        unzip $zipfile -d $target
    end
end

function is-clean-zip --argument zipfile
    if string-empty $zipfile
        echo 'is-clean-zip: missing filename' >&2
        return 1
    end

    set summary (zip -sf $zipfile | string split0)
    set first_file (echo $summary | row 2 | string trim)
    set first_file_last_char (echo $first_file | string sub --start=-1)
    set n_files (echo $summary | awk NF | tail -1 | coln 2)
    test $n_files = 1 && test $first_file_last_char = /
end

function cpr
    set -l args
    for arg in $argv[1..-2]
        set arg (string replace -r '/+$' '' -- $arg)
        set args $args $arg
    end
    set -l dest $argv[-1]
    rsync -aHAX --info=NAME,PROGRESS2 --human-readable --no-inc-recursive -- $args $dest
end

function sr
    if test (count $argv) -lt 2
        echo "Usage: sr <pattern> <replacement> [path]"
        return 1
    end

    set pattern $argv[1]
    set replacement $argv[2]
    set path "."

    if test (count $argv) -ge 3
        set path $argv[3]
    end

    fd --type f --hidden --exclude .git --exclude node_modules --exclude target --exclude .cache -0 . $path | sad -0 $pattern $replacement
end

function src
    if test (count $argv) -lt 3
        echo "Usage: src <extension> <pattern> <replacement> [path]"
        return 1
    end

    set ext $argv[1]
    set pattern $argv[2]
    set replacement $argv[3]
    set path "."

    if test (count $argv) -ge 4
        set path $argv[4]
    end

    fd --type f --extension $ext --hidden --exclude .git --exclude target --exclude build -0 . $path | sad -0 $pattern $replacement
end

sr() {
    if [ $# -lt 2 ]; then
        echo "Usage: sr <pattern> <replacement> [path]"
        return 1
    fi
    
    pattern="$1"
    replacement="$2"
    path="."
    
    if [ $# -ge 3 ]; then
        path="$3"
    fi
    
    find "$path" -type f -not -path "*/\.git/*" -not -path "*/node_modules/*" -not -path "*/target/*" -not -path "*/\.cache/*" -print0 | xargs -0 sad "$pattern" "$replacement"
}

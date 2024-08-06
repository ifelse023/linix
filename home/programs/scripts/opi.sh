#!/bin/bash

asm_file=$1
user="root"
host="192.168.2.33"
home="/root"
ssh_opts="-o ForwardX11=no -o ControlMaster=auto -o ControlPath=~/.ssh/cm-%r@%h:%p -o ControlPersist=5m"

if [ -z "$asm_file" ]; then
    echo "Usage: $0 <assembly_file>"
    exit 1
fi

scp -C $ssh_opts "$asm_file" "$user@$host:$home/" || exit 1

ssh $ssh_opts "$user@$host" "bash $home/compile_and_execute.sh $(basename "$asm_file")"
exit_code=$?

echo
echo "Exit Code: $exit_code"
exit $exit_code

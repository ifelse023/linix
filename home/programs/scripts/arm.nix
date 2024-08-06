{ pkgs, ... }:
let
  arm32 = pkgs.writers.writeBashBin "arm32" ''
    if [ $# -eq 0 ]; then
        echo "Usage: $0 <target-assembly-file>"
        exit 1
    fi

    TARGET=$1

    arm-none-eabi-as $TARGET -o arm32.o
    if [ $? -ne 0 ]; then
        echo "Assembly failed."
        exit 1
    fi

    arm-none-eabi-ld -static a.o -o binary
    if [ $? -ne 0 ]; then
        echo "Linking failed."
        exit 1
    fi

    qemu-arm binary
    if [ $? -ne 0 ]; then
        echo "Execution failed."
        exit 1
    fi
  '';

  arm = pkgs.writers.writeBashBin "arm" ''
    if [ $# -eq 0 ]; then
        echo "Usage: $0 <target-assembly-file>"
        exit 1
    fi

    TARGET=$1

    aarch64-elf-as $TARGET -o asm64.o
    if [ $? -ne 0 ]; then
        echo "Assembly failed."
        exit 1
    fi

    aarch64-elf-ld asm64.o -o binary
    if [ $? -ne 0 ]; then
        echo "Linking failed."
        exit 1
    fi

    qemu-aarch64 binary
    if [ $? -ne 0 ]; then
        echo "Execution failed."
        exit 1
    fi
  '';

  opi = pkgs.writers.writeBashBin "opi" { } ./opi.sh;

in
{
  home.packages = [
    arm
    arm32
    opi
  ];

}

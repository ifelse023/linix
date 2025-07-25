# Fish shell completions for core LLVM binary analysis tools.
# Save this file as ~/.config/fish/completions/llvm_tools.fish

# Helper function to prevent completions on file paths
function __llvm_tools_no_files
    set -l comp (commandline -t)
    if [ (string length -- "$comp") -gt 0 ]
        return 1
    end
    return 0
end

# --- llvm-objdump ---
# Provides detailed information about object files, including disassembly.

complete -c llvm-objdump -n __llvm_tools_no_files -d "Disassemble executable sections" -s d -l disassemble
complete -c llvm-objdump -n __llvm_tools_no_files -d "Disassemble all sections, including data" -s D -l disassemble-all
complete -c llvm-objdump -n __llvm_tools_no_files -d "Intermix source code with disassembly (requires debug info)" -s S -l source
complete -c llvm-objdump -n __llvm_tools_no_files -d "Display source line numbers with disassembly" -s l -l line-numbers
complete -c llvm-objdump -n __llvm_tools_no_files -d "Display full contents of all sections" -s s -l full-contents
complete -c llvm-objdump -n __llvm_tools_no_files -d "Display summaries of section headers" -s h -l section-headers
complete -c llvm-objdump -n __llvm_tools_no_files -d "Display the symbol table" -s t -l syms
complete -c llvm-objdump -n __llvm_tools_no_files -d "Display relocation entries" -s r -l reloc
complete -c llvm-objdump -n __llvm_tools_no_files -d "Display all available headers (section, file, reloc, etc.)" -s x -l all-headers
complete -c llvm-objdump -n __llvm_tools_no_files -d "Demangle C++/Rust symbol names" -s C -l demangle
complete -c llvm-objdump -n __llvm_tools_no_files -d "Specify target triple (e.g., thumbv7m-none-eabi)" -l triple
complete -c llvm-objdump -n __llvm_tools_no_files -d "Target a specific CPU for disassembly (e.g., cortex-m4)" -l mcpu

# --- llvm-readelf ---
# Displays information about ELF format object files.

complete -c llvm-readelf -n __llvm_tools_no_files -d "Display all available information" -s a -l all
complete -c llvm-readelf -n __llvm_tools_no_files -d "Display the main ELF file header" -s h -l file-header
complete -c llvm-readelf -n __llvm_tools_no_files -d "Display program headers (segments)" -s l -l program-headers
complete -c llvm-readelf -n __llvm_tools_no_files -d "Display section headers" -s S -l sections -l section-headers
complete -c llvm-readelf -n __llvm_tools_no_files -d "Display the symbol table" -s s -l symbols -l syms
complete -c llvm-readelf -n __llvm_tools_no_files -d "Display relocation entries" -s r -l relocs
complete -c llvm-readelf -n __llvm_tools_no_files -d "Display the dynamic section" -s d -l dynamic
complete -c llvm-readelf -n __llvm_tools_no_files -d "Display unwind information (e.g., .eh_frame)" -s u -l unwind
complete -c llvm-readelf -n __llvm_tools_no_files -d "Display contents of note sections" -l notes

# --- llvm-nm ---
# Lists symbols from object files.

complete -c llvm-nm -n __llvm_tools_no_files -d "Demangle C++/Rust symbol names" -s C -l demangle
complete -c llvm-nm -n __llvm_tools_no_files -d "Show only external (global) symbols" -s g -l extern-only
complete -c llvm-nm -n __llvm_tools_no_files -d "Show only undefined symbols" -s u -l undefined-only
complete -c llvm-nm -n __llvm_tools_no_files -d "Display dynamic symbols" -s D -l dynamic
complete -c llvm-nm -n __llvm_tools_no_files -d "Sort symbols by address (numeric order)" -s n -l numeric-sort
complete -c llvm-nm -n __llvm_tools_no_files -d "Sort symbols by size" --size-sort
complete -c llvm-nm -n __llvm_tools_no_files -d "Print size and address in radix (d, o, x)" -s t -l radix
complete -c llvm-nm -n __llvm_tools_no_files -d "Add the filename to each symbol line" -s A -l print-file-name

# esp-rs
set -gx LIBCLANG_PATH "$HOME/.rustup/toolchains/esp/xtensa-esp32-elf-clang/esp-20.1.1_20250829/esp-clang/lib"

set -l ESP_XTENSA_BIN "$HOME/.rustup/toolchains/esp/xtensa-esp-elf/esp-15.2.0_20250920/xtensa-esp-elf/bin"
if [ -d "$ESP_XTENSA_BIN" ]
  set PATH "$ESP_XTENSA_BIN" $PATH
end

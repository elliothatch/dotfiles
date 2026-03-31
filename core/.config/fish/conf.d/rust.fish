# rust
set -l RUST_BIN_PATH "$HOME/.cargo/bin"
if [ -d "$RUST_BIN_PATH" ]
  set PATH "$RUST_BIN_PATH" $PATH
end

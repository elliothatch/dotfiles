# rust
set RUST_BIN_PATH "$HOME/.cargo/bin"
if [ -d "$RUST_BIN_PATH" ]
  set PATH "$RUST_BIN_PATH" $PATH
  fnm env | source
end

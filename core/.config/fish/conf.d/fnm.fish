# fnm
set FNM_PATH "$XDG_DATA_HOME/fnm"
if [ -d "$FNM_PATH" ]
  set PATH "$FNM_PATH" $PATH
  fnm env --use-on-cd --shell fish | source
end

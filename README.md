# vimconfig
my .vim, .vimrc, .gitconfig and plugins and anything else

setup
-----
run `install.sh` to automatically link all the files to your home directory (only includes .gitconfig if logged in with my username, since it has my personal info)

If this is the first install, you also need to build `vimproc` for tsuquyomi to work:

```
cd .vim/bundle/vimproc
make
```

In windows, use the VS command prompt or download vimproc binaries to `vimproc/lib`.
```
nmake -f make_msvc.mak nodebug=1 "SDK_INCLUDE_DIR=C:\Program Files (x86)\Microsoft SDKs\Windows\v7.1A\Include"
```


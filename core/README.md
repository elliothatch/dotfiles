/etc/fonts/local.conf

currently testing out some font stuff, trying to improve emoji/symbols

changes:

1. use "Bitstream Vera" instead of DejaVu. it's the same font, but only includes base latin symbols and not extended unicode (DejaVu has poor support for unicode, but it's seemingly impossible to override what it does cover with a better symbol font.
2. Use JuliaMono to provide symbols. I want a monochrome symbol font for monospaced text. I like how JuliaMono looks, but the symbols appear very small.
   - Sometimes they don't seem to fill the entire width of the character or something. idk. Compare the "square with text" symbols with those from Noto CJK, which appear much bigger but fill the same amount of space.
   - some of the characters are double-wide? not sure how this works


## lf image preview

To use image preview in lf file manager:

1. Install dependencies, replacing alacritty with sixel fork:
```bash
sudo pacman -S chafa
yay -S alacritty-sixel-git
```

2. Change `~/.config/lf/lfrc` to use sixel previewer:
```
set previewer ~/.config/lf/previewer-sixel
set sixel
```

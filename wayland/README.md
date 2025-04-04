## Editing ReGreet styles with GTK inspector

You can use GTK inspector to determine the elements and classes that are needed to style a part of the UI.

First, enable inspector:
```bash
gsettings set org.gtk.Settings.Debug enable-inspector-keybinding true
````

Then, run ReGreet in demo mode:

```bash
regreet --demo
```

Finally, press `CTRL+SHIFT+D` to open the inspector window.

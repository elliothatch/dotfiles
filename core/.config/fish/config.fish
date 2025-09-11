if status is-interactive
    # Commands to run in interactive sessions can go here
end
if test $TERM = "alacritty"
	# on or off, there are problems
	# when on, flashing on resize, and prompt duplicated on small window resize
	# when off, prompt just doesn't appear when window is small, despite there being space. no prompt on new terminal is really annoying
	set -g fish_handle_reflow 1
end

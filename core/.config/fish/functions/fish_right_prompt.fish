function fish_right_prompt
    set -l last_pipestatus $pipestatus
    set -lx __fish_last_status $status # Export for __fish_print_pipestatus.
    set -q fish_color_status
    or set -g fish_color_status red

    # Write pipestatus
    # If the status was carried over (if no command is issued or if `set` leaves the status untouched), don't bold it.
    set -l bold_flag --bold
    set -q __fish_prompt_status_generation; or set -g __fish_prompt_status_generation $status_generation
    if test $__fish_prompt_status_generation = $status_generation
        set bold_flag
    end
    set __fish_prompt_status_generation $status_generation
    set -l status_color (set_color $fish_color_status)
    set -l statusb_color (set_color $bold_flag $fish_color_status)
    set -l prompt_status (__fish_print_pipestatus "[" "] " "|" "$status_color" "$statusb_color" $last_pipestatus)

    set -l prompt_date (date "+%H:%M:%S")

	# display time the last command took to execute
	set -l last_duration $CMD_DURATION
	set -l duration_prompt
	if test $last_duration -ge 1000
		set -l last_secs (math --scale=1 $last_duration/1000 % 60)
		set -l last_mins (math --scale=0 $last_duration/60000 % 60)
		set -l last_hours (math --scale=0 $last_duration/3600000)

		test $last_hours -gt 0 && set --append duration_prompt $last_hours"h"
		test $last_mins -gt 0 && set --append duration_prompt $last_mins"m"
		test $last_secs -gt 0 && set --append duration_prompt $last_secs"s"

		set duration_prompt "[$duration_prompt] "
	end

    echo -n -s $prompt_status $duration_prompt $prompt_date
    # echo -n -s $prompt_status $prompt_date
end

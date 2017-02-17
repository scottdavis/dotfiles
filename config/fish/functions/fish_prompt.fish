function fish_prompt
	if not set -q VIRTUAL_ENV_DISABLE_PROMPT
        set -g VIRTUAL_ENV_DISABLE_PROMPT true
    end
    switch (whoami)
    case root
        set user_color red
    case '*'
        set user_color cb4b16
    end

    if not set -q $SSH_TTY
        set host_color red
    else
        set host_color b58900
    end

    set_color $user_color
    printf '%s' (whoami)
    set_color --bold white
    printf ' at '

    set_color $host_color
    echo -n (prompt_hostname)
    set_color --bold white
    printf ' in '

    set_color 859900
    printf '%s' (prompt_pwd)
    set_color --bold white
    printf ' '

    __informative_git_prompt

    # Line 2
    echo
    if test $VIRTUAL_ENV
        printf "(%s) " (set_color blue)(basename $VIRTUAL_ENV)(set_color normal)
    end
    set_color --bold white
    printf '$ '
    set_color normal
end

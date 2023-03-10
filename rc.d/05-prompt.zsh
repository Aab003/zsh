#!/bin/zsh


# # Some useful prompt escape codes:
# #      %F{<x>}:  Set foreground color. <x> can be one of the 8 standard color
# #                names, a number from 0 to 255 or a hex value (if your terminal
# #                supports it). See also
# #                https://en.wikipedia.org/wiki/ANSI_escape_code#Colors
# #           %f:  Reset foreground color to default.
# #           %~:  Current directory, in ~abbreviated form
# #           %#:  If user is root, then '#', else '%'
# # %(?,<a>,<b>):  If last exit status was 0, then <a>, else <b>
# # https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html


# ##
# # Main prompt, left side
# #
# PS1="%F{%(?,10,9)}%#%f "  # 10 is bright green; 9 is bright red.

# # Strings in "double quotes" are what some languages call "template strings":
# # They allow the use of $expansions inside, which are then substituted with the
# # parameters' values.
# # Strings in 'single quotes', on the other hand, are literal strings. They
# # always evaluate to the literal characters you see on your screen.


# # Install our chpwd and precmd hook functions.
# # https://zsh.sourceforge.io/Doc/Release/Functions.html#Hook-Functions
# # -U tells autoload not to expand aliases inside the function.
# # -z tells autoload that the function file is written in the default Zsh style.
# # The latter is normally not necessary, but better safe than sorry.
# autoload -Uz add-zsh-hook
# local hook=
# for hook in chpwd precmd; do
#   add-zsh-hook $hook prompt_launchpad_$hook
# done
# # add-zsh-hook can autoload our functions by name, because in 04-env.zsh, we
# # added their parent dir to our $fpath.

# prompt_launchpad_chpwd  # Call once before the first prompt.

# # Auto-remove the right side of the prompt when you press enter.
# # That way, we'll have less clutter on screen.
# # It also makes it easier to copy code from our terminal.
# setopt TRANSIENT_RPROMPT

# # If we're not on an SSH connection, then remove the outer margin of the right
# # side of the prompt.
# [[ -v SSH_CONNECTION ]] ||
#     ZLE_RPROMPT_INDENT=0


# # Reduce startup time by making the primary prompt visible *immediately.*
# znap prompt


# ##
# # Continuation prompt
# #

# # This prompt is shown if, after pressing enter, you have left unclosed shell
# # constructs in your command line; for example, a string without a terminating
# # quote or a `for` loop without the final `done`.

#  PS2=               # Empty left side to make copying code easier.
# RPS2="%F{11}%^%f"   # %^ shows which shell constructs are still open.
# # 11 is bright yellow.


# Pretty, minimal and fast ZSH prompt
PURE_CMD_MAX_EXEC_TIME=10
zstyle :prompt:pure:git:stash show yes # turn on git stash status
# typeset -A pure_halloween_scheme=( # Halloween Dark
# 	color1 "#E84000" # Tangelo
# 	color2 "#EB6123" # Halloween Orange
# 	color3 "#FFE5D5" # Flesh
# 	color4 "#F1B111" # Spanish Yellow
# 	color5 "#FF1A72" # Electric Pink
# 	color6 "#E40055" # Raspberry
# )
# # typeset -A pure_halloween_scheme=( # Halloween Light
# # 	color1 "#D94E49" # English Vermillion
# # 	color2 "#363B3F" # Onyx
# # 	color3 "#EE7867" # Coral Reef
# # 	color4 "#F2C359" # Maize (Crayola)
# # 	color5 "#E2B44E" # Sunray
# # 	color6 "#494F55" # Quartz
# # )
# zstyle :prompt:pure:execution_time      color $pure_halloween_scheme[color3]
# zstyle :prompt:pure:git:arrow           color $pure_halloween_scheme[color5]
# zstyle :prompt:pure:git:branch          color $pure_halloween_scheme[color2]
# zstyle :prompt:pure:git:branch:cached   color $pure_halloween_scheme[color1]
# zstyle :prompt:pure:git:dirty           color $pure_halloween_scheme[color4]
# zstyle :prompt:pure:host                color $pure_halloween_scheme[color6]
# zstyle :prompt:pure:path                color $pure_halloween_scheme[color1]
# zstyle :prompt:pure:prompt:error        color $pure_halloween_scheme[color1]
# zstyle :prompt:pure:prompt:success      color $pure_halloween_scheme[color4]
# zstyle :prompt:pure:user                color $pure_halloween_scheme[color4]
# zstyle :prompt:pure:user:root           color $pure_halloween_scheme[color3]
# zstyle :prompt:pure:virtualenv          color $pure_halloween_scheme[color6]
znap prompt sindresorhus/pure

PS1='%F{${prompt_pure_colors[path]}}%* ' # current_time
PS1+='%(12V.%F{$prompt_pure_colors[virtualenv]}%12v%f .)' # $PROMPT
PS1+='%(?.%F{$prompt_pure_colors[prompt:success]}.%F{$prompt_pure_colors[prompt:error]})${prompt_pure_state[prompt]}%f ' # $prompt_indicator
PS2=''
RPS2='%F{$prompt_pure_colors[prompt:continuation]}%(1_.%_ .%_)%f'

setopt TRANSIENT_RPROMPT
[[ -v SSH_CONNECTION ]] || ZLE_RPROMPT_INDENT=0

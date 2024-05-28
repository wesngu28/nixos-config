#!/usr/bin/zsh

# The reason I need to use vivaldi is for when I save a bunch of tabs or need to open tabs for research / shopping
# into my vertical tabbed browser. Firefox does not differentiate anything between profiles that I can use to manipulate
# the firefox cli command, afaik, and will always open in the default profile. rip

# hyprctl dispatch focus is for focusing the newly opened tab, something i ended up not being interested in
# i tend to open in bunches

workspace_id=$(hyprctl activeworkspace -j | jq -r ".id")
# original_window_address=$(hyprctl activeworkspace -j | jq -r ".lastwindow")
firefox_windows=$(hyprctl clients -j | jq -r --arg workspace_id "$workspace_id" '.[] | select(.class == "firefox" and .workspace.id == ($workspace_id | tonumber))')
vivaldi_windows=$(hyprctl clients -j | jq -r --arg workspace_id "$workspace_id" '.[] | select(.class == "vivaldi-stable" and .workspace.id == ($workspace_id | tonumber))')

url=$1

if [[ -z "$url" ]]; then
    echo "No URL" >&2
    exit 1
fi

if [[ -n "$vivaldi_windows" ]]; then
    # current_vivaldi_address=$(echo "$vivaldi_windows" | jq -r ".address")
    # hyprctl dispatch focuswindow address:"$current_vivaldi_address"
    vivaldi --new-tab "$url" &
else
    if [[ -n "$firefox_windows" ]]; then
        # current_ff_address=$(echo "$firefox_windows" | jq -r ".address")
        # hyprctl dispatch focuswindow address:"$current_ff_address"
        firefox --new-tab "$url" &
    else
        firefox --new-window "$url" &
    fi
fi

# hyprctl dispatch focuswindow address:"$original_window_address"

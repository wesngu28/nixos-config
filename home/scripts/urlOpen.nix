{pkgs, ...}: {
  home.packages = with pkgs; [
    (writeShellScriptBin
      "open_url"
      ''
        workspace_id=$(hyprctl activeworkspace -j | jq -r ".id")

        url=$1

        if [[ -z "$url" ]]; then
            echo "No URL" >&2
            exit 1
        fi

        if [[ "$workspace_id" -eq 4 ]]; then
            firefox -P "treetabs" --new-tab "$url" &
        elif [[ "$workspace_id" -eq 8 ]]; then
            firefox -P "containerd" --new-tab "$url" &
        else
            firefox_windows=$(hyprctl clients -j | jq -r --arg workspace_id "$workspace_id" '.[] | select(.class == "firefox" and .workspace.id == ($workspace_id | tonumber))')
            if [[ -n "$firefox_windows" ]]; then
                current_ff_address=$(echo "$firefox_windows" | jq -r ".address")
                hyprctl dispatch focuswindow address:"$current_ff_address"
                firefox --new-tab "$url" &
            else
                firefox --new-window "$url" &
            fi
        fi
      '')
  ];
}

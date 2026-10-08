local mainMod = "SUPER"

-- Environment variables
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("XCURSOR_SIZE", "24")
hl.env("NIXOS_OZONE_WL", "1")

-- Config options
hl.config({
  general = {
    allow_tearing = true,
    border_size = 2,
    col = {
      active_border = "rgb(b4befe)",
    },
    gaps_in = 3,
    gaps_out = 5,
    layout = "scrolling",
  },

  master = {
    mfact = 0.5
  },

  scrolling = {
    column_width = 0.5
  },

  input = {
    follow_mouse = 2,
    kb_layout = "us",
    touchpad = {
      natural_scroll = false,
    },
  },

  decoration = {
    rounding = 5,
    blur = {
      enabled = true,
      passes = 1,
      size = 3,
    },
    shadow = {
      enabled = false,
      range = 4,
      render_power = 3,
    },
  },

  cursor = {
    default_monitor = "DP-2",
  },

  misc = {
    allow_session_lock_restore = true,
    disable_hyprland_logo = true,
    key_press_enables_dpms = true,
    mouse_move_enables_dpms = true,
    render_unfocused_fps = 60,
    vrr = 2,
  },

  render = {
    new_render_scheduling = false,
  },
})

-- Monitors
hl.monitor({ output = "DP-2", mode = "3440x1440@164.90", position = "auto", scale = "auto" })
hl.monitor({ output = "Virtual", mode = "3440x1440@164.90", position = "-100000x0", scale = "1" })

-- Curves and animations
hl.curve("myBezier", { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.05} } })

hl.animation({ leaf = "windows", enabled = true, speed = 4, bezier = "myBezier" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 4, bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border", enabled = true, speed = 5, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 4, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 4, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 5, bezier = "default" })

-- Autostart
hl.on("hyprland.start", function()
  hl.exec_cmd("hyprctl output create headless Virtual")
  hl.exec_cmd("waybar")
  hl.exec_cmd("systemctl --user start hyprpolkitagent")
  hl.exec_cmd("dbus-update-activation-environment --systemd DISPLAY HYPRLAND_INSTANCE_SIGNATURE WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE")
  hl.exec_cmd("systemctl --user import-environment QT_QPA_PLATFORMTHEME WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
  hl.exec_cmd("systemctl --user import-environment PATH && systemctl --user restart xdg-desktop-portal.service")
  hl.exec_cmd("gnome-keyring-daemon --start --components=secrets")
  hl.exec_cmd("kdeconnect-indicator")
  hl.exec_cmd("hyprpaper")
  hl.exec_cmd("xrandr --output DP-2 --primary")
  hl.exec_cmd("sleep 0.5 && wallpaper")
end)

-- Auto-resize columns: 0.5 for <=2, 0.333 for 3+
local function adjust_columns()
  local ws = hl.get_active_workspace()
  if ws == nil then return end
  local wins = hl.get_workspace_windows(ws.name)
  local tiled = 0
  for _, w in ipairs(wins) do
    if not w.floating then tiled = tiled + 1 end
  end
  if tiled >= 3 then
    hl.dispatch(hl.dsp.layout("colresize all 0.333"))
  else
    hl.dispatch(hl.dsp.layout("colresize all 0.5"))
  end
  hl.dispatch(hl.dsp.layout("fit tobeg"))
end

hl.on("window.open", function() adjust_columns() end)
hl.on("window.close", function() adjust_columns() end)
hl.on("window.destroy", function() adjust_columns() end)
hl.on("window.move_to_workspace", function() adjust_columns() end)

-- Keybinds: apps
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("thunar"))
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("foot"))
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd("firefox"))
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.exec_cmd("firefox --profile ~/.mozilla/firefox/treetabs"))
hl.bind(mainMod .. " + CTRL + A", hl.dsp.exec_cmd("firefox -P 'containers'"))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("rofi -show drun"))

-- Keybinds: window management
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exit())
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + V", hl.dsp.window.float())
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())

-- Keybinds: focus
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "d" }))

-- Keybinds: scrolling layout
hl.bind(mainMod .. " + l", hl.dsp.layout("swapcol l"))
hl.bind(mainMod .. " + h", hl.dsp.layout("swapcol r"))
hl.bind(mainMod .. " + j", hl.dsp.layout("consume"))
hl.bind(mainMod .. " + k", hl.dsp.layout("expel"))
hl.bind(mainMod .. " + equal", hl.dsp.layout("colresize +conf"))
hl.bind(mainMod .. " + minus", hl.dsp.layout("colresize -conf"))
hl.bind(mainMod .. " + backspace", hl.dsp.layout("fit active"))

-- Keybinds: waybar toggle
hl.bind(mainMod .. " + x", hl.dsp.exec_cmd("pkill -USR1 waybar"))

-- Keybinds: workspace navigation
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + 1", hl.dsp.focus({ workspace = "1" }))
hl.bind("code:91", hl.dsp.focus({ workspace = "1" }))
hl.bind(mainMod .. " + 2", hl.dsp.focus({ workspace = "2" }))
hl.bind(mainMod .. " + 3", hl.dsp.focus({ workspace = "3" }))
hl.bind(mainMod .. " + 4", hl.dsp.focus({ workspace = "4" }))
hl.bind(mainMod .. " + 5", hl.dsp.focus({ workspace = "5" }))
hl.bind(mainMod .. " + 6", hl.dsp.focus({ workspace = "6" }))
hl.bind(mainMod .. " + 7", hl.dsp.focus({ workspace = "7" }))
hl.bind(mainMod .. " + 8", hl.dsp.focus({ workspace = "8" }))
hl.bind(mainMod .. " + 9", hl.dsp.focus({ workspace = "9" }))

-- Keybinds: move to workspace
hl.bind(mainMod .. " + SHIFT + 1", hl.dsp.window.move({ workspace = "1" }))
hl.bind(mainMod .. " + SHIFT + 2", hl.dsp.window.move({ workspace = "2" }))
hl.bind(mainMod .. " + SHIFT + 3", hl.dsp.window.move({ workspace = "3" }))
hl.bind(mainMod .. " + SHIFT + 4", hl.dsp.window.move({ workspace = "4" }))
hl.bind(mainMod .. " + SHIFT + 5", hl.dsp.window.move({ workspace = "5" }))
hl.bind(mainMod .. " + SHIFT + 6", hl.dsp.window.move({ workspace = "6" }))
hl.bind(mainMod .. " + SHIFT + 7", hl.dsp.window.move({ workspace = "7" }))
hl.bind(mainMod .. " + SHIFT + 8", hl.dsp.window.move({ workspace = "8" }))
hl.bind(mainMod .. " + SHIFT + 9", hl.dsp.window.move({ workspace = "9" }))

-- Keybinds: screenshots
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("slurp | grim -g - - | wl-copy --type image/png && wl-paste > ~/Pictures/Screenshots/Screenshot-$(date +%F%T).png"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("grim - | wl-copy --type image/png && wl-paste > ~/Pictures/Screenshots/Screenshot-$(date +%F%T).png"))

-- Keybinds: lock
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("pkill -USR1 hyprlock"))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.exec_cmd("hyprlock"))

-- Keybinds: media (locked)
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })

-- Keybinds: brightness and volume (locked + repeating)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set +5%"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })

-- Keybinds: mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Window rules: workspace assignments
hl.window_rule({ match = { class = "^(virt-manager)$" }, workspace = "7" })
hl.window_rule({ match = { class = "^(lutris)$" }, workspace = "6" })
hl.window_rule({ match = { class = "^(steam)$" }, workspace = "6" })
hl.window_rule({ match = { initial_class = "^(steam_app_)(.*)$" }, workspace = "6" })
hl.window_rule({ match = { class = "^(explorer.exe)$" }, workspace = "6" })
hl.window_rule({ match = { class = "^(battle.net.exe)$" }, workspace = "6" })
hl.window_rule({ match = { class = "^(sc2_x64.exe)$" }, workspace = "6" })
hl.window_rule({ match = { class = "^(moe.launcher.the-honkers-railway-launcher)$" }, workspace = "6" })
hl.window_rule({ match = { class = "^(starrail.exe)$" }, workspace = "6" })
hl.window_rule({ match = { initial_title = "^(Spotify Premium)$" }, workspace = "3" })
hl.window_rule({ match = { title = "^(Nicotine%+)$" }, workspace = "3" })
hl.window_rule({ match = { title = "^(Jellyfin Media Player)$" }, workspace = "3" })
hl.window_rule({ match = { class = "^(feishin)$" }, workspace = "3" })
hl.window_rule({ match = { title = "^(Waydroid)$" }, workspace = "5" })
hl.window_rule({ match = { class = "^(waydroid).*$" }, workspace = "5" })
hl.window_rule({ match = { class = "^(vesktop)$" }, workspace = "2" })
hl.window_rule({ match = { class = "^(discord)$" }, workspace = "2" })
hl.window_rule({ match = { class = "^(obsidian)$" }, workspace = "4" })
hl.window_rule({ match = { class = "^(brave)$" }, workspace = "4" })

-- Window rules: opacity
hl.window_rule({ match = { class = "^(foot)$" }, opacity = "0.93 0.93" })
hl.window_rule({ match = { class = "^(obsidian)$" }, opacity = "0.93 0.93" })
hl.window_rule({ match = { class = "^(vesktop)$" }, opacity = "0.93 0.93" })
hl.window_rule({ match = { class = "^(discord)$" }, opacity = "0.93 0.93" })
hl.window_rule({ match = { class = "^(steam)$" }, opacity = "0.93 0.93" })
hl.window_rule({ match = { class = "^(Lutris)$" }, opacity = "0.93 0.93" })
hl.window_rule({ match = { class = "^(chromium)$" }, opacity = "0.93 0.93" })
hl.window_rule({ match = { class = "^(firefox)$" }, opacity = "0.93 0.93" })
hl.window_rule({ match = { title = "^.*(YouTube — Mozilla Firefox)" }, opacity = "1" })
hl.window_rule({ match = { title = "^.*(YouTube — Chromium)" }, opacity = "1" })
hl.window_rule({ match = { title = "^.*(Jellyfin)" }, opacity = "1" })
hl.window_rule({ match = { title = "(Nicotine+)" }, opacity = "0.93 0.93" })
hl.window_rule({ match = { title = "(Jellyfin Media Player)" }, opacity = "1" })
hl.window_rule({ match = { title = "(Picture-in-Picture)" }, opacity = "1" })
hl.window_rule({ match = { title = "(Picture in picture)" }, opacity = "1" })
hl.window_rule({ match = { class = "(code)" }, opacity = "0.93 override 0.93 override" })
hl.window_rule({ match = { initial_title = "(Spotify Premium)$" }, opacity = "0.93 override 0.93 override" })

-- Window rules: suppress / fullscreen
hl.window_rule({ match = { class = ".*" }, suppress_event = "maximize" })
hl.window_rule({ match = { title = "(Waydroid)$" }, fullscreen = true })
hl.window_rule({ match = { class = "^(waydroid).*$" }, fullscreen = true })
hl.window_rule({ match = { title = "(Starcraft II)$" }, fullscreen = true })

-- Window rules: border
hl.window_rule({ match = { float = true }, border_size = 0 })

-- Window rules: float
hl.window_rule({ match = { class = "(battle.net.exe)$" }, float = true })
hl.window_rule({ match = { class = "(btop)$" }, float = true })
hl.window_rule({ match = { class = "(swayimg)$" }, float = true })
hl.window_rule({ match = { class = "(mpv)$" }, float = true })
hl.window_rule({ match = { title = "(GNU Image Manipulation Program)$" }, float = true })
hl.window_rule({ match = { class = "(blueman-manager)$" }, float = true })
hl.window_rule({ match = { class = "(polkit)$", title = "(Authentication)$" }, float = true })
hl.window_rule({ match = { title = "(Media viewer)$" }, float = true })
hl.window_rule({ match = { title = "(Open Folder)$" }, float = true })
hl.window_rule({ match = { class = "org.gnome.FileRoller" }, float = true })
hl.window_rule({ match = { title = "^(Media viewer)$" }, float = true })
hl.window_rule({ match = { title = "^(Picture-in-Picture)$" }, float = true })
hl.window_rule({ match = { title = "^(Picture in picture)$" }, float = true })
hl.window_rule({ match = { title = "(DevTools)$" }, float = true })
hl.window_rule({ match = { title = "(Rename.*)$" }, float = true })
hl.window_rule({ match = { class = "(file_progress)$" }, float = true })
hl.window_rule({ match = { class = "(confirm)$" }, float = true })
hl.window_rule({ match = { class = "(dialog)$" }, float = true })
hl.window_rule({ match = { class = "(download)$" }, float = true })
hl.window_rule({ match = { class = "(notification)$" }, float = true })
hl.window_rule({ match = { class = "(file.*)$" }, float = true })
hl.window_rule({ match = { class = "(confirmreset)$" }, float = true })
hl.window_rule({ match = { title = "(Open File)$" }, float = true })
hl.window_rule({ match = { title = "(branchdialog)$" }, float = true })
hl.window_rule({ match = { title = "(Confirm to replace files)$" }, float = true })
hl.window_rule({ match = { title = "(File Operation Progress)$" }, float = true })
hl.window_rule({ match = { title = "(Steam - News)$" }, float = true })
hl.window_rule({ match = { class = "(electron)$", title = "(Open Files)$" }, float = true })
hl.window_rule({ match = { class = "(xdg-desktop-portal-gtk)$" }, float = true })
hl.window_rule({ match = { class = "(steam)$", title = "(Special Offers)$" }, float = true })
hl.window_rule({ match = { class = "(firefox)$", title = "(.*Bitwarden Password Manager.*)$" }, float = true })
hl.window_rule({ match = { modal = true }, float = true })
hl.window_rule({ match = { title = "(Extension)$" }, float = true })
hl.window_rule({ match = { title = "(Bluetooth Devices)$" }, float = true })
hl.window_rule({ match = { class = "(steam)$", title = "(Friends List)$" }, float = true })
hl.window_rule({ match = { class = "(waypaper)$" }, float = true })
hl.window_rule({ match = { title = "(Pipewire Volume Control)$" }, float = true })

-- Window rules: center
hl.window_rule({ match = { class = "(xdg-desktop-portal-gtk)$" }, center = true })
hl.window_rule({ match = { title = "(Visual Studio Code)$" }, center = true })
hl.window_rule({ match = { title = "^(Save)(.*)" }, center = true })
hl.window_rule({ match = { title = "^(Select)(.*)" }, center = true })
hl.window_rule({ match = { title = "(.*)(save to)(.*)" }, center = true })

-- Window rules: idle inhibit
hl.window_rule({ match = { class = "(mpv)$" }, idle_inhibit = "focus" })
hl.window_rule({ match = { class = "(firefox)$", title = "(.*YouTube.*)$" }, idle_inhibit = "focus" })
hl.window_rule({ match = { class = "(firefox)$" }, idle_inhibit = "fullscreen" })
hl.window_rule({ match = { workspace = "5" }, idle_inhibit = "always" })
hl.window_rule({ match = { workspace = "6" }, idle_inhibit = "focus" })
hl.window_rule({ match = { workspace = "7" }, idle_inhibit = "always" })

-- Window rules: steam fixes
hl.window_rule({ match = { title = "()$", class = "(steam)$" }, stay_focused = true })
hl.window_rule({ match = { title = "()$", class = "(steam)$" }, min_size = {1, 1} })

-- Window rules: sharing indicators
hl.window_rule({ match = { title = "(Firefox.* — Sharing Indicator)$" }, workspace = "special silent" })
hl.window_rule({ match = { title = "(.*is sharing (your screen|a window).)$" }, workspace = "special silent" })

-- Window rules: render unfocused
hl.window_rule({ match = { title = "(Honkai: Star Rail)$" }, render_unfocused = true })
hl.window_rule({ match = { title = "()$", class = "(steam)$" }, render_unfocused = true })
hl.window_rule({ match = { title = "(Arknights)$" }, render_unfocused = true })

-- Workspace rules
hl.workspace_rule({ workspace = "9", monitor = "Virtual", default = false })
hl.workspace_rule({ workspace = "7", monitor = "DP-2" })
hl.workspace_rule({ workspace = "6", monitor = "DP-2" })
hl.workspace_rule({ workspace = "5", monitor = "DP-2" })
hl.workspace_rule({ workspace = "4", monitor = "DP-2" })
hl.workspace_rule({ workspace = "3", monitor = "DP-2" })
hl.workspace_rule({ workspace = "2", monitor = "DP-2" })
hl.workspace_rule({ workspace = "1", monitor = "DP-2" })

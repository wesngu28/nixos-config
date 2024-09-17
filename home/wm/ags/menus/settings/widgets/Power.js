export const PowerButtons = () =>
  Widget.Box([
    Widget.Button({
      on_clicked: () => Utils.execAsync(`sh -c "sleep 0.5 && swaylock"`),
      class_name: 'settings-power',
      vpack: 'center',
      child: Widget.Icon({
        css: 'color: #f9e2af;',
        icon: 'changes-prevent-symbolic',
      }),
    }),
    Widget.Button({
      on_clicked: () => Utils.execAsync('systemctl suspend'),
      class_name: 'settings-power',
      vpack: 'center',
      child: Widget.Icon('media-playback-pause-symbolic'),
    }),
    Widget.Button({
      on_clicked: () => Utils.execAsync('systemctl reboot'),
      class_name: 'settings-power',
      vpack: 'center',
      child: Widget.Icon({
        css: 'color: #a6e3a1;',
        icon: 'system-reboot-symbolic',
      }),
    }),
    Widget.Button({
      on_clicked: () => Utils.execAsync('systemctl poweroff'),
      class_name: 'settings-power',
      vpack: 'center',
      child: Widget.Icon({
        css: 'color: #f38ba8;',
        icon: 'system-shutdown-symbolic',
      }),
    }),
  ])

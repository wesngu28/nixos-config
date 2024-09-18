import { BlueToothIndicator } from './widgets/BluetoothIndicator.js'
import { Date } from './widgets/Date.js'
import { NetworkIndicator } from './widgets/NetworkIndicator.js'
import { TrayIndicator } from './widgets/TrayIndicator.js'
import { VolumeIndicator } from './widgets/VolumeIndicator.js'
import { WeatherIndicator } from './widgets/WeatherIndicator.js'
import { WireguardIndicator } from './widgets/WireguardIndicator.js'

export const Right = monitor =>
  Widget.Box({
    class_name: 'section',
    hpack: 'end',
    children: [
      Widget.Box({
        children: [
          TrayIndicator(),
          VolumeIndicator(),
          Date(monitor),
          WeatherIndicator(),
          Widget.EventBox({
            onPrimaryClick: () => {
              App.closeWindow(`calendar-${monitor}`)
              App.toggleWindow(`quick-settings-${monitor}`)
            },
            child: Widget.Box({
              children: [
                WireguardIndicator(),
                NetworkIndicator(),
                BlueToothIndicator(),
                Widget.Icon({ css: 'color: #f38ba8', size: 16, icon: 'system-shutdown-symbolic' }),
              ],
            }),
          }).hook(App, (self, window, visible) => {
            if (window === 'quick-settings') {
              self.toggleClassName('active', visible)
            }
          }),
        ],
      }),
    ],
  })

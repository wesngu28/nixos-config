import { Menu, ArrowToggleButton } from '../ToggleButton.js'
const network = await Service.import('network')

export const NetworkToggle = () => {
  let bind_target = network.wifi
  if (network.primary === 'wired' && network.wired.internet === 'connected') {
    bind_target = network.wired
  }
  return ArrowToggleButton({
    name: 'network',
    icon: bind_target.bind('icon_name'),
    label: bind_target.bind('state').as(state => (state === 'activated' ? 'Connected' : 'No Connection')),
    connection: [network.wifi, () => network.wifi.enabled],
    deactivate: () => (network.wifi.enabled = false),
    activate: () => {
      network.wifi.enabled = true
      network.wifi.scan()
    },
  })
}

export const Wired = () =>
  Widget.Box({
    hexpand: true,
    children: [
      Widget.Icon({ icon: network.wired.bind('icon_name') }),
      Widget.Label('Wired'),
      Widget.Box({ hexpand: true }),
      Widget.Button({
        class_name: 'wired',
        on_clicked: () => {
          if (network.wired.internet === 'connected') {
            Utils.execAsync(
              `sh -c "nmcli device | grep ethernet | grep connected | awk '{print $1}' | xargs -r nmcli device disconnect"`
            )
          } else {
            Utils.execAsync(
              `sh -c "nmcli device | grep ethernet | grep disconnected | awk '{print $1}' | xargs -r nmcli device connect"`
            )
          }
        },
        child: Widget.Icon({
          icon: network.bind('connectivity').as(connected => {
            if (connected === 'full') {
              return 'object-select-symbolic'
            } else {
              return 'window-close-symbolic'
            }
          }),
          hpack: 'end',
        }),
      }),
    ],
  })

const validAccessPoints = () =>
  Menu({
    name: 'network',
    icon: network.wifi.bind('icon_name'),
    title: 'Wifi Selection',
    content: [
      Widget.Box({
        vertical: true,
        children: network.wifi.access_points
          .filter(ap => ap)
          .sort((a, b) => b.strength - a.strength)
          .slice(0, 10)
          .map(ap =>
            Widget.Button({
              on_clicked: () => {
                Utils.execAsync(`nmcli device wifi connect ${ap.bssid}`)
              },
              child: Widget.Box({
                children: [
                  Widget.Icon(ap.iconName),
                  Widget.Label(ap.ssid || ''),
                  Widget.Icon({
                    icon: 'object-select-symbolic',
                    hexpand: true,
                    hpack: 'end',
                    setup: self =>
                      Utils.idle(() => {
                        if (!self.is_destroyed) self.visible = ap.active
                      }),
                  }),
                ],
              }),
            })
          ),
      }),
    ],
  })

export const WifiSelection = () => {
  if (network.primary !== 'wired') {
    return Menu({
      name: 'network',
      icon: network.wifi.bind('icon_name'),
      title: 'Wifi Selection',
      content: [validAccessPoints()],
    })
  } else {
    return Menu({
      name: 'network',
      icon: network.wired.bind('icon_name'),
      title: 'Modify Ethernet',
      content: [Wired()],
    })
  }
}

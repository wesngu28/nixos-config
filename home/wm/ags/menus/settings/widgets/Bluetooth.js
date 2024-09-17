import { Menu, ArrowToggleButton } from '../ToggleButton.js'

const bluetooth = await Service.import('bluetooth')

export const BluetoothToggle = () =>
  ArrowToggleButton({
    name: 'bluetooth',
    icon: bluetooth.bind('enabled').as(p => (p ? 'bluetooth-active-symbolic' : 'bluetooth-disabled-symbolic')),
    label: Utils.watch('Disabled', bluetooth, () => {
      if (!bluetooth.enabled) return 'Disabled'
      if (bluetooth.connected_devices.length === 1) return bluetooth.connected_devices[0].alias
      return `${bluetooth.connected_devices.length} Connected`
    }),
    connection: [bluetooth, () => bluetooth.enabled],
    deactivate: () => (bluetooth.enabled = false),
    activate: () => (bluetooth.enabled = true),
  })

const DeviceItem = device =>
  Widget.Box({
    children: [
      Widget.Icon({
        css: device.connected ? 'color: #a6e3a1;' : 'color: #f38ba8;',
        icon: device.icon_name + '-symbolic',
        class_name: 'menu-icon',
      }),
      Widget.Label({
        label: device.name,
      }),
      Widget.Box({ hexpand: true }),
      Widget.Spinner({
        active: device.bind('connecting'),
        visible: device.bind('connecting'),
      }),
      // Widget.Switch({
      //   active: device.connected,
      //   visible: device.bind('connecting').as(p => !p),
      //   setup: self =>
      //     self.on('notify::active', () => {
      //       device.setConnection(self.active)
      //     }),
      // }),
      Widget.Button({
        visible: device.bind('connecting').as(p => !p),
        on_clicked: () => device.setConnection(!device.connected),
        child: Widget.Icon({
          icon: device.connected ? 'object-select-symbolic' : 'window-close-symbolic',
          hexpand: true,
          hpack: 'end',
        }),
      }),
    ],
  })

export const BluetoothDevices = () =>
  Menu({
    class_name: 'menu-items-section',
    name: 'bluetooth',
    title: 'Bluetooth',
    content: [
      Widget.Box({
        vertical: true,
        children: bluetooth.bind('devices').as(device =>
          device
            .filter(d => d.name)
            .map(device =>
              Widget.Box({
                child: DeviceItem(device),
              })
            )
        ),
      }),
    ],
  })

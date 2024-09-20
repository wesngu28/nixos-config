import PopupWindow from '../../components/PopupWindow.js'
import {
  AppMixer,
  InputDevices,
  InputDevicesToggle,
  OutputDevices,
  OutputDevicesToggle,
  speakerSlider,
} from '../settings/widgets/Audio.js'
import { BluetoothDevices, BluetoothToggle } from '../settings/widgets/Bluetooth.js'
import { Media } from '../settings/widgets/Media.js'
import { NetworkToggle, WifiSelection } from '../settings/widgets/Network.js'
import { Header } from './widgets/Header.js'

const Row = (toggles = [], menus = []) =>
  Widget.Box({
    vertical: true,
    children: [
      Widget.Box({
        homogeneous: true,
        children: toggles,
      }),
      Widget.Box({
        children: menus,
      }),
    ],
  })

const SystemMenuBox = () =>
  Widget.Box({
    className: 'quick-settings-menu',
    vertical: true,

    children: [
      Header(),
      Row([speakerSlider()], [AppMixer()]),
      Row([OutputDevicesToggle(), InputDevicesToggle()], [OutputDevices(), InputDevices()]),
      Row([NetworkToggle(), BluetoothToggle()], [WifiSelection(), BluetoothDevices()]),
      Media(),
    ],
  })

export const SystemMenu = (monitor, gdkmonitor) => {
  return PopupWindow({
    anchor: ['top', 'right'],
    name: `quick-settings-${monitor}`,
    gdkmonitor,
    exclusivity: 'exclusive',
    child: SystemMenuBox(),
  })
}

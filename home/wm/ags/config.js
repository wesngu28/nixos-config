import SystemMenu from './menus/settings/QuickSettings.js'
import CalendarWidget from './menus/Calendar.js'
import Wallpapers from './menus/Wallpapers.js'
import { NotificationPopups, NotificationWindow } from './menus/Notifications.js'
import { Right } from './bar/Right.js'
import { Center } from './bar/Center.js'
import { Left } from './bar/Left.js'

const Bar = () => {
  return Widget.Window({
    name: `bar`,
    css: 'background-color: transparent;',
    anchor: ['top', 'left', 'right'],
    exclusivity: 'exclusive',
    child: Widget.CenterBox({
      start_widget: Left(),
      center_widget: Center(),
      end_widget: Right(),
    }),
  })
}

App.config({
  style: './style.css',
  windows: [Bar(), Wallpapers(), CalendarWidget(), SystemMenu(), NotificationPopups(), NotificationWindow()],
})

import { SystemMenu } from './menus/settings/QuickSettings.js'
import { Calendar } from './menus/Calendar.js'
import { Wallpapers } from './menus/Wallpapers.js'
import { NotificationPopups, NotificationWindow } from './menus/Notifications.js'
import { Right } from './bar/Right.js'
import { Center } from './bar/Center.js'
import { Left } from './bar/Left.js'
import Gdk from 'gi://Gdk'
const hyprland = await Service.import('hyprland')

const Bar = (monitor = 0, gdkmonitor) => {
  return Widget.Window({
    name: `bar-${monitor}`,
    css: 'background-color: transparent;',
    gdkmonitor,
    anchor: ['top', 'left', 'right'],
    exclusivity: 'exclusive',
    child: Widget.CenterBox({
      start_widget: Left(),
      center_widget: Center(monitor),
      end_widget: Right(monitor),
    }),
  })
}

// guessing a primary monitor, UW or the largest monitor (if a laptop is plugged into external display)
const isUltrawideOrHighRes = monitor => {
  const aspectRatio = monitor.width / monitor.height
  return aspectRatio > 16 / 9 || monitor.height > 1440
}

// Still a nightmare when hotswapping

const MonitorHandler = widgets => {
  const display = Gdk.Display.get_default()
  let primaryMonitor = null

  for (let monitor of hyprland.monitors) {
    if (isUltrawideOrHighRes(monitor)) {
      primaryMonitor = monitor
      break
    }
  }

  display?.connect('monitor-added', (disp, gdkmonitor) => {
    let monitor = 0
    for (let i = 0; i < display.get_n_monitors(); i++) {
      if (gdkmonitor === display.get_monitor(i)) {
        monitor = i
        break
      }
    }

    widgets.forEach(widget => {
      App.addWindow(widget(monitor, gdkmonitor))
    })
  })

  display?.connect('monitor-removed', (disp, monitor) => {
    App.windows.forEach(win => {
      if (win.gdkmonitor === monitor) App.removeWindow(win)
    })
  })

  const gtkMonitorsCount = display?.get_n_monitors() || 1

  if (primaryMonitor) {
    for (let i = 0; i < gtkMonitorsCount; i++) {
      const gtkMonitor = display.get_monitor(i)
      const gtkModel = gtkMonitor.get_model()

      if (primaryMonitor.model === gtkModel) {
        return widgets.map(x => x(i, gtkMonitor))
      }
    }
  } else {
    for (let i = 0; i < gtkMonitorsCount; i++) {
      const gtkMonitor = display.get_monitor(i)
      return widgets.map(x => x(i, gtkMonitor))
    }
  }
}

App.config({
  style: './style.css',
  windows: [...MonitorHandler([Bar, Wallpapers, Calendar, SystemMenu, NotificationPopups, NotificationWindow])],
})

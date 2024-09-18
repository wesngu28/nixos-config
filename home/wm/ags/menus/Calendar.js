import PopupWindow from '../components/PopupWindow.js'

const CalendarWidget = () => {
  return Widget.Box({
    class_name: 'calendar calendar-menu-item-container calendar',
    child: Widget.Box({
      class_name: 'calendar-container-box',
      child: Widget.Calendar({
        class_name: 'calendar-menu-widget',
        showDayNames: true,
        showDetails: false,
        showHeading: true,
      }),
    }),
  })
}

export default monitor =>
  PopupWindow({
    name: `calendar-${monitor}`,
    anchor: ['top', 'right'],
    monitor,
    exclusivity: 'exclusive',
    child: CalendarWidget(),
  })

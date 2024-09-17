const notifications = await Service.import('notifications')

export function NotificationIndicator() {
  return Widget.Button({
    class_name: 'section',
    on_clicked: () => App.toggleWindow('notification-window'),
    child: Widget.Icon({
      icon: notifications
        .bind('notifications')
        .as(n => (n.length > 0 ? 'org.gnome.Settings-notifications-symbolic' : 'notifications-disabled-symbolic')),
    }),
  })
}
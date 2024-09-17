import PopupWindow from '../components/PopupWindow.js'

const notifications = await Service.import('notifications')

function NotificationIcon({ app_entry, app_icon, image }) {
  if (image) {
    return Widget.Box({
      css:
        `background-image: url("${image}");` +
        'background-size: contain;' +
        'background-repeat: no-repeat;' +
        'background-position: center;',
    })
  }

  let icon = 'dialog-information-symbolic'
  if (Utils.lookUpIcon(app_icon)) icon = app_icon

  if (app_entry && Utils.lookUpIcon(app_entry)) icon = app_entry

  return Widget.Box({
    css: `
        min-width: 58px;
        min-height: 58px;
    `,
    vpack: 'center',
    child: Widget.Icon({
      icon,
      size: 58,
      hpack: 'center',
      hexpand: true,
      vpack: 'center',
    }),
  })
}

function Notification(n) {
  const icon = Widget.Box({
    vpack: 'start',
    class_name: 'icon',
    child: NotificationIcon(n),
  })

  const title = Widget.Label({
    class_name: 'title',
    xalign: 0,
    justification: 'left',
    hexpand: true,
    max_width_chars: 24,
    truncate: 'end',
    wrap: true,
    label: n.summary,
    use_markup: true,
  })

  const body = Widget.Label({
    class_name: 'body',
    hexpand: true,
    use_markup: true,
    xalign: 0,
    justification: 'left',
    label: n.body,
    wrap: true,
  })

  const actions = Widget.Box({
    class_name: 'actions',
    children: n.actions.map(({ id, label }) =>
      Widget.Button({
        class_name: 'action-button',
        on_clicked: () => {
          n.invoke(id)
          n.dismiss()
        },
        hexpand: true,
        child: Widget.Label(label),
      })
    ),
  })

  return Widget.EventBox(
    {
      attribute: { id: n.id },
      on_primary_click: n.dismiss,
    },
    Widget.Box(
      {
        class_name: `notification ${n.urgency}`,
        vertical: true,
      },
      Widget.Box([
        icon,
        Widget.Box({ vertical: true, vpack: 'center', css: 'min-width: 350px; margin-left: 12px;' }, title, body),
      ]),
      actions
    )
  )
}

export const NotificationPopups = () => {
  const list = Widget.Box({
    vertical: true,
    children: notifications.popups.map(Notification),
  })

  function onNotified(_, id) {
    const n = notifications.getNotification(id)
    if (n) list.children = [Notification(n), ...list.children]
  }

  function onDismissed(_, id) {
    list.children.find(n => n.attribute.id === id)?.destroy()
  }

  list.hook(notifications, onNotified, 'notified').hook(notifications, onDismissed, 'dismissed')

  return Widget.Window({
    name: `notifications`,
    class_name: 'notification-popups',
    anchor: ['top'],
    child: Widget.Box({
      css: 'min-width: 2px; min-height: 2px;',
      class_name: 'notifications',
      vertical: true,
      child: list,
    }),
  })
}

const NotificationList = () => {
  return Widget.Scrollable({
    vscroll: 'automatic',
    hscroll: 'never',
    css: 'min-height: 300px; min-width: 500px;',
    child: Widget.Box({
      vertical: true,
      children: notifications.bind('notifications').as(x => x.reverse().map(Notification)),
    }),
  })
}

export const NotificationWindow = () =>
  PopupWindow({
    name: 'notification-window',
    layout: 'top-center',
    exclusivity: 'exclusive',
    child: Widget.Box({
      class_name: 'quick-settings-menu',
      vertical: true,
      children: [
        Widget.Box({
          hexpand: true,
          children: [
            Widget.Label({
              css: 'margin-left: 16px',
              hpack: 'start',
              label: notifications.bind('notifications').as(n => {
                return `There are ${n.length} total notifications`
              }),
            }),
            Widget.Box({ hexpand: 'center' }),
            Widget.Button({
              class_name: 'settings-power',
              hpack: 'end',
              onClicked: () => notifications.clear(),
              child: Widget.Box({
                children: [
                  Widget.Label({ label: 'Clear ' }),
                  Widget.Icon({
                    icon: notifications
                      .bind('notifications')
                      .as(x => (x.length > 0 ? 'user-trash-full-symbolic' : 'user-trash-symbolic')),
                  }),
                ],
              }),
            }),
          ],
        }),
        NotificationList(),
      ],
    }),
  })

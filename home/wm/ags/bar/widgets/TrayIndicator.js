const systemtray = await Service.import('systemtray')

export const TrayIndicator = () => {
  const items = systemtray.bind('items').as(items =>
    items.map(item =>
      Widget.Button({
        child: Widget.Icon({ size: 16, icon: item.bind('icon') }),
        on_secondary_click: (_, event) => item.activate(event),
        on_primary_click: (_, event) => item.openMenu(event),
        tooltip_markup: item.bind('tooltip_markup'),
      })
    )
  )

  return Widget.Box({
    css: 'margin-right: 10px;',
    children: items,
  })
}

import GLib from 'gi://GLib'

export const DateVariable = Variable(GLib.DateTime.new_now_local(), {
  poll: [1000, () => GLib.DateTime.new_now_local()],
})

export const Date = monitor =>
  Widget.Button({
    on_clicked: () => {
      App.closeWindow(`quick-settings-${monitor}`)
      App.toggleWindow(`calendar-${monitor}`)
    },
    class_name: 'calendar-button',
    child: Widget.Label({
      css: 'color: #cba6f7;',
      label: Utils.derive([DateVariable], c => c.format(' %I:%M %a %d ') || '').bind(),
    }),
  })

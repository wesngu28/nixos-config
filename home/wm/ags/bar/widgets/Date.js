import GLib from 'gi://GLib'

export const DateVariable = Variable(GLib.DateTime.new_now_local(), {
  poll: [1000, () => GLib.DateTime.new_now_local()],
})

export const Date = () =>
  Widget.Button({
    on_clicked: () => {
      App.closeWindow('quick-settings')
      App.toggleWindow('calendar')
    },
    class_name: 'calendar-button',
    child: Widget.Label({
      css: 'color: #cba6f7;',
      label: Utils.derive([DateVariable], c => c.format(' %I:%M %a %d ') || '').bind(),
    }),
  })

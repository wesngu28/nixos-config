const hyprland = await Service.import('hyprland')

// const focusedTitle = Widget.Label({
//   label: hyprland.active.client.bind('title'),
//   visible: hyprland.active.client.bind('address').as(addr => addr !== '0x'),
// })

const dispatch = ws => hyprland.messageAsync(`dispatch workspace ${ws}`)

const WorkSpaceIcons = {
  1: '',
  2: '',
  3: '',
  4: '',
  5: '󰓷',
  6: '',
  7: '',
}

export const Workspaces = () => {
  return Widget.EventBox({
    class_name: 'section workspaces',
    onScrollUp: () => dispatch('+1'),
    onScrollDown: () => dispatch('-1'),
    child: Widget.Box({
      children: Array.from({ length: 7 }, (_, i) => i + 1).map(i => {
        return Widget.Button({
          css: 'margin-right: 5px',
          class_name: hyprland.active.workspace.bind('id').as(id => `${id === i ? 'focused' : ''}`),
          attribute: i,
          label: WorkSpaceIcons[i] ? WorkSpaceIcons[i] : String(i),
          onClicked: () => dispatch(i),
        })
      }),

      setup: self =>
        self.hook(hyprland, () =>
          self.children.forEach(btn => {
            btn.visible = hyprland.workspaces.some(ws => ws.id === btn.attribute)
          })
        ),
    }),
  })
}

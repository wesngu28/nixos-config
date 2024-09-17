const { speaker } = await Service.import('audio')

export const VolumeIndicator = () =>
  Widget.Button({
    css: 'margin-right: 18px;',
    tooltip_text: `Volume ${Math.floor(speaker.volume * 100)}%`,
    value: speaker.bind('volume'),
    onScrollUp: ({ value }) => (speaker.volume = value + 0.05),
    onClicked: () => (speaker.is_muted = !speaker.is_muted),
    onScrollDown: ({ value }) => (speaker.volume = value - 0.05),
    child: Widget.Box({
      children: [
        Widget.Icon().hook(speaker, self => {
          const vol = speaker.volume * 100
          let icon
          if (speaker.is_muted) {
            icon = 'muted'
          } else {
            icon = [
              [101, 'overamplified'],
              [67, 'high'],
              [34, 'medium'],
              [1, 'low'],
              [0, 'muted'],
            ].find(([threshold]) => threshold <= vol)?.[1]
          }
          self.icon = `audio-volume-${icon}-symbolic`
          self.css = 'color: #89dceb;'
          self.size = 16
        }),
        Widget.Label().hook(speaker, self => {
          const vol = speaker.volume

          self.label = `${String((vol * 100).toFixed(0))}%`
          self.css = 'color: #89dceb;'
        }),
      ],
    }),
  })

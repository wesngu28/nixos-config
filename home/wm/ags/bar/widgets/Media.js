export const Player = player => {
  if (!player) return

  const PlayerProgress = () =>
    Widget.Box({
      vpack: 'center',
      children: [
        Widget.Button({
          on_clicked: () => player.previous(),
          visible: player.bind('can_go_prev'),
          child: Widget.Icon('media-skip-backward-symbolic'),
        }),
        Widget.CircularProgress({
          marginRight: 4,
          startAt: 0.75,
          rounded: true,
          setup: self => {
            self.poll(1000, self => {
              self.value = player.position / player.length
            })
          },
          child: Widget.Button({
            class_name: 'play-pause',
            on_clicked: () => player.playPause(),
            visible: player.bind('can_play'),
            child: Widget.Icon({
              icon: player.bind('play_back_status').transform(s => {
                switch (s) {
                  case 'Playing':
                    return 'media-playback-pause-symbolic'
                  case 'Paused':
                  case 'Stopped':
                    return 'media-playback-start-symbolic'
                }
              }),
            }),
          }),
        }),
        Widget.Button({
          on_clicked: () => player.next(),
          visible: player.bind('can_go_next'),
          child: Widget.Icon('media-skip-forward-symbolic'),
        }),
      ],
    })

  return Widget.Box(
    { class_name: 'player', spacing: 0 },
    PlayerProgress(),
    Widget.Box({
      css: 'font-weight: bold;',
      vpack: 'center',
      children: [
        Widget.Label({ name: 'label', vpack: 'center', maxWidthChars: 48, truncate: 'end' }).hook(player, label => {
          const { track_artists, track_title } = player
          if (track_artists && track_artists[0] !== 'Unknown artist') {
            label.label = `${track_artists.join(', ')} - ${track_title}`
          }
        }),
      ],
    })
  )
}

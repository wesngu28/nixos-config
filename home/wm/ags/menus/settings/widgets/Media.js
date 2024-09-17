import { activePlayer } from '../../../components/ActivePlayer.js'

function lengthStr(length) {
  const min = Math.floor(length / 60)
  const sec = Math.floor(length % 60)
  const sec0 = sec < 10 ? '0' : ''
  if (min === -1 || sec === -1 || sec0 === -1) {
    return `0:00`
  }
  return `${min}:${sec0}${sec}`
}
const Player = player => {
  if (!player) return

  const img = () => {
    return Widget.Box({
      class_name: 'img',
      css: player.bind('cover_path').transform(p => {
        return `background-image: url('${p}');;`
      }),
    })
  }

  return Widget.Box(
    { class_name: 'menu-player', spacing: 0 },
    img(),
    Widget.Box({
      vertical: true,
      children: [
        Widget.Label({ css: 'font-weight: bold;', hpack: 'start', maxWidthChars: 48, truncate: 'end' }).hook(
          player,
          label => {
            const { track_title } = player
            if (track_title) {
              label.label = `${track_title}`
            }
          }
        ),
        Widget.Label({ css: 'margin-bottom: 4px;', hpack: 'start', maxWidthChars: 48, truncate: 'end' }).hook(
          player,
          label => {
            const { track_artists } = player
            if (track_artists && track_artists[0] !== 'Unknown artist') {
              label.label = `${track_artists.join(', ')}`
            }
          }
        ),
        Widget.Label({ css: 'margin-bottom: 4px;', hpack: 'start', maxWidthChars: 48, truncate: 'end' }).hook(
          player,
          label => {
            const { track_album } = player
            if (track_album) {
              label.label = `${track_album}`
            }
          }
        ),
        Widget.Box({ vexpand: true }),
        Widget.Slider({
          class_name: 'position',
          hexpand: true,
          draw_value: false,
          on_change: ({ value }) => (player.position = value * player.length),
          visible: player.bind('length').as(l => l > 0),
          setup: self => {
            function update() {
              const value = player.position / player.length
              self.value = value > 0 ? value : 0
            }
            self.hook(player, update)
            self.hook(player, update, 'position')
            self.poll(1000, update)
          },
        }),
        Widget.CenterBox({
          css: 'margin-top: 4px;',
          start_widget: Widget.Label({
            hpack: 'start',
            setup: self => {
              const update = (_, time) => {
                self.label = lengthStr(time || player.position)
                self.visible = player.length > 0
              }

              self.hook(player, update, 'position')
              self.poll(1000, update)
            },
          }),
          center_widget: Widget.Box([
            Widget.Button({
              on_clicked: () => player.previous(),
              visible: player.bind('can_go_prev'),
              child: Widget.Icon('media-skip-backward-symbolic'),
            }),
            Widget.Button({
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
            Widget.Button({
              on_clicked: () => player.next(),
              visible: player.bind('can_go_next'),
              child: Widget.Icon('media-skip-forward-symbolic'),
            }),
          ]),
          end_widget: Widget.Label({
            class_name: 'length',
            hpack: 'end',
            visible: player.bind('length').transform(l => l > 0),
            label: player.bind('length').transform(lengthStr),
          }),
        }),
      ],
    })
  )
}

export const Media = () =>
  Widget.Box({
    css: 'margin-top: 16px',
    child: activePlayer.bind().as(p => Player(p)),
  })

import { VolumeIndicator } from '../../../bar/widgets/VolumeIndicator.js'
import { Arrow, ArrowToggleButton, Menu } from '../ToggleButton.js'

const audio = await Service.import('audio')

export const VolumeSlider = (type = 'speaker') =>
  Widget.Box({
    children: [
      VolumeIndicator(),
      Widget.Slider({
        hexpand: true,
        drawValue: false,
        onChange: ({ value }) => (audio[type].volume = value),
        value: audio[type].bind('volume'),
        css: audio[type].bind('is_muted').as(x => `opacity: ${x ? 0.7 : 1}`),
      }),
      Widget.Box({
        vpack: 'center',
        child: Arrow('app-mixer'),
        visible: audio.bind('apps').as(a => a.length > 0),
      }),
      Widget.Button({
        on_clicked: () => Utils.exec('pavucontrol'),
        child: Widget.Icon('emblem-system-symbolic'),
      }),
    ],
  })

export const speakerSlider = () => VolumeSlider('speaker')
export const micSlider = VolumeSlider('microphone')

export const OutputDevicesToggle = () =>
  ArrowToggleButton({
    name: 'output-devices',
    icon: 'audio-headphones-symbolic',
    label: Utils.watch('Disabled', audio, () => {
      if (audio.speaker && audio.speaker.description) return audio.speaker.description
      return `Output Device`
    }),
    connection: [audio, () => audio.speakers],
    deactivate: () => audio.bind('speakers').as(v => v.length <= 0),
    activate: () => audio.bind('speakers').as(v => v.length > 0),
  })

export const InputDevicesToggle = () =>
  ArrowToggleButton({
    name: 'input-devices',
    icon: 'audio-headphones-symbolic',
    label: Utils.watch('Disabled', audio, () => {
      if (audio.microphone && audio.microphone.description) return audio.microphone.description
      return `Input Device`
    }),
    connection: [audio, () => audio.microphones],
    deactivate: () => audio.bind('microphones').as(v => v.length <= 0),
    activate: () => audio.bind('microphones').as(v => v.length > 0),
  })

export const OutputDevices = () =>
  Menu({
    class_name: 'menu-items-section',
    name: 'output-devices',
    title: 'Output Devices',
    content: [
      Widget.Box({
        vertical: true,
        children: audio.bind('speakers').as(speaker =>
          speaker.map(speaker =>
            Widget.Button({
              on_primary_click: () => (audio.speaker = speaker),
              child: Widget.Box({
                hpack: 'start',
                children: [
                  Widget.Icon({
                    icon: audio
                      .bind('speaker')
                      .as(active =>
                        active.description === speaker.description
                          ? 'audio-volume-high-symbolic'
                          : 'audio-volume-muted-symbolic'
                      ),
                    class_name: 'menu-icon',
                  }),
                  Widget.Label({
                    truncate: 'end',
                    wrap: true,
                    hexpand: true,
                    label: speaker.description,
                  }),
                ],
              }),
            })
          )
        ),
      }),
    ],
  })

export const InputDevices = () =>
  Menu({
    class_name: 'menu-items-section',
    vertical: true,
    name: 'input-devices',
    title: 'Input Devices',
    content: [
      Widget.Box({
        vertical: true,
        children: audio.bind('microphones').as(v =>
          v
            .filter(recording => recording)
            .map(recording => {
              return Widget.Button({
                on_primary_click: () => (audio.microphone = recording),
                child: Widget.Box({
                  children: [
                    Widget.Box({
                      hpack: 'start',
                      children: [
                        Widget.Icon({
                          icon: audio
                            .bind('microphone')
                            .as(active =>
                              active.description === recording.description
                                ? 'audio-volume-high-symbolic'
                                : 'audio-volume-muted-symbolic'
                            ),
                          class_name: 'menu-icon',
                        }),
                        Widget.Label({
                          truncate: 'end',
                          wrap: true,
                          hexpand: true,
                          label: recording.description,
                        }),
                      ],
                    }),
                  ],
                }),
              })
            })
        ),
      }),
    ],
  })

export const AppMixer = () =>
  Menu({
    name: 'app-mixer',
    icon: 'audio-volume-high-symbolic',
    title: 'App Mixer',
    content: [
      Widget.Box({
        vertical: true,
        css: 'margin-bottom: 16px',
        children: audio.bind('apps').as(a => a.map(MixerItem)),
      }),
    ],
  })

const MixerItem = stream =>
  Widget.Box(
    {
      hexpand: true,
      class_name: 'mixer-item horizontal',
    },
    Widget.Icon({
      tooltip_text: stream.bind('name').as(n => n || ''),
      icon: stream.bind('name').as(n => {
        return Utils.lookUpIcon(n || '') ? n || '' : 'audio-volume-high-symbolic'
      }),
    }),
    Widget.Box(
      { vertical: true },
      Widget.Label({
        xalign: 0,
        truncate: 'end',
        max_width_chars: 28,
        label: Utils.merge([stream.bind('description'), stream.bind('volume')], (d, v) =>
          d && v ? `${d} - ${String((v * 100).toFixed(0))}%` : ''
        ),
      }),
      Widget.Slider({
        hexpand: true,
        draw_value: false,
        value: stream.bind('volume'),
        on_change: ({ value }) => (stream.volume = value),
      })
    )
  )

import { WeatherLabel } from './Weather.js'
import { DateVariable } from '../../../bar/widgets/Date.js'
import { PowerButtons } from './Power.js'

const Date = () =>
  Widget.Button({
    class_name: 'calendar-button',
    child: Widget.Label({
      css: 'color: #cba6f7;',
      label: Utils.derive([DateVariable], c => c.format(' %a %d %b %I:%M ') || '').bind(),
    }),
  })

export const Header = () =>
  Widget.Box({
    css: 'margin-bottom: 8px',
    children: [
      Widget.Box({
        className: 'avatar',
        css: `background-image: url("/home/serpe/profile.png");`,
      }),
      Widget.Box({
        hpack: 'center',
        vpack: 'center',
        hexpand: true,
        vertical: true,
        children: [Date(), WeatherLabel()],
      }),
      PowerButtons(),
    ],
  })

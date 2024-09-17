import { WeatherVariable } from '../../menus/settings/widgets/Weather.js'

export const WeatherIndicator = () =>
  Widget.Label({
    css: 'margin-right: 10px; color: #f2cdcd;',
    label: WeatherVariable.bind('value').as(weather => {
      return `${weather.currentTemperature}°f`
    }),
    'tooltip-text': WeatherVariable.bind('value').as(weather => weather.currentTime),
  })

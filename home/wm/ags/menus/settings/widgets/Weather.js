export const weatherIntervalInstance = Utils.interval(1800000, () => {
  Utils.execAsync(
    `curl "https://api.open-meteo.com/v1/forecast?latitude=32.2217&longitude=-110.9265&current=temperature_2m&hourly=precipitation_probability&daily=temperature_2m_max&temperature_unit=fahrenheit&wind_speed_unit=mph&precipitation_unit=inch&timezone=America%2FPhoenix&forecast_days=1"`
  )
    .then(res => {
      const weather = JSON.parse(res)

      function findClosestIndex(timeArray, currentTime) {
        return timeArray.reduce((closestIndex, timestamp, index) => {
          const timeDifference = Math.abs(new Date(timestamp) - currentTime)
          const closestTimeDifference = Math.abs(new Date(timeArray[closestIndex]) - currentTime)
          return timeDifference < closestTimeDifference ? index : closestIndex
        }, 0)
      }

      const closestIndex = findClosestIndex(weather.hourly.time, new Date(weather.current.time).toLocaleString())
      const nextSixHours = weather.hourly.precipitation_probability.slice(closestIndex, closestIndex + 6)

      WeatherVariable.value = {
        currentTemperature: Math.round(weather.current.temperature_2m),
        currentTime: new Date(weather.current.time).toLocaleString(),
        chanceOfRain: (nextSixHours.reduce((sum, value) => sum + value, 0) / nextSixHours.length).toFixed(),
        overHours: nextSixHours.length,
        high: weather.daily.temperature_2m_max,
        // currentCode: weather.current.weather_code,
        // dailyCode: weather.daily.weather_code,
      }
    })
    .catch(err => {
      console.error(`Failed to fetch weather: ${err}`)
    })
})

export const WeatherVariable = Variable({
  currentTemperature: 0,
  currentTime: new Date().toLocaleString(),
  chanceOfRain: 0,
  overHours: 0,
  high: 0,
})

export const WeatherLabel = () =>
  Widget.Label({
    label: WeatherVariable.bind('value').as(weather => {
      return `${weather.high}°f - ${weather.chanceOfRain}% 󰖗`
    }),
    'tooltip-text': WeatherVariable.bind('value').as(
      weather => `Daily high, rain chance within ${weather.overHours} hours`
    ),
  })

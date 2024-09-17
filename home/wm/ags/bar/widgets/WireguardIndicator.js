const WireguardVariable = Variable(false)

export const weatherIntervalInstance = Utils.interval(600000, () => {
  const up = Utils.exec('bash -c "[ -d /sys/class/net/wg0 ] && echo exists || echo not_exists"')
  if (up.trim() === 'exists') WireguardVariable.value = true
  else WireguardVariable.value = false
})

export const WireguardIndicator = () =>
  Widget.Icon({
    icon: WireguardVariable.bind('value').as(val => (val ? 'network-vpn' : 'network-vpn-acquiring')),
    size: 16,
  })

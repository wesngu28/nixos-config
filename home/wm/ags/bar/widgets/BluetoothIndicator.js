const bluetooth = await Service.import('bluetooth')

export const BlueToothIndicator = () =>
  Widget.Icon({
    size: 16,
    icon: bluetooth.bind('enabled').as(on => `bluetooth-${on ? 'active' : 'disabled'}-symbolic`),
  })

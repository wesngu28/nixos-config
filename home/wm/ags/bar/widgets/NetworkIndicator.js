const network = await Service.import('network')

export const NetworkIndicator = () =>
  Widget.Icon().hook(network, self => {
    const icon = network[network.primary || 'wifi']?.icon_name
    self.icon = icon || ''
    self.visible = !!icon
    self.size = 16
  })

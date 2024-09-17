const mpris = await Service.import('mpris')

export const activePlayer = Variable(mpris.players[0])
mpris.connect('player-added', (_, bus) => {
  mpris.getPlayer(bus)?.connect('changed', player => {
    if (player.metadata['xesam:url'] && player.metadata['xesam:url'].includes('navidrome')) {
      return
    }
    if (activePlayer.value && activePlayer.value['play-back-status'] === 'Playing') {
      return
    }
    if (player['play-back-status'] !== 'Stopped') {
      activePlayer.value = player || mpris.players[0]
    } else {
      activePlayer.value = mpris.players[0]
    }
  })
})
mpris.connect('player-closed', (_, bus) => {
  const filteredPlayers = mpris.players.filter(player => {
    if (player.name === 'mpv' && player.metadata['xesam:url']?.includes('navidrome')) {
      return false
    }
    return true
  })
  if (activePlayer.value.bus_name === bus) activePlayer.value = filteredPlayers[0]
})
mpris.connect('player-changed', (_, bus) => {
  const filteredPlayers = mpris.players.filter(player => {
    if (player.name === 'mpv' && player.metadata['xesam:url']?.includes('navidrome')) {
      return false
    }
    return true
  })
  const changedPlayer = mpris.getPlayer(bus)
  if (
    changedPlayer.metadata['xesam:url'] &&
    !changedPlayer.metadata['xesam:url'].includes('navidrome') &&
    changedPlayer['play-back-status'] === 'Playing'
  ) {
    activePlayer.value = changedPlayer
    return
  }
  filteredPlayers.forEach(player => {
    if (player['play-back-status'] === 'Playing') activePlayer.value = player
  })
})

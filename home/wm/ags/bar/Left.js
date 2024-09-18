import { activePlayer } from '../components/ActivePlayer.js'
import { Player } from './widgets/Media.js'

const Media = () =>
  Widget.Box({
    visible: activePlayer.bind().as(p => p),
    child: activePlayer.bind().as(p => Player(p)),
  })

export const Left = () => {
  return Widget.Box({
    visible: activePlayer.bind().as(p => p),
    class_name: 'section',
    hpack: 'start',
    children: [Media()],
  })
}

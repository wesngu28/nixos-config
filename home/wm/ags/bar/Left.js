import { activePlayer } from '../components/ActivePlayer.js'
import { Player } from './widgets/Media.js'

const Media = () =>
  Widget.Box({
    child: activePlayer.bind().as(p => Player(p)),
  })

export const Left = () => {
  return Widget.Box({
    class_name: 'section',
    hpack: 'start',
    children: [Media()],
  })
}

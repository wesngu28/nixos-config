import { NotificationIndicator } from './widgets/Notificationindicator.js'
import { WallpaperButton } from './widgets/WallpaperButton.js'
import { Workspaces } from './widgets/Workspaces.js'

export const Center = monitor =>
  Widget.Box({
    children: [NotificationIndicator(monitor), Workspaces(), WallpaperButton(monitor)],
  })

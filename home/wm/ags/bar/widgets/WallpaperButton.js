import { fetchWallpapers } from '../../menus/Wallpapers.js'

export const WallpaperButton = monitor =>
  Widget.Box({
    class_name: 'section',
    css: 'margin-left: 4px',
    children: [
      Widget.Button({
        on_clicked: () => {
          fetchWallpapers()
          App.toggleWindow(`wallpaper-${monitor}`)
        },
        child: Widget.Icon('color-select-symbolic'),
      }),
      Widget.Button({
        on_clicked: () => {
          Utils.exec('wallpaper')
        },
        child: Widget.Icon('view-refresh'),
        tooltip_text: 'Random wallpaper',
      }),
    ],
  })

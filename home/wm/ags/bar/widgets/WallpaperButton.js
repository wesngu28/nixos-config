import { fetchWallpapers } from '../../menus/Wallpapers.js'

export const WallpaperButton = () =>
  Widget.Button({
    class_name: 'section',
    css: 'margin-left: 4px',
    on_clicked: () => {
      fetchWallpapers()
      App.toggleWindow('wallpaper')
    },
    child: Widget.Icon('color-select-symbolic'),
  })

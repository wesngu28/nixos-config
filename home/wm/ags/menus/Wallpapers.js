import PopupWindow from '../components/PopupWindow.js'

const WallpaperVariable = Variable([])
const CurrentPage = Variable(0)
const CurrentWallpaper = Variable('')

const loadThumbnail = async path => {
  const thumbnailPath = path.replace(/\/Wallpapers\//, '/Thumbnails/').replace(/\.(jpg|png)$/, '_thumb.$1')
  try {
    const thumbnailDir = thumbnailPath.split('/').slice(0, -1).join('/')
    await Utils.execAsync(`mkdir -p "${thumbnailDir}"`)

    const thumbnailExists = await Utils.execAsync(
      `sh -c 'ls "${thumbnailPath}" 1> /dev/null 2>&1 && echo exists || echo not'`
    )
    if (thumbnailExists.trim() === 'not') {
      await Utils.execAsync(`sh -c 'convert "${path}" -resize 100x100 "${thumbnailPath}"'`)
    }
    return thumbnailPath
  } catch (err) {
    console.log(err)
    return path
  }
}

export const fetchWallpapers = async () => {
  try {
    const output = await Utils.execAsync(
      `sh -c "find ~/Wallpapers -type f \\( -iname '*.jpg' -o -iname '*.png' \\) -not -name '*_thumb.jpg' -not -name '*_thumb.png'"`
    )
    const files = output.trim().split('\n')
    const thumbnails = await Promise.all(files.map(file => loadThumbnail(file)))
    WallpaperVariable.value = files.map((file, index) => ({
      original: file,
      thumbnail: thumbnails[index],
    }))
  } catch (err) {
    console.log(err.message)
  }
}

const createRow = wallpapers => {
  return Widget.Box({
    hexpand: true,
    children: wallpapers.map(({ thumbnail, original }) => {
      return Widget.Button({
        on_clicked: () => {
          Utils.execAsync(`sh -c 'set-as-wallpaper ${original} '`)
          CurrentWallpaper.value = original
        },
        child: Widget.Icon({
          icon: thumbnail,
          size: 100,
        }),
      })
    }),
  })
}

const WallpaperWidget = () => {
  return Widget.Box({
    class_name: 'wallpapers',
    vertical: true,
    children: [
      Widget.Box({
        class_name: 'wallpapers',
        vertical: true,
        children: Utils.merge([WallpaperVariable.bind(), CurrentPage.bind()], (wallpapers, currentPage) => {
          const startIndex = currentPage * 15
          const endIndex = Math.min(startIndex + 15, wallpapers.length)
          const currentPageWalls = wallpapers.slice(startIndex, endIndex)
          const rows = []
          for (let i = 0; i < currentPageWalls.length; i += 5) {
            rows.push(createRow(currentPageWalls.slice(i, i + 5)))
          }
          return rows
        }),
      }),
      Widget.Box({
        class_name: 'pagination-controls',
        vpack: 'end',
        children: [
          Widget.Button({
            hpack: 'start',
            child: Widget.Icon('media-skip-backward-symbolic'),
            on_clicked: () => {
              if (CurrentPage.value > 0) {
                CurrentPage.value -= 1
              }
            },
          }),
          Widget.Box({
            hexpand: true,
            hpack: 'center',
            children: [
              Widget.Button({
                child: Widget.Icon('view-refresh-symbolic'),
                on_clicked: async () => {
                  await fetchWallpapers()
                },
              }),
              Widget.Label({
                class_name: 'wallpaper-page',
                label: CurrentPage.bind('value').as(page => `Page ${page + 1}`),
              }),
              Widget.Button({
                child: Widget.Icon('user-trash-full-symbolic'),
                on_clicked: async () => {
                  const currentFile = WallpaperVariable.value.find(file =>
                    file.original.endsWith(CurrentWallpaper.value)
                  )
                  if (currentFile) {
                    await Utils.execAsync(`sh -c 'gio trash "${currentFile.original}"'`)
                    await Utils.execAsync(`sh -c 'gio trash "${currentFile.thumbnail}"'`)
                    await fetchWallpapers()
                  }
                },
              }),
            ],
          }),
          Widget.Button({
            child: Widget.Icon('media-skip-forward-symbolic'),
            on_clicked: () => {
              if ((CurrentPage.value + 1) * 15 < WallpaperVariable.value.length) {
                CurrentPage.value += 1
              }
            },
          }),
        ],
      }),
    ],
  })
}

export const Wallpapers = (monitor, gdkmonitor) =>
  PopupWindow({
    name: `wallpaper-${monitor}`,
    layout: 'top-center',
    gdkmonitor,
    exclusivity: 'exclusive',
    child: WallpaperWidget(),
  })

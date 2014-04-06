# Classification sticker in to 3 folder
# Use for prepare image to batch resize
#
# 1.stickers-tab
# 2.stickers-img
# 3.stickers-key

STICKERS_DIR = 'C:/Users/Chokchai/Desktop/stickers/'

TAB_DIR = STICKERS_DIR + 'stickers-tab/'
IMG_DIR = STICKERS_DIR + 'stickers-img/'
KEY_DIR = STICKERS_DIR + 'stickers-key/'

fs = require 'fs'

filterTab = (filename)->
  filename.indexOf('tab_on') > -1

filterKey = (filename)->
  filename.indexOf('key') > -1

filterImg = (filename)->
  # .png, not key and not tabs
  filename.indexOf('.png') > -1 and ! filterKey(filename) and filename.indexOf('tab') is -1

rmrfSync = (path)->
  files = [];
  if fs.existsSync path
    files = fs.readdirSync(path)
    files.forEach (file)->
      curPath = path + "/" + file
      if fs.statSync(curPath).isDirectory()
        rmrfSync curPath
      else
        fs.unlinkSync curPath
    fs.rmdirSync path + "/"

# init dir
console.log 'INIT_DIR'

rmrfSync TAB_DIR
rmrfSync IMG_DIR
rmrfSync KEY_DIR

fs.mkdirSync TAB_DIR
fs.mkdirSync IMG_DIR
fs.mkdirSync KEY_DIR

# each sticker folder to get list of image
stickersDir = fs.readdirSync STICKERS_DIR
for sdir, i in stickersDir

  # create dir
  fs.mkdirSync TAB_DIR + sdir
  fs.mkdirSync IMG_DIR + sdir
  fs.mkdirSync KEY_DIR + sdir

  for fn in fs.readdirSync STICKERS_DIR + sdir
    # read image file
    file = fs.readFileSync STICKERS_DIR + sdir + '/' + fn
    # classify to save by filter
    fs.writeFileSync TAB_DIR + sdir + '/' + fn, file if filterTab(fn)
    fs.writeFileSync KEY_DIR + sdir + '/' + fn, file if filterKey(fn)
    fs.writeFileSync IMG_DIR + sdir + '/' + fn, file if filterImg(fn)

    console.log 'SAVED ['+(i+1)+'/'+(stickersDir.length)+']' + STICKERS_DIR + sdir + '/' + fn

console.log 'DONE!'
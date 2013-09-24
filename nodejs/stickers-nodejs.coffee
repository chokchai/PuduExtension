# !!! This file used for generate sticker.json from stickers director.
#     You can get line sticker folder from http://line.polppolservice.com/getpng/request_sticker_all.php
#     REMOVE sticker5 cause it dont have button

STICKER_DIR = 'C:/Users/Chokchai/Desktop/stickers/stickers/'

fs = require 'fs'

# get all sticker folder
dir = fs.readdirSync STICKER_DIR
stickers = {};

# each sticker folder to get list of image
for stickerDir in dir
  # sticker folder as index (id), array of sticker list as value (filter tab image)
  stickers[stickerDir] = (parseInt(img.split('.').shift()) for img in fs.readdirSync STICKER_DIR + stickerDir + '/' when img.indexOf('tab_') == -1 and img.indexOf('_key') == -1 and img.indexOf('.png') != -1)

# write result to stickers.json
fs.writeFileSync 'pudu.stickers.js', 'window.pudu.stickers = ' + JSON.stringify(stickers) + ';'

console.log 'pudu.stickers.json is saved!'
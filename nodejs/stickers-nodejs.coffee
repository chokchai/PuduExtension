# !!! This file used for generate sticker.json from stickers director.
#     You can get line sticker folder from http://line.polppolservice.com/getpng/request_sticker_all.php
#     REMOVE sticker5 cause it dont have button

STICKER_DIR = 'C:/Users/Chokchai/Desktop/stickers2/'

fs = require 'fs'

# get all sticker folder
dir = fs.readdirSync STICKER_DIR
stickers = {};
stickersName = {};
nameIndex = [];

# each sticker folder to get list of image
for stickerDir in dir

  # get stickername
  sName = JSON.parse(fs.readFileSync(STICKER_DIR + stickerDir + '/productInfo.meta')).title.en

  # remove duplicate
  if nameIndex.indexOf(sName) == -1
    nameIndex.push sName

    # sticker folder as index (id), array of sticker list as value (filter tab image)
    stickers[stickerDir] = (parseInt(img.split('.').shift()) for img in fs.readdirSync STICKER_DIR + stickerDir + '/' when img.indexOf('tab_') == -1 and img.indexOf('_key') == -1 and img.indexOf('.png') != -1)
    # map sticker dirname to sticker name
    stickersName[stickerDir] = sName

# write result to stickers.json
fs.writeFileSync STICKER_DIR+'pudu.stickers.js', 'window.pudu.stickers = ' + JSON.stringify(stickers) + '; \n window.pudu.stickersName = ' + JSON.stringify(stickersName)

console.log 'pudu.stickers.js is saved!'
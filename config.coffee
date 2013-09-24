pudu = {}

pudu.stickerKeyHost = 'http://pudux.googlecode.com/git/k/'
pudu.stickerImgHost = 'http://pudux.googlecode.com/git/i/'
pudu.defaultSetting =
  version : '1.1.0'
  selectedStickers : [
    'sticker1', 'sticker1001', 'sticker1002',
    'sticker1003', 'sticker1004', 'sticker1038'
  ]
  lastUsedEmoSet : '#pudu-emo-smiley'

# dependency library wrapers
pudu.setLocalStorage = (data, func = ->)->
  chrome.storage.local.set data, func

pudu.getLocalStorage = (func)->
  chrome.storage.local.get func

pudu.clearLocalStorage = (func = ->)->
  chrome.storage.local.clear(func)

pudu.removeLocalStorage = (key, func = ->)->
  chrome.storage.local.remove(key, func)

pudu.getExtensionUrl = (uri)->
  chrome.extension.getURL uri

# init default setting if is first time, then refresh
pudu.getLocalStorage (items)->
  # if not have setting data yet, just added default
  if items.version is undefined
    pudu.setLocalStorage pudu.defaultSetting, -> window.location.href = window.location.href
    # if current version is newer, just added only new default setting
  else if pudu.versionCompare(items.version, pudu.defaultSetting.version) == -1
    # assign new version
    items.version = pudu.defaultSetting.version
    # add only not exist
    pudu.setLocalStorage $.extend(pudu.defaultSetting, items), -> window.location.href = window.location.href

window.pudu = pudu
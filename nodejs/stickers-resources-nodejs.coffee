# generate json for use in manifest file -
# section web_accessible_resources

PREFIX = '/imgs/stickers'
RESOURCE_DIR = "C:/Users/Chokchai/Desktop/stickers/stickers-tab/"

fs = require 'fs'

resources = []

resourceToJson = (path)->
  files = [];
  if fs.existsSync path
    files = fs.readdirSync(path)
    files.forEach (file)->
      curPath = path + '/' + file
      if fs.statSync(curPath).isDirectory()
        for f in fs.readdirSync curPath
          resources.push PREFIX + curPath.replace(RESOURCE_DIR, '') + '/' + f
      else
        fs.unlinkSync curPath
  else
    console.log RESOURCE_DIR + ' not found!'


resourceToJson(RESOURCE_DIR)

fs.writeFileSync './resource.json', JSON.stringify(resources)

console.log 'DONE!'
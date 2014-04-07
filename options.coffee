pudu = window.pudu
stickers = pudu.stickers

$stickers = $ '#pudu-stickers'
$stickerModal = $ '#pudu-sticker-modal'
$resetButton = $ '#pudu-options-reset'
$version = $ '#pudu-version'

# display version
$version.text 'v'+chrome.app.getDetails().version

# click reset btn
$resetButton.on 'click', ->
  # clear all then set default
  pudu.clearLocalStorage ->
    pudu.setLocalStorage pudu.defaultSetting, ->
      # refresh
      window.location.href = window.location.href

####################
# Options
####################

checkboxOptions = (optionSelector, optionName)->

  # setup option
  pudu.getLocalStorage (items)->
    # set default to hide
    if items[optionName] == undefined
      opts = {}
      opts[optionName] = true
      pudu.setLocalStorage opts

    if items[optionName] == undefined or items[optionName] == true
      $(optionSelector).attr 'checked', 'checked'

  # bind when change options
  $(optionSelector).on 'change', ->

    checked = $(@).is(':checked')
    opts = {}
    if checked
      opts[optionName] = true
    else
      opts[optionName] = false

    pudu.setLocalStorage opts

# options list

checkboxOptions('#pudu-options-signature', 'hideSignature')
checkboxOptions('#pudu-options-comment-number', 'hideCommentNumber')

####################
# Sticker
####################

setSelectedStickerEffect = ()->
  $('.sticker-box').removeClass('checked')
  $checked = $ '.sticker-checkbox:checked'
  $checked.parents('.sticker-box').addClass('checked')
  # add selected to front
  pudu.getLocalStorage (items)->
    for i in [items.selectedStickers.length..0]
      id = items.selectedStickers[i]
      $stickers.prepend $("##{id}").parent()

saveSelectedStickers = ()->
  selectedStickers = ($(c).data('id') for c in $('.sticker-checkbox:checked'))
  pudu.setLocalStorage {selectedStickers: selectedStickers}
  setSelectedStickerEffect()

# add stickers
i = 1
for id, imgs of stickers

  # skip sticker5 cause not have an preview
  if id != 'sticker5'
    $stickers.append \
      "<li>
        <div id='#{id}' data-name='#{pudu.stickersName[id]}' class='thumbnail sticker-box'>
          <img class='sticker-image' data-id='#{id}' src='#{pudu.stickerButton(id)}' title='Click to preview' />
          <center><small>#{pudu.stickersName[id]}</small></center>
          <div class='sticker-checkbox-wrap'>
            <input class='sticker-checkbox' type='checkbox' data-id='#{id}' name='select' />
          </div>
        </div>
      </li>"

# add current selected
pudu.getLocalStorage (items)->
  for id in items.selectedStickers
    $("##{id} .sticker-checkbox").attr 'checked', true
  # added effect
  setSelectedStickerEffect()

# filter
$('#pudu-stickers-filter').on 'keyup', ()->
  q = $(@).val().trim().toLowerCase()
  $('.sticker-box:not(.checked)').each ->
    if $(@).data('name').toLowerCase().indexOf(q) == -1
      $(@).parent().hide()
    else
      $(@).parent().show()

# event to select
$('body').on 'click', '.sticker-checkbox', ()->
  # save to localstorage
  saveSelectedStickers()

# on click sticker, preview
$('body').on 'click', '.sticker-image', ()->
  id = $(@).data 'id'
  imgs = stickers[id]
  # setup modal
  $stickerModal.find('.btn-success').data 'id', id
  $stickerModal.find('h3').html "<img src='#{pudu.stickerButton(id)}' /> #{pudu.stickersName[id]}"
  $stickerModal.find('.thumbnails').empty().html \
    ("<li><img class='thumbnail' src='#{pudu.stickerKey(id, img)}' width='75' /></li>" for img in imgs).join('')
  # show modal
  $stickerModal.modal 'show'

# reset scroll on hide
$stickerModal.on 'shown', -> $('.modal-body', @).scrollTop(0)

# when click select btn in modal
$stickerModal.find('.btn-success').on 'click', ()->
  # checked the selecte once
  id = $(@).data 'id'
  $("##{id} .sticker-checkbox").attr 'checked', true
  # save
  saveSelectedStickers()
  # hide modal
  $stickerModal.modal 'hide'
# tempic

url = ''+window.location.href;

site =
  tempic: url.indexOf('temppic.com/img.php') isnt -1
  ohozaa: url.indexOf('image.ohozaa.com/view') isnt -1
  iwoow: url.indexOf('iwoow.in/i-i/') isnt -1
  imgchili: url.indexOf('imgchili.net/show/') isnt -1
  wezatv: url.indexOf('wezatv.com/pic/') isnt -1

# auto hide body
$body = $ 'body'
$body.hide()

###############
# Function
###############
showOriginal = ()->
  $('#pudu-menubar, #pudu-ss-image').hide()
  $body.show()

puduHtml = ()->
  '<div id="pudu-menubar" style="padding: 5px; font-size: 12px; font-family: \'Segoe UI\', Tahoma, sans-serif;">
    Clean by Pudu Extension (
    <a style="color:blue;" href="javascript:void(0)" id="pudu-view-original" >view original</a> :
    <a style="color:blue;" href="http://lolthai.com/forums.php?action=viewtopic&topicid=116432">report bug</a>
    )
  </div>'

hideOriginal = ($img)->

  # if image is exist
  if $img.size() > 0

    $body.hide()
    $body.after $('<img />').attr('src', $img.attr('src')).attr('id', 'pudu-ss-image')
    $body.after puduHtml()

    # bind event to show original link
    $('#pudu-view-original').on 'click', ()-> showOriginal()

###############
# Tempic
###############
if site.tempic
  hideOriginal $ 'img[src*="temppic.com/upload"]'

if site.ohozaa
  hideOriginal $ 'a[title="Full Image"] > img'

if site.iwoow
  hideOriginal $ 'a[href="#"] > img'

if site.imgchili
  hideOriginal $ 'img#show_image'

if site.wezatv
  hideOriginal $ 'img[src*="wezatv.com/pic/images/"]'
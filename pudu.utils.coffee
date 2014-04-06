###################################
# Pudu Utility
###################################

pudu.random = (prefix)->
  rand = parseInt(Math.random()*100000000)
  if prefix then "#{prefix}-#{rand}" else rand

pudu.parseUrlQuery = (uri = window.location.href) ->
  queryAsAssoc = []
  queryString = uri.substring(uri.indexOf('?')+1)
  keyValues = queryString.split '&'

  for key in keyValues
    k = key.split '='
    queryAsAssoc[k[0]] = k[1]

  return queryAsAssoc

pudu.updateUrlQuery = (uri, key, value)->
  re = new RegExp("([?|&])" + key + "=.*?(&|$)", "i")
  separator = if uri.indexOf('?') != -1 then "&" else "?"
  if uri.match re
    uri.replace(re, '$1' + key + "=" + value + '$2')
  else
    uri + separator + key + "=" + value

pudu.insertAtCaret = (areaId, text)->
  txtarea = document.getElementById(areaId);
  scrollPos = txtarea.scrollTop;
  strPos = 0;

  strPos = txtarea.selectionStart;

  front = (txtarea.value).substring(0, strPos);
  back = (txtarea.value).substring(strPos, txtarea.value.length);
  txtarea.value = front + text + back;
  strPos = strPos + text.length;

  txtarea.selectionStart = strPos;
  txtarea.selectionEnd = strPos;
  txtarea.focus();
  txtarea.scrollTop = scrollPos;

pudu.insertWrapCaret = (areaId, prefix, suffix)->
  txtarea = document.getElementById(areaId);
  scrollPos = txtarea.scrollTop;
  strPosStart = 0;

  strPosStart = txtarea.selectionStart;
  strPosEnd = txtarea.selectionEnd;

  front = (txtarea.value).substring(0, strPosStart);
  back = (txtarea.value).substring(strPosEnd);
  text = (txtarea.value).substring(strPosStart, strPosEnd)
  txtarea.value = front + prefix + text + suffix + back;

  txtarea.selectionStart = strPosStart + prefix.length + suffix.length + text.length;
  txtarea.selectionEnd = txtarea.selectionStart;
  txtarea.focus();
  txtarea.scrollTop = scrollPos;

pudu.stickerKey = (id, name)->
  "#{pudu.stickerKeyHost}#{id}/#{name}_key.jpg"

pudu.stickerImg = (id, name)->
  "#{pudu.stickerImgHost}#{id}/#{name}.png"

pudu.stickerButton = (id)->
  pudu.getExtensionUrl "imgs/stickers/#{id}/tab_on.png"

pudu.addSticker = (emoId)->

  # loop until found id
  l = (emoId)->

    if $("##{emoId}-emo-tabs").size() > 0

      pudu.getLocalStorage (items)->
        selectedStickers = items.selectedStickers

        # line sticker html
        stickerTabsHtml = ("<li><a href='##{emoId}-#{id}'><img src='#{pudu.stickerButton(id)}' width='48' height='40' /></a></li>" for id in selectedStickers).join('')
        stickerContentHtml = (()->
          html = []
          for id in selectedStickers
            html.push "<div id='#{emoId}-#{id}' class='tab-pane'><ul class='emo sticker thumbnails'>"
            for img in pudu.stickers[id]
              keyImg = pudu.stickerKey id, img
              html.push "<li class='thumbnail' data-text='[img]#{pudu.stickerImg(id, img)}[/img]' style='background-image: url(#{keyImg})' width='62' height='57'/></li>"
            html.push "</ul></div>"
          html.join ""
        )()

        # add html, bind tabs
        $("##{emoId}-emo-tabs").find('.nav-tabs').append stickerTabsHtml
        $("##{emoId}-emo-tabs").find('.tab-content').append stickerContentHtml
        $("##{emoId}-emo-tabs").find('.nav-tabs a').on 'click', (e)->
          e.preventDefault()
          $(@).tab 'show'
          # save last used
          pudu.setLocalStorage lastUsedEmoSet: $(@).attr('href').replace("##{emoId}-", '')

        # selected last used emo set
        $("##{emoId}-emo-tabs a[href='##{emoId}-#{items.lastUsedEmoSet}']").tab 'show'

    else
      setTimeout (->l(emoId)), 99

  # start loop
  l(emoId)

pudu.emoHtml = (id) ->

  # default emotion
  emoList = [{"text":":-)","img":"default/smile1.jpg"},{"text":":smile:","img":"default/smile2.jpg"},{"text":":-D","img":"default/grin.jpg"},{"text":":lol:","img":"default/laugh.jpg"},{"text":":lol2:","img":"default/yoyo_77.jpg"},{"text":":w00t:","img":"default/w00t.jpg"},{"text":":-P","img":"default/tongue.jpg"},{"text":";-)","img":"default/wink.jpg"},{"text":":-|","img":"default/noexpression.jpg"},{"text":":-/","img":"default/confused.jpg"},{"text":":-(","img":"default/sad.jpg"},{"text":":'-(","img":"default/cry.jpg"},{"text":":weep:","img":"default/weep.jpg"},{"text":":-O","img":"default/yoyo_65.jpg"},{"text":":o)","img":"default/clown.jpg"},{"text":"8-)","img":"default/yoyo_01.jpg"},{"text":"|-)","img":"default/sleeping.jpg"},{"text":":uu:","img":"default/yoyo_00.jpg"},{"text":":au:","img":"default/yociexp26.jpg"},{"text":":a1:","img":"default/yoyo17.jpg"},{"text":":a2:","img":"default/yoyo72.jpg"},{"text":":a3:","img":"default/yoyo75.jpg"},{"text":":a4:","img":"default/yoyox32.jpg"},{"text":":a5:","img":"default/yoyox48.jpg"},{"text":":a6:","img":"default/yoyo55.jpg"},{"text":":a7:","img":"default/yoyo66.jpg"},{"text":":a8:","img":"default/yoyo126.jpg"},{"text":":a9:","img":"default/yoyo122.jpg"},{"text":":a0:","img":"default/yoyo04.jpg"},{"text":":b1:","img":"default/yoyox06.jpg"},{"text":":b2:","img":"default/1.jpg"},{"text":":b3:","img":"default/7.jpg"},{"text":":b4:","img":"default/9.jpg"},{"text":":b5:","img":"default/11.jpg"},{"text":":b6:","img":"default/15.jpg"},{"text":":b7:","img":"default/18.jpg"},{"text":":b8:","img":"default/19.jpg"},{"text":":b9:","img":"default/21.jpg"},{"text":":c1:","img":"default/23.jpg"},{"text":":c2:","img":"default/24.jpg"},{"text":":c3:","img":"default/29.jpg"},{"text":":c4:","img":"default/36.jpg"},{"text":":c5:","img":"default/40.jpg"},{"text":":c6:","img":"default/44.jpg"},{"text":":c7:","img":"default/46.jpg"},{"text":":c8:","img":"default/52.jpg"},{"text":":c9:","img":"default/63.jpg"},{"text":":d1:","img":"default/66.jpg"},{"text":":d2:","img":"default/82.jpg"},{"text":":d3:","img":"default/85.jpg"},{"text":":d4:","img":"default/117.jpg"},{"text":":d5:","img":"default/124.jpg"},{"text":":d6:","img":"default/132.jpg"},{"text":":d7:","img":"default/162.jpg"},{"text":":d8:","img":"default/192.jpg"},{"text":":d9:","img":"default/yoyo_51.jpg"},{"text":":e1:","img":"default/yoyo_33.jpg"},{"text":":e2:","img":"default/yoyo_83.jpg"},{"text":":e3:","img":"default/yoyo_89.jpg"},{"text":":e4:","img":"default/yoyo_30.jpg"},{"text":":e5:","img":"default/yoyo_64.jpg"},{"text":":e6:","img":"default/yoyo_52.jpg"},{"text":":e7:","img":"default/87.jpg"},{"text":":e8:","img":"default/103.jpg"},{"text":":e9:","img":"default/114.jpg"},{"text":":f1:","img":"default/yoyo_67.jpg"},{"text":":f2:","img":"default/yoyo_71.jpg"},{"text":":f3:","img":"default/yoyo_72.jpg"},{"text":":f4:","img":"default/92.jpg"},{"text":":f5:","img":"default/101.jpg"},{"text":":f6:","img":"default/102.jpg"},{"text":":f7:","img":"default/1033.jpg"},{"text":":f8:","img":"default/104.jpg"},{"text":":f9:","img":"default/105.jpg"},{"text":":G1:","img":"default/106.jpg"},{"text":":G2:","img":"default/1077.jpg"},{"text":":G3:","img":"default/108.jpg"},{"text":":G4:","img":"default/109.jpg"},{"text":":G5:","img":"default/110.jpg"},{"text":":G6:","img":"default/111.jpg"},{"text":":innocent:","img":"default/innocent.jpg"},{"text":":whistle:","img":"default/whistle.jpg"},{"text":":unsure:","img":"default/unsure.jpg"},{"text":":closedeyes:","img":"default/closedeyes.jpg"},{"text":":cool:","img":"default/cool2.jpg"},{"text":":fun:","img":"default/fun.jpg"},{"text":":thumbsup:","img":"default/thumbsup.jpg"},{"text":":thumbsdown:","img":"default/thumbsdown.jpg"},{"text":":blush:","img":"default/blush.jpg"},{"text":":yes:","img":"default/yes.jpg"},{"text":":no:","img":"default/yoyo_47.jpg"},{"text":":love:","img":"default/yoyo_24.jpg"},{"text":":?:","img":"default/question.jpg"},{"text":":!:","img":"default/excl.jpg"},{"text":":idea:","img":"default/idea.jpg"},{"text":":arrow:","img":"default/arrow.jpg"},{"text":":arrow2:","img":"default/arrow2.jpg"},{"text":":hmm:","img":"default/hmm.jpg"},{"text":":hmmm:","img":"default/hmmm.jpg"},{"text":":huh:","img":"default/huh.jpg"},{"text":":geek:","img":"default/geek.jpg"},{"text":":look:","img":"default/look.jpg"},{"text":":rolleyes:","img":"default/rolleyes.jpg"},{"text":":kiss:","img":"default/yoyo_53.jpg"},{"text":":shifty:","img":"default/shifty.jpg"},{"text":":blink:","img":"default/blink.jpg"},{"text":":smartass:","img":"default/smartass.jpg"},{"text":":sick:","img":"default/sick.jpg"},{"text":":crazy:","img":"default/yoyo_92.jpg"},{"text":":wacko:","img":"default/wacko.jpg"},{"text":":alien:","img":"default/alien.jpg"},{"text":":wizard:","img":"default/wizard.jpg"},{"text":":wave:","img":"default/wave.jpg"},{"text":":wavecry:","img":"default/wavecry.jpg"},{"text":":baby:","img":"default/baby.jpg"},{"text":":angry:","img":"default/angry.jpg"},{"text":":ras:","img":"default/ras.jpg"},{"text":":sly:","img":"default/sly.jpg"},{"text":":devil:","img":"default/devil.jpg"},{"text":":evil:","img":"default/evil.jpg"},{"text":":evilmad:","img":"default/evilmad.jpg"},{"text":":sneaky:","img":"default/sneaky.jpg"},{"text":":axe:","img":"default/axe.jpg"},{"text":":slap:","img":"default/slap.jpg"},{"text":":wall:","img":"default/wall.jpg"},{"text":":rant:","img":"default/rant.jpg"},{"text":":jump:","img":"default/jump.jpg"},{"text":":yucky:","img":"default/yucky.jpg"},{"text":":nugget:","img":"default/nugget.jpg"},{"text":":smart:","img":"default/smart.jpg"},{"text":":shutup:","img":"default/shutup.jpg"},{"text":":shutup2:","img":"default/shutup2.jpg"},{"text":":crockett:","img":"default/crockett.jpg"},{"text":":zorro:","img":"default/zorro.jpg"},{"text":":snap:","img":"default/snap.jpg"},{"text":":beer:","img":"default/beer.jpg"},{"text":":beer2:","img":"default/beer2.jpg"},{"text":":drunk:","img":"default/drunk.jpg"},{"text":":strongbench:","img":"default/strongbench.jpg"},{"text":":weakbench:","img":"default/weakbench.jpg"},{"text":":dumbells:","img":"default/dumbells.jpg"},{"text":":music:","img":"default/music.jpg"},{"text":":stupid:","img":"default/stupid.jpg"},{"text":":dots:","img":"default/dots.jpg"},{"text":":offtopic:","img":"default/offtopic.jpg"},{"text":":spam:","img":"default/spam.jpg"},{"text":":oops:","img":"default/oops.jpg"},{"text":":lttd:","img":"default/lttd.jpg"},{"text":":please:","img":"default/please.jpg"},{"text":":sorry:","img":"default/sorry.jpg"},{"text":":hi:","img":"default/hi.jpg"},{"text":":yay:","img":"default/yay.jpg"},{"text":":cake:","img":"default/cake.jpg"},{"text":":hbd:","img":"default/hbd.jpg"},{"text":":band:","img":"default/band.jpg"},{"text":":punk:","img":"default/punk.jpg"},{"text":":rofl:","img":"default/rofl.jpg"},{"text":":bounce:","img":"default/bounce.jpg"},{"text":":mbounce:","img":"default/mbounce.jpg"},{"text":":thankyou:","img":"default/thankyou.jpg"},{"text":":gathering:","img":"default/gathering.jpg"},{"text":":hang:","img":"default/hang.jpg"},{"text":":chop:","img":"default/chop.jpg"},{"text":":rip:","img":"default/rip.jpg"},{"text":":whip:","img":"default/whip.jpg"},{"text":":judge:","img":"default/judge.jpg"},{"text":":chair:","img":"default/chair.jpg"},{"text":":tease:","img":"default/tease.jpg"},{"text":":box:","img":"default/box.jpg"},{"text":":boxing:","img":"default/boxing.jpg"},{"text":":guns:","img":"default/guns.jpg"},{"text":":shoot:","img":"default/shoot.jpg"},{"text":":shoot2:","img":"default/shoot2.jpg"},{"text":":flowers:","img":"default/flowers.jpg"},{"text":":wub:","img":"default/wub.jpg"},{"text":":lovers:","img":"default/lovers.jpg"},{"text":":kissing:","img":"default/kissing.jpg"},{"text":":kissing2:","img":"default/kissing2.jpg"},{"text":":console:","img":"default/console.jpg"},{"text":":group:","img":"default/group.jpg"},{"text":":hump:","img":"default/hump.jpg"},{"text":":hooray:","img":"default/hooray.jpg"},{"text":":happy2:","img":"default/happy2.jpg"},{"text":":clap:","img":"default/clap.jpg"},{"text":":clap2:","img":"default/clap2.jpg"},{"text":":weirdo:","img":"default/weirdo.jpg"},{"text":":yawn:","img":"default/yawn.jpg"},{"text":":bow:","img":"default/bow.jpg"},{"text":":dawgie:","img":"default/dawgie.jpg"},{"text":":cylon:","img":"default/cylon.jpg"},{"text":":book:","img":"default/book.jpg"},{"text":":fish:","img":"default/fish.jpg"},{"text":":mama:","img":"default/mama.jpg"},{"text":":pepsi:","img":"default/pepsi.jpg"},{"text":":medieval:","img":"default/medieval.jpg"},{"text":":rambo:","img":"default/rambo.jpg"},{"text":":ninja:","img":"default/ninja.jpg"},{"text":":hannibal:","img":"default/hannibal.jpg"},{"text":":party:","img":"default/party.jpg"},{"text":":snorkle:","img":"default/snorkle.jpg"},{"text":":evo:","img":"default/evo.jpg"},{"text":":king:","img":"default/king.jpg"},{"text":":chef:","img":"default/chef.jpg"},{"text":":mario:","img":"default/mario.jpg"},{"text":":pope:","img":"default/pope.jpg"},{"text":":fez:","img":"default/fez.jpg"},{"text":":cap:","img":"default/cap.jpg"},{"text":":cowboy:","img":"default/cowboy.jpg"},{"text":":pirate:","img":"default/pirate.jpg"},{"text":":pirate2:","img":"default/pirate2.jpg"},{"text":":rock:","img":"default/rock.jpg"},{"text":":cigar:","img":"default/cigar.jpg"},{"text":":icecream:","img":"default/icecream.jpg"},{"text":":oldtimer:","img":"default/oldtimer.jpg"},{"text":":trampoline:","img":"default/trampoline.jpg"},{"text":":banana:","img":"default/bananadance.jpg"},{"text":":smurf:","img":"default/smurf.jpg"},{"text":":yikes:","img":"default/yikes.jpg"},{"text":":osama:","img":"default/osama.jpg"},{"text":":saddam:","img":"default/saddam.jpg"},{"text":":santa:","img":"default/santa.jpg"},{"text":":indian:","img":"default/indian.jpg"},{"text":":pimp:","img":"default/pimp.jpg"},{"text":":nuke:","img":"default/nuke.jpg"},{"text":":jacko:","img":"default/jacko.jpg"},{"text":":ike:","img":"default/ike.jpg"},{"text":":greedy:","img":"default/greedy.jpg"},{"text":":super:","img":"default/super.jpg"},{"text":":wolverine:","img":"default/wolverine.jpg"},{"text":":spidey:","img":"default/spidey.jpg"},{"text":":spider:","img":"default/spider.jpg"},{"text":":bandana:","img":"default/bandana.jpg"},{"text":":construction:","img":"default/construction.jpg"},{"text":":sheep:","img":"default/sheep.jpg"},{"text":":police:","img":"default/police.jpg"},{"text":":detective:","img":"default/detective.jpg"},{"text":":bike:","img":"default/bike.jpg"},{"text":":fishing:","img":"default/fishing.jpg"},{"text":":clover:","img":"default/clover.jpg"},{"text":":horse:","img":"default/horse.jpg"},{"text":":shit:","img":"default/shit.jpg"},{"text":":soldiers:","img":"default/soldiers.jpg"}]

  emoUse = [
    0,1,2,3,5,6,7,8,9,10,
    11,12,81,82,83,84,86,87,89,97,
    98,99,100,104,105,112,113,114,116,123,
    124,125,127,128,155,163,183,187,182,184
     4,13,15,18,19,20,21,22,23,24,
    25,26,27,28,29,30,31,32,33,34,
    35,36,37,38,39,40,41,42,43,44,
    45,46,47,48,49,50,51,52,53,54,
    55,56,57,58,59,60,61,62,63,64,
    65,66,67,68,90,91,103,108,215,17
  ]

  # emo use number: margin
  emoMarignTop = { 81:4, 86:6, 87:4, 112:3, 113:3, 124:3, 163:2, 187:3, 17:5 }

  emoUrl = pudu.getExtensionUrl '/imgs/emo/'
  emoHtml = ('<li class="thumbnail" data-text="'+emoList[i].text+'" >
                <div style="padding:'+(emoMarignTop[i] ? 0)+'px 0;">
                  <img src="'+emoUrl+emoList[i].img+'" />
                </div>
              </li>' for i in emoUse)

  # add line sticker
  pudu.addSticker(id);

  ['<div class="pudu pudu-emo" data-id="'+id+'">
    <div class="btn-toolbar emo" style="margin-bottom:5px; margin-top: 5px;">
      <div class="btn-group">
        <a class="btn" href="javascript:void(0)" data-prefix="[b]" data-suffix="[/b]"><i class="icon-bold"></i></a>
        <a class="btn" href="javascript:void(0)" data-prefix="[i]" data-suffix="[/i]"><i class="icon-italic"></i></a>
        <a class="btn" href="javascript:void(0)" data-prefix="[u]" data-suffix="[/u]"><i class="icon-underline"></i></a>
        <a class="btn" href="javascript:void(0)" data-prefix="[img]" data-suffix="[/img]"><i class="icon-picture"></i></a>
        <a class="btn" href="javascript:void(0)" data-prefix="[url]" data-suffix="[/url]"><i class="icon-link"></i></a>
        <a class="btn" href="javascript:void(0)" data-prefix="[spoiler]" data-suffix="[/spoiler]"><i class="icon-minus-sign-alt"></i></a>
        <a class="btn" href="javascript:void(0)" data-prefix="[quote]" data-suffix="[/quote]"><i class="icon-quote-left"></i></a>
        <a class="btn" href="javascript:void(0)" data-prefix="[youtube]" data-suffix="[/youtube]"><i class="icon-youtube-play"></i></a>
        <a class="btn" href="javascript:void(0)" data-prefix="[size=3]" data-suffix="[/size]"><i class="icon-font"></i><span style="font-size:14px; line-height:14px;">3</span></a>
        <a class="btn" href="javascript:void(0)" data-prefix="[size=4]" data-suffix="[/size]"><i class="icon-font"></i><span style="font-size:14px; line-height:14px;">4</span></a>
        <a class="btn" href="javascript:void(0)" data-prefix="[size=5]" data-suffix="[/size]"><i class="icon-font"></i><span style="font-size:14px; line-height:14px;">5</span></a>
        <a class="btn" href="javascript:void(0)" data-prefix="[size=6]" data-suffix="[/size]"><i class="icon-font"></i><span style="font-size:14px; line-height:14px;">6</span></a>
        <a class="btn" href="javascript:void(0)" data-prefix="[size=7]" data-suffix="[/size]"><i class="icon-font"></i><span style="font-size:14px; line-height:14px;">7</span></a>
        <a class="btn" href="javascript:void(0)" data-prefix="[color=red]" data-suffix="[/color]"><i class="icon-circle" style="color:red"></i></a>
        <a class="btn" href="javascript:void(0)" data-prefix="[color=orange]" data-suffix="[/color]"><i class="icon-circle" style="color:orange"></i></a>
        <a class="btn" href="javascript:void(0)" data-prefix="[color=yellow]" data-suffix="[/color]"><i class="icon-circle" style="color:yellow"></i></a>
        <a class="btn" href="javascript:void(0)" data-prefix="[color=green]" data-suffix="[/color]"><i class="icon-circle" style="color:green"></i></a>
        <a class="btn" href="javascript:void(0)" data-prefix="[color=blue]" data-suffix="[/color]"><i class="icon-circle" style="color:blue"></i></a>
        <a class="btn" href="javascript:void(0)" data-prefix="[color=magenta]" data-suffix="[/color]"><i class="icon-circle" style="color:magenta"></i></a>
        <a class="btn" href="javascript:void(0)" data-prefix="[color=grey]" data-suffix="[/color]"><i class="icon-circle" style="color:grey"></i></a>
      </div>
    </div>
  </div>',
  '<div class="pudu pudu-emo" data-id="'+id+'">
    <div id="'+id+'-emo-tabs" class="tabbable pudu-emo-tabs">
      <ul class="nav nav-tabs">
        <li class="active"><a href="#pudu-emo-smiley"><img src="'+pudu.getExtensionUrl('/imgs/smiley.png')+'" width="48" /></a></li>
      </ul>
      <div class="tab-content">
        <div id="pudu-emo-smiley" class="emo tab-pane active"><ul class="thumbnails">'+emoHtml.join('')+'</ul></div>
      </div>
    </div>
    <div style="position: absolute; right: 0; top:30px;">
      <small><a style="text-decoration: none; opacity: 0.5;" target="_blank" href="'+pudu.getExtensionUrl('/options.html')+'">settings</a></small>
    </div>
  </div>']

pudu.commentHtml = (action, hidden, textarea, id = "pudu-quick-comment-#{pudu.random()}", cancel=false)->
  emoHtml = pudu.emoHtml id
  '<div>
  <table id="'+id+'" width="750" border="0" cellspacing="0" cellpadding="10">
    <tbody id="pudu-quick-comment">
    <tr>
      <td align="center" style="border:0;">
        <form method="post" action="' + action + '">
        <input type="hidden" name="' + hidden + '" value="">
        <table class="main" border="0" cellspacing="0" cellpadding="5">
          <tbody>
          <tr>
            <td align="left" style="padding: 0px; border-bottom: 0;">
              <div style="padding:15px 15px 0 15px;">
              <b class="pudu-quick-comment-title">Comment</b>
              '+emoHtml[0]+'
              <textarea id="'+id+'-textarea" class="pudu-quick-comment-textarea" name="' + textarea + '" cols="100" rows="15" style="border: 0px; width:100%;"></textarea>
              '+emoHtml[1]+'
              </div>
            </td>
          </tr>
          <tr>
            <td align="center" style="border-top:0;">
              <div style="padding-bottom: 15px;">
              <input type="submit" class="btn" value="Submit">
              '+(if cancel then '<input type="button" class="btn pudu-btn-remove-quick-box" value="Cancel">' else '')+'
              </div>
            </td>
          </tr>
          </tbody>
          </table>
        </form>
      </td>
    </tr>
    </tbody>
  </table>
  </div>'

pudu.pmHtml = (returnto, receiverUser, receiverId, id = "pudu-qucik-pm-#{pudu.random()}")->
  emoHtml = pudu.emoHtml id
  '<table id="'+id+'" width="750" border="0" cellspacing="0" cellpadding="10">
    <tbody>
    <tr>
      <td align="center" style="border:0;">
        <form method="post" action="takemessage.php">
        <input type="hidden" name="returnto" value="'+returnto+'">
        <input type="hidden" name="receiver" value="'+receiverId+'">
        <table class="main" border="0" cellspacing="0" cellpadding="5">
          <tbody>
          <tr>
            <td align="left" style="padding: 0px; border-bottom: 0;">
              <div style="padding:15px 15px 0 15px;">
              <b class="pudu-quick-comment-title">PM to '+receiverUser+'</b>
              '+emoHtml[0]+'
              <textarea id="'+id+'-textarea" class="pudu-quick-comment-textarea" name="msg" cols="100" rows="15" style="border: 0px; width:100%;"></textarea>
              '+emoHtml[1]+'
              </div>
            </td>
          </tr>
          <tr>
            <td align="center" style="border-top:0; border-bottom: 0;"><input type="checkbox" name="save" value="yes" checked="">Save message to Sentbox</td>
          </tr>
          <tr>
            <td align="center" style="border-top:0; border-bottom: 0;"><input type="text" size="30" name="money" value="ถ้าจะโอนเงินใส่จำนวนเงินที่นี่"></td>
          </tr>
          <tr>
            <td align="center" style="border-top:0;">
              <div style="padding-bottom: 15px;">
              <input type="submit" class="btn" value="Submit">
              <input type="button" class="btn pudu-btn-remove-quick-box" value="Cancel">
              </div>
            </td>
          </tr>
          </tbody>
          </table>
        </form>
      </td>
    </tr>
    </tbody>
  </table>'

pudu.replyHtml = (receiverUser, receiverId, originalMessageId, message, id="pudu-quick-reply-#{pudu.random()}")->
  emoHtml = pudu.emoHtml id
  '<table id="'+id+'" width="750" border="0" cellspacing="0" cellpadding="10">
    <tbody>
    <tr>
      <td align="center" style="border:0;">
        <form method="post" action="takemessage.php">
        <input type="hidden" name="returnto" value="/inbox.php">
        <input type="hidden" name="receiver" value="'+receiverId+'">
        <table class="main" border="0" cellspacing="0" cellpadding="5">
          <tbody>
          <tr>
            <td align="left" style="padding: 0px; border-bottom: 0;">
              <div style="padding:15px 15px 0 15px;">
              <b class="pudu-quick-comment-title">Reply to '+receiverUser+'</b>
              '+emoHtml[0]+'
              <textarea id="'+id+'-textarea" class="pudu-quick-comment-textarea" name="msg" cols="100" rows="15" style="border: 0px; width:100%;">'+message+'</textarea>
              '+emoHtml[1]+'
              </div>
            </td>
          </tr>
          <tr>
              <td align="center" style="border-top:0; border-bottom: 0;">
                <input type="checkbox" name="delete" value="yes" checked="">Delete message you are replying to
                <input type="hidden" name="origmsg" value="'+originalMessageId+'">
                <input type="checkbox" name="save" value="yes" checked="">Save message to Sentbox
              </td>
          </tr>
          <tr>
            <td align="center" style="border-top:0; border-bottom: 0;"><input type="text" size="30" name="money" value="ถ้าจะโอนเงินใส่จำนวนเงินที่นี่"></td>
          </tr>
          <tr>
            <td align="center" style="border-top:0;">
              <div style="padding-bottom: 15px;">
              <input type="submit" class="btn" value="Submit">
              <input type="button" class="btn pudu-btn-remove-quick-box" value="Cancel">
              </div>
            </td>
          </tr>
          </tbody>
          </table>
        </form>
      </td>
    </tr>
    </tbody>
  </table>'

pudu.parseBBCodeImage = (text)->
  while text.indexOf('[img]') isnt -1 or text.indexOf('[IMG]') isnt -1
    text = text.replace('[img]', '<img style="max-width: 700px;" src="')
                .replace('[IMG]', '<img style="max-width: 700px;" src="')
                .replace('[/img]', '" />')
                .replace('[/IMG]', '" />')
  return text

pudu.getCookie = (c_name)->
  c_value = document.cookie;
  c_start = c_value.indexOf(" " + c_name + "=");
  if (c_start == -1)
    c_start = c_value.indexOf(c_name + "=");

  if (c_start == -1)
    c_value = null;
  else
    c_start = c_value.indexOf("=", c_start) + 1;
    c_end = c_value.indexOf(";", c_start);
    if (c_end == -1)
      c_end = c_value.length;
    c_value = unescape(c_value.substring(c_start,c_end));

  return c_value;

pudu.siteUrl = (uri = '')->
  return window.location.href.toString().split(window.location.host)[0] + window.location.host + '/' + uri

window.pudu = pudu;
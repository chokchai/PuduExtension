###################################
# Pudu Utility
###################################

pudu = {}

pudu.random = (prefix)->
  rand = parseInt(Math.random()*100000000)
  if prefix then "#{prefix}_#{rand}" else rand

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

pudu.emoHtml = (id) ->
  '<div class="pudu">
    <div class="emo" data-id="'+id+'">
      <div class="btn-toolbar" style="margin-bottom:0;">
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
          <a class="btn" href="javascript:void(0)" data-prefix="[color=black]" data-suffix="[/color]"><i class="icon-circle" style="color:black"></i></a>
          <a class="btn" href="javascript:void(0)" data-prefix="[color=red]" data-suffix="[/color]"><i class="icon-circle" style="color:red"></i></a>
          <a class="btn" href="javascript:void(0)" data-prefix="[color=orange]" data-suffix="[/color]"><i class="icon-circle" style="color:orange"></i></a>
          <a class="btn" href="javascript:void(0)" data-prefix="[color=yellow]" data-suffix="[/color]"><i class="icon-circle" style="color:yellow"></i></a>
          <a class="btn" href="javascript:void(0)" data-prefix="[color=green]" data-suffix="[/color]"><i class="icon-circle" style="color:green"></i></a>
          <a class="btn" href="javascript:void(0)" data-prefix="[color=blue]" data-suffix="[/color]"><i class="icon-circle" style="color:blue"></i></a>
          <a class="btn" href="javascript:void(0)" data-prefix="[color=violet]" data-suffix="[/color]"><i class="icon-circle" style="color:violet"></i></a>
        </div>
      </div>
      <ul class="thumbnails">
        <li class="thumbnail"><div style="background-position: 0px 0px;"  data-text=":baby:" href="javascript:void(0);"></div></li>
        <li class="thumbnail"><div style="background-position: -48px 0px;"  data-text=":blink:" href="javascript:void(0);"></div></li>
        <li class="thumbnail"><div style="background-position: -96px 0px;"  data-text=":bow:"  href="javascript:void(0);"></div></li>
        <li class="thumbnail"><div style="background-position: -144px 0px;"  data-text=":closedeyes:"  href="javascript:void(0);"></div></li>
        <li class="thumbnail"><div style="background-position: -192px 0px;"  data-text=":cool:"  href="javascript:void(0);"></div></li>
        <li class="thumbnail"><div style="background-position: -240px 0px;" data-text=":\'-(" href="javascript:void(0);"></div></li>
        <li class="thumbnail"><div style="background-position: -288px 0px;"  data-text=":-D"  href="javascript:void(0);"></div></li>
        <li class="thumbnail"><div style="background-position: -336px 0px;"  data-text=":hmm:"  href="javascript:void(0);"></div></li>
        <li class="thumbnail"><div style="background-position: -384px 0px;"  data-text=":hmmm:"  href="javascript:void(0);"></div></li>
        <li class="thumbnail"><div style="background-position: -432px 0px;"  data-text=":huh:"  href="javascript:void(0);"></div></li>
        <li class="thumbnail"><div style="background-position: -480px 0px;"  data-text=":lol:"  href="javascript:void(0);"></div></li>
        <li class="thumbnail"><div style="background-position: -528px 0px;"  data-text=":ninja:"  href="javascript:void(0);"></div></li>
        <li class="thumbnail"><div style="background-position: -576px 0px;"  data-text=":-|"  href="javascript:void(0);"></div></li>
        <li class="thumbnail"><div style="background-position: -624px 0px;"  data-text=":punk:"  href="javascript:void(0);"></div></li>
        <li class="thumbnail"><div style="background-position: -672px 0px;"  data-text=":rolleyes:"  href="javascript:void(0);"></div></li>
        <li class="thumbnail"><div style="background-position: -720px 0px;"  data-text=":-("  href="javascript:void(0);"></div></li>
        <li class="thumbnail"><div style="background-position: -768px 0px;"  data-text=":shifty:"  href="javascript:void(0);"></div></li>
        <li class="thumbnail"><div style="background-position: -816px 0px;"  data-text=":slap:"  href="javascript:void(0);"></div></li>
        <li class="thumbnail"><div style="background-position: -864px 0px;"  data-text=":-)"  href="javascript:void(0);"></div></li>
        <li class="thumbnail"><div style="background-position: -912px 0px;"  data-text=":tease:"  href="javascript:void(0);"></div></li>
        <li class="thumbnail"><div style="background-position: -960px 0px;"  data-text=":thumbsdown:"  href="javascript:void(0);"></div></li>
        <li class="thumbnail"><div style="background-position: -1008px 0px;"  data-text=":thumbsup:"  href="javascript:void(0);"></div></li>
        <li class="thumbnail"><div style="background-position: -1056px 0px;"  data-text=":-P"  href="javascript:void(0);"></div></li>
        <li class="thumbnail"><div style="background-position: -1104px 0px;"  data-text=":wall:"  href="javascript:void(0);"></div></li>
        <li class="thumbnail"><div style="background-position: -1152px 0px;"  data-text=":wave:"  href="javascript:void(0);"></div></li>
        <li class="thumbnail"><div style="background-position: -1200px 0px;"  data-text=":wavecry:"  href="javascript:void(0);"></div></li>
        <li class="thumbnail"><div style="background-position: -1248px 0px;"  data-text=":weep:"  href="javascript:void(0);"></div></li>
        <li class="thumbnail"><div style="background-position: -1296px 0px;"  data-text=":whistle:"  href="javascript:void(0);"></div></li>
        <li class="thumbnail"><div style="background-position: -1344px 0px;"  data-text=";-)"  href="javascript:void(0);"></div></li>
        <li class="thumbnail"><div style="background-position: -1392px 0px;"  data-text=":yes:"  href="javascript:void(0);"></div></li>
      </ul>
  </div>
</div>'
pudu.commentHtml = (action, hidden, textarea, id = "pudu-quick-comment-#{pudu.random()}", cancel=false)->
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
                    <textarea id="'+id+'-textarea" class="pudu-quick-comment-textarea" name="' + textarea + '" cols="100" rows="15" style="border: 0px; width:100%;"></textarea>' + pudu.emoHtml(id) + '
                    </div>
                  </td>
                </tr>
                <tr>
                  <td align="center" style="border-top:0;">
                    <div style="padding-bottom: 15px;">
                    <input type="submit" class="btn" value="Submit">
                    '+(if cancel then '<input type="button" class="btn pudu-btn-remove-quick-form" value="Cancel">' else '')+'
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
                  <textarea id="'+id+'-textarea" class="pudu-quick-comment-textarea" name="msg" cols="100" rows="15" style="border: 0px; width:100%;"></textarea>' + pudu.emoHtml(id) + '
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
                  <input type="button" class="btn pudu-btn-remove-quick-form" value="Cancel">
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

window.pudu = pudu;
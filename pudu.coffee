# jQuery Elements
$menu = $('.outer:first')
$content = $('.outer:last')
$addReplyButton = $ 'input[value="Add Reply"]'
$topPagination = $('p font.gray:first').parent()
$bottomPagination = $('p font.gray:last').parent()
$commentsTable = $ 'table.main[width="750"]'
$commentsTableInner = $commentsTable.find 'table:first'
$commentsBox = $commentsTableInner.find('a[name] > table').parent()
$commentsHeader = $ 'p.sub > table'
$comemntsBody = $commentsBox.find '>table.main'
$commentsContent = $ '.comment'
$torrentCommentLink = $ 'a[href^="comment.php?action=add"]'

# Add Class to Elemetns for edit style
$commentsTable.addClass 'pudu-comments-table'
$commentsTableInner.addClass 'pudu-comments-table-inner'
$topPagination.addClass 'pudu-top-pagination'
$bottomPagination.addClass 'pudu-bottom-pagination'
$commentsBox.addClass 'pudu-comments-box'
$commentsHeader.addClass 'pudu-comments-header'
$commentsContent.addClass 'pudu-comments-content'
$comemntsBody.addClass 'pudu-comments-body'

# Fixed Elements
$('a[href="#top"]').hide()
$commentsBox.css 'backgroundColor', $commentsHeader.css 'backgroundColor'

# Default Html
emoHtml = '<div class="pudu"><ul id="emo" class="thumbnails">
<li class="thumbnail"><div style="background-position: 0px 0px;"  data-text=":baby:" href="javascript:void(0);"></div></li>
<li class="thumbnail"><div style="background-position: -48px 0px;"  data-text=":blink:" href="javascript:void(0);"></div></li>
<li class="thumbnail"><div style="background-position: -96px 0px;"  data-text=":bow:"  href="javascript:void(0);"></div></li>
<li class="thumbnail"><div style="background-position: -144px 0px;"  data-text=":closedeyes:"  href="javascript:void(0);"></div></li>
<li class="thumbnail"><div style="background-position: -192px 0px;"  data-text=":cool:"  href="javascript:void(0);"></div></li>
<li class="thumbnail"><div style="background-position: -240px 0px;" data-text="'+":'-("+' href="javascript:void(0);"></div></li>
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
</ul></div>'

commentHtml = (action, hidden, textarea) -> '<div>
<table width="750" border="0" cellspacing="0" cellpadding="10">
<tbody>
<tr>
  <td align="center" style="border:0;">
    <form method="post" action="'+action+'">
    <input type="hidden" name="'+hidden+'" value="">
    <table class="main" border="0" cellspacing="0" cellpadding="5">
      <tbody>
      <tr>
        <td align="left" style="padding: 0px; border-bottom: 0;">
          <div style="padding:15px 15px 0 15px;">
          <b>Comment</b>
          <textarea id="pudu-comment-textarea" name="'+textarea+'" cols="100" rows="15" style="border: 0px; width:100%;"></textarea>'+emoHtml+'
          </div>
        </td>
      </tr>
      <tr>
        <td align="center" style="border-top:0;">
          <div style="padding-bottom: 15px;">
          <input type="submit" class="btn" value="Submit">
          </div>
        </td>
      </tr>
      </tbody>
      </table>
    </form>
    <p align="center"><a href="tags.php" target="_blank">Tags<img src="pic/new.gif"></a> | <a href="smilies.php" target="_blank">Smilies</a></p>
  </td>
</tr>
</tbody>
</table>
</div>'

# added fast-comment to topics
if $addReplyButton.size() > 0
  $bottomPagination.after \
    $(commentHtml('?action=post', 'topicid', 'body'))
      .find('input[name="topicid"]')
      .val($('input[name="topicid"]').val())
      .end()
      .html()

# add fast comment to torrent page
if $torrentCommentLink.size() > 0
  $('.pudu-comments-table+p').after \
    $(commentHtml('comment.php?action=add', 'tid', 'text'))
      .find('input[name="tid"]')
      .val($('input[name="torrentid"]').val())
      .end()
      .html()

# bind emo
$('body').on 'click', '#emo div', (event)->
  event.preventDefault();
  event.stopImmediatePropagation();
  event.stopPropagation();
  insertAtCaret('pudu-comment-textarea', $(this).data('text'));
  return false;

insertAtCaret = (areaId,text)->
  txtarea = document.getElementById(areaId);
  scrollPos = txtarea.scrollTop;
  strPos = 0;

  strPos = txtarea.selectionStart;

  front = (txtarea.value).substring(0,strPos);
  back = (txtarea.value).substring(strPos,txtarea.value.length);
  txtarea.value=front+text+back;
  strPos = strPos + text.length;

  txtarea.selectionStart = strPos;
  txtarea.selectionEnd = strPos;
  txtarea.focus();
  txtarea.scrollTop = scrollPos;

# remove signature
if $commentsContent.size() > 0
  $commentsContent.each ()->
    html = $(this).html()
    cIndex = html.indexOf '<br>------------------------<br>'
    if cIndex != -1 then $(this).html html.substring(0, cIndex)+'<div class="hide pudu-comment-signature" >'+html.substring(cIndex)+'</div>'

  # show signature by double click alt
  $('body').on 'keydown', (e)->
    $('.pudu-comment-signature').toggleClass 'hide' if e.keyCode == 18

# highlight on more like commend
if $commentsBox.size() > 0
  likes = []
  $commentsBox.each ()->
    # collect like score
    score = $(this).find('td.embedded[width="99%"] b:last').text()
    if score > 0 then likes.push(score: score, name: $(this).attr 'name')

  # add focus to comment
  for like in likes
    if 10 >= like.score > 0
      focus = 1
    else if 20 >= like.score > 10
      focus = 2
    else if 30 >= like.score > 20
      focus = 3
    else if 40 >= like.score > 30
      focus = 4
    else focus = 5

    $commentsBox.filter("[name='#{like.name}']").addClass "focus-#{focus}"

# fix comment id (#)
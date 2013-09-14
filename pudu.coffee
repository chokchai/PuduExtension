# load pudu utils
pudu = window.pudu

#######################################
# indentify page
#######################################

url = window.location.href
page =
  # forums and market use same operation
  viewtopic: url.indexOf('/forums.php?action=viewtopic') isnt -1 \
              or url.indexOf('/markets.php?action=viewtopic') isnt -1
  viewforum: url.indexOf('/forums.php?action=viewforum') isnt -1 \
              or url.indexOf('/markets.php?action=viewforum') isnt -1 \
              or url.indexOf('/markets.php?action=viewall') isnt -1 # market have view all feature...
  forums: (url.indexOf('/forums.php') isnt -1 or url.indexOf('/markets.php') isnt -1) \
              and url.indexOf('?action=') is -1 # and no action
  browse: url.indexOf('/browse.php') isnt -1
  details: url.indexOf('/details.php') isnt -1
  inbox: url.indexOf('/inbox.php') isnt -1 and url.indexOf('?out=1') is -1
  sentbox: url.indexOf('/inbox.php?out=1') isnt -1,
  history: url.indexOf('/userhistory.php') isnt -1,
  newtopic: url.indexOf('/forums.php?action=newtopic') isnt -1 or url.indexOf('/markets.php?action=newtopic') isnt -1


#######################################
# jQuery Elements
#######################################

# global
$menu = $ '.outer:first'
$content = $ '.outer:last'
$header = $ 'h1:first'

if page.viewtopic or page.viewforum
  $topPagination = $ 'h1+p:first'
  $bottomPagination = $ 'table+p:first'

if page.viewtopic or page.details or page.history
  $commentsTable = $ 'table.main[width="750"]'
  $commentsContent = $ '.comment'
  $commentsTableInner = $commentsTable.find 'table:first'
  $commentsBox = $commentsTableInner.find('a[name] > table').parent()
  $commentsHeader = $commentsTableInner.find 'p.sub > table'
  $commentsBody = $commentsBox.find '>table.main'
  $commentsUser = $commentsHeader.find 'a[href^="userdetails.php"]'
  $commentsPmLink = $commentsHeader.find 'a[href^="sendmessage.php"]'
  $commentsQuoteLink = $commentsHeader.find 'a[href^="?action=quotepost"]'
  $commentsLikeLink = $commentsHeader.find 'a[href^="forums.php?action=likes"]'
  $commentsEditLink = $commentsHeader.find 'a[href^="?action=editpost"]'
  $torrentCommentLink = $ 'a[href^="comment.php?action=add"]'

if page.viewtopic
  $addReplyButton = $ 'input[value="Add Reply"]'

if page.forums
  $forumsTable = $ 'h1+p+table, h1+table'
  $forumsTableRow = $forumsTable.find('tbody > tr')
  $forumsTableHeader = $forumsTable.find('tbody > tr:eq(0)')
  $forumsTableRowForum = $forumsTableRow.find('> td:eq(0)')
  $forumsTableRowTopics = $forumsTableRow.find('> td:eq(1)')
  $forumsTableRowPosts = $forumsTableRow.find('> td:eq(2)')
  $forumsTableRowLastTopic = $forumsTableRow.find('> td:eq(3)')

if page.details or page.history
  $topPagination = $ 'p[align="center"]:eq(1)'
  $bottomPagination = $ 'p[align="center"]:eq(2)'
  $topAddComment = $ 'p[align="center"]:eq(0) > a'
  $bottomAddComment = $ 'p[align="center"]:eq(3) > a'
  $commentsHeader = $ 'p.sub'
  $commentsBody = $ 'p.sub+table'
  $commentsContent = $commentsBody.find 'td.text'
  $commentsUser = $commentsHeader.find 'a[href^="userdetails.php"]'

if page.viewforum
  $topicTable = $topPagination.next()
  $topicTableRow = $topicTable.find('tbody > tr')
  $topicTableHeader = $topicTable.find('tbody > tr:eq(0)')
  $topicTableRowTopic = $topicTableRow.find('> td:eq(0)')
  $topicTableRowReplies = $topicTableRow.find('> td:eq(1)')
  $topicTableRowViews = $topicTableRow.find('> td:eq(2)')
  $topicTableRowAuthor = $topicTableRow.find('> td:eq(3)')
  $topicTableRowLastPost = $topicTableRow.find('> td:eq(4)')

if page.browse
  $topPagination = $ 'p[align="center"]:eq(1)'
  $bottomPagination = $ 'p[align="center"]:eq(2)'
  $browseTable = $topPagination.next()
  $browseTableRow = $browseTable.find 'tbody > tr'
  $browseTableHeader = $browseTable.find 'tbody > tr:eq(0)'
  $browseTableType = $browseTableRow.find '> td:eq(0)'
  $browseTableName = $browseTableRow.find '> td:eq(1)'
  $browseTableFiles = $browseTableRow.find '> td:eq(2)'
  $browseTableComm = $browseTableRow.find '> td:eq(3)'
  $browseTableAdded = $browseTableRow.find '> td:eq(4)'
  $browseTableSize = $browseTableRow.find '> td:eq(5)'
  $browseTableSnatched = $browseTableRow.find '> td:eq(6)'
  $browseTablePeers = $browseTableRow.find '> td:eq(7)'
  $browseTableSeeders = $browseTableRow.find '> td:eq(8)'
  $browseTableLeechers = $browseTableRow.find '> td:eq(9)'
  $browseTableUppedby = $browseTableRow.find '> td:eq(10)'

if page.inbox or page.sentbox
  $messageBox = $ '.main[width=750] td:first > p'
  $messageUser = $messageBox.find '.text:first > b > a[href^="userdetails.php"]'
  $messageContent = $messageBox.find '.text:first > p:eq(0) .text'
  $messageMenu = $messageBox.find '.text:first > p:eq(1)'
  $messageReplyButton = $messageMenu.find 'a[href^="sendmessage.php"]'
  $messageDeleteButton = $messageMenu.find 'a[href^="deletemessage.php?id="]'
  $messageDeleteAllButton = $messageMenu.find 'a[href^="deletemessage.php?empty=1"]'

#######################################
# Add Class to Elemetns
#######################################

# add class pudu-page-{pagename} to body tag
$('body').addClass "pudu-page-#{p}" for p, v of page when v is true

$menu.addClass 'pudu-menu'
$content.addClass 'pudu-content'
$header.addClass 'pudu-header'

if page.viewtopic or page.details or page.browse
  $topPagination.addClass 'pudu-top-pagination'
  $bottomPagination.addClass 'pudu-bottom-pagination'

if page.viewtopic or page.details or page.history
  $commentsTable.addClass 'pudu-comments-table'
  $commentsTableInner.addClass 'pudu-comments-table-inner'
  $commentsBox.addClass 'pudu-comments-box'
  $commentsHeader.addClass 'pudu-comments-header'
  $commentsContent.addClass 'pudu-comments-content'
  $commentsBody.addClass 'pudu-comments-body'
  $commentsUser.addClass 'pudu-comments-user'
  $commentsPmLink.addClass 'pudu-comments-pm-link'
  $commentsQuoteLink.addClass 'pudu-comments-quote-link'
  $commentsLikeLink.addClass 'pudu-comments-like-link'
  $commentsEditLink.addClass 'pudu-comments-edit-link'

if page.forums
  $forumsTable.addClass 'pudu-forums-table'
  $forumsTableRow.addClass 'pudu-forums-table-row'
  $forumsTableHeader.removeClass('pudu-forums-table-row').addClass 'pudu-forums-table-header'
  $forumsTableRowForum.addClass 'pudu-forums-table-row-forum'
  $forumsTableRowTopics.addClass 'pudu-forums-table-row-topic'
  $forumsTableRowPosts.addClass 'pudu-forums-table-row-posts'
  $forumsTableRowLastTopic.addClass 'pudu-forums-table-row-lasttopic'

if page.details
  $topAddComment.addClass 'pudu-top-add-comment'
  $bottomAddComment.addClass 'pudu-bottom-add-comment'

if page.viewforum
  $topicTable.addClass 'pudu-topic-table'
  $topicTableRow.addClass 'pudu-topic-table-row'
  $topicTableHeader.removeClass('pudu-topic-table-row').addClass 'pudu-topic-table-header'
  $topicTableRowTopic.addClass 'pudu-topic-table-row-topic'
  $topicTableRowReplies.addClass 'pudu-topic-table-row-repiles'
  $topicTableRowViews.addClass 'pudu-topic-table-row-views'
  $topicTableRowAuthor.addClass 'pudu-topic-table-row-author'
  $topicTableRowLastPost.addClass 'pudu-topic-table-row-lastpost'

if page.browse
  $browseTable.addClass 'pudu-browse-table'
  $browseTableRow.addClass 'pudu-browse-table-row'
  $browseTableHeader.removeClass('pudu-browse-table-row').addClass 'pudu-browse-table-header'
  $browseTableType.addClass 'pudu-browse-table-row-type'
  $browseTableName.addClass 'pudu-browse-table-row-name'
  $browseTableFiles.addClass 'pudu-browse-table-row-files'
  $browseTableComm.addClass 'pudu-browse-table-row-comm'
  $browseTableAdded.addClass 'pudu-browse-table-row-added'
  $browseTableSize.addClass 'pudu-browse-table-row-size'
  $browseTableSnatched.addClass 'pudu-browse-table-row-snatched'
  $browseTablePeers.addClass 'pudu-browse-table-row-peers'
  $browseTableSeeders.addClass 'pudu-browse-table-row-seeders'
  $browseTableLeechers.addClass 'pudu-browse-table-row-leechers'
  $browseTableUppedby.addClass 'pudu-browse-table-row-uppedby'

if page.inbox or page.sentbox
  $messageBox.addClass 'pudu-message-box'
  $messageUser.addClass 'pudu-message-user'
  $messageContent.addClass 'pudu-message-content'
  $messageMenu.addClass 'pudu-message-menu'
  $messageReplyButton.addClass 'pudu-message-reply-button'
  $messageDeleteButton.addClass 'pudu-message-delete-button'
  $messageDeleteAllButton.addClass 'pudu-message-delete-all-button'

#######################################
# Fixed Elements
#######################################

if page.viewtopic
  # remove top button
  $('a[href="#top"]').hide()
  # change comment box color
  $commentsBox.css 'backgroundColor', $commentsHeader.css 'backgroundColor'
  # change href of quote and edit for quick comment
  $commentsEditLink.each ()-> $(@).attr('data-href', $(@).attr 'href').attr 'href', 'javascript:void(0)'
  $commentsQuoteLink.each ()-> $(@).attr('data-href', $(@).attr 'href').attr 'href', 'javascript:void(0)'
  $commentsPmLink.each ()-> $(@).attr('data-href', $(@).attr 'href').attr 'href', 'javascript:void(0)'

if page.details
  # goto quick comment when click add comment
  $topAddComment.attr 'href', '#pudu-quick-comment'

if page.viewforum
  # change table display
  $('.pudu-topic-table-row > td, .pudu-topic-table-header > td')
    .css 'borderColor', $('.pudu-topic-table-header > td:first').css 'backgroundColor'

if page.browse
  # change table display
  $('.pudu-browse-table-row > td, .pudu-browse-table-header > td')
  .css 'borderColor', $('.pudu-browse-table-header > td:first').css 'backgroundColor'
  # set table header link font-color
  $browseTableHeader.find('a').css 'color', $browseTableHeader.find('td').css 'color'
  # remove churry image
  $browseTableRow.find('img[src="pic/xr.gif"], img[src="pic/xl.gif"]').remove()

if page.forums
  # change table display
  $('.pudu-forums-table-row > td, .pudu-forums-table-header > td')
  .css 'borderColor', $('.pudu-forums-table-header > td:first').css 'backgroundColor'

if page.inbox
  $messageReplyButton.each ()-> $(@).attr('data-href', $(@).attr 'href').attr 'href', 'javascript:void(0)'

#######################################
# operations
#######################################

################
# to top button
################
$().UItoTop(scrollSpeed: 'normal', easingType: 'swing');

################
# remove quick form btton
################
$content.on 'click', '.pudu-btn-remove-quick-box', ()->
  $(".quick-box").remove()

#################
# bind emo
#################
$content.on 'click', '.emo li, .emo a', (event)->
  event.preventDefault();
  event.stopImmediatePropagation();
  event.stopPropagation();

  textareaId = $(@).parents('.emo').data('id')+'-textarea'
  if $(@).data 'text'
    pudu.insertAtCaret(textareaId, $(@).data('text'));
  else if $(@).data('prefix') and $(@).data('suffix')
    pudu.insertWrapCaret textareaId, $(@).data('prefix'), $(@).data('suffix')
  return false;

################
# clean menu and add extra menu
################
$menu.find('.navigation:last').after \
  ['<td align="center" class="navigation"><a href="userhistory.php?action=viewnewposts&id='+pudu.getCookie('xid')+'">Forums History</a></td>',
  '<td align="center" class="navigation"><a href="userhistory.php?action=viewmarkets&id='+pudu.getCookie('xid')+'">Markets History</a></td>',
  '<td align="center" class="navigation"><a href="inbox.php">Inbox</a></td>',
  '<td align="center" class="navigation"><a href="inbox.php?out=1">Sentbox</a></td>',
  '<td align="center" class="navigation"><a href="logout.php">Logout</a></td>',
  '<td align="center" class="navigation">+<a href="javascript:void(0)" id="pudu-menu-more-button">More</a></td>'].join('')

# add more button
$menu.find('> table > tbody > tr:first').after('<tr class="pudu-menu-more hide"></tr>')
$menuMore = $ '.pudu-menu-more'

# toggle show and hide menu
$('#pudu-menu-more-button').on 'click', ()-> $menuMore.toggleClass('hide')

$menuMore.append \
  '<td align="center" class="navigation"><a href="userdetails.php?id='+pudu.getCookie('xid')+'">User</a></td>',
  $menu.find('a[href="http://lolthai.com/pets.php"]').parent(),
  $menu.find('a[href="http://lolthai.com/faq.php"]').parent().attr('colspan',2),
  $menu.find('a[href="http://lolthai.com/oforums.php"]').parent(),
  '<td align="center" class="navigation"><a href="bookmark.php">Bookmark</a></td>',
  $menu.find('a[href="http://lolthai.com/topten.php"]').parent(),
  $menu.find('a[href="http://lolthai.com/arena.php"]').parent(),
  '<td align="center" class="navigation" colspan="2"><a href="users.php">Search Users</a></td>',
  $menu.find('a[href="http://lolthai.com/casino.php"]').parent(),
  $menu.find('a[href="http://lolthai.com/chat.php"]').parent()

if page.forums

  # set title
  $('title').text $header.text()

if page.viewforum

  # set title
  $('title').text $header.text()

if page.viewtopic

  # set title
  title = $header.text()
  $('title').text title.substring(title.indexOf('> ')+2)

  ###############
  # added fast-comment to topics
  ###############
  if $addReplyButton.size() > 0
    $bottomPagination.after \
      $(pudu.commentHtml('?action=post', 'topicid', 'body'))
      .find('input[name="topicid"]')
      .val($('input[name="topicid"]').val())
      .end()
      .html()

  ###############
  # remove signature
  ###############
  $commentsContent.each ()->
    html = $(this).html()
    cIndex = html.indexOf '<br>------------------------<br>'
    if cIndex != -1 then $(this).html html.substring(0,
      cIndex) + '<div class="hide pudu-comment-signature" >' + html.substring(cIndex) + '</div>'

  ###############
  # show signature by press ctrl+alt
  ###############
  $('body').on 'keydown', (e)->
    if e.ctrlKey and e.altKey
        $('.pudu-comment-signature').toggleClass 'hide'

  ###############
  # highlight on more like commend
  ###############
  $commentsBox.each ()->
    # collect like score
    score = $(this).find('td.embedded[width="99%"] b:last').text()
    name = $(this).attr 'name'

    if 10 >= score > 0
      focus = 1
    else if 20 >= score > 10
      focus = 2
    else if 30 >= score > 20
      focus = 3
    else if 40 >= score > 30
      focus = 4
    else if score > 40
      focus = 5
    $commentsBox.filter("[name='#{name}']").addClass("focus-#{focus}").css 'borderColor', $commentsContent.css 'borderColor' if focus > 0

  ###############
  # edit comment header
  ###############
  $commentsBox.each ()->
    # reformat
    name = $(this).attr 'name'
    name = $(this).prev().attr 'name' if name == 'last'
    $header = $(this).find '.pudu-comments-header'
    html = $header.html()
    .replace(' GMT', '')
    .replace("##{name}", '')
    .replace(///\[///g, '')
    .replace(///\]///g, '')
    .replace('--', '-')

    # remove b-tag on all link except username
    $html = $(html).find('a:not(.pudu-comments-user, .pudu-comments-like-link)').each(()-> $(@).text $(@).text()).end()

    $header.html($html)

  ###############
  # quick edit, quote and pm
  ###############
  # quick edit, quote
  $commentsHeader.on 'click', '.pudu-comments-edit-link, .pudu-comments-quote-link', ()->

    isEdit = $(@).is('.pudu-comments-edit-link')

    # get parrent box
    $cbox = $(@).parents '.pudu-comments-box'
    id = 'quick-' + $cbox.attr 'name'

    # remove old edit box
    $(".quick-box").remove()

    # show loading
    $cbox.after "<div id='#{id}' class='quick-box'><div style='text-align:center;'>loading...</div></div>"

    # move scroll
    $("html, body").animate scrollTop: $("##{id}").offset().top-40

    # get data from server
    $.get($(@).data 'href')
      .done((res)->

        hiddenName = if isEdit then 'returnto' else 'topicid'
        title = if isEdit then 'Edit' else 'Quote '+$cbox.find('.pudu-comments-user').html()

        # create quick comment
        $res = $(res)
        $qcom = $(pudu.commentHtml($res.find('form').attr('action'), hiddenName, 'body', id, true))

        # modify value to can comment
        $qcom.find('.pudu-quick-comment-textarea').html $res.find('textarea[name="body"]').html()
        $qcom.find('.pudu-quick-comment-title').html title
        $qcom.find('input[name="'+hiddenName+'"]').val $res.find('input[name="'+hiddenName+'"]').val()

        # add to loading
        $("##{id}").html $qcom.html()

        # scroll to comment then focus
        $("##{id}").find('.pudu-quick-comment-textarea').focus()

      ).fail ()->

        # on fail just show fail message then fade out
        $("##{id}").html('Fail...').fadeOut 'slow', ()-> $(@).remove()

  # quick pm
  $commentsHeader.on 'click', '.pudu-comments-pm-link', ()->
    # get parrent box
    $cbox = $(@).parents '.pudu-comments-box'
    id = 'quick-' + $cbox.attr 'name'

    # remove old edit box
    $(".quick-box").remove()

    # show loading
    $cbox.after "<div id='#{id}' class='quick-box'></div>"

    # move scroll
    $("html, body").animate scrollTop: $("##{id}").offset().top-40

    # add pm html
    $receiver = $cbox.find('.pudu-comments-user')
    html = pudu.pmHtml window.location.href, $receiver.html(), pudu.parseUrlQuery($receiver.attr 'href').id
    $("##{id}").html html

    # scroll to comment then focus
    $("##{id}").find('.pudu-quick-comment-textarea').focus()

if page.details

  # set title
  $('title').text $header.text()

  ###############
  # add fast comment to torrent page
  ###############
  html = $(pudu.commentHtml('comment.php?action=add', 'tid', 'text'))
          .find('input[name="tid"]')
          .val(pudu.parseUrlQuery().id)
          .end()
          .html() + '<br/>'
  if $bottomAddComment.size() > 0
    $bottomAddComment.before html
  else
    $topAddComment.before html

  ###############
  # edit comment header
  ###############
  $commentsHeader.each ()->
    name = $(this).find('.pudu-comments-user').attr('name').replace('comm', '')
    html = $(this).html()
    .replace(' GMT', '')
    .replace("##{name}", '')
    .replace(///\[///g, '')
    .replace(///\]///g, '')
    .replace('--', '-')
    $(this).html html

if page.browse

  ###############
  # add download torrent link
  ###############
  $browseTableName.each ()->
    # add url to link as data
    link = $(this).find('a:first')
    if link.size() > 0
      $td = $(this).siblings('.pudu-browse-table-row-peers').html("<a class='pudu-direct-download' data-url='#{link.attr('href')}' href='javascript:void(0);'>torrent</a>")
    else
      $td = $(this).siblings('.pudu-browse-table-row-peers').text('Download')

    $(this).after($td)

  ###############
  # onclick download torrent link
  ###############
  $('.pudu-direct-download').on 'click', ()->

    # lock on disable
    if ! $(@).is '.disable'

      # show loading
      $(@).text 'loading'
      # disable all
      $('.pudu-direct-download').addClass('disable')

      url = $(@).data 'url'
      $.get(url).done((res)=>
        # load
        window.location.href = $(res).find('a[href^="download.php"]').attr('href')
        # show message
        $(@).text 'torrent'
        # enable all
        $('.pudu-direct-download').removeClass('disable')
      ).fail(()=>
        # show message
        $(@).text 'try again'
        # enable all
        $('.pudu-direct-download').removeClass('disable')
      )

if page.sentbox or page.inbox

  # fixed title
  $('title').text $('title').text().replace('--- :: ', '')

  ###############
  # parse bbcode
  ###############
  $messageContent.each ()->
    $(@).html pudu.parseBBCodeImage($(@).html())

  ###############
  # highlight on new message
  ###############
  $messageBox.each ()->
    if $(@).find('.text > b > font[color="red"]').size() > 0
      $(@).addClass 'focus-1'

  ###############
  # remove b tage in menu (Reply, Delete,...)
  ###############
  $messageMenu.find('a').each ()-> $(@).text $(@).text()

  ###############
  # add confirmation to delete, and delete all
  ###############
  $messageDeleteAllButton.on 'click', ()->
    return confirm("Delete all message ?")
  $messageDeleteButton.on 'click', ()->
    # confirmation to delete message also show recievier name
    return confirm("Delete message form #{$(@).parents('.pudu-message-box').find('.pudu-message-user').text()} ?")

  ###############
  # quick reply
  ###############
  $messageReplyButton.on 'click', ()->

    # get parrent box
    $mbox = $(@).parents '.pudu-message-box'
    id = pudu.random 'quick-reply'

    # remove old edit box
    $(".quick-box").remove()

    # show loading
    $mbox.after "<div id='#{id}' class='quick-box'><div style='text-align:center;'>loading...</div></div>"

    # move scroll
    $("html, body").animate scrollTop: $("##{id}").offset().top-40

    # get reply message
    href = $(@).data 'href'
    $.get(href)
    .done((res)->
        $res = $ res
        # add pm html
        $receiver = $mbox.find('.pudu-message-user')
        html = pudu.replyHtml($receiver.text(), pudu.parseUrlQuery(href).receiver, pudu.parseUrlQuery(href).replyto, $res.find('textarea[name="msg"]').html(), id)
        $("##{id}").html html

        # scroll to comment then focus
        $("##{id}").find('.pudu-quick-comment-textarea').focus()
    )
    .fail ()->
      # on fail just show fail message then fade out
      $("##{id}").html('Fail...').fadeOut 'slow', ()-> $(@).remove()

if page.history

  ###############
  # Fix title
  ###############
  page = if url.indexOf('?action=viewnewposts') isnt -1 then 'Forums' else 'Markets'
  $('title').text "#{page} History"
  $header.html $header.html().replace('Post history',  "#{page} History")


  ###############
  # fixed comment header
  ###############
  $commentsHeader.each ()->
    html = $(@).html()
    html = html.replace('&nbsp;--&nbsp;<b>Forum:&nbsp;</b>', ' - ')
                .replace('&nbsp;--&nbsp;<b>Topic:&nbsp;</b>', ' / ')
                .replace('GMT', '')
                .replace('&nbsp;--&nbsp;<b>Post:&nbsp;</b>', ' - ')
    $(@).html html

if page.newtopic
  ###############
  # Add emotion to new topic
  ###############
  id = pudu.random()
  $subject = $('input[name="subject"]').css(width:'100%')
  $textarea = $('textarea[name="body"]')
  $textarea
    .css(width:'100%')
    .attr('id', "#{id}-textarea")
    .after pudu.emoHtml(id)


######################################
# Lolthai helper Compatiable
######################################

window.onload = ()->
  # lolthai helper extra menu ? hide it
  if $('#lth_extra_menu').size() > 0
    $('#lth_extra_menu').remove()

  # lolthai helper emo ? move to bottom
  if $('#lth_emo_tabs').size() > 0
    $('#lth_emo_tabs').before $('.emo').parent()
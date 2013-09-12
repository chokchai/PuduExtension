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

if page.viewtopic or page.details
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

if page.details
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

if page.viewtopic or page.details
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

#######################################
# operations
#######################################

# to top button
$().UItoTop(scrollSpeed: 'normal', easingType: 'swing');

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

  # added fast-comment to topics
  if $addReplyButton.size() > 0
    $bottomPagination.after \
      $(pudu.commentHtml('?action=post', 'topicid', 'body'))
      .find('input[name="topicid"]')
      .val($('input[name="topicid"]').val())
      .end()
      .html()

  # remove signature
  $commentsContent.each ()->
    html = $(this).html()
    cIndex = html.indexOf '<br>------------------------<br>'
    if cIndex != -1 then $(this).html html.substring(0,
      cIndex) + '<div class="hide pudu-comment-signature" >' + html.substring(cIndex) + '</div>'

  # show signature by press ctrl+alt
  $('body').on 'keydown', (e)->
    if e.ctrlKey and e.altKey
        $('.pudu-comment-signature').toggleClass 'hide'

  # highlight on more like commend
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

  # edit comment header
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

  # remove quick form btton
  $commentsTableInner.on 'click', '.pudu-btn-remove-quick-form', ()->
    $(".quick-quote-edit-pm").remove()

  # when click edit load data then insert to quick comment
  $commentsHeader.on 'click', '.pudu-comments-edit-link, .pudu-comments-quote-link', ()->

    isEdit = $(@).is('.pudu-comments-edit-link')

    # get parrent box
    $cbox = $(@).parents '.pudu-comments-box'
    id = 'quick-' + $cbox.attr 'name'

    # remove old edit box
    $(".quick-quote-edit-pm").remove()

    # show loading
    $cbox.after "<div id='#{id}' class='quick-quote-edit-pm'><div style='text-align:center;'>loading...</div></div>"

    # move scroll
    $("html, body").animate scrollTop: $("##{id}").offset().top-50

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
    $(".quick-quote-edit-pm").remove()

    # show loading
    $cbox.after "<div id='#{id}' class='quick-quote-edit-pm'></div>"

    # move scroll
    $("html, body").animate scrollTop: $("##{id}").offset().top-50

    # add pm html
    $receiver = $cbox.find('.pudu-comments-user')
    html = pudu.pmHtml window.location.href, $receiver.html(), pudu.parseUrlQuery($receiver.attr 'href').id
    $("##{id}").html html

    # scroll to comment then focus
    $("##{id}").find('.pudu-quick-comment-textarea').focus()

if page.details

  # set title
  $('title').text $header.text()

  # add fast comment to torrent page
  html = $(pudu.commentHtml('comment.php?action=add', 'tid', 'text'))
          .find('input[name="tid"]')
          .val(pudu.parseUrlQuery().id)
          .end()
          .html() + '<br/>'
  if $bottomAddComment.size() > 0
    $bottomAddComment.before html
  else
    $topAddComment.before html

  # edit comment header
  $commentsHeader.each ()->
    name = $(this).find('.pudu-comments-user').attr('name').replace('comm', '')
    html = $(this).html()
    .replace(' GMT', '')
    .replace("##{name}", '')
    .replace(///\[///g, '')
    .replace(///\]///g, '')
    .replace('--', '-')
    $(this).html html

if page.details or page.viewtopic
  # bind emo
  $('body').on 'click', '.emo li > div, .emo a', (event)->
    event.preventDefault();
    event.stopImmediatePropagation();
    event.stopPropagation();

    textareaId = $(@).parents('.emo').data('id')+'-textarea'
    if $(@).data 'text'
      pudu.insertAtCaret(textareaId, $(@).data('text'));
    else if $(@).data('prefix') and $(@).data('suffix')
      pudu.insertWrapCaret textareaId, $(@).data('prefix'), $(@).data('suffix')

    return false;

if page.browse
  # add download torrent link
  $browseTableName.each ()->
    # add url to link as data
    link = $(this).find('a:first')
    if link.size() > 0
      $td = $(this).siblings('.pudu-browse-table-row-peers').html("<a class='pudu-direct-download' data-url='#{link.attr('href')}' href='javascript:void(0);'>torrent</a>")
    else
      $td = $(this).siblings('.pudu-browse-table-row-peers').text('Download')

    $(this).after($td)

  # onclick download torrent link
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
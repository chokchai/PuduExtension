// Generated by CoffeeScript 1.6.3
(function() {
  var $resetButton, $stickerModal, $stickers, $version, checkboxOptions, i, id, imgs, pudu, saveSelectedStickers, setSelectedStickerEffect, stickers;

  pudu = window.pudu;

  stickers = pudu.stickers;

  $stickers = $('#pudu-stickers');

  $stickerModal = $('#pudu-sticker-modal');

  $resetButton = $('#pudu-options-reset');

  $version = $('#pudu-version');

  $version.text('v' + chrome.app.getDetails().version);

  $resetButton.on('click', function() {
    return pudu.clearLocalStorage(function() {
      return pudu.setLocalStorage(pudu.defaultSetting, function() {
        return window.location.href = window.location.href;
      });
    });
  });

  checkboxOptions = function(optionSelector, optionName) {
    pudu.getLocalStorage(function(items) {
      var opts;
      if (items[optionName] === void 0) {
        opts = {};
        opts[optionName] = true;
        pudu.setLocalStorage(opts);
      }
      if (items[optionName] === void 0 || items[optionName] === true) {
        return $(optionSelector).attr('checked', 'checked');
      }
    });
    return $(optionSelector).on('change', function() {
      var checked, opts;
      checked = $(this).is(':checked');
      opts = {};
      if (checked) {
        opts[optionName] = true;
      } else {
        opts[optionName] = false;
      }
      return pudu.setLocalStorage(opts);
    });
  };

  checkboxOptions('#pudu-options-signature', 'hideSignature');

  checkboxOptions('#pudu-options-comment-number', 'hideCommentNumber');

  setSelectedStickerEffect = function() {
    var $checked;
    $('.sticker-box').removeClass('checked');
    $checked = $('.sticker-checkbox:checked');
    $checked.parents('.sticker-box').addClass('checked');
    return pudu.getLocalStorage(function(items) {
      var i, id, _i, _ref, _results;
      _results = [];
      for (i = _i = _ref = items.selectedStickers.length; _ref <= 0 ? _i <= 0 : _i >= 0; i = _ref <= 0 ? ++_i : --_i) {
        id = items.selectedStickers[i];
        _results.push($stickers.prepend($("#" + id).parent()));
      }
      return _results;
    });
  };

  saveSelectedStickers = function() {
    var c, selectedStickers;
    selectedStickers = (function() {
      var _i, _len, _ref, _results;
      _ref = $('.sticker-checkbox:checked');
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        c = _ref[_i];
        _results.push($(c).data('id'));
      }
      return _results;
    })();
    pudu.setLocalStorage({
      selectedStickers: selectedStickers
    });
    return setSelectedStickerEffect();
  };

  i = 1;

  for (id in stickers) {
    imgs = stickers[id];
    if (id !== 'sticker5') {
      $stickers.append("<li>        <div id='" + id + "' data-name='" + pudu.stickersName[id] + "' class='thumbnail sticker-box'>          <img class='sticker-image' data-id='" + id + "' src='" + (pudu.stickerButton(id)) + "' title='Click to preview' />          <center><small>" + pudu.stickersName[id] + "</small></center>          <div class='sticker-checkbox-wrap'>            <input class='sticker-checkbox' type='checkbox' data-id='" + id + "' name='select' />          </div>        </div>      </li>");
    }
  }

  pudu.getLocalStorage(function(items) {
    var _i, _len, _ref;
    _ref = items.selectedStickers;
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      id = _ref[_i];
      $("#" + id + " .sticker-checkbox").attr('checked', true);
    }
    return setSelectedStickerEffect();
  });

  $('#pudu-stickers-filter').on('keyup', function() {
    var q;
    q = $(this).val().trim().toLowerCase();
    return $('.sticker-box:not(.checked)').each(function() {
      if ($(this).data('name').toLowerCase().indexOf(q) === -1) {
        return $(this).parent().hide();
      } else {
        return $(this).parent().show();
      }
    });
  });

  $('body').on('click', '.sticker-checkbox', function() {
    return saveSelectedStickers();
  });

  $('body').on('click', '.sticker-image', function() {
    var img;
    id = $(this).data('id');
    imgs = stickers[id];
    $stickerModal.find('.btn-success').data('id', id);
    $stickerModal.find('h3').html("<img src='" + (pudu.stickerButton(id)) + "' /> " + pudu.stickersName[id]);
    $stickerModal.find('.thumbnails').empty().html(((function() {
      var _i, _len, _results;
      _results = [];
      for (_i = 0, _len = imgs.length; _i < _len; _i++) {
        img = imgs[_i];
        _results.push("<li><img class='thumbnail' src='" + (pudu.stickerKey(id, img)) + "' width='75' /></li>");
      }
      return _results;
    })()).join(''));
    return $stickerModal.modal('show');
  });

  $stickerModal.on('shown', function() {
    return $('.modal-body', this).scrollTop(0);
  });

  $stickerModal.find('.btn-success').on('click', function() {
    id = $(this).data('id');
    $("#" + id + " .sticker-checkbox").attr('checked', true);
    saveSelectedStickers();
    return $stickerModal.modal('hide');
  });

}).call(this);

/*
//@ sourceMappingURL=options.map
*/

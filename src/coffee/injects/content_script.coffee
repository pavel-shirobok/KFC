chrome.extension.sendMessage {isRequestMagnet : true, url : location.href, search : location.search }

chrome.extension.onMessage.addListener (request)->
  onHash(request.hash) is request.isHash

TABLE_PATCH = '
<div class="justify">
  <div class="kfc_magnet_button" style="margin-bottom: 3px">
    <div class="kfc_magnet_button_icon"></div>
    <div class="kfc_magnet_button_label">Скопировать magnet-ссылку</div>
  </div>
</div>
'

onHash = (hash)->
  tablePatch = $( TABLE_PATCH )

  tablePatch
    .prependTo '.mn1_content'
    .find '.kfc_magnet_button'
    .on 'click', ()->
      chrome.extension.sendMessage {isCopyToClipboard : true, text : 'magnet:?xt=urn:btih:' + hash}
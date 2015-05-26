chrome.extension.sendMessage {isRequestMagnet : true, url : location.href, search : location.search }

chrome.extension.onMessage.addListener (request)->
  onHash(request.hash) is request.isHash

TABLE_PATCH = '
  <tr>
    <td style="width: 210px;" class="nw"><button style="margin-top:5px">Download</button></td>
    <td><p style="margin-top:5px">Нажми и в буффер обмена скопируется магнет ссылка для скачивания этого торрента</p></td>
  </tr>
'

onHash = (hash)->
  tablePatch = $( TABLE_PATCH )

  tablePatch
    .appendTo 'table.w100p:first>tbody'
    .find 'button'
    .on 'click', ()->
      chrome.extension.sendMessage {isCopyToClipboard : true, text : 'magnet:?xt=urn:btih:' + hash}
$ "<textarea type='text' id='copyBuffer'></textarea>"
  .appendTo document.body

chrome.runtime.onMessage.addListener (request, sender, response)->
  onRequestMagnet(request, sender) if request.isRequestMagnet
  onCopyToClipboard(request.text) if request.isCopyToClipboard
  #TODO


onRequestMagnet = (request, sender)->
  torrent_id = getParameterByName(request.search, 'id');
  $
    .get('http://kinozal.tv/get_srv_details.php?action=2&id='+torrent_id)
    .then (html)->
      html = $ html
      pre_element = html.find 'li:first'
      pre_code = pre_element.text()
      code_regex = /[A-Z0-9]{10,100}/g
      code = code_regex.exec(pre_code)[0]
      chrome.tabs.sendMessage sender.tab.id, { isHash:true, hash:code }

onCopyToClipboard = (text)->
  $ 'textarea'
    .val text;
  document
    .getElementById "copyBuffer"
    .select();
  document
    .execCommand "Copy", false, null
  showNotify text

notifyID = 0;
showNotify  = (text)->
  notifyID++;
  chrome.notifications.create notifyID + '', {
    type    : 'basic'
    title   : 'Скопирована magnet-ссылка'
    iconUrl : chrome.extension.getURL('img/icon512.png'),
    message : text
  }

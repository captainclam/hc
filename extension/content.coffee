console.log 'HC Extension: Content Script Starting'

chrome.runtime.onMessage.addListener (msg, sender, sendResponse) ->
  if msg?.text is 'report_back'
    sendResponse document.all[0].outerHTML

console.log 'HC Extension: Content Script Starting'

chrome.runtime.onMessage.addListener (msg, sender, sendResponse) ->
  if msg?.text is 'report_back'
    sendResponse document.all[0].outerHTML

    banner = $ '<div id="hc-extension-banner">'
    banner.text 'Saved to HipCharts'
    banner.click -> banner.slideUp() #.promise().then -> banner.remove()
    $('body').prepend banner
    banner.slideDown()

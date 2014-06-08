console.log 'HC Extension: Content Script Starting'

list = JSON.parse(localStorage.getItem('hc-list'))
list ?= []

banner = $ '<div class="hc-banner">'
banner.append '<ul></ul>'

for item in list
  banner.find('ul').append "<li>#{item}</li>"

# banner.text 'Saved to HipCharts'
$('body').prepend banner

chrome.runtime.onMessage.addListener (msg, sender, sendResponse) ->
  if msg?.text is 'report_back'
    sendResponse document.all[0].outerHTML
    banner.click ->
      console.log document.title
      # todo: localStorage
      banner.removeClass 'hc-banner--active'

    list.push document.title
    localStorage.setItem('hc-list', JSON.stringify(list))

    banner.find('ul').append "<li>#{document.title}</li>"
    banner.addClass 'hc-banner--active'

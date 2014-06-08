console.log 'HC Extension: Content Script Starting'

list = JSON.parse(localStorage.getItem('hc-list'))
list ?= []

banner = $ '<div class="hc-banner">'
addIcon = $ '<i class="fa fa-plus" id="add-item">+</i>'
banner.append addIcon
banner.append '<ul></ul>'

addIcon.click ->
  banner.toggleClass 'hc-banner--active'
  banner.find('ul').append "<li>#{document.title}</li>"
  list.push document.title
  localStorage.setItem('hc-list', JSON.stringify(list))

for item in list
  banner.find('ul').append "<li>#{item}</li>"

# banner.text 'Saved to HipCharts'
$('body').prepend banner

chrome.runtime.onMessage.addListener (msg, sender, sendResponse) ->
  if msg?.text is 'report_back'
    sendResponse document.all[0].outerHTML

    banner.toggle()
    $('html').toggleClass('hc-on')
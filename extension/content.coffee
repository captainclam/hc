console.log 'HC Extension: Content Script Starting'

list = JSON.parse(localStorage.getItem('hc-list'))
list ?= []

# reset if bad old values
if list[0] and !list[0].title
  list = []

banner = $ '<div class="hc-banner">'
addIcon = $ '<i class="fa fa-plus" id="add-item">+</i>'
banner.append addIcon
banner.append '<ul></ul>'

isOn = -> JSON.parse(localStorage.getItem('hc-on'))
  
toggle = (hc_on) ->
  banner.toggle(hc_on)
  $('html').toggleClass 'hc-on', hc_on
  localStorage.setItem('hc-on', JSON.stringify(hc_on))

toggle isOn() or false

appendItem = (item) ->
  {title, href} = item
  banner.find('ul').append "<li><a href='#{href}'>#{title}</a></li>"

addIcon.click ->
  banner.toggleClass 'hc-banner--active'
  item = {title: document.title, href: window.location.href}
  appendItem item
  # save
  list.push item
  localStorage.setItem('hc-list', JSON.stringify(list))

for item in list
  appendItem item

# banner.text 'Saved to HipCharts'
$('body').prepend banner

chrome.runtime.onMessage.addListener (msg, sender, sendResponse) ->
  if msg?.text is 'report_back'
    sendResponse document.all[0].outerHTML

    toggle !isOn()

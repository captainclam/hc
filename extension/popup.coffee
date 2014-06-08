dom = null

list = JSON.parse(localStorage.getItem('hc-list'))
list ?= []

# reset if bad old values
if list[0] and !list[0].title
  list = []

appendItem = (item) ->
  {title, href} = item
  dom.find('ul.list').append "<li><a href='#{href}'>#{title}</a></li>"

$ ->
  dom = $ '#hipcharts'
  
  for item in list
    appendItem item

  $('button').click (e) ->
    e.preventDefault()
    $(this).html 'LOL'
    item = {title: document.title, href: window.location.href}
    # item = title:'hello', href: 'google'
    appendItem item
    # save
    list.push item
    localStorage.setItem('hc-list', JSON.stringify(list))


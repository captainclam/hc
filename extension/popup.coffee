dom = null

list = JSON.parse(localStorage.getItem('hc-list'))
list ?= []

# reset if bad old values
if list[0] and (!list[0].title or !list[0].label)
  list = []

saveItem = (item) ->
  list.push item
  saveList()
  dom.find('.label-title').html item.label
  dom.find('ul.item-list').empty()
  for item in _.where list, {label: item.label}
    appendItem item

saveList = ->
  localStorage.setItem('hc-list', JSON.stringify(list))

appendItem = (item) ->
  {title, href} = item
  dom.find('ul.item-list').append "<li><a href='#{href}'>#{title}</a></li>"

$ ->
  dom = $ '#hipcharts'

  labels = _.uniq _.pluck list, 'label'
  _.each labels, (label) ->
    li = $ "<li>#{label}</li>"
    li.click -> saveItem title:'hello', href: 'google', label: label
    $('ul.label-list').append li
  
  $('button.create-list').click (e) ->
    e.preventDefault()
    input = $('input.list-title')
    label = input.val()
    saveItem title:'hello', href: 'google', label: label
    input.val('').focus()

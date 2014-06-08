dom = null

list = JSON.parse(localStorage.getItem('hc-list'))
list ?= []

# reset if bad old values
if list[0] and (!list[0].title or !list[0].label)
  list = []

saveItem = (item) ->
  list.push item
  saveList()
  module 'list'
  dom.find('.label-title .value').html item.label
  dom.find('ul.item-list').empty()
  for item in _.where(list, {label: item.label}).slice(0,5)
    appendItem item

saveList = ->
  localStorage.setItem('hc-list', JSON.stringify(list))

appendItem = (item) ->
  {title, href} = item
  dom.find('ul.item-list').append "<li><a href='#{href}'>#{title}</a></li>"

$ ->
  dom = $ '#hipcharts'

  href = null
  title = null
  chrome.tabs.getSelected null, (tab) ->
    # console.log tab
    href = tab.url
    title = tab.title

  labels = _.uniq _.pluck list, 'label'
  _.each labels, (label) ->
    li = $ "<li class='hc-chart'>#{label}</li>"
    li.click -> saveItem {title, href, label}
    $('ul.label-list').append li
  
  $('button.create-list').click (e) ->
    e.preventDefault()
    input = $('input.list-title')
    label = input.val()
    return unless label
    saveItem {title, href, label}
    input.val('').focus()

  $('.hipcharts__back').click (e) ->
    e.preventDefault()
    module 'add'

module = (id) ->
  $('.hc-module').hide()
  $('#hc-'+id).show()


dom = null

# temp oops global scope bad huh
href = null
title = null

list = JSON.parse(localStorage.getItem('hc-list'))
list ?= []

# reset if bad old values
if list[0] and (!list[0].title or !list[0].label)
  list = []

saveItem = (item) ->
  list.unshift item # tack it on the start (recency)
  saveList()
  module 'list'
  appendItems item.label

viewList = (label) ->
  appendItems label
  module 'list'

appendItems = (label) ->
  dom.find('.label-title .value').html label
  dom.find('ul.item-list').empty()
  for item in _.where(list, {label}).slice(0,5)
    appendItem item

saveList = ->
  localStorage.setItem('hc-list', JSON.stringify(list))

appendItem = (item) ->
  {title, href} = item
  li = $ "<li class='hc-item'><a href='#{href}' target='_blank'>#{title}</a> <i class='hc-remove'>x</i></li>"
  li.find('.hc-remove').click (e) ->
    e.stopPropagation()
    e.stopImmediatePropagation()
    e.preventDefault()
    list = _.reject list, (obj) -> obj is item
    saveList()
    li.remove()
  dom.find('ul.item-list').append li

printLabels = ->
  $('ul.label-list').empty()
  labels = _.uniq _.pluck list, 'label'
  _.each labels.slice(0,5), (label) ->
    li = $ "<li class='hc-chart'><a>#{label}</a> <span>(preview)</span></li>"
    li.find('a').click -> saveItem {title, href, label}
    li.find('span').click -> viewList label
    $('ul.label-list').append li

$ ->
  dom = $ '#hipcharts'

  chrome.tabs.getSelected null, (tab) ->
    # console.log tab
    href = tab.url
    title = tab.title

  printLabels()
  
  $('button.create-list').click (e) ->
    e.preventDefault()
    input = $('input.list-title')
    label = input.val()
    return unless label
    saveItem {title, href, label}
    input.val('').focus()
    printLabels()

  $('.hipcharts__back').click (e) ->
    e.preventDefault()
    module 'add'

module = (id) ->
  $('.hc-module').hide()
  $('#hc-'+id).show()


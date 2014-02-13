class FinderView
  constructor: (model) ->
    @model = model
    @dom = $ '.results__list' # '<div class="results">'

  render: =>
    @dom.empty()
    for entry in @model then do (entry) =>
      # console.log entry.title
      console.log entry
      li = $ ss.tmpl['chart-result'].render entry
      $(".item__thumb img").load ->
        $(this).css "opacity", "1"
      li.click ->
        $('.finder__input').focus()
        $('.finder__input').val('')
        if collectionView.model.length is 5
          return
        collectionView.add entry
        $(this).addClass('item--selected')
      # else
      #   alert('Full chart')

      @dom.append li
    return @dom

responseHandler = (res) ->
  $('.spinner').hide()
  $('.finder__clear').show()
  chart = []
  albums = res.results?.albummatches?.album?.slice? 0, 10
  albums ?= []
  for album in albums
    chart.push
      title: album.name
      subtitle: album.artist
      image: album.image[3]?['#text']  # todo find?
  finderView.model = chart
  finderView.render()

keyUpHandler = ->
  $('.finder__clear').addClass('fa-times')
  term = input.val()
  $('#query').html(term)
  unless term.length > 2
    finderView.dom.empty()
    return
  data.album = term
  $.ajax(
    url: url
    cache: false
    data: data
  ).done responseHandler


url = 'http://ws.audioscrobbler.com/2.0/'
data =
  method: 'album.search'
  api_key: '08b9be8ca570eb793277e9f88cc5ad14'
  format: 'json'

input = $ '.finder__input'
input.keyup _.debounce keyUpHandler, 400

window.finderView = new FinderView []


# todo: put this some place better
# todo: not repeat code from suggestions

printSuggestions = (suggestions) ->
  for suggestion in suggestions then do (suggestion) ->
    el = $ ss.tmpl['chart-suggestion'].render suggestion
    el.click ->
      if $(".item--selected").length <= 4
        collectionView.add suggestion
        $(this).addClass('item--selected')
      else
        return
      if $(".item--selected").length == 5
        $('.app').addClass('app--publish')
    $('#suggestions-list').append el

$('.finder__clear').click ->
  $(this).hide()
  $('.results__list').html('')
  $('.finder__input').focus()
  $('.finder__input').val('')
  $('.spinner').show()
  if window.lastFmUsername
    window.getSuggestions()
  else
    window.printSuggestions _.shuffle window.defaultSuggestions

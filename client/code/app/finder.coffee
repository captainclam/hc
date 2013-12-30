class FinderView
  constructor: (model) ->
    @model = model
    @dom = $ '.results__list' # '<div class="results">'

  render: =>
    @dom.empty()
    @dom[0].classList.add('results__list--active')
    for entry in @model then do (entry) =>
      # console.log entry.title
      console.log entry
      li = $ ss.tmpl['chart-result'].render entry
      li.click ->
        collectionView.add entry
        $(this).addClass('item--selected')
      # else
      #   alert('Full chart')

      @dom.append li
    return @dom

responseHandler = (res) ->
  $('.spinner').hide()
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
  $('.spinner').show()
  $('.app')[0].classList.add('app--searching')
  $('.finder__clear').show()
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

input = $ '#finder .header input'
input.keyup _.debounce keyUpHandler, 400

window.finderView = new FinderView []


# todo: put this some place better

$('.finder__clear').click ->
  # @dom.empty()
  # @dom.html('')
  $('.app').removeClass('app--searching')
  $('.results__list').html('')
  $(this).hide()
  $('.finder__input').focus()
  $('.finder__input').val('')
  $('.search').removeClass('search--active')

$('.header__action').click ->
  $('.finder').hide()


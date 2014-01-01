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
  $('.tip').removeClass('tip--show')
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
  printSuggestions [
    {title:"Watching Movies with the Sound Off (Deluxe Edition)", subtitle:"Mac Miller", image:"http://userserve-ak.last.fm/serve/300x300/91010329.png"}
    {title: "Acid Rap", subtitle: "Chance the Rapper", image: "http://userserve-ak.last.fm/serve/300x300/93294971.png"}
    {title:"Old", subtitle:"Danny Brown", image:"http://userserve-ak.last.fm/serve/300x300/94257157.jpg"}
    {title:"Retrograde", subtitle:"James Blake", image:"http://userserve-ak.last.fm/serve/300x300/88442075.png"}
    {title:"Doris", subtitle:"Earl Sweatshirt", image:"http://userserve-ak.last.fm/serve/300x300/91706171.png"}
    {title:"Born Sinner", subtitle:"J. Cole", image:"http://userserve-ak.last.fm/serve/300x300/92364469.png"}
    {title:"Wolf", subtitle:"Tyler, the Creator", image:"http://userserve-ak.last.fm/serve/300x300/88141265.png"}
    {title:"Stranger Than Fiction", subtitle:"Kevin Gates", image:"http://userserve-ak.last.fm/serve/300x300/91531681.png"}
    {title:"Kismet", subtitle:"Mr. Muthafuckin' eXquire", image:"http://userserve-ak.last.fm/serve/300x300/90212407.jpg"}
    {title:"LONG.LIVE.A$AP (Deluxe Version)", subtitle:"A$AP Rocky", image:"http://userserve-ak.last.fm/serve/300x300/88031365.png"}
    {title:"Kiss Land", subtitle:"The Weeknd", image:"http://userserve-ak.last.fm/serve/300x300/91697657.png"}
    {title:"No Poison No Paradise", subtitle:"Black Milk", image:"http://userserve-ak.last.fm/serve/300x300/93986839.jpg"}
    {title:"Indigioism", subtitle:"The Underachievers", image:"http://userserve-ak.last.fm/serve/300x300/91205035.png"}
    {title:"Twelve Reasons To Die", subtitle:"Ghostface Killah", image:"http://userserve-ak.last.fm/serve/300x300/93647957.jpg"}
    {title:"My Name Is My Name", subtitle:"Pusha T", image:"http://userserve-ak.last.fm/serve/300x300/92761901.png"}
    {title:"Yeezus", subtitle:"Kanye West", image:"http://userserve-ak.last.fm/serve/300x300/91826975.png"}
    {title:"Nothing Was the Same", subtitle:"Drake", image:"http://userserve-ak.last.fm/serve/300x300/92541381.png"}
    {title:"Doris", subtitle:"Earl Sweatshirt", image:"http://userserve-ak.last.fm/serve/300x300/91706171.png"}
    {title:"Run The Jewels", subtitle:"Run the Jewels", image:"http://userserve-ak.last.fm/serve/300x300/90507813.png"}
    {title:"The Gifted", subtitle:"Wale", image:"http://userserve-ak.last.fm/serve/300x300/90875377.png"}
    {title:"Something Else", subtitle:"Tech N9ne", image:"http://userserve-ak.last.fm/serve/300x300/95439353.png"}
    {title:"Because The Internet", subtitle:"Childish Gambino", image:"http://userserve-ak.last.fm/serve/300x300/95152407.png"}
  ]

$('.header__action').click (e) ->
  e.preventDefault()
  $(this).hide()
  $('.finder').hide()


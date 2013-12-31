printSuggestions = (suggestions) ->
  for suggestion in suggestions then do (suggestion) ->
    el = $ ss.tmpl['chart-suggestion'].render suggestion
    el.click ->
      if collectionView.model.length is 5
        return
      $(this).addClass('item--selected')
      collectionView.add suggestion
    $('#suggestions-list').append el

# todo: refactor this into a data layer. see finder
url = 'http://ws.audioscrobbler.com/2.0/'
data =
  method: 'user.gettopalbums'
  limit: 36
  api_key: '08b9be8ca570eb793277e9f88cc5ad14'
  format: 'json'
  user: 'jaseflow'

getSuggestions = (username) ->
  data.user = username
  $.ajax(
    url: url
    cache: false
    data: data
  ).done (res) ->
    albums = res.topalbums?.album?.slice? 0, 100
    albums ?= []
    suggestions = []
    for album in albums
      suggestions.push
        title: album.name
        subtitle: album.artist.name
        image: album.image[3]?['#text']  # todo find?
    Nav.go 'suggestions'
    printSuggestions suggestions
    $('.finder').show()


lastFmForm = $('#last-fm-form')
lastFmForm.submit (e) ->
  $('.app').addClass('app--landing')
  e.preventDefault()
  username = lastFmForm.find('#last-fm-username').val()
  getSuggestions username

$('#get-default-suggestions').click ->
  $('.app').removeClass('app--landing')
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
  $('.finder').show()
  $('.tip').addClass('tip--show')

$('.tip__hide').click ->
  $(this).parents('.tip').removeClass('tip--show')

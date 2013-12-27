printSuggestions = (suggestions) ->
  for suggestion in suggestions then do (suggestion) ->
    el = $ ss.tmpl['chart-suggestion'].render suggestion
    el.click ->
      collectionView.add suggestion
      $(this).addClass('item--selected')
      if $(".item--selected").length >= 5
        $('.app').addClass('app--publish')
    $('#suggestions').append el

# todo: refactor this into a data layer. see finder
url = 'http://ws.audioscrobbler.com/2.0/'
data =
  method: 'user.gettopalbums'
  limit: 12
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
    printSuggestions suggestions
    $('.alert--lastFM').fadeOut()


lastFmForm = $('#last-fm-form')
lastFmForm.submit (e) ->
  e.preventDefault()
  username = lastFmForm.find('#last-fm-username').val()
  getSuggestions username


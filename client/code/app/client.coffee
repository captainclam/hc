# Client Code

console.log('App Loaded')

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

class CollectionView
  constructor: (model) ->
    @model = model
    @dom = $ '#collection .list'

  add: (item) =>
    @model.push item
    @render()

  render: =>
    @dom.empty()
    for entry in @model then do (entry) =>
      li = $ ss.tmpl['chart-entry'].render entry
      @dom.append li
    return @dom

window.login = ({username, password}) ->
  ss.rpc 'app.authenticate', username, password, ({success, message}) ->
    console.log 'login response', success, message
    if success
      Nav.go 'app'
    # window.location.reload()

register = ({email, username, password, chart}) ->
  ss.rpc 'app.register', {email, username, password, chart} , (res) ->
    console.log res
    if res is "ERROR: username is taken"
      $(".register__alert").text "Username taken dickhead"
      $(".register__alert")[0].classList.add('register__alert--error')
      $(".register")[0].classList.add('register--alert')
    if res is 'OK'
      login
        username: $(this).find('input#username').val()
        password: $(this).find('input#password').val()
      $('.register__window').html('You good bro, you logged in')
    
logout = ->
  ss.rpc 'app.logout', ->
    window.location.reload()

# lastfm key: 556717aa07990447a306688c12b23e2b

window.Nav =
  go: (module) ->
    $('.module').hide()
    $('.module#'+module).show()

Nav.go 'app'

window.finderView = new FinderView []
window.collectionView = new CollectionView []

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

url = 'http://ws.audioscrobbler.com/2.0/'
data =
  method: 'album.search'
  api_key: '08b9be8ca570eb793277e9f88cc5ad14'
  format: 'json'
input = $ '#finder .header input'
input.keyup _.debounce ->
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
, 400

# key "a", ->
#   alert "you pressed a!"

$('form#login').submit (e) ->
  e.preventDefault()
  login
    username: $(this).find('input#username').val()
    password: $(this).find('input#password').val()

$('form#register').submit (e) ->
  e.preventDefault()
  register
    email: $(this).find('input#email').val()
    username: $(this).find('input#username').val()
    password: $(this).find('input#password').val()
    chart: collectionView.model

$('a.logout').click logout
$('a.go').click -> Nav.go $(this).attr('href').replace('#','')

# Better way to do all this shit
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
  $('.alert--register').show()

window.publicProfile = ->
  username = window.location.pathname.substring(1)
  return unless username
  ss.rpc 'app.getCollection', {username}, ({success, user, message}) ->
    if success
      collectionView.model = user.chart
      collectionView.render()
      # alert 'yay! #1' + user.chart[0].title
    else
      alert 'boo! ' + message

setTimeout publicProfile, 10

suggestions = require '/suggestions'
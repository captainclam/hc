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
      li.click =>
      # if $(".collection li").length >= 4
      #   $('.app')[0].classList.add('app--publish')
      # if $(".collection li").length < 5
        @dom.empty()
        @dom.html('')
        $('.finder__clear').hide()
        $('.finder__input').val('')
        collectionView.add entry
        $('.app').removeClass('app--searching')
        $('.app').addClass('app--collection')
        $(".entry__thumb").load ->
          src = $(this).attr("src")
          # console.log(src)
          $(this).parent(".entry__wrap").css "background-image", 'url(' + src + ')'
          $(this).attr('src','')
        $('.entry__remove').click ->
          $(this).parents('.entry').remove()
          $('.finder__input').focus()
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

url = 'http://ws.audioscrobbler.com/2.0/'
data =
  method: 'album.search'
  api_key: '08b9be8ca570eb793277e9f88cc5ad14'
  format: 'json'
input = $ '#finder .header input'
input.keyup _.throttle ->
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
  ).done (res) ->
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
, 400

# $('.suggestion').click ->
#   $('.app').addClass('app--collection')
#   $(this).addClass('suggestion--selected')
#   $(this).find('.suggestion__add')[0].classList.add('fa-check-circle')

# key "a", ->
#   alert "you pressed a!"

# Better way to do all this shit
$('.finder__clear').click ->
  $('.app').removeClass('app--searching')
  $('.results__list').html('')
  $(this).hide()
  $('.finder__input').focus()
  $('.finder__input').val('')
  $('.search').removeClass('search--active')

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

window.publicProfile = ->
  username = window.location.pathname.substring(1)
  return unless username
  ss.rpc 'app.getCollection', {username}, ({success, user, message}) ->
    if success
      $('.suggestions').html('')
      $('.suggestions').hide()
      collectionView.model = user.chart
      collectionView.render()
      # alert 'yay! #1' + user.chart[0].title
    else
      alert 'boo! ' + message

setTimeout publicProfile, 10

suggestions = require '/suggestions'
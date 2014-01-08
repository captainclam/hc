
window.login = ({email, password, user}) ->
  ss.rpc 'app.authenticate', email, password, ({success, message, user}) ->
    console.log 'login response', success, message
    if success
      $('.login-link').hide()
      $('.logout-link').show()
      $('.app').removeClass('app--login')
      collectionView.model = user.chart
      collectionView.render()
      Nav.go 'collection'

register = ({email, username, password, chart}) ->
  ss.rpc 'app.register', {email, username, password, chart} , (res) ->
    console.log res
    if res is 'OK'
      window.currentUser = {email, username, password, chart}
      login
        email: $(this).find('input#email').val()
        password: $(this).find('input#password').val()
      $('.login-link').show()
      $('.logout-link').show()
    
logout = ->
  ss.rpc 'app.logout', ->
    Nav.go 'lastfm'
    window.location.reload()

$('#login-form').submit (e) ->
  e.preventDefault()
  login
    email: $(this).find('input#email').val()
    password: $(this).find('input#password').val()

$('#register-form').submit (e) ->
  e.preventDefault()
  register
    email: $(this).find('input#email').val()
    username: $(this).find('input#username').val()
    password: $(this).find('input#password').val()
    chart: collectionView.model

$('.logout-link').click logout

$('.login-link').click ->
  $('.app').addClass('app--login')
  $('#username')
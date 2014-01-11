window.loginSuccess = (user) ->
  # $('.app').addClass('app--auth')
  # $('.app').removeClass('app--login')
  # $('.login-link').hide()
  # $('.logout-link').show()
  # collectionView.model = user.chart
  # collectionView.render()
  # Nav.go 'collection'
  # $('.finder').hide()
  # $('.footer').hide()
  window.location = '/' + user.username

window.checkUsername = (username, cb) ->
  ss.rpc 'auth.checkUsername', username, cb

window.login = ({email, password, user}) ->
  ss.rpc 'auth.login', {email, password}, ({success, message, user}) ->
    console.log 'login response', success, message
    if success
      loginSuccess(user)

register = ({email, username, password, chart}) ->
  ss.rpc 'auth.register', {email, username, password, chart} , (res) ->
    if res.success
      window.currentUser = {email, username, password, chart}
      loginSuccess(currentUser)
    else
      console.log ({email, username, password, chart})
      $('.register__alert').show()
      $('.register__alert').html(res.message)
    
logout = ->
  ss.rpc 'auth.logout', ->
    window.location = '/'

$('#login-form').submit (e) ->
  e.preventDefault()
  login
    email: $(this).find('input#email').val()
    password: $(this).find('input#password').val()
  Nav.go 'collection'

$('#register-form').submit (e) ->
  e.preventDefault()
  register
    email: $(this).find('input#email').val()
    username: $(this).find('input#username').val()
    password: $(this).find('input#password').val()
    chart: collectionView.model

$('.logout-link').click logout

$('.register #username').keyup _.debounce (e) ->
  username = @value
  checkUsername username, (exists) ->
    # console.log 'checkUsername', username, exists
    $('.register__check').toggleClass 'register__check--error', exists
, 500

$(".login-link").click ->
  $('.app').toggleClass "app--login"
  $('.login #email').focus()


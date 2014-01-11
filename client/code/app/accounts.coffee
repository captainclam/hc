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
  ss.rpc 'app.checkUsername', username, cb

window.login = ({email, password}) ->
  ss.rpc 'app.authenticate', email, password, ({success, message, user}) ->
    console.log 'login response', success, message
    if success
      loginSuccess(user)

register = ({email, username, password, chart}) ->
  ss.rpc 'app.register', {email, username, password, chart} , (res) ->
    if res.success
      window.currentUser = {email, username, password, chart}
      loginSuccess(currentUser)
    else
      $('.register__alert').show()
      $('.register__alert').html(res.message)
    
logout = ->
  ss.rpc 'app.logout', ->
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

# Nav.go 'register'

ss.rpc 'app.getCurrentUser', (user) ->
  if user
    publicProfile(user.username)
  # else
  #   Nav.go 'lastfm'

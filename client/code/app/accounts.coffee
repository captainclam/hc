window.checkUsername = (username, cb) ->
  ss.rpc 'auth.checkUsername', username, cb

window.login = ({email, password, user}) ->
  ss.rpc 'auth.login', {email, password}, ({success, message, user}) ->
    console.log 'login response', success, message
    if success
      $('.login-link').hide()
      $('.logout-link').show()
      $('.app').removeClass('app--login')
      collectionView.model = user.chart
      collectionView.render()
      Nav.go 'collection'

register = ({email, username, password, chart}) ->
  ss.rpc 'auth.register', {email, username, password, chart} , (res) ->
    if res.success
      window.currentUser = {email, username, password, chart}
      login
        email: $(this).find('input#email').val()
        password: $(this).find('input#password').val()
      $('.login-link').hide()
      $('.logout-link').show()
    else
      $('.register__alert').show()
      $('.register__alert').html(res.message)
    
logout = ->
  ss.rpc 'auth.logout', ->
    Nav.go 'lastfm'
    window.location.reload()

$('#login-form').submit (e) ->
  e.preventDefault()
  login
    username: $(this).find('input#username').val()
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

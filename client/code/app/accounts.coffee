window.checkUsername = (username) ->
  ss.rpc 'app.checkUsername', username, (exists) ->
    console.log username, exists

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
  ss.rpc 'app.logout', ->
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

Nav.go ('register')

# $('.register #username').keyup _.debounce (e) ->
#   v = $(e.target).value
#   checkUsername v, (exists) ->
#     console.log 'ayyyyy', v, exists
# , 500
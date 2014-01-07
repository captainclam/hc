
window.login = ({username, password}) ->
  ss.rpc 'app.authenticate', username, password, ({success, message}) ->
    console.log 'login response', success, message

register = ({email, username, password, chart}) ->
  ss.rpc 'app.register', {email, username, password, chart} , (res) ->
    console.log res
    if res is 'OK'
      window.currentUser = {email, username, password, chart}
      login
        username: $(this).find('input#username').val()
        password: $(this).find('input#password').val()
      $('.header__action').hide()
      $('.logout').show()
      $('.register__window').html('<div class="success"><h2 class="success__title">Chart successfully created!</h2><div class="success__message"><p>People can now see your charts at</p></div><div class="success__address">www.hipcharts.com/' + currentUser.username + '</div><a href="/' + currentUser.username + '" class="button button--blue success__action">View your charts</a></div>')
    
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

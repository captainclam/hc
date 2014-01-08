
window.login = ({email, password, user}) ->
  ss.rpc 'app.authenticate', email, password, ({success, message}) ->
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
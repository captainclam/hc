
window.login = ({username, password}) ->
  ss.rpc 'app.authenticate', username, password, ({success, message}) ->
    console.log 'login response', success, message
    if success
      Nav.go 'app'

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
      $('.register__window').html('<div class="success"><h3 class="success__title">Chart successfully created!</h3><div class="success__message"><p>People can now see your charts at</p></div><div class="success__address">www.hipcharts.com/jaseflow</div><a href="#" class="button button--blue success__action">View your charts</a></div>')
    
logout = ->
  ss.rpc 'app.logout', ->
    window.location.reload()

$('#login').submit (e) ->
  e.preventDefault()
  login
    username: $(this).find('input#username').val()
    password: $(this).find('input#password').val()

$('#register-form').submit (e) ->
  e.preventDefault()
  register
    email: $(this).find('input#email').val()
    username: $(this).find('input#username').val()
    password: $(this).find('input#password').val()
    chart: collectionView.model

$('a.logout').click logout

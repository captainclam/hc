window.publicProfile = (username) ->
  username ?= window.location.pathname.substring(1)
  return unless username
  ss.rpc 'app.getCollection', {username}, ({success, user, message}) ->
    if success
      $('.controls').show()
      $('.app').addClass('app--auth')
      $('.app').removeClass('app--login')
      $('.login-link').hide()
      $('.logout-link').show()
      collectionView.model = user.chart
      collectionView.render()
      Nav.go 'collection'
      $('.finder').hide()
      $('.footer').hide()
      $('.app').addClass('app--start')
      $('.header__action').hide()
      collectionView.model = user.chart
      collectionView.render()
      Nav.go 'collection'
      # alert 'yay! #1' + user.chart[0].title
    else
      alert 'boo! ' + message

setTimeout publicProfile, 10

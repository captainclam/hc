require '/nav'
require '/accounts'
require '/finder'
require '/collectionView'
require '/publicProfile'
require '/suggestions'
require '/lastFm'

# bootstrap
ss.rpc 'auth.getCurrentUser', (user) ->
  if username = window.location.pathname.substring(1)
    # viewing someone elses profile?
    publicProfile username
  else if user
    # logged in, show own profile
    publicProfile user.username
  else
    # not logged in, default to lastfm suggestion module
    Nav.go 'landing'

$('.show-options').click ->
  $('.header').addClass('header--visible')
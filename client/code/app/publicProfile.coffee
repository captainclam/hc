activeEntry = 1
collectionPos = 0

setBackground = ->
  activeImg = $(".entry:nth-child(" + activeEntry + ")").find('.entry__thumb').css('background-image')
  $('.app').css('background-image', activeImg)
  activeEntry++

# slideCollection = (el) ->
#   $('.entries').css('-webkit-transform','translateX(' + collectionPos +')')
#   if($(this).attr('href') is 'next')
#     collectionPos + 100
#   else if($(this).attr('href') is 'prev')
#     collectionPos - 100

window.publicProfile = (username) ->
  username ?= window.location.pathname.substring(1)
  return unless username
  ss.rpc 'auth.getCollection', {username}, ({success, user, message}) ->
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
      setBackground()
      # alert 'yay! #1' + user.chart[0].title
    else
      console.warn 'publicProfile fail ' + message

$('.chart-toggle').click (e) ->
  collectionInc = 50

  $('.chart-toggle.button--inactive').removeClass('button--inactive')
  if($(this).attr('href') == '#next')
    collectionPos = collectionPos - collectionInc
  else if($(this).attr('href') is '#prev')
    collectionPos = collectionPos + collectionInc
  $('.entries').css('-webkit-transform','translateX(' + collectionPos + '%)')
  setBackground()

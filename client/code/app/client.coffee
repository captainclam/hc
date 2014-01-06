
require '/nav'
require '/accounts'
require '/finder'
require '/collectionView'
require '/publicProfile'
require '/suggestions'

slideCount = 0

ss.rpc 'app.getCurrentUser', (user) -> if user then $('.logout').show()

$(".next-slide").click ->
  slideCount++
  $(".slides__slider").addClass "slides__slider--" + slideCount
  if $(this).attr("id") is "yes"
    $('.lastfm').addClass('lastfm--visible')

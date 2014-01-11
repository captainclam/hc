
require '/nav'
# Nav.go 'splash'
require '/accounts'
require '/finder'
require '/collectionView'
require '/publicProfile'
require '/suggestions'

slideCount = 0

$(".next-slide").click ->
  slideCount++
  $(".slides__slider").addClass "slides__slider--" + slideCount
  if $(this).attr("id") is "yes"
    setTimeout (->
      $('#last-fm-username').focus()
    ), 100
    $('.lastfm').addClass('lastfm--visible')

$(".login-link").click ->
  $('.app').toggleClass "app--login"
  $('.login #email').focus()
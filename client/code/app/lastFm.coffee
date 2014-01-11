slideCount = 0

$(".next-slide").click ->
  slideCount++
  $(".slides__slider").addClass "slides__slider--" + slideCount
  if $(this).attr("id") is "yes"
    setTimeout (->
      $('#last-fm-username').focus()
    ), 100
    $('.lastfm').addClass('lastfm--visible')

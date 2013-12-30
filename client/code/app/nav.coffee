window.Nav =
  go: (module) ->
    $('.module').hide()
    $('.module#'+module).show()

$('a.go').click -> Nav.go $(this).attr('href').replace('#','')

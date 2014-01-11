window.Nav =
  go: (module) ->
    $('.module--active').removeClass 'module--active'
    $('.module#'+module).addClass 'module--active'

$('a.go').click -> Nav.go $(this).attr('href').replace('#','')

window.Nav =
  go: (module) ->
    $('.module').hide()
    $('.module#'+module).show()

Nav.go 'app'
$('a.go').click -> Nav.go $(this).attr('href').replace('#','')

require '/accounts'

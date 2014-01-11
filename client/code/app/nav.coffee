window.Nav =
  go: (module) ->
    $('.module--active').removeClass 'module--active'
    $('.module#'+module).addClass 'module--active'
    # History.pushState {location:module}, 'Hipcharts : ' + module, '/' + module

# History.Adapter.bind window, 'statechange', =>
#   Nav.go History.getState().data

$('a.go').click -> Nav.go $(this).attr('href').replace('#','')

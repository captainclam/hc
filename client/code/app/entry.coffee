# This file automatically gets called first by SocketStream and must always exist

# Make 'ss' available to all modules and the browser console
window.ss = require('socketstream')

ss.server.on 'disconnect', ->
  console.log('Connection down :-(')

ss.server.on 'reconnect', ->
  console.log('Connection back up :-)')

ss.server.on 'ready', ->

  # Wait for the DOM to finish loading
  jQuery ->
    
    # Load app
    require('/app')

    # Better way to do all this shit
    $('.finder__clear').click ->
      @dom.empty()
      @dom.html('')
      $('.app').removeClass('app--searching')
      $('.results__list').html('')
      $(this).hide()
      $('.finder__input').focus()
      $('.finder__input').val('')
      $('.search').removeClass('search--active')

    $('.header__action').click ->
      $('.alert--register').show()

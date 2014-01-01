
require '/nav'
require '/accounts'
require '/finder'
require '/collectionView'
require '/publicProfile'
require '/suggestions'

ss.rpc 'app.getCurrentUser', (user) -> if user then $('.logout').show()

$('.next-slide').click ->
  $('.slides__slider')[0].classList.add('slides__slider--1')
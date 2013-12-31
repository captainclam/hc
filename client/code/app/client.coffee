require '/nav'
require '/accounts'
require '/finder'
require '/collectionView'
require '/publicProfile'
require '/suggestions'

Nav.go 'lastfm'

ss.rpc 'app.getCurrentUser', (user) -> if user then $('.logout').show()
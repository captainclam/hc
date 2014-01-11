window.publicProfile = ->
	username = window.location.pathname.substring(1)
	return unless username
	ss.rpc 'auth.getCollection', {username}, ({success, user, message}) ->
		if success
			$('.app').addClass('app--start')
			$('.header__action').hide()
			collectionView.model = user.chart
			collectionView.render()
			Nav.go 'collection'
			# alert 'yay! #1' + user.chart[0].title
		else
			alert 'boo! ' + message

setTimeout publicProfile, 10

window.publicProfile = ->
	username = window.location.pathname.substring(1)
	return unless username
	ss.rpc 'app.getCollection', {username}, ({success, user, message}) ->
		if success
			collectionView.model = user.chart
			console.log user.chart
			collectionView.render()
			# alert 'yay! #1' + user.chart[0].title
		else
			alert 'boo! ' + message

setTimeout publicProfile, 10

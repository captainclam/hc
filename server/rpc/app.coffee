User = require '../models/user'

exports.actions = (req, res, ss) ->

  req.use('session')

  authenticate: (username, password) ->
    unless username and password
      res success: false, message: 'Both Username and Password are required'
    User.findOne {username, password}, (err, user) ->      
      if err
        res success: false, message: err
      if user
        req.session.setUserId user._id
        res success: true
      else
        res success: false, message: 'Invalid Username/Password'

  logout: ->
    req.session.setUserId null
    res 'Logged Out'

  getCurrentUser: ->
    User.findOne {_id: req.session.userId}, (err, user) ->
      throw err if err
      res user

  register: (details) ->
    validEmail = /^[^\s@]+@[^\s,;@]+$/g
    if details and validEmail.test details.email
      User.findOne {username: details.username}, (err, existingUser) ->
        if existingUser?
          console.log 'ERROR: username is taken'
          res 'ERROR: username is taken'
        else
          console.log 'OK'
          user = new User details
          user.save (err) ->
            throw err if err
            res 'OK'
    else
      console.log 'ERROR: no user supplied'
      res 'ERROR: no user supplied'

  updateProfile: ->
    User.findOne {_id: req.session.userId}, (err, user) ->
      throw err if err
      for param in params
        console.log 'user', param.name, ' = ', param.value
        user[param.name] = param.value
      user.save (err) ->
        throw err if err
        res 'OK'

  listCollection: (username) ->
    User.findOne {username}, (err, user) ->
      throw err if err
      games = []
      unless user?.games?
        return res false
      for id in user.games
        game = _.findWhere gameCache, {id}
        games.push game if game?
      res games

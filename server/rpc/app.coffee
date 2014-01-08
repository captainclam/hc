User = require '../models/user'

exports.actions = (req, res, ss) ->

  req.use('session')

  authenticate: (email, password) ->
    unless email and password
      res success: false, message: 'Both email and password are required'
    User.findOne {email, password}, (err, user) ->      
      if err
        res success: false, message: err
      if user
        req.session.setUserId user._id
        res success: true, user: user
      else
        res success: false, message: 'Invalid Email/Password'

  logout: ->
    req.session.setUserId null
    res 'Logged Out'

  getCurrentUser: ->
    User.findOne {_id: req.session.userId}, (err, user) ->
      throw err if err
      res user

  getCollection: (details) ->
    User.findOne {username: details.username}, (err, user) ->
      if user?
        res
          success: true
          user: user
      else
        res
          success: false
          message: 'User not found'

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

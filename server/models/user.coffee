mongoose = require 'mongoose'
mongoose.connect 'mongodb://localhost/hipcharts'
module.exports = mongoose.model 'User',
  name: String
  username: String
  password: String
  games: Array

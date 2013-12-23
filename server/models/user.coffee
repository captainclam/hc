# mongoose = require 'mongoose'
# mongoose.connect 'mongodb://localhost/hipcharts'
# module.exports = mongoose.model 'User',
#   name: String
#   username: String
#   password: String
#   chart: Array

ss = require 'socketstream'
mongoose = require 'mongoose'

if process.env.SUBDOMAIN
  url = 'mongodb://nodejitsu:381bc3c074ae32c696fe2f2674a60578@alex.mongohq.com:10031/nodejitsudb642965969'
else
  url = 'mongodb://localhost/hipcharts'
mongoose.connect url
module.exports = mongoose.model 'User',
  name: String
  username: String
  password: String
  chart: Array
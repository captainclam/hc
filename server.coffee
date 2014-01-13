# My SocketStream 0.3 app
http = require 'http'
ss = require 'socketstream'

# hello, mongo
global.mongoose = require 'mongoose'
if process.env.SUBDOMAIN
  url = 'mongodb://nodejitsu:381bc3c074ae32c696fe2f2674a60578@alex.mongohq.com:10031/nodejitsudb642965969'
else
  url = 'mongodb://localhost/hipcharts'
mongoose.connect url

# jitsu/local port
port = 1337
url = 'http://localhost:' + port + '/'
if process.env.SUBDOMAIN
  port = 8080
  url = 'http://' + process.env.SUBDOMAIN + '.jit.su/'

# Define a single-page client called 'main'
ss.client.define 'main',
  view: 'app.jade'
  css: ['app.styl']
  code: ['libs/jquery.min.js', 'libs/underscore.min.js', 'libs/fastclick.js', 'libs/history.js', 'libs/keymaster.js', 'libs/masonry.js', 'app']
  tmpl: '*'

# Serve this client on the root URL
ss.http.route '/', (req, res) ->
  res.serveClient 'main'

# Code Formatters
ss.client.formatters.add require 'ss-coffee'
ss.client.formatters.add require 'ss-jade'
ss.client.formatters.add require 'ss-stylus'

# Use server-side compiled Hogan (Mustache) templates. Others engines available
ss.client.templateEngine.use require 'ss-hogan'

# Minimize and pack assets if you type: SS_ENV=production node app.js
if ss.env is 'production'
  ss.client.packAssets()

# Start web server
server = http.Server ss.http.middleware
server.listen port

# Start SocketStream
ss.start server

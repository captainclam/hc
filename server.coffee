# My SocketStream 0.3 app
http = require 'http'
ss = require 'socketstream'

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
  code: ['libs/jquery.min.js', 'libs/underscore.min.js', 'libs/fastclick.js', 'libs/keymaster.js', 'libs/masonry.js', 'app']
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

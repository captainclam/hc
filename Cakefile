{spawn, exec} = require 'child_process'

task 'go', 'Run the server', ->
  server = spawn 'coffee', ['server.coffee']
  server.stdout.on 'data', (data) -> console.warn data.toString()
  server.stderr.on 'data', (err) -> console.warn err.toString()

task 'dev', 'Run the server with nodemon', ->
  server = spawn 'nodemon', ['server.coffee']
  server.stdout.on 'data', (data) -> console.warn data.toString()
  server.stderr.on 'data', (err) -> console.warn err.toString()

module.exports = (grunt) ->
  
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    coffee:
      compile:
        files:
          'popup.js': 'popup.coffee'
          'content.js': 'content.coffee'
          'bg.js': 'bg.coffee'

    stylus:
      compile:
        # options:
        #   compress: !DEBUG
        files:
          'extension.css': 'styles/main.styl'
          'popup.css': 'styles/popup.styl'

    # jade:
    #   compile:
    #     options:
    #       data:
    #         DEBUG: DEBUG
    #     files:
    #       'www/index.html': ['lib/index.jade']

    watch:
      stylus:
        files: ['styles/*.styl']
        tasks: ['stylus']
      coffee:
        files: ['*.coffee']
        tasks: ['coffee']
      # jade:
      #   files: ['lib/*.jade', 'lib/templates/*.jade']
      #   tasks: ['jade']
      livereload:
        options:
          livereload: true
        files: [
          'www/css/main.css'
          'www/index.html'  # todo: having this forces full reload on style change :(
          'www/js/app.js'
        ]
  
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-stylus'
  grunt.loadNpmTasks 'grunt-contrib-jade'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  # grunt.loadNpmTasks 'grunt-autoprefixer'
  
  # grunt.registerTask 'default', ['coffee', 'stylus', 'jade', 'autoprefixer', 'uglify']
  grunt.registerTask 'default', ['coffee', 'stylus']
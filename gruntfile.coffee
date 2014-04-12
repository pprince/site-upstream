
module.exports = (grunt) ->

  grunt.initConfig


    env: process.env

    pkg: grunt.file.readJSON('package.json')

    siteconfig: grunt.file.readJSON('site/config.json')


    clean:
      dev:
        src: ['BUILD/development/']
      prod:
        src: ['BUILD/production/']
      build:
        src: ['BUILD/']
      cache:
        src: ['.cache/']
      dist:
        src: ['htdocs/*']
        options:
          force: true


    jekyll:
      options:
        bundleExec: true
        src: 'site/jekyll'
        dest: 'BUILD/development/jekyll'
        raw: 'encoding: UTF-8\n' +
          'name: <%= siteconfig.site_name %>\n' +
          'gems:\n' +
          '    - jekyll-pandoc-multiple-formats\n' +
          'highlighter: none\n' +
          'markdown: pandoc\n' +
          'pandoc:\n' +
          '    skip: "true"\n' +
          '    output: "tmp"\n' +
          '    flags: "--smart"\n' +
          '    site_flags: "--toc"\n' +
          '    outputs:\n' +
          '        pdf:\n' +
          '        epub:\n' +
          'permalink: pretty'
      dev:
        options:
          drafts: true
          future: true
      watchdev:
        options:
          drafts: true
          future: true
          watch: true
      prod:
        options:
          drafts: false
          future: false
          dest: 'BUILD/production/jekyll'
      watchprod:
        options:
          drafts: false
          future: false
          watch: true
          dest: 'BUILD/production/jekyll'
      lint:
        options:
          doctor: true


    compass:
      options:
        cacheDir:       '.cache/compass'
        sassDir:        'site/stylesheets'
        imagesDir:      'site/images'
        fontsDir:       'site/fonts'
        javascriptsDir: 'site/javascript'
        httpPath:       '/'
        httpFontsPath:  '/fonts'
        importPath: [
          'lib/sass'
          'lib/bower/sass/garnish'
        ]
        relativeAssets: false
        bundleExec: true
        require: [
          #"compass/import-once/activate"
          "sass-globbing"
          "breakpoint"
          "susy"
          "sassy-buttons"
          "sassy_noise"
          "bluesy-noise"
        ] ## Note: This list should be sync'd with the list of gems to install (i.e., the Gemfile.)
      dev:
        options:
          environment: 'development'
          cssDir: 'BUILD/development/compass/css'
          outputStyle: 'nested'
      watchdev:
        options:
          environment: 'development'
          cssDir: 'BUILD/development/compass/css'
          outputStyle: 'nested'
          watch: true
      prod:
        options:
          environment: 'production'
          cssDir: 'BUILD/production/compass/css'
          outputStyle: 'compressed'
      watchprod:
        options:
          environment: 'production'
          cssDir: 'BUILD/production/compass/css'
          outputStyle: 'compressed'
          watch: true
      compile: {}


    prettify:
      options:
        condense: true
        indent: 4
        indent_inner_html: false
        indent_scripts: 'normal'
      dev:
        expand: true
        cwd: 'BUILD/development/jekyll'
        src: ['**/*.html']
        dest: 'BUILD/development/prettyhtml'
      prod:
        expand: true
        cwd: 'BUILD/production/jekyll'
        src: ['**/*.html']
        dest: 'BUILD/production/prettyhtml'


    browserify:
      options:
        transform: ['coffeeify']
        debug: false
      libs:
        src: []
        dest: 'BUILD/js/libs-bundle.js'
        options:
          shim:
            jquery:
              path: 'lib/bower/js/jquery/jquery.js'
              exports: '$'
            'jquery.starscroll':
              path: 'lib/js/starscroll/starscroll.js'
              exports: null
              depends:
                jquery: 'jQuery'
      dev:
        src: ['site/js/*.{js,coffee}']
        dest: 'BUILD/development/js/main-bundle.js'
        options:
          transform: ['coffeeify']
          external: ['jquery', 'jquery.starscroll']
          debug: true
          
      prod:
        src: '<%= browserify.dev.src %>'
        dest: 'BUILD/production/js/main-bundle.js'
        options:
          transform: ['coffeeify', ['uglifyify', {global: true}]]
          external: '<%= browserify.dev.options.external %>'
          alias: '<%= browserify.dev.options.alias %>'

    concat:
      options:
        separator: ';\n'
      dev:
        src: ['<%= browserify.libs.dest %>', '<%= browserify.dev.dest %>']
        dest: 'BUILD/development/OUTPUT/js/bundle.js' 
      prod:
        src: ['<%= browserify.libs.dest %>', '<%= browserify.prod.dest %>']
        dest: 'BUILD/production/OUTPUT/js/bundle.js' 


    bowercopy:
      iconfonts:
        files:
          'site/fonts': [
            'etlinefont-bower/fonts/et-line.{eot,svg,ttf,woff}'
            'icomoon/fonts/icomoon.{eot,svg,ttf,woff}'
          ]
      jslibs:
        files:
          'lib/bower/js/jquery': [
            'jquery/dist/jquery.js'
            'jquery/dist/jquery.min.js'
          ]
      garnish:
        files:
          'lib/bower/sass/garnish/': [
            'garnish/src/garnish.scss'
            'garnish/src/{helpers,layout,style,typography}'
          ]


    copy:
      options:
        mode: '644'
        nonull: true
      dev:
        files: [
          {
            cwd: 'site'
            src: ['images/**/*.{png,gif,jpg,jpeg}', 'fonts/**/*.{woff,svg,eot,ttf,otf}']
            dest: 'BUILD/development/OUTPUT'
            expand: true
          },
          {
            cwd: 'BUILD/development/compass'
            src: '**'
            dest: 'BUILD/development/OUTPUT'
            expand: true
          },
          {
            cwd: 'BUILD/development/jekyll'
            src: '**'
            dest: 'BUILD/development/OUTPUT'
            expand: true
          },
          {
            cwd: 'BUILD/development/prettyhtml'
            src: '**'
            dest: 'BUILD/development/OUTPUT'
            expand: true
          },
        ]
      prod:
        files: [
          {
            cwd: 'site'
            src: ['images/**/*.{png,gif,jpg,jpeg}', 'fonts/**/*.{woff,svg,eot,ttf,otf}']
            dest: 'BUILD/production/OUTPUT'
            expand: true
          },
          {
            cwd: 'BUILD/production/compass'
            src: '**'
            dest: 'BUILD/production/OUTPUT'
            expand: true
          },
          {
            cwd: 'BUILD/production/jekyll'
            src: '**'
            dest: 'BUILD/production/OUTPUT'
            expand: true
          },
          {
            cwd: 'BUILD/production/prettyhtml'
            src: '**'
            dest: 'BUILD/production/OUTPUT'
            expand: true
          },
        ]
      dist:
        files: [
          {
            cwd: 'BUILD/production/OUTPUT'
            src: ['**']
            dest: 'htdocs'
            expand: true
          },
        ]
  
    chmod:
      options:
        mode: '755'
      dist:
        filter: 'isDirectory'
        src: ['htdocs/**', 'htdocs/']
        expand: true
   
    concurrent:
      options:
        limit: 6
        logConcurrentOutput: true
      watchdev: ['watch', 'compass:watchdev', 'jekyll:watchdev']
      watchprod: ['watch', 'compass:watchprod', 'jekyll:watchprod']

    newer:
      options:
        cache: '.cache/grunt-newer'

    watch:
      options: {}
      concat_dev:
        files: [
          '<%= browserify.libs.dest %>'
          '<%= browserify.dev.dest %>'
        ]
        tasks: ['concat:dev']
      concat_prod:
        files: [
          '<%= browserify.libs.dest %>'
          '<%= browserify.prod.dest %>'
        ]
        tasks: ['concat:prod']
      browserify_dev:
        files: '<%= browserify.dev.src %>'
        tasks: ['browserify:dev']
      browserify_prod:
        files: '<%= browserify.prod.src %>'
        tasks: ['browserify:prod']
      grunt:
        files: ['gruntfile.coffee']
      prettify_dev:
        files: ['BUILD/development/jekyll/**/*.html']
        tasks: ['newer:prettify:dev']
      prettify_prod:
        files: ['BUILD/production/jekyll/**/*.html']
        tasks: ['newer:prettify:prod']
      copy_dev:
        files: ['BUILD/development/compass/**/*', 'BUILD/development/jekyll/**/*', 'BUILD/development/prettyhtml']
        tasks: ['newer:copy:dev']
      copy_prod:
        files: ['BUILD/production/compass/**/*', 'BUILD/production/jekyll/**/*', 'BUILD/production/prettyhtml']
        tasks: ['newer:copy:prod']
      lr_dev:
        files: ['BUILD/development/OUTPUT/**/*']
        tasks: ['notify:reload']
        options:
          livereload: 4040
      lr_prod:
        files: ['BUILD/production/OUTPUT/**/*']
        tasks: ['notify:reload']
        options:
          livereload: 4040

    connect:
      options:
        hostname: '*' # listen on all interfaces, not just 127.0.0.1
        port: 4000
        livereload: 4040
      dev:
        options:
          base: 'BUILD/development/OUTPUT'
       prod:
        options:
          base: 'BUILD/production/OUTPUT'

    notify:
      reload:
        options:
          title: "Build Complete"
          message: "Site reloaded."


    jsonlint:
      all:
        src: ['*.json', 'site/**/*.json']

    coffeelint:
      gruntfile: ['gruntfile.coffee']
      options:
        indentation:                { level: 'warn' }
        max_line_length:            { level: 'warn' }
        no_trailing_whitespace:     { level: 'warn' }

    jshint:
      options:
        reporter: require('jshint-stylish')
      dev: ['site/js/**/*.js']

    cssmetrics:
      dev:
        src: ['BUILD/development/OUTPUT/**/*.css']
      prod:
        src: ['BUILD/production/OUTPUT/**/*.css']



  # Load plugins that provide tasks.
  require('load-grunt-tasks')(grunt)

  # Keep track of and report how long each task takes to run.
  require('time-grunt')(grunt)


  # Tasks You Can Call
  # ==================

  # Build
  # ---------------------
  grunt.registerTask 'build:dev', [
    'jekyll:dev'
    'compass:dev'
    'prettify:dev'
    'copy:dev'
    'browserify:libs'
    'browserify:dev'
    'concat:dev'
  ]
  grunt.registerTask 'build:prod', [
    'jekyll:prod'
    'compass:prod'
    'prettify:prod'
    'copy:prod'
    'browserify:libs'
    'browserify:prod'
    'concat:prod'
  ]
  grunt.registerTask 'build', ['build:dev', 'build:prod']

  # Test
  # -------------------------------------------
  grunt.registerTask 'run:dev', [
    'connect:dev'
    'concurrent:watchdev'
  ]
  grunt.registerTask 'run:prod', [
    'connect:prod'
    'concurrent:watchprod'
  ]
  grunt.registerTask 'run', ['run:dev']

  # Deploy: Copy Production Build to htdocs/
  # ----------------------------------------
  grunt.registerTask 'dist', ['clean:dist', 'copy:dist', 'chmod:dist']

  # Automatically Complain About (and Analyse) Your Code:
  # -----------------------------------------------------
  grunt.registerTask 'lint', ['jsonlint', 'coffeelint', 'jekyll:lint', 'cssmetrics']
 
  # Task 'all'; mainly for debugging this Gruntfile
  # -----------------------------------------------
  grunt.registerTask 'all', ['clean', 'build', 'lint', 'dist', 'run']

  # Default Task, Or:  What Happens When You Just Run `grunt`?
  # ----------------------------------------------------------
  grunt.registerTask 'prod', ['build:prod', 'run:prod']
  grunt.registerTask 'dev', ['build:dev', 'run:dev']
  grunt.registerTask 'default', ['dev']

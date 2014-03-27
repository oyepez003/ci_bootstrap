
module.exports = (grunt) ->
  
  # Package
  # =======
  pkg = require './package.json'

  # Variables
  # =======
  dir_app = 'applications/'
  dir_js = 'assets/js/'
  dir_css = 'assets/css/'
  dir_sass = 'assets/styles/'
  dir_img = 'assets/images/'
  dir_bower = 'bower_components/'


  # Configuration
  # =============
  grunt.initConfig

    # Package
    # -------
    pkg: pkg

    # Clean
    # --------------------
    clean: [
      "assets/dist/**"
    ]

    # Copy
    # --------------------
    copy:
      # fonts:fonts
      fonts:
        files: [
          expand: true
          cwd: dir_bower
          src: [
            'bootstrap/dist/fonts/**'
            'font-awesome/fonts/**'
          ]
          dest: "assets/dist/fonts/"
          flatten: true
          filter: 'isFile'
        ]

    # Minify - scripts
    # --------------------
    uglify:
      # uglify:frontend
      frontend:
        files:
          "assets/dist/app.min.js" : [
            # bower files
            dir_bower + 'jquery/dist/jquery.min.js',
            dir_bower + 'bootstrap/dist/js/bootstrap.min.js',
            # custom files
            #dir_js + 'base.js'
          ]
      # uglify:backend
      backend:
        files:
          "assets/dist/backend.min.js" : [
            # bower files
            dir_bower + 'jquery/dist/jquery.min.js',
            dir_bower + 'bootstrap/dist/js/bootstrap.min.js',
            # custom files
            #dir_js + 'backend.js'
          ]

    # Minify - css
    # --------------------
    cssmin:
      # cssmin:frontend
      frontend:
        files: 
          'assets/dist/app.min.css': [
            # bower files
            dir_bower + 'bootstrap/dist/css/bootstrap.min.css'
            dir_bower + 'font-awesome/css/font-awesome.min.css'
            # custom files
            #dir_css + 'base.css'
          ]
      # cssmin:backend
      backend:
        files: 
          'assets/dist/backend.min.css': [
            # bower files
            dir_bower + 'bootstrap/dist/css/bootstrap.min.css'
            dir_bower + 'font-awesome/css/font-awesome.min.css'
            # custom files
            #dir_css + 'backend.css'
          ]

    # Optimize images
    # --------------------
    imagemin:
      # imagemin:frontend
      frontend:
        options:
          optimizationLevel: 3
          progressive: true
        files: [
          expand: true
          cwd: dir_img
          src: ['**/*.{png,jpg,gif}']
          dest: 'assets/dist/images/'
        ]

    # Watch
    # --------------------
    watch: 

      # options
      options:
        livereload: true
        spawn: false
        debounceDelay: 250

      # watch:scripts
      scripts:
        files: [dir_js + '*.js']
        tasks: ['uglify']

      # watch:css
      css:
        files: [dir_css + '*.css']
        tasks: ['cssmin']

      # watch:images
      images: 
        files: [dir_img + '**/*.{png,jpg,gif}', dir_img + '*.{png,jpg,gif}']
        tasks: ['imagemin']

      # watch:other
      other:
        files: [dir_app + '**/*.{html,php}']
        tasks: []

  # Dependencies
  # ============
  for name of pkg.devDependencies when name.substring(0, 6) is 'grunt-'
    grunt.loadNpmTasks name

  # Build only
  # -------
  grunt.registerTask 'build', [
    'clean'
    'copy'
    'uglify'
    'cssmin'
    'imagemin'
  ]

  # Default
  # -------
  grunt.registerTask 'default', [
    'build'
    'watch'
  ]
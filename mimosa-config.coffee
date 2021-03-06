# this coffeescript file generates a json object which configures the entirety of mimosa operation
# the below values are the only things changed from default -- comments describing the behavior
# of all fields and the default settings are located in mimosa-config-documented.coffee

exports.config =

  minMimosaVersion: "2.1.17"

  # we use these mimosa modules
  modules: ['bower',
            'jshint',
            'csslint',
            'minify-js',
            'minify-css',
            'server',
            'live-reload',
            'testem-simple',
            'client-jade-static',
            'jade',
            'stylus',
            'emblem',
            'ember-handlebars',
            'copy',
            'coffeescript']

  # limit file watcher to 100 simultaneously open file handlers at a time -- since the files are
  # processed asynchronously, without this option file processing could otherwise open all the
  # files at essentially the same time on startup and could hit the os's file handle limit
  watch:
    throttle: 100

  # enable coffeescript with sourcemap support and compile all coffeescript files with the
  # default function wrapper (mimosa default is bare:true because that is best if you are
  # using requirejs -- this project does not use requirejs however)
  coffeescript:
    bare: false

  # Provide specific versions of emblem (and a specific version of handlebars that emblem should use)
  emblem:
    helpers: ["app/handlebars-helpers"]
    lib: require('emblem')
    handlebars: require('handlebars')

  emberHandlebars:
    helper: ["app/handlebars-helpers"]

  # don't wrap generated templates in amd modules, output ember compatible pre-compiled tempalates
  # to compiled-handlebars.js and compiled-emblem-js. These files just add the expected template
  # functions to the Ember.TEMPLATES array so that Ember template discovery functions normally
  template:
    wrapType: "none"
    outputFileName:
      emblem: "javascripts/compiled-emblem"
      emberHandlebars: "javascripts/compiled-handlebars"

    # this section will configure the template compiler to precompile any .hbs and .emblem
    # templateswithin the assets/javascripts/templates/ directory with the correct 'name' --
    # so a template at templates/somedir/foo.emblem will map to the ember template 'somedir/foo'
    nameTransform: (path) ->
      m = path.match /templates?\/(.*)$/
      if m?.length and m.length == 2
        return m[1]
      path = path.split '/'
      return path[path.length - 1]


  # configures mimosa bower module to place any bower installed assets in
  # assets/javascripts/vendor/bower_assets/{package_name}/{} or
  # assets/stylesheets/vendor/bower_assets/{package_name}/{}
  # qunit packaging doesn't specify a main option -- we want the package's js and css
  bower:
    copy:
      outRoot: "bower-assets"
      mainOverrides:
        qunit: ["qunit/qunit.js", "qunit/qunit.css"]

        "semantic-ui": [
          "build/packaged": "semantic-ui"
        ]
    bowerDir:
      clean: true
    exclude:
      ["foundation/**.*.js"]
    forceLatest: true

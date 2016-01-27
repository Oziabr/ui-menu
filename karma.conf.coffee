module.exports = (config) ->
  config.set

    basePath: ''

    frameworks: [
      'jasmine'
    ]

    files: [
      'bower_components/jquery/dist/jquery.js'
      'bower_components/lodash/lodash.js'
      'bower_components/angular/angular.js'
      'bower_components/angular-ui-router/release/angular-ui-router.js'
      'bower_components/angular-mocks/angular-mocks.js'
      'dummy.coffee'
      'ui-menu.coffee'
      'ui-menu.spec.coffee'
    ]

    exclude: []

    preprocessors:
      'ui-menu.coffee':      ['coffee-coverage']
      'dummy.coffee':        ['coffee']
      'ui-menu.spec.coffee': ['coffee']

    reporters: [
      'dots'
      'coverage'
    ]

    port: 9876

    colors: true

    logLevel: config.LOG_WARN

    autoWatch: true

    browsers: ['PhantomJS']

    singleRun: true

    coffeeCoverage:
      preprocessor:
        instrumentor: 'istanbul'

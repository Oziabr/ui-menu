angular.module 'ExampleApp', [
  'ng'
  'ngAnimate'
  'ui.bootstrap'
  'ui.router'
  'ui-menu'
]

.run ($log, $rootScope, $state) ->
  $rootScope.$on "$stateChangeError", console.log.bind console
  window.state = $state

.config ($stateProvider, $urlRouterProvider) ->
  $urlRouterProvider.otherwise '/'
  $stateProvider
    .state 'app',
      abstract: true
      resolve:
        programmaticalStateExample: ($state) ->
          # adding state programmatically
          $stateProvider.state 'app.extra', url: '/extra', 'ui-menu': title: 'Extra Nav', icon: 'plus', tag: 'nav', order: 15
          # changing state programmatically
          ($state.get 'app.home')['ui-menu'].title = 'Hause'
          true
      template: '''
        <div class='container'>
          <div class='jumbotron hero hero-unit'>
            <h1>ui-menu demo
              <a href='https://github.com/Oziabr/ui-menu'><i class='pull-right fa fa-github'></i></a>
            </h1>
          </div>
          <div class='row'>
            <div class='col-sm-3 sidenav'>
              <h2>Navigation</h2>
              <hr/>
              <ui-nav-menu></ui-nav-menu>
              <hr/>
            </div>
            <div class='col-sm-9' ui-view=''></div>
          </div>
        </div>
      '''
      controller: ($scope) ->

    .state 'app.examples',
      'ui-menu': tag: 'nav',  icon: 'code', title: 'Usage Examples'
      abstract: true
      url: '/examples'
      template: '''
        <div ui-view=''>
      '''

    .state 'app.tabs',
      'ui-menu': tag: 'nav',  icon: 'gift', title: 'Inner Tabs'
      url: '/tabs'
      template: '''
        <div class='well'><h1>Inner Tabs</h1></div>
        <hr/>
        <ul class="nav nav-tabs" ui-menu='' parent='app.tabs' tag='tab'></ul>
        <div ui-view=''></div>
      '''
    .state 'app.tabs.info',
      'ui-menu': tag: 'tab', icon: 'info',      title: 'Info Tab',     parent: 'app.tabs'
      url: '/info'
    .state 'app.tabs.action',
      'ui-menu': tag: 'tab', icon: 'bicycle',   title: 'Action Tab',   parent: 'app.tabs', default: true
      url: '/action'
    .state 'app.tabs.details',
      'ui-menu': tag: 'tab', icon: 'list',      title: 'Details Tab',  parent: 'app.tabs'
      url: '/details'
      template: '''<h1>Some Content</h1><p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>'''

    .state 'app.nest',
      'ui-menu': tag: 'nav',                     title: 'Nested L0'
      abstract: true
      template: '''<h1>Nested Head L0</h1><div ui-view=''></div>'''
      url: '/l0'
    .state 'app.nest.nest',
      'ui-menu': tag: 'nav',                     title: 'Nested L1',    parent: 'app.nest'
      abstract: true
      template: '''<h2>Nested Head L1</h2><div ui-view=''></div>'''
      url: '/l1'
    .state 'app.nest.nest.nest',
      'ui-menu': tag: 'nav',                     title: 'Nested L2',    parent: 'app.nest.nest'
      abstract: true
      template: '''<h3>Nested Head L2</h3><div ui-view=''></div>'''
      url: '/l2'
    .state 'app.nest.nest.nest.nest',
      'ui-menu': tag: 'nav',                     title: 'Nested L3',    parent: 'app.nest.nest.nest'
      url: '/l3'
      template: '''<h4>Nested Head L3</h4><p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>'''

    .state 'app.examples.coffee',
      'ui-menu': tag: 'nav',  icon: 'coffee',    title: 'CoffeeScript', parent: 'app.examples'
      url: '/coffee'
      template: '''
        <h1>CoffeeScript Example</h1>
        <hr/>
        <p>Comming soon, check the code</p>
      '''
    .state 'app.examples.js',
      'ui-menu': tag: 'nav',  icon: 'file-text', title: 'JavaScript',   parent: 'app.examples'
      url: '/js'
      template: '''
        <h1>JavaScript Example</h1>
        <hr/>
        <p>Comming soon, check the code</p>
      '''
    .state 'app.examples.restrictedShown',
      'ui-menu': tag: 'nav',  icon: 'times',     title: 'Restricted Shown',   parent: 'app.examples'
      url: '/resticted-shown'
      controller: ($state) -> $state.go 'app.home'
    .state 'app.examples.restrictedHidden',
      'ui-menu': tag: 'nav',  icon: 'times',     title: 'Restricted Hidden',  parent: 'app.examples', restricted: true
      url: '/resticted-hidden'

    .state 'app.home',
      'ui-menu': tag: 'nav',  icon: 'home',      title: 'Home',                                   order: 10
      url: '/'
      template: '<h1>Home Page</h1>'

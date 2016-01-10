angular.module 'ExampleApp', [
  'ng'
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
      template: '''
        <div class='container'>
          <div class='jumbotron hero hero-unit'>
            <h1>ui-menu demo</h1>
          </div>
          <div class='row'>
            <div class='col-sm-3 sidenav'>
              <h2>Navigation</h2>
              <hr/>
              <ul class="nav nav-pills nav-stacked" uimenu=''></ul>
              <hr/>
              <ul class="nav nav-pills nav-stacked" uimenu='' parent='app.examples'></ul>
            </div>
            <div class='col-sm-9' ui-view=''></div>
          </div>
        </div>
      '''
      controller: ($scope) ->

    .state 'app.examples',
      'ui-menu':
        title: 'Usage Examples'
        tag: 'nav'
        icon: 'code'
      abstract: true
      url: '/examples'
      template: '''
        <div ui-view=''>
      '''

    .state 'app.tabs',
      'ui-menu':
        title: 'Inner Tabs'
        icon: 'gift'
        tag: 'nav'
      url: '/tabs'
      template: '''
        <div class='well'><h1>Inner Tabs</h1></div>
        <hr/>
        <ul class="nav nav-tabs" uimenu='' parent='app.tabs' tag='tabs'></ul>
        <div ui-view=''></div>
      '''
    .state 'app.tabs.info',
      'ui-menu':
        title: 'Info Tab'
        icon: 'info'
        tag: 'tabs'
        parent: 'app.tabs'
      url: '/info'
    .state 'app.tabs.action',
      'ui-menu':
        title: 'Action Tab'
        tag: 'tabs'
        parent: 'app.tabs'
      url: '/action'
    .state 'app.tabs.details',
      'ui-menu':
        title: 'Details Tab'
        tag: 'tabs'
        parent: 'app.tabs'
      url: '/details'
      template: '''<h1>Some Content</h1><p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>'''

    .state 'app.nested0',
      'ui-menu':
        title: 'Nested L0'
        tag: 'nav'
      abstract: true
      url: '/l0'
    .state 'app.nested1',
      'ui-menu':
        title: 'Nested L1'
        tag: 'nav'
        parent: 'app.nested0'
      abstract: true
      url: '/l1'
    .state 'app.nested2',
      'ui-menu':
        title: 'Nested L2'
        tag: 'nav'
        parent: 'app.nested1'
      abstract: true
      url: '/l2'
    .state 'app.nested3',
      'ui-menu':
        title: 'Nested L3'
        tag: 'nav'
        parent: 'app.nested2'
      url: '/l3'
      template: '''<h1>Some Content</h1><p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>'''



    .state 'app.examples.coffee',
      'ui-menu':
        title: 'CoffeeScript'
        tag: 'nav'
        icon: 'coffee'
        parent: 'app.examples'
      url: '/coffee'
      template: '''
        <h1>CoffeeScript Example</h1>
        <hr/>
        <p>Comming soon, check the code</p>
      '''
    .state 'app.examples.js',
      'ui-menu':
        title: 'JavaScript'
        tag: 'nav'
        icon: 'file-text'
        parent: 'app.examples'
      url: '/js'
      template: '''
        <h1>JavaScript Example</h1>
        <hr/>
        <p>Comming soon, check the code</p>
      '''

    .state 'app.home',
      'ui-menu':
        title: 'Home'
        tag: 'nav'
        icon: 'home'
        order: 10
      url: '/'
      template: '<h1>Home Page</h1>'

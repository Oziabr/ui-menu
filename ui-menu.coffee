angular.module 'ui-menu', [
  'ng'
  'ui.router'
]

.service '$uiMenu', ($state) ->
  menus = []
  defaultNavItem = false
  @get = (tag, parent) ->
    menus[tag] ?= _ $state.get()
      .filter (el) -> el.hasOwnProperty 'ui-menu'
      .map (el) ->
        el['ui-menu'].parent ?= ''
        el['ui-menu'].route = el.name
        el['ui-menu']
      .filter 'tag', tag
      .each (el, x, group) ->
        el.children = _.filter group, parent: el.route
        if el.restricted
          ($state.get el.route).controller = -> $state.go(defaultNavItem); return
      .value()

    result = _ menus[tag]
      .filter 'parent', parent
      .sortBy 'order'
      .value()

    if tag != 'nav' && $state.current.name == parent
       id = _.findIndex result, 'default'
       id = 0 if !~id
       $state.go result[id].route

    defaultNavItem = result[0].route  if !defaultNavItem && tag == 'nav' && !parent && result.length
    result

  return

.directive 'uiMenu', ($uiMenu) ->
  restrict: 'EA'
  scope:
    tag: '@'
    parent: '@'
  template: '''
    <li ui-sref-active='active' ng-repeat='item in menu' ui-menu-item></li>
  '''
  link: (scope, element, attrs) ->
    tag = attrs.tag || 'nav'
    parent = attrs.parent || ''
    scope.menu = $uiMenu.get tag, parent
    return

.directive 'uiMenuItem', ($uiMenu, $compile) ->
  restrict: 'EA'
  # scope:
  #   item: '='
  template: '''
    <a title='{{item.title}}'>
      <i ng-if='item.icon' class='fa fa-lg fa-fw fa-{{item.icon}}'></i>
      <span>{{item.title}}</span>
    </a>
  '''
  # controller: ($scope) ->
  link: (scope, element, attrs) ->
    element.find('a').attr 'ui-sref': scope.item.route
    ($compile element.contents())(scope)


.directive 'uiNavMenu', ($uiMenu) ->
  restrict: 'EA'
  template: '''
    <ul class="nav nav-pills nav-stacked">
      <li ui-sref-active='active' ng-repeat='item in menu' ui-nav-menu-item></li>
    </ul>
  '''
  controller: ($scope) ->
    @.navState = []
    @
  link: (scope) ->
    scope.menu = $uiMenu.get 'nav', ''
    scope.depth = 0
    return

.directive 'uiNavSubMenu', ($uiMenu) ->
  restrict: 'EA'
  scope:
    parent: '='
  template: '''
    <li ui-sref-active='active' ng-repeat='item in menu' ui-nav-menu-item>{{item.title}}</li>
  '''
  link: (scope) ->
    scope.depth = 1 + scope.$parent.$parent.depth
    scope.menu = $uiMenu.get 'nav', scope.parent
    return

.directive 'uiNavMenuItem', ($uiMenu, $compile, $state) ->
  restrict: 'EA'
  require: '^uiNavMenu'
  template: '''
    <a title='{{item.title}}' ng-hide='item.restricted'>
      <i ng-if='item.icon' class='fa fa-lg fa-fw fa-{{item.icon}}'></i>
      <span>{{item.title}}</span>
    </a>
  '''
  controller: ($scope) ->
    $scope.toggle = ->
      depth = $scope.$parent.depth
      route = $scope.item.route
      if $scope.navState[depth] != route
        return $scope.navState[depth] = route
      $scope.navState[depth] = ''
  link: (scope, element, attrs, uiNavMenu) ->
    scope.navState = uiNavMenu.navState
    scope.navState[scope.$parent.depth] = scope.item.route if $state.includes scope.item.route
    if scope.item.children.length
      element.find('a')
        .append '''
          <b class='pull-right'>
            <em class='fa  fa-plus-square-o' ng-if='navState[$parent.depth] != item.route'></em>
            <em class='fa fa-minus-square-o' ng-if='navState[$parent.depth] == item.route'></em>
          </b>'''
        .attr 'ng-click': 'toggle($event.preventDefault())'
        .attr 'ng-class': '{expanded: navState[$parent.depth] == item.route}'
      element.append '''<ul ui-nav-sub-menu class="nav nav-pills nav-stacked"
        uib-collapse='navState[$parent.depth] != item.route' parent='item.route'></ul>'''
    element.find('a').attr 'ui-sref': scope.item.route
    ($compile element.contents())(scope)
    scope.navState = uiNavMenu.navState
    return

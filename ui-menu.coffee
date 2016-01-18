angular.module 'ui-menu', [
  'ng'
  'ui.router'
]

.service '$uiMenu', ($state) ->
  menus = undefined
  @get = (tag, parent) ->
    menus = _ $state.get()
      .filter (el) -> el.hasOwnProperty 'ui-menu'
      .map (el) ->
        el['ui-menu'].parent ?= ''
        el['ui-menu'].route = el.name
        el['ui-menu']
      .filter 'tag', tag
      .each (el, x, group) -> el.children = _.filter group, parent: el.route
      .filter 'parent', parent
      .sortBy 'order'
      .value()
  @find = (name) ->
    _.find menus, route: name
  return

.directive 'uimenu', ($uiMenu) ->
  restrict: 'EA'
  scope:
    tag: '@'
    parent: '@'
  template: '''
    <li ui-sref-active='active' ng-repeat='item in menu' uimenu-item></li>
  '''
  # controller: ($scope) ->
  link: (scope, element, attrs) ->
    tag = attrs.tag || 'nav'
    parent = attrs.parent || ''
    scope.menu = $uiMenu.get tag, parent
    return

.directive 'uimenuItem', ($uiMenu, $compile) ->
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
    if scope.item.children.length && scope.item.tag == 'nav'
      element.find('a').append '''<b class='pull-right'><em class='fa fa-plus-square-o'></em></b>'''
      element.append '''<ul class="nav" uimenu='' parent='{{item.route}}'></ul>'''
    else
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
    @.prop = 'some'
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
    <a title='{{item.title}}'>
      <i ng-if='item.icon' class='fa fa-lg fa-fw fa-{{item.icon}}'></i>
      <span>{{item.title}}</span>
    </a>
  '''
  link: (scope, element, attrs, uiNavMenu) ->
    uiNavMenu.navState[scope.$parent.depth] = scope.item.route if $state.includes scope.item.route
    if scope.item.children.length
      element.find('a')
        .append '''
          <b class='pull-right'>
            <em class='fa fa-plus-square-o' ng-if='navState[$parent.depth] != item.route'></em>
            <em class='fa fa-minus-square-o' ng-if='navState[$parent.depth] == item.route'></em>
          </b>'''
        .attr 'ng-click': 'navState[$parent.depth] = item.route'
      element.append '''<ul ui-nav-sub-menu class="nav nav-pills nav-stacked"
        uib-collapse='navState[$parent.depth] != item.route' parent='item.route'></ul>'''
      element.parent().addClass 'active'
    else
      element.find('a').attr 'ui-sref': scope.item.route
    ($compile element.contents())(scope)
    scope.navState = uiNavMenu.navState
    # console.log element.parent()  if scope.item.route == $state.current.name
    return

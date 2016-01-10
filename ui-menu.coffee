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

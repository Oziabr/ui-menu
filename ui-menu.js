// Generated by CoffeeScript 1.10.0
angular.module('ui-menu', ['ng', 'ui.router']).service('$uiMenu', function($state) {
  var defaultNavItem, menus;
  menus = [];
  defaultNavItem = false;
  this.get = function(tag, parent) {
    var id, result;
    if (menus[tag] == null) {
      menus[tag] = _($state.get()).filter(function(el) {
        return el.hasOwnProperty('ui-menu');
      }).map(function(el) {
        var base;
        if ((base = el['ui-menu']).parent == null) {
          base.parent = '';
        }
        el['ui-menu'].route = el.name;
        return el['ui-menu'];
      }).filter('tag', tag).each(function(el, x, group) {
        el.children = _.filter(group, {
          parent: el.route
        });
        if (el.restricted) {
          return ($state.get(el.route)).controller = function() {
            $state.go(defaultNavItem);
          };
        }
      }).value();
    }
    result = _(menus[tag]).filter('parent', parent).sortBy('order').value();
    if (tag !== 'nav' && $state.current.name === parent) {
      id = _.findIndex(result, 'default');
      if (!~id) {
        id = 0;
      }
      $state.go(result[id].route);
    }
    if (!defaultNavItem && tag === 'nav' && !parent && result.length) {
      defaultNavItem = result[0].route;
    }
    return result;
  };
}).directive('uiMenu', function($uiMenu) {
  return {
    restrict: 'EA',
    scope: {
      tag: '@',
      parent: '@'
    },
    template: '<li ui-sref-active=\'active\' ng-repeat=\'item in menu\' ui-menu-item></li>',
    link: function(scope, element, attrs) {
      var parent, tag;
      tag = attrs.tag || 'nav';
      parent = attrs.parent || '';
      scope.menu = $uiMenu.get(tag, parent);
    }
  };
}).directive('uiMenuItem', function($uiMenu, $compile) {
  return {
    restrict: 'EA',
    template: '<a title=\'{{item.title}}\'>\n  <i ng-if=\'item.icon\' class=\'fa fa-lg fa-fw fa-{{item.icon}}\'></i>\n  <span>{{item.title}}</span>\n</a>',
    link: function(scope, element, attrs) {
      element.find('a').attr({
        'ui-sref': scope.item.route
      });
      return ($compile(element.contents()))(scope);
    }
  };
}).directive('uiNavMenu', function($uiMenu) {
  return {
    restrict: 'EA',
    template: '<ul class="nav nav-pills nav-stacked">\n  <li ui-sref-active=\'active\' ng-repeat=\'item in menu\' ui-nav-menu-item></li>\n</ul>',
    controller: function($scope) {
      this.navState = [];
      return this;
    },
    link: function(scope) {
      scope.menu = $uiMenu.get('nav', '');
      scope.depth = 0;
    }
  };
}).directive('uiNavSubMenu', function($uiMenu) {
  return {
    restrict: 'EA',
    scope: {
      parent: '='
    },
    template: '<li ui-sref-active=\'active\' ng-repeat=\'item in menu\' ui-nav-menu-item>{{item.title}}</li>',
    link: function(scope) {
      scope.depth = 1 + scope.$parent.$parent.depth;
      scope.menu = $uiMenu.get('nav', scope.parent);
    }
  };
}).directive('uiNavMenuItem', function($uiMenu, $compile, $state) {
  return {
    restrict: 'EA',
    require: '^uiNavMenu',
    template: '<a title=\'{{item.title}}\' ng-hide=\'item.restricted\'>\n  <i ng-if=\'item.icon\' class=\'fa fa-lg fa-fw fa-{{item.icon}}\'></i>\n  <span>{{item.title}}</span>\n</a>',
    controller: function($scope) {
      return $scope.toggle = function() {
        var depth, route;
        depth = $scope.$parent.depth;
        route = $scope.item.route;
        if ($scope.navState[depth] !== route) {
          return $scope.navState[depth] = route;
        }
        return $scope.navState[depth] = '';
      };
    },
    link: function(scope, element, attrs, uiNavMenu) {
      scope.navState = uiNavMenu.navState;
      if ($state.includes(scope.item.route)) {
        scope.navState[scope.$parent.depth] = scope.item.route;
      }
      if (scope.item.children.length) {
        element.find('a').append('<b class=\'pull-right\'>\n  <em class=\'fa  fa-plus-square-o\' ng-if=\'navState[$parent.depth] != item.route\'></em>\n  <em class=\'fa fa-minus-square-o\' ng-if=\'navState[$parent.depth] == item.route\'></em>\n</b>').attr({
          'ng-click': 'toggle($event.preventDefault())'
        }).attr({
          'ng-class': '{expanded: navState[$parent.depth] == item.route}'
        });
        element.append('<ul ui-nav-sub-menu class="nav nav-pills nav-stacked"\nuib-collapse=\'navState[$parent.depth] != item.route\' parent=\'item.route\'></ul>');
      }
      element.find('a').attr({
        'ui-sref': scope.item.route
      });
      ($compile(element.contents()))(scope);
      scope.navState = uiNavMenu.navState;
    }
  };
});

//# sourceMappingURL=ui-menu.js.map

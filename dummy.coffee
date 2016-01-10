loadStates = (states, stateProvider) ->
  for state of states
    stateProvider.state state, states[state]
  return

uiTreeMenuStates =
  'node1':          abstract: true,  url: '/node1',   'ui-menu': {title: 'node 1',          tag: 'nav'}
  'node1.child1':                    url: '/child1',  'ui-menu': {title: 'node 1 Child 1',  tag: 'nav', parent: 'node1'}
  'node1.child2':                    url: '/child2',  'ui-menu': {title: 'node 1 Child 2',  tag: 'nav', parent: 'node1'}
  'node2':          abstract: true,  url: '/node2',   'ui-menu': {title: 'node 2',          tag: 'nav', parent: 'node1.child1'}
  'node2.child1':                    url: '/child1',  'ui-menu': {title: 'node 2 Child 1',  tag: 'nav', parent: 'node1.child2'}
  'nodeCustom':                      url: '/custom',  'ui-menu': {title: 'node 2 Custom',   tag: 'nav', parent: 'node2.child1'}
  'node2.child1.tab1':               url: '/tab1',    'ui-menu': {title: 'tab1 subnav',     tag: 'tab', order: 2, default: true}
  'node2.child1.tab2':               url: '/tab2',    'ui-menu': {title: 'tab2 subnav',     tag: 'tab', order: 1}
  'node2.child1.tab3':               url: '/tab3',    'ui-menu': {title: 'tab3 subnav',     tag: 'tab', order: 3}

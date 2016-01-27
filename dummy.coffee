loadStates = (states, stateProvider) ->
  for state of states
    stateProvider.state state, states[state]
  return

uiTreeMenuStates =
  'app': abstract: true,  url: '/',       'ui-menu': {title: 'App Group',       tag: 'nav'}
  'app.one':              url: 'one/',    'ui-menu': {title: 'App One',         tag: 'nav', parent: 'app'}
  'app.two':              url: 'two/',    'ui-menu': {title: 'App Two',         tag: 'nav', parent: 'app'}
  'app.tree':             url: 'tree/',   'ui-menu': {title: 'App Tree',        tag: 'nav', parent: 'app', restricted: true}
  'otr': abstract: true,  url: '/otr/',   'ui-menu': {title: 'Other Group',     tag: 'nav'}
  'otr.some':             url: 'some/',   'ui-menu': {title: 'Some Other Item', tag: 'nav', parent: 'otr'}
  'custom':               url: '/custom', 'ui-menu': {title: 'Custom',          tag: 'nav', order: 10}
  'app.one.tab1':         url: '/tab1',   'ui-menu': {title: 'tab1 subnav',     tag: 'tab', order: 2, parent: 'app.one'}
  'app.one.tab2':         url: '/tab2',   'ui-menu': {title: 'tab2 subnav',     tag: 'tab', order: 1, parent: 'app.one'}
  'app.one.tab3':         url: '/tab3',   'ui-menu': {title: 'tab3 subnav',     tag: 'tab', order: 3, parent: 'app.one', default: true}

describe 'Module: `ui-menu`', ->
  state = menus = compile = scope = element = timeout = undefined
  describe 'ui-menu state service', ->
    beforeEach ->
      module 'ui.router', (_$stateProvider_) ->
        $stateProvider = _$stateProvider_
        loadStates uiTreeMenuStates, $stateProvider
      module 'ui-menu'
      inject (_$uiMenu_, _$state_) ->
        menus = _$uiMenu_
        state = _$state_
    it 'loaded ten states', ->
      expect(state.get().length).toBe 11
    it 'tree root navigation items', ->
      expect((menus.get 'nav', '').length).toBe 3
    it 'tree navigation items for "app"', ->
      expect((menus.get 'nav', 'app').length).toBe 3
    it 'tree of wich is taged "tab"', ->
      expect((menus.get 'tab').length).toBe 3
    return
  describe 'ui-menu navigation directive', ->
    beforeEach ->
      module 'ui.router', (_$stateProvider_) ->
        $stateProvider = _$stateProvider_
        loadStates uiTreeMenuStates, $stateProvider
      module 'ui-menu'
      inject (_$uiMenu_, _$state_, _$compile_, _$rootScope_, _$timeout_) ->
        menus = _$uiMenu_
        state = _$state_
        compile = _$compile_
        scope = _$rootScope_
        timeout = _$timeout_
      state.go 'app.one'
      element = compile('<ui-nav-menu></ui-nav-menu>')(scope)
      scope.$digest()

    it 'restricted redirect', ->
      state.go 'app.tree'
      timeout.flush()
      (state.get 'app.tree').controller()
      scope.$digest()
      expect state.current.name
      .toBe 'custom'

    it 'state name', ->
      expect state.current.name
      .toBe 'app.one'
    it 'got to "custom"', ->
      element.find('li:first a').click()
      timeout.flush()
      expect state.current.name
      .toBe 'custom'
    it 'App Group should be opened', ->
      expect element.find('.fa-minus-square-o').parent().parent().text().trim()
      .toBe 'App Group'
    it 'Other Group should be closed', ->
      expect element.find('.fa-plus-square-o').parent().parent().text().trim()
      .toBe 'Other Group'
    it 'Reverse opened items', ->
      element.find('.fa-plus-square-o').parent().parent().click()
      scope.$digest()
      expect element.find('.fa-minus-square-o').parent().parent().text().trim()
      .toBe 'Other Group'
      expect element.find('.fa-plus-square-o').parent().parent().text().trim()
      .toBe 'App Group'
    it 'Shoul close opened group', ->
      element.find('.fa-minus-square-o').parent().parent().click()
      scope.$digest()
      expect element.find('.fa-minus-square-o').parent().parent().text().trim()
      .toBe ''
    it 'Tree tabs in order', ->
      element.find('li:eq(1) a:eq(1)').click()
      timeout.flush()
      tabs = compile('''<ul class="nav nav-tabs" ui-menu='' parent='app.one' tag='tab'></ul>''')(scope)
      scope.$digest()
      expect tabs.find('a:eq(0)').text().trim()
      .toBe 'tab2 subnav'
      expect tabs.find('a:eq(1)').text().trim()
      .toBe 'tab1 subnav'
      expect tabs.find('a:eq(2)').text().trim()
      .toBe 'tab3 subnav'
    it 'Tabs should redirect', ->
      element.find('li:eq(1) a:eq(1)').click()
      timeout.flush()
      tabs = compile('''<ul class="nav nav-tabs" ui-menu='' parent='app.one' tag='tab'></ul>''')(scope)
      scope.$digest()
      expect state.current.name
      .toBe 'app.one.tab3'
    it 'Tabs should redirect even without default item', ->
      element.find('li:eq(1) a:eq(1)').click()
      timeout.flush()
      delete (state.get 'app.one.tab3')['ui-menu'].default
      tabs = compile('''<ul class="nav nav-tabs" ui-menu='' parent='app.one' tag='tab'></ul>''')(scope)
      scope.$digest()
      expect state.current.name
      .toBe 'app.one.tab2'

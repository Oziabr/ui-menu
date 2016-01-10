describe 'Module: `ui-menu`', ->
  $state = menus = undefined
  describe 'ui-menu states', ->
    beforeEach ->
      module 'ui.router', (_$stateProvider_) ->
        $stateProvider = _$stateProvider_
        loadStates uiTreeMenuStates, $stateProvider
      module 'ui-menu'
      inject (_$uiMenu_, _$state_) ->
        menus = _$uiMenu_
        $state = _$state_
    it 'loaded nine states', ->
      expect($state.get().length).toBe 10
    it 'six of wich is taged "nav"', ->
      expect((menus.get 'nav').length).toBe 6
    it 'tree of wich is taged "tab"', ->
      expect((menus.get 'tab').length).toBe 3
    return
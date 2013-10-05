Router.map ->
  @route 'home', path: '/', controller: 'HomeController'
  @route 'about', path: '/about', controller: 'AboutController'
  @route 'propose', controller: 'ProposeController'
  @route 'wishes', controller: 'WishesController'
  @route 'wish', path: '/wish/:id', controller: 'WishController'

Router.configure
  layout: 'layout'
  loadingTemplate: 'loading'

Router.configure
  layoutTemplate: 'layout'
  loadingTemplate: 'loading'
  notFoundTemplate: 'notFound'
  waitOn: -> Meteor.subscribe 'posts'

Router.route '/', name:'postsList'

Router.route '/posts/:_id', 
  name: 'postPage'
  data: -> Posts.findOne(@params._id)

Router.route '/posts/:_id/edit',
  name: 'postEdit'
  data: -> Posts.findOne(@params._id)

Router.route '/submit',
  name: 'postSubmit'

requireLogin = ->
  if not Meteor.user()
   if Meteor.loggingIn()
     this.render(this.loadingTemplate)
   else
    this.render 'accessDenied' 
  else
   this.next()
  return

Router.onBeforeAction 'dataNotFound',
  only: 'postPage'

Router.onBeforeAction requireLogin,
  only: 'postSubmit'

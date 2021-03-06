root = exports ? this

root.User = class User
  @findOne: (idOrName) ->
    data = Meteor.users.findOne(idOrName)
    if not data
      data = Meteor.users.findOne({'profile.name': new RegExp('^' + idOrName + '$', 'i')})
    new User(data)

  @current: ->
    Meteor.userId() and new User(Meteor.user())

  constructor: (@data) ->

  name: -> @data.profile.name

  photoUrl: (height) ->
    if @data.services
      if @data.services.google
        picture = @data.services.google.picture
        if picture and height
          picture = "#{picture}?sz=#{height}"
      else if @data.services.github
        picture = @data.services.github.picture
        if picture and height
          picture = "#{picture}&s=#{height}"
      else if @data.services.facebook
        picture = "http://graph.facebook.com/#{@data.services.facebook.id}/picture/"
        if height
          picture = "#{picture}?height=#{height/2}"
      else if @data.services.twitter
        picture = @data.services.twitter.profile_image_url
    if not picture
      if height
        picture = Cdn.cdnify("/img/user-#{height}x#{height}.png")
      else
        picture = Cdn.cdnify('/img/user.png')
    picture


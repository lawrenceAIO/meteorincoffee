@Posts = new Mongo.Collection 'posts'
#'Posts' may need an '@' in front of it per abstractThat's commit in his examples

Meteor.methods
  postInsert: (postAttributes) ->
    check(Meteor.userId(), String)
    check(postAttributes,
      title: String
      url: String)
    postWithSameLink = Posts.findOne(url: postAttributes.url)
    return {postExists: true, _id: postWithSameLink._id} if postWithSameLink
    user = Meteor.user()

    post = _.extend(postAttributes,
      userId: user._id
      author: user.username
      submitted: new Date())

    postId = Posts.insert(post)
    return _id: postId

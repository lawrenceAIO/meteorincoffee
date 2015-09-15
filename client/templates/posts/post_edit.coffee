Template.postEdit.events
  'submit form':
     (e)->
        e.preventDefault()
        currentPostId=@_id
        postProperties =
          url: $(e.target).find('[name=url]').val()
          title: $(e.target).find('[name=url]').val()
        Posts.update currentPostId, {$set: postProperties}, 
          (error)->
            if error 
              alert(error.reason)             
              return
            else
              Router.go('postPage', {_id: currentPostId})
              return
  'click .delete':
     (e)->
       if confirm("Delete this post?")
         currentPostID = @_id
         Posts.remove(currentPostId)
         Router.go('postsList')
         return

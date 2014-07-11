$(document).ready ->
	if $('body').hasClass('post-page')
		collection = new Blog.Collections.Posts()

		collection.fetch().then ()->
			listView = new Blog.Views.Post_list({ collection: collection })

			listView.render().el

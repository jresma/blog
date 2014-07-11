class Blog.Views.Post_list extends Blog.Views.Collection
	el: '#post'

	events: () =>
		{
			'click .home': 'render'
			'click .new-post': 'new_post'
		}

	initialize: () =>
		@collection.on 'add', @addOne, @
		@collection.on 'change', @render, @

	render: () ->
		$('div[data-target-template="Blog-Views-Post-Add-Form"]').html ''
		$('div[data-target-template="Blog-Views-Post-Edit-Form"]').html ''
		@$el.find('.box-holder').html ''

		@collection.each @addOne, @

		@

	addOne: (model) =>
		model.attributes.edit = 'edit'
		model.attributes.delete = 'delete'
		item = new Blog.Views.Post_List_Row({ model: model, collection: @collection })

		@$el.find('.box-holder').append item.render().el

		@

	new_post: (e) =>
		@$el.find('.box-holder').html ''
		$('div[data-target-template="Blog-Views-Post-Edit-Form"]').html ''
		form = new Blog.Views.Post_Add_Form({ collection: @collection })

		$('div[data-target-template="Blog-Views-Post-Add-Form"]').html form.render().el

		@
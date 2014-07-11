class Blog.Views.Post_List_Row extends Blog.Views.Base
	tagName: 'li'
	className: 'clearfix'
	template: 'post-item'

	initialize: () =>
		@model.on 'change', @render, @
		@model.on 'destroy', @unrender, @

	events: () =>
		{
			'click .edit': 'editPost'
			'click .delete': 'deletePost'
		}

	
	render: ->
		template = _h.template(@template)
		@$el.html template
		@$el.find('.title').html @model.get('title')
		@$el.find('.permalink').html @model.get('permalink')
		@$el.find('.content').html @model.get('content')
		@$el.find('.edit').html @model.get('edit')
		@$el.find('.delete').html @model.get('delete')

		@

	unrender: () =>
		@remove()

	editPost: (e) =>
		e.preventDefault()
		$('div[data-target-template="Blog-Views-Post-Add-Form"]').html ''
		$('#post .box-holder').html ''

		editForm = new Blog.Views.Post_Edit_Form({ model: @model, collection: @collection })
		$('div[data-target-template="Blog-Views-Post-Edit-Form"]').html editForm.render().el

	deletePost: (e) =>
		e.preventDefault()
		@model.destroy()
		@unrender()
class Blog.Views.Post_Edit_Form extends Blog.Views.Base
	template: 'post-edit-form'

	render: () =>
		@$el.html _h.template(@template)
		@$el.find('.title').val @model.get('title')
		@$el.find('.permalink').val @model.get('permalink')
		@$el.find('.content').val @model.get('content')
		model = @model
		collection = @collection

		form = this.$el.find('form')
		form_file = form.find('#form_file')

		form_file.fileupload(
			dataType: 'json'
			type: 'PUT'
			url: '/post/' + @model.get('id')
			add: (e, data) ->
				e.preventDefault()
				data.context = form.find('input[type="submit"]')
				.click( (e) ->
					e.preventDefault()
					if form.valid() then data.submit() else false
				)
			done: (e, data) ->
				model.set(data)
				$('div[data-target-template="Blog-Views-Post-Add-Form"]').html ''
				$('div[data-target-template="Blog-Views-Post-Edit-Form"]').html ''
				listView = new Blog.Views.Post_list({ collection: collection })
				listView.render().el
		)

		form.validate({
			rules:
				'title':
					required: true
				'permalink':
					required: true
				'content':
					required: true
			submitHandler: () ->
				unless !!form_file[0].files[0]
					$.ajax({
						url: 'post/' + model.get('id'),
						data: form.serialize(),
						type: 'PUT',
						success: (response) ->					  			
							if response
							  model.set(response)
							  $('div[data-target-template="Blog-Views-Post-Add-Form"]').html ''
							  $('div[data-target-template="Blog-Views-Post-Edit-Form"]').html ''
							  listView = new Blog.Views.Post_list({ collection: collection })
							  listView.render().el
					})
		})

		@
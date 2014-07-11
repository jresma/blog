class Blog.Views.Post_Add_Form extends Blog.Views.Base
	template: 'post-add-form'

	render: () =>
		template = _h.template(@template)
		@$el.html template
		collection = @collection

		form = this.$el.find('form')
		form_file = form.find('#form_file')

		form_file.fileupload(
			dataType: 'json'
			type: 'POST'
			url: '/post/'
			add: (e, data) ->
				e.preventDefault()
				data.context = form.find('input[type="submit"]')
				.click( (e) ->
					e.preventDefault()
					if form.valid() then data.submit() else false
				)
			done: (e, data) ->
				model = new Blog.Models.Post(data)
				collection.add(model)
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
						url: 'post',
						data: form.serialize(),
						type: 'POST',
						success: (response) ->					  			
							if response
							  model = new Blog.Models.Post(response)
							  collection.add(model)
							  $('div[data-target-template="Blog-Views-Post-Add-Form"]').html ''
							  $('div[data-target-template="Blog-Views-Post-Edit-Form"]').html ''
							  listView = new Blog.Views.Post_list({ collection: collection })
							  listView.render().el
					})
		})

		@	

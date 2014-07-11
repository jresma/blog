window.Blog = 
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  
class window.Blog.Helper
  
  # templating for backbone view 
  #
  # e.g _h.template 'template'
  #
  template: (id)->
      template = $('#'+ id).html()
      _.template(template)
      
  #
  # Form Serializer
  #
  # e.g _h.serializeForm form
  #
  serializeForm: (form) ->
      # declare empty object
      data = {}
      # serialize form
      formData = form.serializeArray() 
      # extract data from each object and push to data object
      $.each(formData, () -> 
          if (data[this.name])
              if (!data[this.name].push)
                  data[this.name] = [data[this.name]]
              
              data[this.name].push(this.value || '')
          else
              data[this.name] = this.value || ''
      )
      # return serialize data
      data

window._e = _.extend( {}, Backbone.Events )
Backbone.history.start()

window._h = new window.Blog.Helper()
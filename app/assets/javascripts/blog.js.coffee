
#
# BASE VIEW 
#
#
class Blog.Views.Base extends Backbone.View

    render: () =>
        template = _h.template(@template)
        @$el.html template( @model.toJSON() )
        @

#
# BASE COLLECTION VIEW
#
#
class Blog.Views.Collection extends Backbone.View
  
    render: () =>
        template = $('#'+ @template).html();
        compiled = _.template(template)
        @setElement(compiled(@data))
        @
#
# BASE MODEL
#
#
class Blog.Models.Base extends Backbone.Model
    urlRoot: null

#
# BASE COLLECTION
#
#
class Blog.Collections.Base extends Backbone.Collection
    urlRoot: null
    

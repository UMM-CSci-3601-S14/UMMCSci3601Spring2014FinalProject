class window.prompt extends Backbone.Model

  defaults:
    description: ''

  urlRoot: 'https://try-api.lightsidelabs.com/api/prompts/3'

  sync: (method,model,options) ->
    $.ajaxSetup {
      headers:
        Authorization: 'Token c35f045779a7564c55df0f7df7fedaf4346b3d40'
        'Content-Type': 'application/json'
      method: 'post'}
    Backbone.sync(method,model,options)


  parse: (response, options) ->
    response

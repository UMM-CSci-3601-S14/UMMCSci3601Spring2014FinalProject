class window.prompt extends Backbone.Model

  defaults:
    description: ''

  urlRoot: 'https://try-api.lightsidelabs.com/api/prompts/114'

  sync: (method,model,options) ->
    $.ajaxSetup {
      headers:
        Authorization: 'Token a9c60d6b68ca214e595cbdd44a21e832df8f8216'
        'Content-Type': 'application/json'
      method: 'post'}
    Backbone.sync(method,model,options).done ->
      console.log model


  parse: (response, options) ->
    response

class window.clonePrompt extends Backbone.Model
  urlRoot: 'https://try-api.lightsidelabs.com/api/prompts/1/clone'

  sync: (method,model,options) ->
    $.ajaxSetup {
      headers:
        Authorization: 'Token a9c60d6b68ca214e595cbdd44a21e832df8f8216' #dummy token
        'Content-Type': 'application/json'
      type: 'POST'}
    Backbone.sync(method,model,options).done ->
      console.log model



  parse: (response, options) ->
    response
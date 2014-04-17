class window.superPost extends Backbone.Model

  sync: (method,model,options) ->
    $.ajaxSetup {
      headers:
        Authorization: 'Token a9c60d6b68ca214e595cbdd44a21e832df8f8216'
        'Content-Type': 'application/json'
      }
    Backbone.sync(method,model,options).done ->
      console.log model


  parse: (response, options) ->
    response

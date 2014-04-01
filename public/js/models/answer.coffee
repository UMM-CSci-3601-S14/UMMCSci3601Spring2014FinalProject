class window.answer extends Backbone.Model
  urlRoot: 'https://try-api.lightsidelabs.com/api/answers/'

  sync: (method,model,options) ->
    $.ajaxSetup {
      headers:
        Authorization: 'Token a9c60d6b68ca214e595cbdd44a21e832df8f8216'
        'Content-Type': 'application/json'
      type: 'POST'}
    console.log 'before post call'
    Backbone.sync(method,model,options).done ->
      console.log model



  parse: (response, options) ->
    response

#model
#https://try-api.lightsidelabs.com/api/trained-models/4
#copora
#https://try-api.lightsidelabs.com/api/corpora/3

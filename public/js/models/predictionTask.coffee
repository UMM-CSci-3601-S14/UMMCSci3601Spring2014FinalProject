class window.predictionTask extends Backbone.Model
  urlRoot: 'https://try-api.lightsidelabs.com/api/prediction-tasks/'


  sync: (method,model,options) ->
    $.ajaxSetup {
      data:
        "trained_model": "https://try-api.lightsidelabs.com/api/trained-models/4",
        "answer_set": "https://try-api.lightsidelabs.com/api/answer-sets/3"
      headers:
        "Authorization": 'Token c35f045779a7564c55df0f7df7fedaf4346b3d40' #dummy token
        "Content-Type": 'application/json'
      method: 'post'}
    Backbone.sync(method,model,options).done ->


  parse: (response, options) ->
    response
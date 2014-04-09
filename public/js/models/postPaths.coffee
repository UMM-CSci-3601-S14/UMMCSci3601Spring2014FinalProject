# This is the cloned prompt that we are using for the demo page
class window.prompt extends superPost
  urlRoot: 'https://try-api.lightsidelabs.com/api/prompts/114'

# This author is the same for all submitions on this page.
class window.author extends superPost
  urlRoot:'https://try-api.lightsidelabs.com/api/authors'

#  Clone is presently unused/commented out.
class window.clonePrompt extends superPost
  urlRoot: 'https://try-api.lightsidelabs.com/api/prompts/1/clone'

class window.clonePrompt extends superPost
  urlRoot: 'https://try-api.lightsidelabs.com/api/prompts/1/clone'

  # Calls for sending an answer to the api
class window.answerSet extends superPost
  urlRoot: 'https://try-api.lightsidelabs.com/api/answer-sets/'

class window.answer extends superPost
  urlRoot: 'https://try-api.lightsidelabs.com/api/answers/'

class window.predictionTask extends superPost
  urlRoot: 'https://try-api.lightsidelabs.com/api/prediction-tasks/'

#  This general request call takes the place of the prediction process
#   and the prediction status, as the urls for both can't be predefined
class window.theRequest extends superPost
  urlRoot: ""

# Calls for getting the grades from the api
class window.predictionResult extends superPost
  urlRoot: 'https://try-api.lightsidelabs.com/api/prediction-results/'

class window.ourAnswerSet extends superPost
  urlRoot: 'https://try-api.lightsidelabs.com/api/answer-sets/263'

  ##Calls for making a new model.
class window.createPrompt extends superPost
  urlRoot: 'https://try-api.lightsidelabs.com/api/prompts/'

class window.createCorpora extends superPost
  urlRoot: 'https://try-api.lightsidelabs.com/api/corpora/'

class window.corpusUploadTasks extends superPost
  urlRoot: 'https://try-api.lightsidelabs.com/api/corpus-upload-tasks/'

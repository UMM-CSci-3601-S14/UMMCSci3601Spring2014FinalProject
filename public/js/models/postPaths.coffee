
# This is the cloned prompts that we are using for the demo page
class window.prompt1 extends superPost
  urlRoot: 'https://try-api.lightsidelabs.com/api/prompts/114'

class window.prompt2 extends superPost
  urlRoot: 'https://try-api.lightsidelabs.com/api/prompts/449'

#needed to creat an answer set for a prompt/model
class window.createAnswerSet extends superPost
  urlRoot: 'https://try-api.lightsidelabs.com/api/answer-sets/'

#  Clone is presently unused/commented out.
class window.clonePrompt1 extends superPost
  urlRoot: 'https://try-api.lightsidelabs.com/api/prompts/1/clone'

class window.clonePrompt2 extends superPost
  urlRoot: 'https://try-api.lightsidelabs.com/api/prompts/2/clone'

# This author is the same for all submitions on this page.
class window.author extends superPost
  urlRoot:'https://try-api.lightsidelabs.com/api/authors'

# Calls for sending an answer to the api
class window.answerSet1 extends superPost
  urlRoot: 'https://try-api.lightsidelabs.com/api/answer-sets/263'

class window.answerSet2 extends superPost
  urlRoot: 'https://try-api.lightsidelabs.com/api/answer-sets/279'

class window.answer extends superPost
  urlRoot: 'https://try-api.lightsidelabs.com/api/answers/'

class window.predictionTask extends superPost
  urlRoot: 'https://try-api.lightsidelabs.com/api/prediction-tasks/'

# Call for getting the grades from the api once sucessfully graded
class window.predictionResult extends superPost
  urlRoot: 'https://try-api.lightsidelabs.com/api/prediction-results/'

# Calls for making a new model.
class window.createPrompt extends superPost
  urlRoot: 'https://try-api.lightsidelabs.com/api/prompts/'

class window.createCorpora extends superPost
  urlRoot: 'https://try-api.lightsidelabs.com/api/corpora/'

class window.corpusUploadTasks extends superPost
  urlRoot: 'https://try-api.lightsidelabs.com/api/corpus-upload-tasks/'

class window.trainingTasks extends superPost
  urlRoot: 'https://try-api.lightsidelabs.com/api/training-tasks/'

#  This general request call takes the place of the prediction process,
#  the prediction status, and other places where the URL can't be predefined
class window.request extends superPost
  urlRoot: ""

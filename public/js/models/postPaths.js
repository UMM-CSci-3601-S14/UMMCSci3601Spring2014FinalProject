// Generated by CoffeeScript 1.6.3
(function() {
  var _ref, _ref1, _ref10, _ref2, _ref3, _ref4, _ref5, _ref6, _ref7, _ref8, _ref9,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  window.prompt = (function(_super) {
    __extends(prompt, _super);

    function prompt() {
      _ref = prompt.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    prompt.prototype.urlRoot = 'https://try-api.lightsidelabs.com/api/prompts/114';

    return prompt;

  })(superPost);

  window.clonePrompt = (function(_super) {
    __extends(clonePrompt, _super);

    function clonePrompt() {
      _ref1 = clonePrompt.__super__.constructor.apply(this, arguments);
      return _ref1;
    }

    clonePrompt.prototype.urlRoot = 'https://try-api.lightsidelabs.com/api/prompts/1/clone';

    return clonePrompt;

  })(superPost);

  window.author = (function(_super) {
    __extends(author, _super);

    function author() {
      _ref2 = author.__super__.constructor.apply(this, arguments);
      return _ref2;
    }

    author.prototype.urlRoot = 'https://try-api.lightsidelabs.com/api/authors';

    return author;

  })(superPost);

  window.ourAnswerSet = (function(_super) {
    __extends(ourAnswerSet, _super);

    function ourAnswerSet() {
      _ref3 = ourAnswerSet.__super__.constructor.apply(this, arguments);
      return _ref3;
    }

    ourAnswerSet.prototype.urlRoot = 'https://try-api.lightsidelabs.com/api/answer-sets/263';

    return ourAnswerSet;

  })(superPost);

  window.answer = (function(_super) {
    __extends(answer, _super);

    function answer() {
      _ref4 = answer.__super__.constructor.apply(this, arguments);
      return _ref4;
    }

    answer.prototype.urlRoot = 'https://try-api.lightsidelabs.com/api/answers/';

    return answer;

  })(superPost);

  window.predictionTask = (function(_super) {
    __extends(predictionTask, _super);

    function predictionTask() {
      _ref5 = predictionTask.__super__.constructor.apply(this, arguments);
      return _ref5;
    }

    predictionTask.prototype.urlRoot = 'https://try-api.lightsidelabs.com/api/prediction-tasks/';

    return predictionTask;

  })(superPost);

  window.predictionResult = (function(_super) {
    __extends(predictionResult, _super);

    function predictionResult() {
      _ref6 = predictionResult.__super__.constructor.apply(this, arguments);
      return _ref6;
    }

    predictionResult.prototype.urlRoot = 'https://try-api.lightsidelabs.com/api/prediction-results/';

    return predictionResult;

  })(superPost);

  window.createPrompt = (function(_super) {
    __extends(createPrompt, _super);

    function createPrompt() {
      _ref7 = createPrompt.__super__.constructor.apply(this, arguments);
      return _ref7;
    }

    createPrompt.prototype.urlRoot = 'https://try-api.lightsidelabs.com/api/prompts/';

    return createPrompt;

  })(superPost);

  window.createCorpora = (function(_super) {
    __extends(createCorpora, _super);

    function createCorpora() {
      _ref8 = createCorpora.__super__.constructor.apply(this, arguments);
      return _ref8;
    }

    createCorpora.prototype.urlRoot = 'https://try-api.lightsidelabs.com/api/corpora/';

    return createCorpora;

  })(superPost);

  window.corpusUploadTasks = (function(_super) {
    __extends(corpusUploadTasks, _super);

    function corpusUploadTasks() {
      _ref9 = corpusUploadTasks.__super__.constructor.apply(this, arguments);
      return _ref9;
    }

    corpusUploadTasks.prototype.urlRoot = 'https://try-api.lightsidelabs.com/api/corpus-upload-tasks/';

    return corpusUploadTasks;

  })(superPost);

  window.request = (function(_super) {
    __extends(request, _super);

    function request() {
      _ref10 = request.__super__.constructor.apply(this, arguments);
      return _ref10;
    }

    request.prototype.urlRoot = "";

    return request;

  })(superPost);

}).call(this);

/*
//@ sourceMappingURL=postPaths.map
*/

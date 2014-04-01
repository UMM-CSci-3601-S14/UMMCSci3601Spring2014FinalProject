// Generated by CoffeeScript 1.7.1
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  window.welcomeView = (function(_super) {
    __extends(welcomeView, _super);

    function welcomeView() {
      return welcomeView.__super__.constructor.apply(this, arguments);
    }

    welcomeView.prototype.tagName = 'div';

    welcomeView.prototype.template = _.template($('#welcomePage').html());

    welcomeView.prototype.events = {
      'click button.submitEssay': 'submitEssay',
      'click button#hideResults': 'hideResults'
    };

    welcomeView.prototype.initialize = function() {
      var thePrompt;
      thePrompt = new prompt().fetch().done(function() {
        var theAuthor;
        $('#promptContents').html(thePrompt.responseJSON.text);
        return theAuthor = new author({
          designator: "BG2",
          email: "test@gmail.com"
        }).fetch().done(function() {
          var theAnswerSet;
          return theAnswerSet = new answerSet({
            prompt: thePrompt.responseJSON.url,
            "trained-models": thePrompt.responseJSON.default_models[0]
          }).save().done(function() {
            var theAnswer;
            return theAnswer = new answer({
              author: "https://try-api.lightsidelabs.com/api/authors/51",
              "answer_set": "https://try-api.lightsidelabs.com/api/answer-sets/92",
              text: "sup."
            }).save().done(function() {
              var thePredictionTask;
              return thePredictionTask = new predictionTask({
                "answer_set": "https://try-api.lightsidelabs.com/api/answer-sets/92"
              }).save().done(function() {
                var thePredictionProcess;
                return thePredictionProcess = new predictionProcess().save().done(function() {
                  var thePredictionResult;
                  return thePredictionResult = new predictionResult().fetch().done(function() {
                    return console.log(thePredictionResult.responseJSON);
                  });
                });
              });
            });
          });
        });
      });
      this.render();
    };

    welcomeView.prototype.render = function() {
      this.$el.html(this.template());
      return this;
    };

    welcomeView.prototype.submitEssay = function() {
      var postAnswer;
      $('#sandboxResults').show(1000);
      console.log('in function');
      return postAnswer = new answer({
        parent: null,
        author: null,
        answer_set: null,
        text: "blah"
      }).save();
    };

    welcomeView.prototype.hideResults = function() {
      return $('#sandboxResults').hide(1000);
    };

    return welcomeView;

  })(Backbone.View);

}).call(this);

//# sourceMappingURL=welcomeView.map

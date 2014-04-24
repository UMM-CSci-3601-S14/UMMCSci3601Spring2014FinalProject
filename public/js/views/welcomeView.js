// Generated by CoffeeScript 1.7.1
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  window.welcomeView = (function(_super) {
    var thePrompt;

    __extends(welcomeView, _super);

    function welcomeView() {
      return welcomeView.__super__.constructor.apply(this, arguments);
    }

    welcomeView.prototype.tagName = 'div';

    welcomeView.prototype.template = _.template($('#welcomePage').html());

    welcomeView.prototype.events = {
      'click button.submitEssay': 'submitEssay',
      'click button#hideResults': 'hideResults',
      'click button#more': 'showExtra',
      'click button#less': 'hideExtra'
    };

    thePrompt = null;

    welcomeView.prototype.initialize = function() {
      thePrompt = new prompt1().fetch().done(function() {
        $('#promptTitle').html('Prompt: ' + thePrompt.responseJSON.text);
        return $('#promptDescription').html(thePrompt.responseJSON.description);
      });
      this.render();
    };

    welcomeView.prototype.render = function() {
      this.$el.html(this.template());
      return this;
    };

    welcomeView.prototype.showExtra = function() {
      $('.extra').show();
      $('#more').hide();
      return $('#less').show();
    };

    welcomeView.prototype.hideExtra = function() {
      $('.extra').hide();
      $('#more').show();
      return $('#less').hide();
    };

    welcomeView.prototype.submitEssay = function() {
      var theAuthor;
      if ($('#essayContents').val() === "") {
        return alert("Please enter text to for LightSide to Grade.");
      } else {
        $('#sandboxResults').show(500);
        return theAuthor = new author({
          designator: "BG2",
          email: "test@gmail.com"
        }).fetch().done(function() {
          var theAnswerSet;
          return theAnswerSet = new answerSet1({}).fetch().done(function() {
            var theAnswer;
            console.log(theAnswerSet);
            return theAnswer = new answer({
              author: theAuthor.responseJSON.results[0].url,
              answer_set: theAnswerSet.responseJSON.url,
              text: $('#essayContents').val()
            }).save().done(function() {
              var thePredictionTask;
              return thePredictionTask = new predictionTask({
                answer_set: theAnswerSet.responseJSON.url,
                trained_model: thePrompt.responseJSON.default_models[0]
              }).save().done(function() {
                var theProcess;
                theProcess = new request();
                theProcess.urlRoot = thePredictionTask.responseJSON.process;
                return theProcess.save().done(function() {
                  var looping, thePredictionStatus;
                  thePredictionStatus = new request();
                  return looping = setInterval((function() {
                    thePredictionStatus.urlRoot = theProcess.attributes.prediction_task.slice(0, 4) + "s" + theProcess.attributes.prediction_task.slice(4);
                    return thePredictionStatus.fetch().done(function() {
                      var thePredictionResult;
                      console.log("Prediction Task status: " + thePredictionStatus.attributes.status);
                      if (thePredictionStatus.attributes.status === 'S') {
                        console.log("Prediction Task was SUCCESSFUL");
                        thePredictionResult = new predictionResult().fetch().done(function() {
                          var answerGraded;
                          $('#grade').html("Your grade for the submitted essay is " + thePredictionResult.responseJSON.results[0].label + " out of 5.");
                          return answerGraded = new answer;
                        });
                        window.clearInterval(looping);
                      }
                      if (thePredictionStatus.attributes.status === 'U') {
                        console.log("Prediction Task was UNSUCCESSFUL");
                        $('#grade').html("The grading process was unsucessful. Please wait before resubmitting.");
                        return window.clearInterval(looping);
                      }
                    });
                  }), 1000);
                });
              });
            });
          });
        });
      }
    };

    welcomeView.prototype.hideResults = function() {
      return $('#sandboxResults').hide(500);
    };

    return welcomeView;

  })(Backbone.View);

}).call(this);

//# sourceMappingURL=welcomeView.map

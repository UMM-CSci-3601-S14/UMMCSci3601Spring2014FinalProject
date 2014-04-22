// Generated by CoffeeScript 1.7.1
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  window.modelView = (function(_super) {
    __extends(modelView, _super);

    function modelView() {
      return modelView.__super__.constructor.apply(this, arguments);
    }

    modelView.prototype.tagName = 'div';

    modelView.prototype.template = _.template($('#modelPage').html());

    modelView.prototype.events = {
      'click button#createPrompt': 'createPrompt',
      'click button#hideWait': 'hideWait'
    };

    modelView.prototype.initialize = function() {
      return this.render();
    };

    modelView.prototype.render = function() {
      console.log('Model');
      this.$el.html(this.template());
      return this;
    };

    modelView.prototype.createPrompt = function() {
      var newClass, newDescription, newPrompt, newText, newTitle;
      console.log('in function');
      $('#waitingForModel').show(1000);
      newTitle = $('#title').val();
      newText = $('#title').val();
      newDescription = $('#description').val();
      newClass = $('#cDescription').val();
      return newPrompt = new createPrompt({
        title: newTitle,
        text: newText,
        description: newDescription
      }).save().done(function() {
        var newCorpus;
        console.log(newPrompt.responseJSON.url);
        return newCorpus = new createCorpora({
          prompt: newPrompt.responseJSON.url,
          description: newClass
        }).save().done(function() {
          var newCorpusUpload;
          return newCorpusUpload = new corpusUploadTasks().fetch().done(function() {
            var s3Request;
            s3Request = new request();
            s3Request.url = 'https://try-api.lightsidelabs.com/api/corpus-upload-parameters';
            return s3Request.fetch().done(function() {
              var form, xhr;
              form = new FormData();
              form.append('AWSAccessKeyId', s3Request.attributes.access_key_id);
              form.append('key', s3Request.attributes.key);
              form.append('policy', s3Request.attributes.policy);
              form.append('signature', s3Request.attributes.signature);
              form.append('acl', 'public-read');
              form.append('success_action_status', '201');
              form.append('file', $('#file').get(0).files[0]);
              xhr = new XMLHttpRequest();
              xhr.open('POST', "https://lightsidelabs-try.s3.amazonaws.com/", true);
              xhr.onreadystatechange = function() {
                var newUploadTask, s3Key;
                if (xhr.readyState === 4) {
                  s3Key = $(xhr.responseXML).find("Key").first().text();
                  console.log(s3Key);
                  return newUploadTask = new corpusUploadTasks({
                    corpus: newCorpus.responseJSON.url,
                    s3_key: s3Key,
                    content_type: 'text/csv'
                  }).save().done(function() {
                    var uploadQueue;
                    uploadQueue = new request();
                    uploadQueue.urlRoot = newUploadTask.responseJSON.process;
                    return uploadQueue.save().done(function() {
                      var count, looping, uploadTask;
                      uploadTask = new request();
                      console.log(newUploadTask.responseJSON.url);
                      uploadTask.urlRoot = newUploadTask.responseJSON.url;
                      count = 0;
                      looping;
                      return looping = setInterval((function() {
                        count++;
                        return uploadTask.fetch().done(function() {
                          if (uploadTask.attributes.status === 'S') {
                            console.log("Prediction Task was SUCCESSFUL");
                            console.log("exited while loop");
                            console.log(newUploadTask.responseJSON);
                            console.log(count);
                            window.clearInterval(looping);
                            window.alert("Your Model Has Been Made");
                          }
                          if (uploadTask.attributes.status === 'U') {
                            console.log("Prediction Task was UNSUCCESSFUL");
                            window.clearInterval(looping);
                            return window.alert("Your Model Has Failed. Please review your csv for the proper format and try again.");
                          }
                        });
                      }), 1000);
                    });
                  });
                }
              };
              return xhr.send(form);
            });
          });
        });
      });
    };

    modelView.prototype.hideResults = function() {
      return $('#waitingForModel').hide(1000);
    };

    return modelView;

  })(Backbone.View);

  this;

}).call(this);

//# sourceMappingURL=modelView.map

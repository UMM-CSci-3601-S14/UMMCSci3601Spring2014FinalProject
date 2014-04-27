// Generated by CoffeeScript 1.7.1
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  window.CSVView = (function(_super) {
    __extends(CSVView, _super);

    function CSVView() {
      return CSVView.__super__.constructor.apply(this, arguments);
    }

    CSVView.prototype.tagName = 'div';

    CSVView.prototype.template = _.template($('#csvPage').html());

    CSVView.prototype.events = {
      'click button#downloadCSV': 'downloadCSV',
      'click button#add': 'add',
      'click button#delete': 'delete',
      'click button#saveFields': 'saveFields',
      'click button#replace': 'replace',
      'click button#cancel': 'cancel'
    };

    CSVView.prototype.initialize = function() {
      return this.render();
    };

    CSVView.prototype.render = function() {
      console.log('rendering CSVView');
      this.$el.html(this.template());
      window.onbeforeunload = function() {
        return "WARNING: Reloading the page will restart the process and you will lose all of your data!";
      };
      return this;
    };

    return CSVView;

  })(Backbone.View);

  ({

    /*
    These functions are found in funtions.html
     */
    downloadCSV: function() {
      return exportToCSV();
    },
    add: function() {
      return add();
    },
    "delete": function() {
      return del();
    },
    saveFields: function() {
      saveFields();
      $("#fieldTut").hide();
      return $("#textTut").show();
    },
    cancel: function() {
      return cancelReplace();
    },
    replace: function() {
      return replace();
    }
  });

}).call(this);

//# sourceMappingURL=CSVView.map

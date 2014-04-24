// Generated by CoffeeScript 1.6.3
(function() {
  var AppRouter, _ref,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  AppRouter = (function(_super) {
    __extends(AppRouter, _super);

    function AppRouter() {
      _ref = AppRouter.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    AppRouter.prototype.routes = {
      '': 'index',
      'dash': 'dash',
      'csvPage': 'csvPage',
      'model-maker': 'modelMaker',
      'login': 'login',
      'newUser': 'newUser',
      'failed': 'login',
      'account': 'account',
      'uploadCSV': 'uploadCSV',
      'uploadZip': 'uploadZip'
    };

    AppRouter.prototype.index = function() {
      console.log("in index");
      $('#content').html(new window.welcomeView().$el);
    };

    AppRouter.prototype.dash = function() {
      console.log("in dash");
      $('#content').html(new window.dashView().$el);
    };

    AppRouter.prototype.csvPage = function() {
      console.log("in csv");
      $('#content').html(new window.CSVView().$el);
    };

    AppRouter.prototype.uploadCSV = function() {
      console.log("in uploadCSV");
      $('#content').html(new window.uploadCSVView().$el);
    };

    AppRouter.prototype.uploadZip = function() {
      console.log("in uploadZip");
      $('#content').html(new window.uploadZipView().$el);
    };

    AppRouter.prototype.modelMaker = function() {
      console.log("in model");
      $('#content').html(new window.modelView().$el);
    };

    AppRouter.prototype.login = function() {
      console.log("in Sign in");
      $('#content').html(new window.logInView().$el);
    };

    AppRouter.prototype.newUser = function() {
      console.log("in newUser");
      $('#content').html(new window.newUserView().$el);
    };

    AppRouter.prototype.account = function() {
      console.log("in account");
      $('#content').html(new window.accountView().$el);
    };

    return AppRouter;

  })(Backbone.Router);

  $(document).ready(function() {
    var app;
    app = new AppRouter();
    return Backbone.history.start({
      pushState: true
    });
  });

}).call(this);

/*
//@ sourceMappingURL=app.map
*/

// Generated by CoffeeScript 1.7.1
(function() {
  var AppRouter,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  AppRouter = (function(_super) {
    __extends(AppRouter, _super);

    function AppRouter() {
      return AppRouter.__super__.constructor.apply(this, arguments);
    }

    AppRouter.prototype.routes = {
      '': 'index',
      'results': 'results',
      'csvPage': 'csvPage',
      'modelPage': 'modelPage',
      'logIn': 'logIn',
      'newUser': 'newUser',
      'failed': 'logIn'
    };

    AppRouter.prototype.index = function() {
      console.log("in index");
      $('#content').html(new window.welcomeView().$el);
    };

    AppRouter.prototype.results = function() {
      console.log("in results");
      $('#content').html(new window.resultsView().$el);
    };

    AppRouter.prototype.csvPage = function() {
      console.log("in csv");
      $('#content').html(new window.CSVView().$el);
    };

    AppRouter.prototype.modelPage = function() {
      console.log("in model");
      $('#content').html(new window.modelView().$el);
    };

    AppRouter.prototype.logIn = function() {
      console.log("in Sign in");
      $('#content').html(new window.logInView().$el);
    };

    AppRouter.prototype.newUser = function() {
      console.log("in newUser");
      $('#content').html(new window.newUserView().$el);
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

//# sourceMappingURL=app.map

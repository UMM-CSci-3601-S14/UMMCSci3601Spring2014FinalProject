// Generated by CoffeeScript 1.7.1
(function() {
  var User;

  User = require('../schemas/userSchema').user;

  exports.index = function(req, res) {
    console.log('inside index');
    res.locals = {
      title: 'LightSide',
      header: 'LightSide Test Page'
    };
    return res.render('index');
  };

  exports.results = function(req, res) {
    console.log('inside results');
    res.locals = {
      title: 'LightSide',
      header: 'LightSide Results Page'
    };
    return res.render('index');
  };

  exports.csvPage = function(req, res) {
    if (req.user === void 0) {
      return res.redirect('/logIn');
    } else {
      res.locals = {
        title: 'LightSide',
        header: 'LightSide CSV Upload Page'
      };
      return res.render('index');
    }
  };

  exports.modelPage = function(req, res) {
    res.locals = {
      title: 'LightSide',
      header: 'LightSide Model Maker'
    };
    return res.render('index');
  };

  exports.list = function(req, res) {
    return res.send("respond with a resource");
  };

  exports.failed = function(req, res) {
    res.locals = {
      title: 'Lightside',
      header: 'Failed Login',
      failed: 'Your username or password does not match!'
    };
    return res.render('index');
  };

  exports.user = function(req, res) {
    if (req.session.passport.user === void 0) {
      return res.redirect('/');
    } else {
      res.locals = {
        title: 'Lightside',
        header: 'Welcome ' + req.session.passport.user.username + '!'
      };
      return res.render('index');
    }
  };

  exports.logIn = function(req, res) {
    res.locals = {
      title: 'LightSide',
      header: 'LightSide Sign In'
    };
    return res.render('index');
  };

  exports.newUser = function(req, res) {
    res.locals = {
      title: 'LightSide',
      header: 'LightSide Register'
    };
    return res.render('index');
  };

  exports.create = function(req, res) {
    var newUser;
    newUser = new User(req.body);
    console.log('created user');
    newUser.save();
    return res.send(newUser);
  };

}).call(this);

//# sourceMappingURL=index.map

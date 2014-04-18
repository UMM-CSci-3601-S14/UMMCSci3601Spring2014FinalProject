// Generated by CoffeeScript 1.6.3
(function() {
  var User;

  User = require('../schemas/userSchema').user;

  exports.index = function(req, res) {
    console.log('inside index');
    if (req.user === void 0) {
      res.locals = {
        title: 'LightSide',
        header: 'LightSide Test Page'
      };
    } else {
      res.locals = {
        title: 'LightSide',
        header: 'LightSide Test Page',
        user: req.user
      };
    }
    return res.render('index');
  };

  exports.results = function(req, res) {
    console.log('inside results');
    res.locals = {
      title: 'LightSide',
      header: 'LightSide Results Page',
      user: req.user
    };
    return res.render('index');
  };

  exports.csvPage = function(req, res) {
    if (req.user === void 0) {
      return res.redirect('/logIn');
    } else {
      res.locals = {
        title: 'LightSide',
        header: 'LightSide CSV Upload Page',
        user: req.user
      };
      return res.render('index');
    }
  };

  exports.modelPage = function(req, res) {
    if (req.user === void 0) {
      return res.redirect('/logIn');
    } else {
      res.locals = {
        title: 'LightSide',
        header: 'LightSide Model Maker',
        user: req.user
      };
      return res.render('index');
    }
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
        header: 'Welcome ' + req.session.passport.user.username + '!',
        user: req.user
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

  exports.logout = function(req, res) {
    if (req.session.passport.user === void 0) {
      return res.redirect('/');
    } else {
      req.logout();
      return res.redirect('/');
    }
  };

  exports.account = function(req, res) {
    if (req.session.passport.user === void 0) {
      res.redirect('/logIn');
    } else {
      res.locals = {
        title: 'LightSide',
        header: 'Welcome ' + req.user.firstName,
        user: req.user
      };
    }
    return res.render('index');
  };

  exports.updatePassword = function(req, res) {
    var currentUser, newPass;
    if (req.user.password === req.body.oldPassword) {
      currentUser = req.user.username;
      newPass = req.body.newPassword;
      return User.update({
        username: currentUser
      }, {
        password: newPass
      }, function(err, numAffected, raw) {
        if (err) {
          console.log(err);
        }
        return console.log('The number of updated documents was %d', numAffected);
      });
    } else {
      return console.log('you are wrong');
    }
  };

  exports.create = function(req, res) {
    var newUser;
    newUser = new User(req.body);
    console.log(req.body);
    newUser.save();
    res.send(newUser);
    return res.redirect('/logIn');
  };

}).call(this);

/*
//@ sourceMappingURL=index.map
*/

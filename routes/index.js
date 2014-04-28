// Generated by CoffeeScript 1.7.1
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

  exports.dash = function(req, res) {
    if (req.session.passport.user === void 0) {
      return res.redirect('/login');
    } else {
      res.locals = {
        title: 'LightSide',
        header: 'Dashboard',
        user: req.user
      };
      return res.render('index');
    }
  };

  exports.uploadCSV = function(req, res) {
    if (req.user === void 0) {
      return res.redirect('/login');
    } else {
      res.locals = {
        title: 'LightSide',
        header: 'LightSide CSV Upload Page',
        username: req.user.username
      };
      return res.render('index');
    }
  };

  exports.csvPage = function(req, res) {
    if (req.user === void 0) {
      return res.redirect('/login');
    } else {
      res.locals = {
        title: 'LightSide',
        header: 'LightSide CSV Upload Page',
        user: req.user
      };
      return res.render('index');
    }
  };

  exports.uploadZip = function(req, res) {
    if (req.user === void 0) {
      return res.redirect('/login');
    } else {
      res.locals = {
        title: 'LightSide',
        header: 'LightSide CSV Upload Page',
        user: req.user
      };
      return res.render('index');
    }
  };

  exports.modelMaker = function(req, res) {
    if (req.user === void 0) {
      return res.redirect('/login');
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
      failed: 'Your email or password is incorrect!'
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

  exports.login = function(req, res) {
    res.locals = {
      title: 'LightSide',
      header: 'Sign In'
    };
    return res.render('index');
  };

  exports.newUser = function(req, res) {
    res.locals = {
      title: 'LightSide',
      header: 'Register'
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
      res.redirect('/login');
    } else {
      console.log(req.user);
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
      currentUser = req.user.email;
      newPass = req.body.newPassword;
      req.user.password = newPass;
      User.update({
        email: currentUser
      }, {
        password: newPass
      }, function(err, numAffected, raw) {
        if (err) {
          console.log(err);
        }
        return console.log('The number of updated documents was %d', numAffected);
      });
      return res.send(200, "Password changed successfully!");
    } else {
      return res.send(500, "Passwords do not match!");
    }
  };

  exports.create = function(req, res) {
    return User.findOne({
      email: req.body.email
    }, function(err, result) {
      var newUser;
      if (err) {
        console.log("err");
      }
      if (result) {
        return res.send(500, "Email is already being used");
      } else {
        newUser = new User(req.body);
        newUser.save();
        return res.send(200, "Password changed successfully!");
      }
    });
  };

  exports.getPromptArray = function(req, res) {
    var prompts;
    prompts = Array;
    return User.findOne({
      email: req.user.email
    }, {
      promptArray: true
    }, {
      _id: false
    }, function(err, result) {
      if (err) {
        res.send(500, "Prompts not found");
      }
      if (result) {
        prompts = result.promptArray;
        return res.send(prompts);
      } else {
        return res.send(500, "else");
      }
    });
  };

  exports.addPrompt = function(req, res) {
    var currentUser, promptToAdd;
    currentUser = req.user.email;
    promptToAdd = req.body.promptArray;
    User.update({
      email: currentUser
    }, {
      $push: {
        promptArray: promptToAdd
      }
    }, function(err, numAffected, raw) {
      if (err) {
        console.log(err);
      }
      return console.log('The number of updated documents was %d', numAffected);
    });
    return res.send(200, "Prompt was added to the user.");
  };

}).call(this);

//# sourceMappingURL=index.map

#
# * GET home page.
#
exports.index = (req, res) ->
  console.log 'inside index'
  res.locals = {
    title: 'LightSide'
    header: 'LightSide Test Page'
  }
  res.render 'index'

exports.results = (req, res) ->
  console.log 'inside results'
  res.locals = {
    title: 'LightSide'
    header: 'LightSide Results Page'
  }
  res.render 'index'

exports.csvPage = (req, res) ->
  res.locals = {
    title: 'LightSide'
    header: 'LightSide CSV Upload Page'
  }
  res.render 'index'

exports.modelPage = (req, res) ->
  res.locals = {
    title: 'LightSide'
    header: 'LightSide Model Maker'
  }
  res.render 'index'

exports.list = (req, res) ->
  res.send "respond with a resource"

exports.failed = (req, res) ->
  res.locals = {
    title: 'Lightside'
    header: 'Failed Login'
    failed: 'YOU HAVE FAILED!'
  }
  res.render 'index'

exports.user = (req, res) ->
  if (req.session.passport.user is undefined)
    res.redirect '/'
  else
    res.locals = {
      title: 'Lightside'
      header: 'Welcome ' + req.session.passport.user.username + '!'
    }
    res.render 'index'

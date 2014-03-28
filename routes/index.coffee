#
# * GET home page.
#
exports.index = (req, res) ->
  console.log 'inside index'
  res.locals = {
    title: 'LightSide',
    header: 'LightSide Test Page'
  }
  res.render 'index'

exports.results = (req, res) ->
  console.log 'inside results'
  res.locals = {
    title: 'LightSide',
    header: 'LightSide Results Page'
  }
  res.render 'index'

exports.csvPage = (req, res) ->
  res.locals = {
    title: 'LightSide',
    header: 'LightSide CSV Upload Page'
  }
  res.render 'index'

exports.list = (req, res) ->
  res.send "respond with a resource"

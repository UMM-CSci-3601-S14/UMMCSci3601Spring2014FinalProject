
###
Module dependencies.
###
express = require("express")
routes = require("./routes")

#
# * GET users listing.
# 
exports.list = (req, res) ->
  res.send "respond with a resource"
  return
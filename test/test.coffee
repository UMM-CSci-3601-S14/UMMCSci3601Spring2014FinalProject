describe 'testing a coffeescript cube function in the browser', ->
  it '3 cubed is 27', ->
    chai.assert.equal 27, cube(3)
  it '-3 cubed is -27', ->
    chai.assert.equal -27, cube(-3)
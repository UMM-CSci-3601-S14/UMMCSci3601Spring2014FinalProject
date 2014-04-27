assert = require('assert')
test = require('selenium-webdriver/testing')
webdriver = require('selenium-webdriver')
chai = require('chai')
#import our functions
Dictionary = require('../public/js/visualization').Dictionary
generateMap = require('../public/js/visualization').generateMap

#describe "Create paragraph", ->
#  describe "test 1", ->
#    it "should create a paragraph with given text", ->
#      assert.equal "2", "2"
#
#    it '3 cubed is 27', ->
#      chai.assert.equal 27, cube(3)
#    it '-3 cubed is -27', ->
#      chai.assert.equal -27, cube(-3)


######## Testing Dictionary ##########


describe 'dictionary tests', ->

  it 'empty keys in dictionary', ->
    emptyDict = new Dictionary()
    chai.assert.deepEqual [], emptyDict.keys
  it 'empty value in dictionary', ->
    emptyDict = new Dictionary()
    chai.assert.deepEqual [], emptyDict.values
  it 'adds one item to dictionary then checks the key', ->
    emptyDict = new Dictionary()
    emptyDict.add('item')
    chai.assert.deepEqual ['item'], emptyDict.keys
  it 'adds one item to dictionary then checks the value', ->
    emptyDict = new Dictionary()
    emptyDict.add('item')
    chai.assert.deepEqual [1], emptyDict.values
  it 'checks to see if value.length works', ->
    emptyDict = new Dictionary()
    emptyDict.add('item')
    emptyDict.add('item')
    emptyDict.add('item')
    emptyDict.add('otheritem')
    chai.assert.deepEqual 2, emptyDict.values.length
  it 'checks to see if keys.length works', ->
    emptyDict = new Dictionary()
    emptyDict.add('item')
    emptyDict.add('item')
    emptyDict.add('item')
    emptyDict.add('otheritem')
    chai.assert.deepEqual 2, emptyDict.values.length
  it 'adds 500 items to the Dictionary using a loop ', ->
    emptyDict = new Dictionary()
    i = 0
    while i < 500
      emptyDict.add "item"
      i++
    chai.assert.deepEqual [500], emptyDict.values
  it 'adds 500 items to the Dictionary using a loop then another 300 ', ->
    emptyDict = new Dictionary()
    i = 0
    while i < 500
      emptyDict.add "item"
      i++
    while i < 800
      emptyDict.add "otheritem"
      i++
    chai.assert.deepEqual [500, 300], emptyDict.values
  it 'adds 500 items to the Dictionary using a loop then another 300, checks the keys ', ->
    emptyDict = new Dictionary()
    i = 0
    while i < 500
      emptyDict.add "item"
      i++
    while i < 800
      emptyDict.add "otheritem"
      i++
    chai.assert.deepEqual ['item','otheritem'], emptyDict.keys



##### Test GenerateMap #####

describe 'testing GenerateMap', ->
  it 'should test to see if .values is working', ->
    numbers = ['1', '1', '1', '1', '1', '1', '1', '1', '1']

    chai.assert.deepEqual generateMap(numbers).values, [9];

    numbers = ['1', '2', '3', '4', '5', '6', '7', '8', '9']
    chai.assert.deepEqual generateMap(numbers).values, [1,1,1,1,1,1,1,1,1]

    numbers = ['1', '1', '2', '2', '5', '5', '7', '8', '9', '1']
    chai.assert.deepEqual generateMap(numbers).values, [3,2,2,1,1,1]

  it 'should test keys', ->
    blankArray = []
    chai.assert.deepEqual generateMap(blankArray).keys, new Dictionary().keys;

    numbers = ['1', '1', '1', '1', '1', '1', '1', '1', '1']
    chai.assert.deepEqual generateMap(numbers).keys, ['1'];

    numbers = ['1', '2', '3', '1', '1', '1', '1', '1', '1']
    chai.assert.deepEqual generateMap(numbers).keys, ['1', '2', '3'];

    numbers = ['1', '2', '3', '4', '5', '6', '7', '8', '9']
    chai.assert.deepEqual generateMap(numbers).keys, ['1', '2', '3', '4', '5', '6', '7', '8', '9'];


#testing front end API calls
###

test.describe "gradingOnTheDemo", ->
  test.describe "testABadPaper", ->
    test.it "should return the label being 1", ->
      driver = new webdriver.Builder().withCapabilities(webdriver.Capabilities.chrome()).build()
      driver.get('http://localhost:3000/')

      driver.findElement(webdriver.By.id('essayContents')).sendKeys("this paper should return a 1")
      driver.findElement(webdriver.By.id('submitEssay')).click()
      driver.sleep(4000)
      driver.findElement(webdriver.By.id('grade')).getAttribute('textContent').then (value) ->
        assert.equal value, "Your grade for the submitted essay is 1 out of 5."
        driver.close()


  test.describe "testAnOkayPaper", ->
    test.it "should return the label being 3", ->
      paper = "Computers can calculate and figure out things much quicker than the average person. This process cannot only save time, but money too. Stock trading is now on the Internet, along with banking and any other type of business you could imagine. The world wants thing to be quick and easy. The best answer to that is to have a computer do it for you. In the future, hundreds of millions of jobs will be taken away from honest hard-working employees and will be given to computers. No matter what choices we make, or what plans we change, these outcomes are going to become real. Why would a business pay someone to take phone orders, when a computer can do it in less time and make it both cheaper and easier for the business and the buyer? Computers and the Internet are definitely affecting the way we entertain ourselves. The most basic example is card games. If the computer can deal out cards on a screen with the click of a button, why would anyone want to deal out a deck of cards manually and have to clean them up afterwards? On the Internet, you can gamble with on-line casinos, place bets on a horse race, or even watch movies. People can do all of these activities in the comfort of their own home. No gas money is wasted or time spent driving around to find entertainment so people are happy. The inevitable outcome of this magnificent invention is going to change the world. Society is happy about the way things are changing. Cheaper is better, less time consuming is better. With the choice of having a computer and being on-line, there is almost nothing you cannot do. This remarkable idea of the Internet is going to revolutionize the way we live in the future."
      driver = new webdriver.Builder().withCapabilities(webdriver.Capabilities.chrome()).build()
      driver.get('http://localhost:3000/')

      driver.findElement(webdriver.By.id('essayContents')).sendKeys(paper)
      driver.findElement(webdriver.By.id('submitEssay')).click()

      driver.sleep(4000)

      driver.findElement(webdriver.By.id('grade')).getAttribute('textContent').then (value) ->
        assert.equal(value, "Your grade for the submitted essay is 3 out of 5.")
        driver.close()

  test.describe "testAGoodPaper", ->
    test.it "should return the label being 5", ->
      paper = "Before we know it, technology is going to pass us by. With the invention of the computer and the Internet, the possibilities are endless. Society is changing by leaps and bounds, with no chance of a stopping point in the near future. All this change is dealing with computers and the effects that it will have on the way we live tomorrow. The Internet affects us in every way, most importantly with our social lives, our jobs, and our entertainment. Our social lives are not just communicating with telephones and mail anymore. Going “on-line” is the new way we like to communicate with people. Chat rooms on the Internet are open for people to talk and explore with other people who may live on the other side of the world or the other side of the street. E-Mail is also another popular way to correspond with others. Users can electronically send mail to another person with an on-line mailbox, simply by typing in their message and sending it by the click of a button. Two seconds to send e-mail to someone on the other side of the world is much quicker than a week or more through the ordinary mail. The Internet can also affect our jobs. Computers can calculate and figure out things much quicker than the average person. This process cannot only save time, but money too. Stock trading is now on the Internet, along with banking and any other type of business you could imagine. The world wants thing to be quick and easy. The best answer to that is to have a computer do it for you. In the future, hundreds of millions of jobs will be taken away from honest hard-working employees and will be given to computers. No matter what choices we make, or what plans we change, these outcomes are going to become real. Why would a business pay someone to take phone orders, when a computer can do it in less time and make it both cheaper and easier for the business and the buyer? Computers and the Internet are definitely affecting the way we entertain ourselves. The most basic example is card games. If the computer can deal out cards on a screen with the click of a button, why would anyone want to deal out a deck of cards manually and have to clean them up afterwards? On the Internet, you can gamble with on-line casinos, place bets on a horse race, or even watch movies. People can do all of these activities in the comfort of their own home. No gas money is wasted or time spent driving around to find entertainment so people are happy. The inevitable outcome of this magnificent invention is going to change the world. Society is happy about the way things are changing. Cheaper is better, less time consuming is better. With the choice of having a computer and being on-line, there is almost nothing you cannot do. This remarkable idea of the Internet is going to revolutionize the way we live in the future."
      driver = new webdriver.Builder().withCapabilities(webdriver.Capabilities.chrome()).build()
      driver.get('http://localhost:3000/')

      driver.findElement(webdriver.By.id('essayContents')).sendKeys(paper)
      driver.findElement(webdriver.By.id('submitEssay')).click()

      driver.sleep(4000)

      driver.findElement(webdriver.By.id('grade')).getAttribute('textContent').then (value) ->
        assert.equal(value, "Your grade for the submitted essay is 5 out of 5.")

        driver.close()
###

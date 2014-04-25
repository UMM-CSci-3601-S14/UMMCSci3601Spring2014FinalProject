// Generated by CoffeeScript 1.7.1
(function() {
  describe('dictionary tests', function() {
    it('empty keys in dictionary', function() {
      var emptyDict;
      emptyDict = new Dictionary();
      return chai.assert.deepEqual([], emptyDict.keys);
    });
    it('empty value in dictionary', function() {
      var emptyDict;
      emptyDict = new Dictionary();
      return chai.assert.deepEqual([], emptyDict.values);
    });
    it('adds one item to dictionary then checks the key', function() {
      var emptyDict;
      emptyDict = new Dictionary();
      emptyDict.add('item');
      return chai.assert.deepEqual(['item'], emptyDict.keys);
    });
    it('adds one item to dictionary then checks the value', function() {
      var emptyDict;
      emptyDict = new Dictionary();
      emptyDict.add('item');
      return chai.assert.deepEqual([1], emptyDict.values);
    });
    it('checks to see if value.length works', function() {
      var emptyDict;
      emptyDict = new Dictionary();
      emptyDict.add('item');
      emptyDict.add('item');
      emptyDict.add('item');
      emptyDict.add('otheritem');
      return chai.assert.deepEqual(2, emptyDict.values.length);
    });
    it('checks to see if keys.length works', function() {
      var emptyDict;
      emptyDict = new Dictionary();
      emptyDict.add('item');
      emptyDict.add('item');
      emptyDict.add('item');
      emptyDict.add('otheritem');
      return chai.assert.deepEqual(2, emptyDict.values.length);
    });
    it('adds 500 items to the Dictionary using a loop ', function() {
      var emptyDict, i;
      emptyDict = new Dictionary();
      i = 0;
      while (i < 500) {
        emptyDict.add("item");
        i++;
      }
      return chai.assert.deepEqual([500], emptyDict.values);
    });
    it('adds 500 items to the Dictionary using a loop then another 300 ', function() {
      var emptyDict, i;
      emptyDict = new Dictionary();
      i = 0;
      while (i < 500) {
        emptyDict.add("item");
        i++;
      }
      while (i < 800) {
        emptyDict.add("otheritem");
        i++;
      }
      return chai.assert.deepEqual([500, 300], emptyDict.values);
    });
    return it('adds 500 items to the Dictionary using a loop then another 300, checks the keys ', function() {
      var emptyDict, i;
      emptyDict = new Dictionary();
      i = 0;
      while (i < 500) {
        emptyDict.add("item");
        i++;
      }
      while (i < 800) {
        emptyDict.add("otheritem");
        i++;
      }
      return chai.assert.deepEqual(['item', 'otheritem'], emptyDict.keys);
    });
  });

  describe('testing GenerateMap', function() {
    it('should test to see if .values is working', function() {
      var numbers;
      numbers = ['1', '1', '1', '1', '1', '1', '1', '1', '1'];
      chai.assert.deepEqual(generateMap(numbers).values, [9]);
      numbers = ['1', '2', '3', '4', '5', '6', '7', '8', '9'];
      chai.assert.deepEqual(generateMap(numbers).values, [1, 1, 1, 1, 1, 1, 1, 1, 1]);
      numbers = ['1', '1', '2', '2', '5', '5', '7', '8', '9', '1'];
      return chai.assert.deepEqual(generateMap(numbers).values, [3, 2, 2, 1, 1, 1]);
    });
    return it('should test keys', function() {
      var blankArray, numbers;
      blankArray = [];
      chai.assert.deepEqual(generateMap(blankArray).keys, new Dictionary().keys);
      numbers = ['1', '1', '1', '1', '1', '1', '1', '1', '1'];
      chai.assert.deepEqual(generateMap(numbers).keys, ['1']);
      numbers = ['1', '2', '3', '1', '1', '1', '1', '1', '1'];
      chai.assert.deepEqual(generateMap(numbers).keys, ['1', '2', '3']);
      numbers = ['1', '2', '3', '4', '5', '6', '7', '8', '9'];
      return chai.assert.deepEqual(generateMap(numbers).keys, ['1', '2', '3', '4', '5', '6', '7', '8', '9']);
    });
  });

}).call(this);

//# sourceMappingURL=test.map

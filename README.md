# GameMaker Unittest

An automated unit testing framework built in GameMaker made for GameMaker.

Compatable with GameMaker version 2.3+

version 0.0.1

## Basic example

The most basic elements that GameMaker Unittest needs to function are:

1. Create TestSuite
2. Create TestCase
3. Add TestCase to TestSuite
4. Run TestSuite

```js
// Create TestSuite
suite = new TestSuite();

// Create TestCase
testAdd = new TestCase(function() {
	var sum = 2 + 3;
	self.assertEqual(sum, 5);
}, "testAdd");
// Add TestCase to TestSuite
suite.addTest(testAdd);

// Run TestSuite
suite.run();
```

**TestCase**
A _TestCase_ is where the actions of the test are stored. TestCase expects the test to be passed as a script or method function. 

## Naming your tests

It's a good idea to give your tests descriptive names, this will make it easier if you have to go back in your code and find the TestCase. 

## License

[MIT License](https://opensource.org/licenses/MIT)

Copywrite (c) 2020 bfrymire

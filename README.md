<div style="text-align:center;"><img src="./LOGO.png" style="display:block;width:250px;margin:auto;"></div>

# crispy 0.0.1

An automated unit testing framework built in GML for GameMaker Studio 2.3+

## Basic example

The most basic elements that Crispy needs to function are:

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

###TestSuite

A _TestSuite_ is where the TestCases are stored. When `TestSuite.run()`  is executed, the TestSuite will iterate through every supplied TestCase and run its test.

###TestCase

A _TestCase_ is where the actions of the test are stored. Pass the test to the TestCase in the type of a method function. A name can also be supplied to the TestCase

## License

[MIT License](https://opensource.org/licenses/MIT)

Copywrite (c) 2020 bfrymire

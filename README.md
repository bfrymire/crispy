
<p align="center"><img src="./LOGO.png" style="display:block;width:250px; margin:auto;"></p>

<h1>crispy</h1>
<p>Version 1.0.1</p>
<p>An automated unit testing framework built in GML for GameMaker Studio 2.3+</p>


<h2>Basic example</h2>
<p>The most basic elements that Crispy needs to function are:</p>

<ol>
	<li>Create TestRunner</li>
	<li>Create TestSuite</li>
	<li>Add TestSuite to TestRunner</li>
	<li>Create TestCase</li>
	<li>Add TestCase to TestSuite</li>
	<li>Run TestRunner</li>
</ol>


```js
// Create Testrunner
runner = new TestRunner();

// Create TestSuite
suite = new TestSuite();

// Add TestSuite to TestRunner
runner.addTestSuite(suite);

// Create TestCase
testAdd = new TestCase(function() {
	var sum = 2 + 3;
	self.assertEqual(sum, 5);
}, "testAdd");

// Add TestCase to TestSuite
suite.addTestCase(testAdd);

// Run TestRunner
runner.run();
```


<h2>Installation</h2>
<a href="https://github.com/bfrymire/crispy/releases/tag/v.1.0.1">Download the .yymps file</a>

A good starting point is copying and pasting the code from the <a href="#basic-example">Basic Example</a> section into the Create Event of an object created specifically for running tests.

Expand upon the code to suit your testing needs.


<h2>TestCase Assertions</h2>

| Method function | Checks that |
|--|--|
| `assertEqual(a, b)` | `a == b` |
| `assertNotEqual(a, b)` | `a != b` |
| `assertTrue(a)` | `bool(a) == true` |
| `assertFalse(a)` | `bool(a) == false` |

<i>TestCase</i><samp>.assertEqual(first, second, [msg=undefined])</samp> - Will check if first and second are the same type. If they are not, the test will fail and an error message will output with their types. If they are the same type, they'll be checked if they're equal and determine whether or not it's equal.

<i>TestCase</i><samp>.assertNotEqual(first, second, [msg=undefined])</samp> - Checks whether or not the first and second are not equal.

<i>TestCase</i><samp>.assertTrue(expr, [msg=undefined])</samp> - Will try and convert <samp>expr</samp> into the <samp>typeof</samp> <samp>bool</samp>. If it's unable to do so, an error message will display and the test will fail. After successfully converting the <samp>expr</samp>, the test will check Checks whether or not <samp>bool(expr)</samp> is true.

<i>TestCase</i><samp>.assertFalse(expr, [msg=undefined])</samp> - Will try and convert <samp>expr</samp> into the <samp>typeof</samp> <samp>bool</samp>. If it's unable to do so, an error message will display and the test will fail. After successfully converting the <samp>expr</samp>, the test will check Checks whether or not <samp>bool(expr)</samp> is false.


<h2>setUp() and tearDown()</h2>
<samp>TestRunner</samp>, <samp>TestSuite</samp>, and <samp>TestCase</samp> all have a <samp>setUp()</samp> and <samp>tearDown()</samp> function that comes with pre-defined instructions. Custom code can be ran along-side the pre-defined instructions, you can pass a method function into the functions.

<samp>.setUp([method function])</samp> - Provide a method function to run during <samp>setUp()</samp>. If anything other than a method function is provided, an error message will be thrown.

<samp>.tearDown([method function])</samp> - Provide a method function to run during <samp>tearDown()</samp>. If anything other than a method function is provided, an error message will be thrown.

```js
testAdd = new TestCase(function() {
	self.assertEqual(_number, 24);
}, "testAdd");
testAdd.setUp(function() {
	_number = 24;
});
testAdd.tearDown(function() {
	show_debug_message("Your number is: " + string(_number));
});
```

In the example above, we're able to add instructions to this <samp>TestCase.setUp()</samp> and <samp>TestCase.tearDown()</samp> functions. These functions are very powerful. Notice in the example that we're able to define a variable to the <samp>TestCase</samp> in the <samp>setUp()</samp> function and be able to call upon it in the <samp>test()</samp> and <samp>tearDown()</samp> functions. Passing variables in this fashion applies the variables directly to the structure. This could possibly lead to you overwritting variables and breaking the objects. Be careful with these functions.


<h2>License</h2>
<a href="https://opensource.org/licenses/MIT" _target="blank">MIT License</a>
<p>Copyright (c) 2020 bfrymire</p>

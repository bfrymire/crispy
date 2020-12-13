<p align="center"><img src="./LOGO.png" style="display:block;width:250px; margin:auto;"></p>

<h1>crispy</h1>
<p>Version 1.0.2</p>
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
<a href="https://github.com/bfrymire/crispy/releases/tag/v1.0.2">Download the .yymps file</a>

A good starting point is copying and pasting the code from the <a href="#basic-example">Basic Example</a> section into the Create Event of an object created specifically for running tests.

Expand upon the code to suit your testing needs.


<h2>TestCase Assertions</h2>

| Method function | Checks that |
|--|--|
| `assertEqual(a, b)` | `a == b` |
| `assertNotEqual(a, b)` | `a != b` |
| `assertTrue(x)` | `bool(x) == true` |
| `assertFalse(x)` | `bool(x) == false` |
| `assertIsNoone(x)` | `x == -4` |
| `assertIsNotNoone(x)` | `x != -4` |

<samp><b>assertEqual(first, second, [msg=undefined])</b></samp>
<br>
<samp><b>assertNotEqual(first, second, [msg=undefined])</b></samp>

<samp>assertEqual</samp> will check if <samp>first</samp> and <samp>second</samp> are the same type. If they are not, the test will immediately fail and log an error message. If they are the same type, the test checks whether or not <samp>first</samp> and <samp>second</samp> are equal based on the function name.

<samp><b>assertTrue(expr, [msg=undefined])</b></samp>
<br>
<samp><b>assertFalse(expr, [msg=undefined])</b></samp>

<samp>assertTrue</samp> will try and convert <samp>expr</samp> into a boolean value. If it's unable to do so, the test will immediately fail and log an error message. After successfully converting the <samp>expr</samp>, the test checks whether or not <samp>bool(expr)</samp> is true based on the function name.

<samp><b>assertIsNoone(expr, [msg=undefined])</b></samp>
<br>
<samp><b>assertIsNotNoone(expr, [msg=undefined])</b></samp>

The keyword <samp>noone</samp> has a value of -4. Checks whether or not <samp>expr</samp> is -4 based on the function name.

<h2>setUp() and tearDown()</h2>
<samp>TestRunner</samp>, <samp>TestSuite</samp>, and <samp>TestCase</samp> all have a <samp>setUp()</samp> and <samp>tearDown()</samp> function that comes with pre-defined instructions. Custom code can be ran along-side the pre-defined instructions, you can pass a method function into the functions.

<samp><b>setUp([method function])</b></samp>
Provide a method function to run during <samp>setUp()</samp>. If anything other than a method function is provided, an error message will be thrown.

<samp><b>tearDown([method function])</b></samp>
Provide a method function to run during <samp>tearDown()</samp>. If anything other than a method function is provided, an error message will be thrown.

```js
// Create TestCase
testAdd = new TestCase(function() {
	self.assertEqual(_number, 24);
}, "testAdd");

// Define setUp() function
testAdd.setUp(function() {
	_number = 24;
});

// Define tearDown() function
testAdd.tearDown(function() {
	show_debug_message("Your number is: " + string(_number));
});
```

In the example above, we're able to add instructions to this <samp>TestCase.setUp()</samp> and <samp>TestCase.tearDown()</samp> functions. These functions are very powerful. Notice in the example that we're able to define a variable to the <samp>TestCase</samp> in the <samp>setUp()</samp> function and be able to call upon it in the <samp>test()</samp> and <samp>tearDown()</samp> functions. Passing variables in this fashion applies the variables directly to the structure. This could possibly lead to you overwritting variables and breaking the objects. Be careful with these functions.


<h2>License</h2>
<a href="https://opensource.org/licenses/MIT" _target="blank">MIT License</a>
<p>Copyright (c) 2020 bfrymire</p>

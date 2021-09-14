<p align="center"><img src="./LOGO.png" style="margin:auto;"></p>

<h1>crispy</h1>
<p>Version 1.2.0</p>
<p>An automated unit testing framework built in GML for GameMaker Studio 2.3+</p>


<h2>Basic Example</h2>
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
// Create TestRunner
runner = new TestRunner();

// Create TestSuite
suite = new TestSuite();

// Add TestSuite to TestRunner
runner.addTestSuite(suite);

// Create TestCase
test_sum = new TestCase(function() {
	var sum = 2 + 3;
	self.assertEqual(sum, 5);
}, "test_sum");

// Add TestCase to TestSuite
suite.addTestCase(test_sum);

// Run TestRunner
runner.run();
```


<h2>Installation</h2>

<ol>
	<li>
		<a href="https://github.com/bfrymire/crispy/releases/latest">Download the .yymps file</a>	
	</li>
	<li>
		Import the .yymps file into your project from the top menu
		<ul>
			<li>
				Tools <b>></b> Import Local Package
			</li>
		</ul>
	</li>
</ol>


A good starting point is copying and pasting the code from the <a href="#basic-example">Basic Example</a> section into the Create Event of an object created specifically for running tests.

Expand upon the code to suit your testing needs.


<h2>TestCase Assertions</h2>

| Function | Checks that |
|--|--|
| `assertEqual(a, b)` | `a == b` |
| `assertNotEqual(a, b)` | `a != b` |
| `assertTrue(x)` | `bool(x) == true` |
| `assertFalse(x)` | `bool(x) == false` |
| `assertIsNoone(x)` | `x == -4` |
| `assertIsNotNoone(x)` | `x != -4` |
| `assertIsUndefined(x)` | `is_undefined(x)` |
| `assertIsNotUndefined(x)` | `!is_undefined(x)` |

<samp><b>assertEqual(first, second, [msg=undefined])</b></samp>
<br>
<samp><b>assertNotEqual(first, second, [msg=undefined])</b></samp>
<br>
<samp>assertEqual</samp> will check if <samp>first</samp> and <samp>second</samp> are the same type. If they are not, the test will immediately fail and log an error message. If they are the same type, the test checks whether or not <samp>first</samp> and <samp>second</samp> are equal based on the function name.

<samp><b>assertTrue(expr, [msg=undefined])</b></samp>
<br>
<samp><b>assertFalse(expr, [msg=undefined])</b></samp>
<br>
<samp>assertTrue</samp> will try and convert <samp>expr</samp> into a boolean value. If it's unable to do so, the test will immediately fail and log an error message. After successfully converting the <samp>expr</samp>, the test checks whether or not <samp>bool(expr)</samp> is true based on the function name.

<samp><b>assertIsNoone(expr, [msg=undefined])</b></samp>
<br>
<samp><b>assertIsNotNoone(expr, [msg=undefined])</b></samp>
<br>
The keyword <samp>noone</samp> has a value of -4. Checks whether or not <samp>expr</samp> is -4 based on the function name.

<samp><b>assertIsUndefined(expr, [msg=undefined])</b></samp>
<br>
<samp><b>assertIsNotUndefined(expr, [msg=undefined])</b></samp>
<br>
Checks whether or not <samp>expr</samp> is undefined based on the function name.

<h2>setUp() and tearDown()</h2>
<samp>TestRunner</samp>, <samp>TestSuite</samp>, and <samp>TestCase</samp> all have a <samp>setUp()</samp> and <samp>tearDown()</samp> function that comes with pre-defined instructions. By providing a function, the function will be ran alongside the pre-defined instructions.

<samp><b>setUp([function])</b></samp>
<br>
Provide a function to run during <samp>setUp()</samp>. If anything other than a function is provided, an error message will be thrown.

<samp><b>tearDown([function])</b></samp>
<br>
Provide a function to run during <samp>tearDown()</samp>. If anything other than a function is provided, an error message will be thrown.

```js
// Create TestCase
test_example = new TestCase(function() {
	self.assertEqual(_number, 24); // The _number variable is defined in the setUp() function
}, "test_example");

// Define setUp() function
test_example.setUp(function() {
	_number = 24; // Here we're defining a variable to use in our test
});

// Define tearDown() function
test_example.tearDown(function() {
	show_debug_message("Your number is: " + string(_number)); // We can call our _number variable in the tearDown() too
});
```

In the example above, we're able to add instructions to this <samp>TestCase.setUp()</samp> and <samp>TestCase.tearDown()</samp> functions. These functions are very powerful. Notice in the example that we're able to define a variable to the <samp>TestCase</samp> in the <samp>setUp()</samp> function and be able to call upon it in the <samp>test()</samp> and <samp>tearDown()</samp> functions. Passing variables in this fashion applies the variables directly to the structure. This could possibly lead to you overwriting variables and breaking the objects. Be careful with these functions.


<h2>License</h2>
<a href="https://opensource.org/licenses/MIT" _target="blank">MIT License</a>
<p>Copyright (c) 2020-2021 bfrymire</p>
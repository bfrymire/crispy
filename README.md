<p align="center"><img src="./LOGO.png" style="display:block;width:250px; margin:auto;"></p>

<h1>crispy</h1>
<p>Version 0.0.1</p>
<p>An automated unit testing framework built in GML for GameMaker Studio 2.3+</p>

<h2>Basic example</h2>
<p>The most basic elements that Crispy needs to function are:</p>

<ol>
	<li>Create TestSuite</li>
	<li>Create TestCase</li>
	<li>Add TestCase to TestSuite</li>
	<li>Run TestSuite</li>
</ol>

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

<b>TestSuite</b>
<p>A <i>TestSuite</i> is where the TestCases are stored. When <samp>TestSuite.run()</samp>  is executed, the TestSuite will iterate through every supplied TestCase and run its test.</p>

<b>TestCase</b>
<p>A <i>TestCase</i> is where the actions of the test are stored. Pass the test to the TestCase in the type of a method function. A name can also be supplied to the TestCase</p>

<h2>Installation</h2>
<a href="https://github.com/bfrymire/crispy/releases/tag/v.0.0.1">Download the .yymp file</a>

<h2>License</h2>
<a href="https://opensource.org/licenses/MIT" _target="blank">MIT License</a>
<p>Copywrite (c) 2020 bfrymire</p>

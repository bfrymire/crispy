<p align="center"><img src="./LOGO.png" style="display:block;width:250px; margin:auto;"></p>

<h1>crispy</h1>
<p>Version 0.0.1</p>
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

<b>TestRunner</b>
<p>A <i>TestRunner</i> is where the test suites are stored. When <samp>TestRunner.run()</samp> is executed, the test runner will iterate through its test suites, then every test suite's test case, and run the test. A name can be given to the test runner.</p>

<b>TestSuite</b>
<p>A <i>TestSuite</i> is where the test cases are stored for more organization. A name can be given to the test suite.</p>

<b>TestCase</b>
<p>A <i>TestCase</i> is where the actions of the test are stored. Give the test to the test case in the type of a method function. A name can also be given to the test case.</p>

<h2>Installation</h2>
<a href="https://github.com/bfrymire/crispy/releases/tag/v.0.0.1">Download the .yymp file</a>

<h2>License</h2>
<a href="https://opensource.org/licenses/MIT" _target="blank">MIT License</a>
<p>Copywrite (c) 2020 bfrymire</p>

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


<b>TestRunner</b><samp>([struct_unpack])</samp>
<p>A <i>TestRunner</i> is where the test suites are stored. When <samp>TestRunner.run()</samp> is executed, the test runner will iterate through its test suites, then every test suite's test case, and run the test. A name can be given to the test runner.</p>

<samp>.setUp([method function])</samp> Specify instructions to run at the start of the <samp>run</samp> sequence. If provided with a method function, <samp>setUp</samp> will run that function when called.
<samp>.\_\_setUp(method function)</samp> Function that is ran along side the default <samp>setUp</samp>. Use <samp>.setUp(method function)</samp> to edit this function.
<samp>.tearDown([method function])</samp> Specify instructions to run at the end of the <samp>run</samp> sequence. If provided with a method function, <samp>tearDown</samp> will run that function when called.
<samp>.\_\_tearDown(method function)</samp> Function that is ran along side the default <samp>tearDown</samp>. Use <samp>.tearDown(method function)</samp> to edit this function.
<samp>.run()</samp> Iterates through the <samp>suites</samp> and runs each <samp>test</samp>.
<samp>.addLog(log)</samp> Add a <samp>crispyLog</samp> object to the <samp>logs</samp> array. When running a <samp>TestCase</samp>, it will capture all logs from the test.
<samp>.captureLogs({TestSuite|TestCase|crispyLog})</samp> Will recursively capture and add all <samp>crispyLog</samp> objects from the provided object.
<samp>.addTestSuite(TestSuite)</samp> Add the supplied <samp>TestSuite</samp> object as a child suite.
<samp>.hr([string], [length])</samp> Display a horizontal row. It will output "-" * 70 by default, but can be overwritten by supplying a string and number between 0 and 120.


<b>TestSuite</b><samp>([struct_unpack])</samp>
<p>A <i>TestSuite</i> is where the test cases are stored for more organization. A name can be given to the test suite.</p>

<samp>.setUp([method function])</samp> Specify instructions to run at the start of the <samp>run</samp> sequence. If provided with a method function, <samp>setUp</samp> will run that function when called.
<samp>.\_\_setUp(method function)</samp> Function that is ran along side the default <samp>setUp</samp>. Use <samp>.setUp(method function)</samp> to edit this function.
<samp>.tearDown([method function])</samp> Specify instructions to run at the end of the <samp>run</samp> sequence. If provided with a method function, <samp>tearDown</samp> will run that function when called.
<samp>.\_\_tearDown(method function)</samp> Function that is ran along side the default <samp>tearDown</samp>. Use <samp>.tearDown(method function)</samp> to edit this function.
<samp>.run()</samp> Runs each test added to the <samp>suite</samp>.
<samp>.addTestCase(TestCase)</samp> Add the supplied <samp>TestCase</samp> object as a child test case.


<b>TestCase</b><samp>([name], [struct_unpack])</samp>
<p>A <i>TestCase</i> is where the actions of the test are stored. Give the test to the test case in the type of a method function. A name can also be given to the test case.</p>

<samp>.setUp([method function])</samp> Specify instructions to run at the start of the <samp>run</samp> sequence. If provided with a method function, <samp>setUp</samp> will run that function when called.
<samp>.\_\_setUp(method function)</samp> Function that is ran along side the default <samp>setUp</samp>. Use <samp>.setUp(method function)</samp> to edit this function.
<samp>.tearDown([method function])</samp> Specify instructions to run at the end of the <samp>run</samp> sequence. If provided with a method function, <samp>tearDown</samp> will run that function when called.
<samp>.\_\_tearDown(method function)</samp> Function that is ran along side the default <samp>tearDown</samp>. Use <samp>.tearDown(method function)</samp> to edit this function.
<samp>.run()</samp> Runs the test.



<h2>Installation</h2>
<a href="https://github.com/bfrymire/crispy/releases/tag/v.1.0.1">Download the .yymp file</a>


<h2>License</h2>
<a href="https://opensource.org/licenses/MIT" _target="blank">MIT License</a>
<p>Copyright (c) 2020 bfrymire</p>

can_run_tests = true;

// Setting up text to display on screen
display_text = CRISPY_NAME + " " + CRISPY_VERSION + "\n\n";
display_text += "View the Output Window to see the test results.\n";
display_text += "Press \"R\" to re-run tests.";


/**
 * Adds two numbers together
 * @function
 * @param {real} a - Number to be added
 * @param {real} b - Number to be added
 * @returns {real} Sum of a and b
 */
add = function(a, b) {
	return a + b;
}


// Create TestRunner
runner = new TestRunner();

// Create TestSuite
suite = new TestSuite();

// Add TestSuite to TestRunner
runner.addTestSuite(suite);


// Create TestCase for custom add function defined above
testAddFunction = new TestCase(function() {
	var _number = other.add(10, 5);
	assertEqual(_number, 15);
}, "testAddFunction");

// Add TestCase to TestSuite
suite.addTestCase(testAddFunction);


// Create TestCase for assertion functions
testEqual = new TestCase(function() {
	assertEqual(10, 10);
}, "testEqual");
suite.addTestCase(testEqual);

testNotEqual = new TestCase(function() {
	assertNotEqual(1, 5);
}, "testNotEqual");
suite.addTestCase(testNotEqual);

testTrue = new TestCase(function() {
	assertTrue(true);
}, "testTrue");
suite.addTestCase(testTrue);

testFalse = new TestCase(function() {
	assertFalse(false);
}, "testFalse");
suite.addTestCase(testFalse);

testIsNooneKeyword = new TestCase(function() {
	assertIsNoone(noone);
}, "testIsNooneKeyword");
suite.addTestCase(testIsNooneKeyword);

testIsNooneNumber = new TestCase(function() {
	assertIsNoone(-4);
}, "testIsNooneNumber");
suite.addTestCase(testIsNooneNumber);

testIsNotNoone = new TestCase(function() {
	assertIsNotNoone(all);
}, "testIsNotNoone");
suite.addTestCase(testIsNotNoone);

testIsUndefined = new TestCase(function() {
	assertIsUndefined(undefined);
}, "testIsUndefined");
suite.addTestCase(testIsUndefined);

testIsNotUndefined = new TestCase(function() {
	assertIsNotUndefined(undefined);
}, "testIsNotUndefined");
suite.addTestCase(testIsNotUndefined);


// Failure without custom message
testFailureTypes = new TestCase(function() {
	assertEqual(3, "String");
}, "testFailureTypes");
suite.addTestCase(testFailureTypes);

// Failure with custom message
testFailureCustomMessage = new TestCase(function() {
	assertFalse(instance_exists(obj_test), "This is a custom failure message.");
}, "testFailureCustomMessage");
suite.addTestCase(testFailureCustomMessage);


// Discovering test scripts
runner.discover();
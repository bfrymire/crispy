can_run_tests = true;
display_text = CRISPY_NAME + " " + CRISPY_VERSION + "\n\n";
display_text += "View the Output Window to see the test results.\n";
display_text += "Press \"R\" to re-run tests.";


/// Custom function to test
function add(a, b) {
	return a + b;
}


// Create TestRunner
runner = new TestRunner();

// Create TestSuite
suite = new TestSuite();

// Add TestSuite to TestRunner
runner.addTestSuite(suite);


// Create TestCase for our custom function
testAddFunction = new TestCase(function() {
	var _number = other.add(10, 5);
	self.assertEqual(_number, 15);
}, "testAddFunction");

// Add TestCase to TestSuite
suite.addTestCase(testAddFunction);


// Create TestCase for the rest of the assertion functions
testEqual = new TestCase(function() {
	self.assertEqual(10, 10);
}, "testEqual");
suite.addTestCase(testEqual);

testNotEqual = new TestCase(function() {
	self.assertNotEqual(1, 5);
}, "testNotEqual");
suite.addTestCase(testNotEqual);

testTrue = new TestCase(function() {
	self.assertTrue(true);
}, "testTrue");
suite.addTestCase(testTrue);

testFalse = new TestCase(function() {
	self.assertFalse(false);
}, "testFalse");
suite.addTestCase(testFalse);

testIsNooneKeyword = new TestCase(function() {
	self.assertIsNoone(noone);
}, "testIsNooneKeyword");
suite.addTestCase(testIsNooneKeyword);

testIsNooneNumber = new TestCase(function() {
	self.assertIsNoone(-4);
}, "testIsNooneNumber");
suite.addTestCase(testIsNooneNumber);

testIsNotNoone = new TestCase(function() {
	self.assertIsNotNoone(all);
}, "testIsNotNoone");
suite.addTestCase(testIsNotNoone);

testIsUndefined = new TestCase(function() {
	self.assertIsUndefined(undefined);
}, "testIsUndefined");
suite.addTestCase(testIsUndefined);

testIsNotUndefined = new TestCase(function() {
	self.assertIsNotUndefined(undefined);
}, "testIsNotUndefined");
suite.addTestCase(testIsNotUndefined);


// Failure without custom message
testFailure = new TestCase(function() {
	self.assertEqual(3, "String");
}, "testFailure");
suite.addTestCase(testFailure);

// Failure with custom message
testFailureCustomMessage = new TestCase(function() {
	self.assertFalse(instance_exists(obj_test), "This is a custom failure message.");
}, "testFailureCustomMessage");
suite.addTestCase(testFailureCustomMessage);

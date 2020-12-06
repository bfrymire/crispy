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


// Failure without custom message
testFailure = new TestCase(function() {
	self.assertEqual(3, "String");
}, "testFailure");
suite.addTestCase(testFailure);

// Failure with custom message
testFailureCustomMessage = new TestCase(function() {
	self.assertFalse(instance_exists(obj_test), "This is a custom failure message.");
}, "testFailureCustomMessage");
suite.addTest(testFailureCustomMessage);


// Run the TestRunner
if CRISPY_RUN {
	runner.run();
}

// Destroy testing object once complete
instance_destroy();

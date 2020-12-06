/// Custom function to test
function add(a, b) {
	return a + b;
}


// Create TestRunner
runner = new TestRunner();

// Create TestSuite
suite = new TestSuite();

// Add TestSuite to TestRunner
runner.addSuite(suite);

// Create TestCase for our custom function
testAddFunction = new TestCase(function() {
	var _number = other.add(10, 5);
	self.assertEqual(_number, 15);
}, "testAddFunction");

// Add TestCase to TestSuite
suite.addTest(testAddFunction);


// Create TestCase for the rest of the assertion functions
testEqual = new TestCase(function() {
	self.assertEqual(10, 10);
}, "testEqual");
suite.addTest(testEqual);

testNotEqual = new TestCase(function() {
	self.assertNotEqual(1, 5);
}, "testNotEqual");
suite.addTest(testNotEqual);

testTrue = new TestCase(function() {
	self.assertTrue(true);
}, "testTrue");
suite.addTest(testTrue);

testFalse = new TestCase(function() {
	self.assertFalse(false);
}, "testFalse");
suite.addTest(testFalse);


// Failure without custom message
testFailure = new TestCase(function() {
	self.assertEqual(3, "String");
}, "testFailure");
suite.addTest(testFailure);

// Failure with custom message
testFailure = new TestCase(function() {
	self.assertFalse(instance_exists(obj_test), "This is a custom failure message.");
}, "testFailure");
suite.addTest(testFailure);


// Run the TestRunner
if CRISPY_RUN {
	runner.run();
}

// Destroy testing object once complete
instance_destroy();

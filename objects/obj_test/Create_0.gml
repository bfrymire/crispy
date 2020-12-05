/// Custom function to test
function add(a, b) {
	return a + b;
}

// Create TestSuite
suite = new TestSuite();

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


// Run the Crispy suite
suite.run();

// Destroy testing object once complete
instance_destroy();

/// Custom function to test
function add(a, b) {
	return a + b;
}

// Create test suite
suite = new TestSuite();

// Create test case for our custom function
testAddFunction = new TestCase(function() {
	var _number = other.add(10, 5);
	self.assertEqual(_number, 15);
}, "testAddFunction");
// Add it to the test suite
suite.addTest(testAddFunction);


// Create test cases for the rest of the assertion functions
testEqual = new TestCase(function() {
	self.assertEqual(2 + 3, 5);
}, "testEqual");
suite.addTest(testEqual);

testNotEqual = new TestCase(function() {
	self.assertNotEqual(1, 5);
	self.assertNotEqual(-4, noone);
	self.assertNotEqual(true, "true");
	self.assertNotEqual(3, "This is a test");
	self.assertNotEqual(1, 1, "Wait, these are equal.");
}, "testNotEqual");
suite.addTest(testNotEqual);

testTrue = new TestCase(function() {
	self.assertTrue(true);
}, "testTrue");
suite.addTest(testTrue);

testFalse = new TestCase(function() {
	self.assertFalse(false);
	self.assertFalse(noone);
	self.assertFalse(undefined);
}, "testFalse");
suite.addTest(testFalse);


// Run the Crispy suite
if CRISPY_RUN {
	suite.run();
}

// Destroy testing object once complete
if CRISPY_AUTO_DESTROY || !CRISPY_RUN {
	instance_destroy();
}

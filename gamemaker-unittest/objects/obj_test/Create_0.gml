function add(a, b) {
	return a + b;
}

function subtract(a, b) {
	return a - b;
}

function multiply(a, b) {
	return a * b;
}

function divide(a, b) {
	return a / b;
}

suite = new TestSuite();

// False negative
testEqualArrays = new TestCase(function() {
	var a = ["Test", 0, 3, undefined];
	var b = ["Test", 0, 3, undefined];
	self.assertEqual(a, b);
	var arr_equ = array_equals(a, b);
	self.assertTrue(arr_equ);
}, "testEqualArrays");
suite.addTest(testEqualArrays);


/*
testAdd = new TestCase(function() {
	var _number = other.add(10, 5);
	self.assertEqual(_number, 15);
	_number = other.add(-3, -2);
	self.assertEqual(_number, -5);
	_number = other.add(, -2);
	self.assertEqual(_number, -5);
}, "testAdd");
suite.addTest(testAdd);

testSubtract = new TestCase(function() {
	var _number = other.subtract(7, 4);
	self.assertEqual(_number, 3);
}, "testSubtract");
suite.addTest(testSubtract);

testMultiply = new TestCase(function() {
	var _number = other.multiply(5, -6);
	self.assertEqual(_number, -30);
}, "testMultiply");
suite.addTest(testMultiply);

testDivide = new TestCase(function() {
	var _number = other.divide(100, 2);
	self.assertEqual(_number, 50);
}, "testDivide");
suite.addTest(testDivide);
*/

// Run the unittest suite
if UNITTEST_RUN {
	suite.run();
}

// Destroy self once done
if UNITTEST_AUTO_DESTROY {
	instance_destroy();
}
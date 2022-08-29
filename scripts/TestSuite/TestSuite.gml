/**
 * Testing suite that holds tests
 * @constructor TestSuite
 * @param {string} _name - Name of suite
 * @param [struct] _unpack - Struct for crispyStructUnpack
 */
function TestSuite(_name, _unpack) : BaseTestClass(_name) constructor {

	parent = undefined;
	tests = [];
	
	
	/**
	 * Adds TestCase to array of cases
	 * @function addTestCase
	 * @param {struct} _test_case - TestCase to add
	 */
	static addTestCase = function(_test_case) {
		if instanceof(_test_case) != "TestCase" {
			var _type = !is_undefined(instanceof(_test_case)) ? instanceof(_test_case) : typeof(_test_case);
			throw(instanceof(self) + ".addTestCase() \"test_case\" expected an instance of TestCase, received " + _type + ".");
		}
		_test_case.parent = self;
		array_push(tests, _test_case);
	}

	/**
	 * Event that runs before all tests to set up variables
	 * Can also overwrite __setUp__
	 * @function setUp
	 * @param [function] _func - Function to overwrite __setUp__
	 */
	static setUp = function() {
		if argument_count > 0 {
			var _func = argument[0];
			if is_method(_func) {
				__setUp__ = method(self, _func);
			} else {
				throw(instanceof(self) + ".setUp() \"func\" expected a method, received " + typeof(_func) + ".");
			}
		} else {
			if is_method(__setUp__) {
				__setUp__();
			}
		}
	}

	/**
	 * Event that runs after all tests to clean up variables
	 * Can also overwrite __tearDown__
	 * @function tearDown
	 * @param [function] _func - Function to overwrite __tearDown__
	 */
	static tearDown = function() {
		if argument_count > 0 {
			var _func = argument[0];
			if is_method(_func) {
				__tearDown__ = method(self, _func);
			} else {
				throw(instanceof(self) + ".tearDown() \"func\" expected a method, received " + typeof(_func) + ".");
			}
		} else {
			if is_method(__tearDown__) {
				__tearDown__();
			}
		}
	}

	/**
	 * Runs tests
	 * @function run
	 */
	static run = function() {
		setUp();
		var _len = array_length(tests);
		var i = 0;
		repeat (_len) {
			onRunBegin();
			tests[i].run();
			onRunEnd();
			++i;
		}
		tearDown();
	}

	/**
	 * Run struct unpacker if unpack argument was provided
	 * Stays after all variables are initialized so they may be overwritten
	 */
	if !is_undefined(_unpack) {
		if is_struct(_unpack) {
			crispyStructUnpack(_unpack);
		} else {
			throw(instanceof(self) + " \"unpack\" expected a struct or undefined, recieved " + typeof(_unpack) + ".");
		}
	}

}

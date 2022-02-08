/**
 * Testing suite that holds tests
 * @constructor TestSuite
 * @param {string} name - Name of suite
 * @param [struct] unpack - Struct for crispyStructUnpack
 */
function TestSuite(_name) : BaseTestClass() constructor {

	setName(_name);
	parent = undefined;
	tests = [];
	
	
	/**
	 * Adds test case to array of cases
	 * @function addTestCase
	 * @param {TestCase} case - TestCase to add
	 */
	static addTestCase = function(_case) {
		var _inst = instanceof(_case);
		if _inst != "TestCase" {
			var _type = !is_undefined(_inst) ? _inst : typeof(_case);
			crispyThrowExpected(self, "addTestCase", "TestCase", _type);
		}
		_case.parent = self;
		array_push(tests, _case);
	}

	/**
	 * Event that runs before all tests to set up variables
	 * Can also overwrite __setUp__
	 * @function setUp
	 * @param {method} func - Function to overwrite __setUp__
	 */
	static setUp = function() {
		if argument_count > 0 {
			var _func = argument[0];
			if is_method(_func) {
				__setUp__ = method(self, _func);
			} else {
				crispyThrowExpected(self, "setUp", "method", typeof(_func));
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
	 * @param {method} func - Function to overwrite __tearDown__
	 */
	static tearDown = function() {
		if argument_count > 0 {
			var _func = argument[0];
			if is_method(_func) {
				__tearDown__ = method(self, _func);
			} else {
				crispyThrowExpected(self, "tearDown", "method", typeof(_func));
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
		for(var i = 0; i < _len; i++) {
			tests[i].run();
		}
		tearDown();
	}

	/**
	 * Run struct unpacker if unpack argument was provided
	 */
	if argument_count > 1 {
		crispyStructUnpack(argument[1]);
	}

}

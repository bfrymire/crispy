/**
 * Testing suite that holds tests
 * @constructor TestSuite
 * @param {string} name - Name of suite
 * @param [struct] unpack - Struct for crispy_struct_unpack
 */
function TestSuite(_name) : BaseTestClass() constructor {

	set_name(_name);
	parent = undefined;
	tests = [];
	
	
	/**
	 * Adds test case to array of cases
	 * @function add_test_case
	 * @param {TestCase} case - TestCase to add
	 */
	static add_test_case = function(_case) {
		var _inst = instanceof(_case);
		if _inst != "TestCase" {
			var _type = !is_undefined(_inst) ? _inst : typeof(_case);
			crispy_throw_expected(self, "add_test_case", "TestCase", _type);
		}
		_case.parent = self;
		array_push(tests, _case);
	}

	/**
	 * Event that runs before all tests to set up variables
	 * Can also overwrite __setUp__
	 * @function set_up
	 * @param {method} func - Function to overwrite __setUp__
	 */
	static set_up = function() {
		if argument_count > 0 {
			var _func = argument[0];
			if is_method(_func) {
				__setUp__ = method(self, _func);
			} else {
				crispy_throw_expected(self, "set_up", "method", typeof(_func));
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
	 * @function tear_down
	 * @param {method} func - Function to overwrite __tearDown__
	 */
	static tear_down = function() {
		if argument_count > 0 {
			var _func = argument[0];
			if is_method(_func) {
				__tearDown__ = method(self, _func);
			} else {
				crispy_throw_expected(self, "tear_down", "method", typeof(_func));
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
		set_up();
		var _len = array_length(tests);
		for(var i = 0; i < _len; i++) {
			tests[i].run();
		}
		tear_down();
	}

	/**
	 * Run struct unpacker if unpack argument was provided
	 */
	if argument_count > 1 {
		crispy_struct_unpack(argument[1]);
	}

}

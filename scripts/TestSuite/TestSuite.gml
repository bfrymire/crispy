/**
 * Testing suite that holds tests
 * @constructor TestSuite
 * @param {struct} data - Struct containing instructions to set up TestSuite
 */
function TestSuite(_data) : BaseTestClass() constructor {

	// Check for correct type
	if !is_struct(_data) {
		throw(instanceof(self) + " \"data\" expected a struct, received " + typeof(_data) + ".");
	}

	parent = undefined;
	tests = [];
	discovered = false;

	// Struct of variable names that are reserved by the library
	reserved_names = {
		reserved: [
			"class",
			"parent",
			"run",
			"add_test_case",
			"crispy_struct_unpack",
			"__set_up__",
			"__tear_down__",
		],
		overwrite: [
			"set_up",
			"tear_down",
		],
		specific: [
			{
				name: "tests",
				func: method(self, function(_tests) {
					add(_tests);
				}),
			},
		],
	}

	// Apply test_struct to TestCase
	crispy_struct_unpack(_data, reserved_names);

	// Checks whether the name was set up correctly
	validate_name();
	
	
	/**
	 * Adds test case to array of cases
	 * @function add_test_case
	 * @param {TestCase} case - TestCase to add
	 * @returns {struct} self
	 */
	static add_test_case = function(_test_case) {
		if instanceof(_test_case) != "TestCase" {
			var _type = !is_undefined(instanceof(_test_case)) ? instanceof(_test_case) : typeof(_test_case);
			throw(instanceof(self) + ".add_test_case() \"test_case\" expected an instance of TestCase, received " + _type + ".");
		}
		_test_case.parent = self;
		array_push(tests, _test_case);
		return self;
	}

	/**
	 * Adds test case or array of test cases to tests
	 * @function add
	 * @param {struct|array} tests - Test case or test cases to be added to tests
	 * @returns {struct} self
	 */
	static add = function(_tests) {
		if is_struct(_tests) {
			add_test_case(_tests);
		} else if is_array(_tests) {
			var _len = array_length(_tests);
			repeat (_len) {
				add_test_case(_tests[i]);
				++i;
			}
		} else {
			throw(instanceof(self) + ".add() \"tests\" expected either a struct or an array, received " + typeof(_tests) + ".");
		}
		return self;
	}

	/**
	 * Event that runs before all tests to set up variables
	 * Can also overwrite __set_up__
	 * @function set_up
	 * @param {method} func - Function to overwrite __set_up__
	 */
	static set_up = function() {
		if argument_count > 0 {
			var _func = argument[0];
			if is_method(_func) {
				__set_up__ = method(self, _func);
			} else {
				throw(instanceof(self) + ".set_up() \"func\" expected a method, received " + typeof(_func) + ".");
			}
		} else {
			if is_method(__set_up__) {
				__set_up__();
			}
		}
	}

	/**
	 * Event that runs after all tests to clean up variables
	 * Can also overwrite __tear_down__
	 * @function tear_down
	 * @param {method} func - Function to overwrite __tear_down__
	 */
	static tear_down = function() {
		if argument_count > 0 {
			var _func = argument[0];
			if is_method(_func) {
				__tear_down__ = method(self, _func);
			} else {
				throw(instanceof(self) + ".tear_down() \"func\" expected a method, received " + typeof(_func) + ".");
			}
		} else {
			if is_method(__tear_down__) {
				__tear_down__();
			}
		}
	}

	/**
	 * Runs child tests
	 * @function run
	 */
	static run = function() {
		set_up();
		var _len = array_length(tests);
		var i = 0;
		repeat (_len) {
			on_run_begin();
			tests[i].run();
			on_run_end();
			++i;
		}
		tear_down();
	}

}

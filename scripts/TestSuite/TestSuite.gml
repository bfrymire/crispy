/**
 * Testing suite that holds tests
 * @constructor TestSuite
 * @param {struct} suite_struct - Struct containing instructions to set up TestSuite
 */
function TestSuite(_suite_struct) : BaseTestClass() constructor {

	// Check for correct types
	if !is_struct(_suite_struct) {
		crispy_throw_expected(self, "", "struct", typeof(_suite_struct));
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
	crispy_struct_unpack(_suite_struct, reserved_names);

	// Checks whether the name was set up correctly
	check_name();
	
	
	/**
	 * Adds test case to array of cases
	 * @function add_test_case
	 * @param {TestCase} case - TestCase to add
	 * @returns {struct} self
	 */
	static add_test_case = function(_case) {
		var _inst = instanceof(_case);
		if _inst != "TestCase" {
			var _type = !is_undefined(_inst) ? _inst : typeof(_case);
			crispy_throw_expected(self, "add_test_case", "TestCase", _type);
		}
		_case.parent = self;
		array_push(tests, _case);
		return self;
	}

	/**
	 *Adds test case or array of test cases to tests
	 * @function add
	 * @param {struct|array} tests - Test case or test cases to be added to tests
	 * @returns {struct} self
	 */
	static add = function(_tests) {
		if is_struct(_tests) {
			// Single TestCase passed
			add_test_case(_tests);
		} else if is_array(_tests) {
			// Array of TestCases passed
			var _len = array_length(_tests);
			for(var i = 0; i < _len; i++) {
				var _test = _tests[i];
				if !is_struct(_test) {
					crispy_throw_expected(self, "add", "struct", typeof(_test));
				}
				add_test_case(_test);
			}
		} else {
			// Throw error
			crispy_throw_expected(self, "add", "{struct|array}", typeof(_test));
		}
		return self;
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
	 * Runs child tests
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

}

/**
 * Creates a TestCase object to run assertions
 * @constructor TestCase
 * @param {struct} test_struct - Struct containing instructions to set up TestCase
 */
function TestCase(_test_struct) : BaseTestClass() constructor {

	// Check for correct types
	if !is_struct(_test_struct) {
		crispy_throw_expected(self, "", "struct", typeof(_test_struct));
	}

	class = instanceof(self);
	parent = undefined;
	test = undefined;
	logs = [];
	discovered = false;

	// Struct of variable names that are reserved by the library
	// reserved - nothing can overwrite them, unless false is passed to crispy_struct_unpack's ignore_reserved_names parameter
	// overwrite - this will call the name as a method and pass the value of name from the source struct to that method
	// specific - this will create a method function from the function passed as func and pass the contents of source struct to that method
	reserved_names = {
		reserved: [
			"class",
			"parent",
			"logs",
			"crispy_struct_unpack",
			"assert_equal",
			"assert_not_equal",
			"assert_true",
			"assert_false",
			"assert_is_noone",
			"assert_is_not_noone",
			"assert_is_undefined",
			"assert_is_not_undefined",
			"__set_up__",
			"__tear_down__",
		],
		overwrite: [
			"set_up",
			"tear_down",
		],
	}

	// Apply test_struct to TestCase
	crispy_struct_unpack(_test_struct, reserved_names);

	// Checks whether the name was set up correctly
	check_name();

	// Throw exception if a test isn't passed to TestCase on creation
	if !is_method(test) {
		throw(instanceof(self) + "() requires a test to be passed as a \"test\" variable in \"test_struct\", received " + typeof(test));
	}

	/**
	 * Adds a Log to the array of logs
	 * @function add_log
	 * @param {struct} log - Log struct
	 * @returns {struct} self
	 */
	static add_log = function(_log) {
		if !is_struct(_log) {
			crispy_throw_expected(self, "add_log", "struct", typeof(_log));
		}
		array_push(logs, _log);
		return self;
	}

	/**
	 * Clears array of Logs
	 * @function clear_logs
	 * @returns {struct} Self
	 */
	static clear_logs = function() {
		logs = [];
		return self;
	}

	/**
	 * Test that first and second are equal
	 * The first and second will be checked for the same type first, then check if they're equal
	 * @function assert_equal
	 * @param {*} first - First value
	 * @param {*} second - Second value to check against _first
	 * @param [string] message - Custom message to output on failure
	 */
	static assert_equal = function() {
		// Check supplied arguments
		if argument_count < 2 {
			show_error("assert_equal expects 2 arguments, got " + string(argument_count) + ".", true);
		}
		var _first = argument[0];
		var _second = argument[1];
		var _message = (argument_count > 2) ? argument[2] : undefined;
		if !is_string(_message) && !is_undefined(_message) {
			crispyThrowExpected(self, "assertEqual", "string", typeof(_message));
		}
		// Check types of first and second
		if typeof(_first) != typeof(_second) {
			add_log(new CrispyLog(self, {pass:false,msg:"Supplied value types are not equal: " + typeof(_first) + " and " + typeof(_second) + "."}));
			return;
		}
		if _first == _second {
			add_log(new CrispyLog(self));
		} else {
			add_log(new CrispyLog(self, {pass:false,msg:_message,helper_text:"first and second are not equal: " + string(_first) + ", " + string(_second)}));
		}
	}

	/**
	 * Tests that first and second are not equal
	 * @function assert_not_equal
	 * @param {*} first - First type to check
	 * @param {*} second - Second type to check against
	 * @param [string] message - Custom message to output on failure
	 */
	static assert_not_equal = function() {
		// Check correct number of arguments
		if argument_count < 2 {
			show_error("assert_not_equal expects 2 arguments, got " + string(argument_count) + ".", true);
		}
		var _first = argument[0];
		var _second = argument[1];
		var _message = (argument_count > 2) ? argument[2] : undefined;
		if !is_string(_message) && !is_undefined(_message) {
			crispyThrowExpected(self, "assertEqual", "string", typeof(_message));
		}
		if _first != _second {
			add_log(new CrispyLog(self, {
				pass: true,
			}));
		} else {
			add_log(new CrispyLog(self, {
				pass: false,
				msg: _message,
				helper_text: "first and second are equal: " + string(_first) + ", " + string(_second),
			}));
		}
	}

	/**
	 * Test whether the provided expression is true
	 * The test will first convert the expression to a boolean, then check if it equals true
	 * @function assert_true
	 * @param {*} expr - Expression to check
	 * @param [string] message - Custom message to output on failure
	 */
	static assert_true = function() {
		// Check supplied arguments
		if argument_count < 1 {
			show_error("assert_true expects 1 argument, got " + string(argument_count) + ".", true);
		}
		var _expr = argument[0];
		var _message = (argument_count > 1) ? argument[1] : undefined;
		if !is_string(_message) && !is_undefined(_message) {
			crispyThrowExpected(self, "assertEqual", "string", typeof(_message));
		}
		try {
			var _bool = bool(_expr);
		}
		catch(err) {
			add_log(new CrispyLog(self, {
				pass: false,
				helper_text: "Unable to convert " + typeof(_expr) + " into boolean. Cannot evaluate.",
			}));
			return;
		}
		if _bool == true {
			add_log(new CrispyLog(self, {
				pass: true,
			}));
		} else {
			add_log(new CrispyLog(self, {
				pass: false,
				msg: _message,
				helper_text: "Expression is not true."
			}));
		}
	}

	/**
	 * Test whether the provided expression is false
	 * The test will first convert the expression to a boolean, then check if it equals false
	 * @function assert_false
	 * @param {*} expr - Expression to check
	 * @param [string] message - Custom message to output on failure
	 */
	static assert_false = function() {
		// Check supplied arguments
		if argument_count < 1 {
			show_error("assert_false expects 1 argument, got " + string(argument_count) + ".", true);
		}
		var _expr = argument[0];
		var _message = (argument_count > 1) ? argument[1] : undefined;
		if !is_string(_message) && !is_undefined(_message) {
			crispyThrowExpected(self, "assertEqual", "string", typeof(_message));
		}
		try {
			var _bool = bool(_expr);
		}
		catch(err) {
			add_log(new CrispyLog(self, {
				pass: false,
				helper_text: "Unable to convert " + typeof(_expr) + " into boolean. Cannot evaluate.",
			}));
			return;
		}
		if _bool == false {
			add_log(new CrispyLog(self, {
				pass: true,
			}));
		} else {
			add_log(new CrispyLog(self, {
				pass: false,
				msg: _message,
				helper_text: "Expression is not false.",
			}));
		}
	}

	/**
	 * Test whether the provided expression is noone
	 * @function assert_is_noone
	 * @param {*} expr - Expression to check
	 * @param [string] message - Custom message to output on failure
	 */
	static assert_is_noone = function() {
		// Check supplied arguments
		if argument_count < 1 {
			show_error("assert_is_noone expects 1 argument, got " + string(argument_count) + ".", true);
		}
		var _expr = argument[0];
		var _message = (argument_count > 1) ? argument[1] : undefined;
		if !is_string(_message) && !is_undefined(_message) {
			crispyThrowExpected(self, "assertEqual", "string", typeof(_message));
		}
		if _expr == -4 {
			add_log(new CrispyLog(self, {
				pass: true,
			}));
		} else {
			add_log(new CrispyLog(self, {
				pass: false,
				msg: _message,
				helper_text: "Expression is not noone.",
			}));
		}
	}

	/**
	 * Test whether the provided expression is not noone
	 * @function assert_is_not_noone
	 * @param {*} expr - Expression to check
	 * @param [string] message - Custom message to output on failure
	 */
	static assert_is_not_noone = function() {
		// Check supplied arguments
		if argument_count < 1 {
			show_error("assert_is_not_noone expects 1 argument, got " + string(argument_count) + ".", true);
		}
		var _expr = argument[0];
		var _message = (argument_count > 1) ? argument[1] : undefined;
		if !is_string(_message) && !is_undefined(_message) {
			crispyThrowExpected(self, "assertEqual", "string", typeof(_message));
		}
		if _expr != -4 {
			add_log(new CrispyLog(self, {
				pass: true,
			}));
		} else {
			add_log(new CrispyLog(self, {
				pass: false,
				msg: _message,
				helper_text: "Expression is noone.",
			}));
		}
	}

	/**
	 * Test whether the provided expression is undefined
	 * @function assert_is_undefined
	 * @param {*} expr - Expression to check
	 * @param [string] message - Custom message to output on failure
	 */
	static assert_is_undefined = function() {
		// Check supplied arguments
		if argument_count < 1 {
			show_error("assert_is_undefined expects 1 argument, got " + string(argument_count) + ".", true);
		}
		var _expr = argument[0];
		var _message = (argument_count > 1) ? argument[1] : undefined;
		if !is_string(message) || !is_undefined(_message) {
			crispyThrowExpected(self, "assertEqual", "string", typeof(_message));
		}
		if is_undefined(_expr) {
			add_log(new CrispyLog(self, {
				pass: true,
			}));
		} else {
			add_log(new CrispyLog(self, {
				pass: false,
				msg: _message,
				helper_text: "Expression is not undefined.",
			}));
		}
	}

	/**
	 * Test whether the provided expression is not undefined
	 * @function assert_is_not_undefined
	 * @param {*} expr - Expression to check
	 * @param [string] message - Custom message to output on failure
	 */
	static assert_is_not_undefined = function() {
		// Check supplied arguments
		if argument_count < 1 {
			show_error("assert_is_not_undefined expects 1 argument, got " + string(argument_count) + ".", true);
		}
		var _expr = argument[0];
		var _message = (argument_count > 1) ? argument[1] : undefined;
		if !is_string(_message) && !is_undefined(_message) {
			crispyThrowExpected(self, "assertEqual", "string", typeof(_message));
		}
		if !is_undefined(_expr) {
			add_log(new CrispyLog(self, {
				pass: true
			}));
		} else {
			add_log(new CrispyLog(self, {
				pass: false,
				msg: _message,
				helper_text: "Expression is undefined.",
			}));
		}
	}


	/**
	 * Function ran before test executes, used to set up test
	 * @function set_up
	 * @param [method] func - Method to override __set_up__ with
	 */
	static set_up = function() {
		if argument_count > 0 {
			var _func = argument[0];
			if is_method(_func) {
				__set_up__ = method(self, _func);
			} else {
				crispy_throw_expected(self, "set_up", "method", typeof(_func));
			}
		} else {
			clear_logs();
			if is_method(__set_up__) {
				__set_up__();
			}
		}
	}
	
	/**
	 * Function ran after test executes, used to clean up test
	 * @function tear_down
	 * @param [method] func - Method to override __tear_down__ with
	 */
	static tear_down = function() {
		if argument_count > 0 {
			var _func = argument[0];
			if is_method(_func) {
				__tear_down__ = method(self, _func);
			} else {
				crispy_throw_expected(self, "tear_down", "method", typeof(_func));
			}
		} else {
			if is_method(__tear_down__) {
				__tear_down__();
			}
		}
	}

	/**
	 * Set of functions to run in order for the test
	 * @function run
	 */
	static run = function() {
		set_up();
		test();
		tear_down();
	}

}

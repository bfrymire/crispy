/**
 * Creates a Test case object to run assertions
 * @constructor TestCase
 * @param {string} name - Name of case
 * @param {method} func - Test assertion to run for case
 * @param [struct] unpack - Struct for crispy_struct_unpack
 */
function TestCase(_name, _func) : BaseTestClass() constructor {

	if !is_method(_func) {
		crispy_throw_expected(self, "", "method", typeof(_func));
	}

	set_name(_name);
	class = instanceof(self);
	parent = undefined;
	test = undefined;
	logs = [];
	__is_discovered__ = false;
	__discovered_script__ = undefined;
	create_test_method(_func);

	/**
	 * Turns a function into a method variable for the test.
	 * @function create_test_method
	 * @param {method} func - Function to turn into a method variable
	 */
	static create_test_method = function(_func) {
		if !is_method(_func) {
			crispy_throw_expected(self, "createMethodVariable", "method", typeof(_func));
		}
		test = method(self, _func);
	}

	/**
	 * Adds a Log to the array of logs
	 * @function add_log
	 * @param {struct} log - Log struct
	 */
	static add_log = function() {
		var _log = (argument_count > 0) ? argument[0] : undefined;
		array_push(logs, _log);
	}

	/**
	 * Clears array of Logs
	 * @function clear_logs
	 */
	static clear_logs = function() {
		logs = [];
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
	 * Test that first and second are not equal
	 * @function assert_not_equal
	 * @param {*} first - First type to check
	 * @param {*} second - Second type to check against
	 * @param [string] message - Custom message to output on failure
	 */
	static assert_not_equal = function() {
		// Check supplied arguments
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
			add_log(new CrispyLog(self, {pass:true}));
		} else {
			add_log(new CrispyLog(self, {pass:false,msg:_message,helper_text:"first and second are equal: " + string(_first) + ", " + string(_second)}));
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
			add_log(new CrispyLog(self, {pass:false,helper_text:"Unable to convert " + typeof(_expr) + " into boolean. Cannot evaluate."}));
			return;
		}
		if _bool == true {
			add_log(new CrispyLog(self, {pass:true}));
		} else {
			add_log(new CrispyLog(self, {pass:false,msg:_message,helper_text:"Expression is not true."}));
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
			add_log(new CrispyLog(self, {pass:false,helper_text:"Unable to convert " + typeof(_expr) + " into boolean. Cannot evaluate."}));
			return;
		}
		if _bool == false {
			add_log(new CrispyLog(self, {pass:true}));
		} else {
			add_log(new CrispyLog(self, {pass:false,msg:_message,helper_text:"Expression is not false."}));
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
			add_log(new CrispyLog(self, {pass:true}));
		} else {
			add_log(new CrispyLog(self, {pass:false,msg:_message,helper_text:"Expression is not noone."}));
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
			add_log(new CrispyLog(self, {pass:true}));
		} else {
			add_log(new CrispyLog(self, {pass:false,msg:_message,helper_text:"Expression is noone."}));
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
			add_log(new CrispyLog(self, {pass:true}));
		} else {
			add_log(new CrispyLog(self, {pass:false,msg:_message,helper_text:"Expression is not undefined."}));
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
			add_log(new CrispyLog(self, {pass:true}));
		} else {
			add_log(new CrispyLog(self, {pass:false,msg:_message,helper_text:"Expression is undefined."}));
		}
	}


	/**
	 * Function ran before test, used to set up test
	 * @function set_up
	 * @param [method] func - Method to override __setUp__ with
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
			clear_logs();
			if is_method(__setUp__) {
				__setUp__();
			}
		}
	}
	
	/**
	 * Function ran after test, used to clean up test
	 * @function tear_down
	 * @param [method] func - Method to override __tearDown__ with
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
	 * Set of functions to run in order for the test
	 * @function run
	 */
	static run = function() {
		set_up();
		test();
		tear_down();
	}

	/**
	 * Sets up a discovered script to use as the test
	 * @function __discover__
	 * @param {real} script - ID of script
	 * @returns {struct} self
	 */
	static __discover__ = function(_script) {
		if !is_real(_script) {
			crispy_throw_expected(self, "__discovered__", "real", typeof(_script));
		}
		__discovered_script__ = _script;
		__is_discovered__ = true;
		create_test_method(function() {__discovered_script__()});
		return self;
	}

	/**
	 * Run struct unpacker if unpack argument was provided
	 */
	if argument_count > 2 {
		crispy_struct_unpack(argument[2]);
	}

}

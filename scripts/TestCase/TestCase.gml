// Feather disable all

/**
 * Creates a Test case object to run assertions
 * @constructor TestCase
 * @param {String} _name - Name of case
 * @param {Function} _func - Function for test assertion
 * @param {Struct} [_unpack=undefined] - Struct for crispyStructUnpack
 */
function TestCase(_name, _func, _unpack=undefined) : BaseTestClass(_name) constructor {

	if !is_method(_func) {
		throw(instanceof(self) + " \"func\" expected a function, received " + typeof(_func) + ".");
	}

	class = instanceof(self);
	parent = undefined;
	test = method(self, _func);
	logs = [];
	__is_discovered__ = false;
	__discovered_script__ = undefined;

	/**
	 * Run struct unpacker if unpack argument was provided
	 * Stays after all variables are initialized so they may be overwritten
	 */
	if !is_undefined(_unpack) {
		if is_struct(_unpack) {
			crispyStructUnpack(_unpack);
		} else {
			throw(instanceof(self) + " \"_unpack\" expected a struct or undefined, recieved " + typeof(_unpack) + ".");
		}
	}

	// Methods

	/**
	 * Adds a Log to the array of logs
	 * @function addLog
	 * @param {Struct} _log - Log struct
	 */
	static addLog = function(_log) {
		if !is_struct(_log) {
			throw(instanceof(self) + ".addLog() \"_log\" expected a struct, recieved " + typeof(_log) + ".");
		}
		array_push(logs, _log);
	}

	/**
	 * Clears array of Logs
	 * @function clearLogs
	 */
	static clearLogs = function() {
		logs = [];
	}

	/**
	 * Test that first and second are equal
	 * The first and second will be checked for the same type first, then check if they're equal
	 * @function assertEqual
	 * @param {Any} _first - First value
	 * @param {Any} _second - Second value to check against _first
	 * @param {String} [_message] - Custom message to output on failure
	 */
	static assertEqual = function(_first, _second, _message) {
		// Check supplied arguments
		if argument_count < 2 {
			show_error(instanceof(self) + ".assertEqual() expected 2 arguments, recieved " + string(argument_count) + ".", true);
		}
		if !is_string(_message) && !is_undefined(_message) {
			throw(instanceof(self) + ".assertEqual() \"_message\" expected either a string or undefined, received " + typeof(_message) + ".");
		}
		// Check types of first and second
		if typeof(_first) != typeof(_second) {
			addLog(new CrispyLog(self, {
				pass: false,
				msg: "Supplied value types are not equal: " + typeof(_first) + " and " + typeof(_second) + ".",
			}));
			return;
		}
		if _first == _second {
			addLog(new CrispyLog(self, {
				pass: true,
			}));
		} else {
			addLog(new CrispyLog(self, {
				pass: false,
				msg: _message,
				helper_text: "first and second are not equal: " + string(_first) + ", " + string(_second),
			}));
		}
	}

	/**
	 * Test that first and second are not equal
	 * @function assertNotEqual
	 * @param {Any} _first - First type to check
	 * @param {Any} _second - Second type to check against
	 * @param {String} [_message] - Custom message to output on failure
	 */
	static assertNotEqual = function(_first, _second, _message) {
		// Check supplied arguments
		if argument_count < 2 {
			show_error(instanceof(self) + ".assertNotEqual() expected 2 arguments, recieved " + string(argument_count) + ".", true);
		}
		if !is_string(_message) && !is_undefined(_message) {
			throw(instanceof(self) + ".assertNotEqual() \"_message\" expected either a string or undefined, received " + typeof(_message) + ".");
		}
		var _outcome = typeof(_first) != typeof(_second);
		if !_outcome {
			_outcome = _first != _second;
		}
		if _outcome {
			addLog(new CrispyLog(self, {
				pass: true,
			}));
		} else {
			addLog(new CrispyLog(self, {
				pass: false,
				msg: _message,
				helper_text: "first and second are equal: " + string(_first) + ", " + string(_second),
			}));
		}
	}

	/**
	 * Test whether the provided expression is true
	 * The test will first try to convert the expression to a boolean, then check if it equals true
	 * @function assertTrue
	 * @param {Any} _expr - Expression to check
	 * @param {String} [_message] - Custom message to output on failure
	 */
	static assertTrue = function(_expr, _message) {
		// Check supplied arguments
		if argument_count < 1 {
			show_error(instanceof(self) + ".assertTrue() expected 1 argument, recieved " + string(argument_count) + ".", true);
		}
		if !is_string(_message) && !is_undefined(_message) {
			throw(instanceof(self) + ".assertTrue() \"_message\" expected either a string or undefined, received " + typeof(_message) + ".");
		}
		
		try {
			bool(_expr);
		}
		catch(err) {
			addLog(new CrispyLog(self, {
				pass: false,
				helper_text:"Unable to convert " + typeof(_expr) + " into boolean. Cannot evaluate.",
			}));
			return;
		}
		if _expr {
			addLog(new CrispyLog(self, {
				pass: true,
			}));
		} else {
			addLog(new CrispyLog(self, {
				pass: false,
				msg: _message,
				helper_text: "Expression is not true.",
			}));
		}
	}

	/**
	 * Test whether the provided expression is false
	 * The test will first try to convert the expression to a boolean, then check if it equals false
	 * @function assertFalse
	 * @param {Any} _expr - Expression to check
	 * @param {String} [_message] - Custom message to output on failure
	 */
	static assertFalse = function(_expr, _message) {
		// Check supplied arguments
		if argument_count < 1 {
			show_error(instanceof(self) + ".assertFalse() expected 1 argument, recieved " + string(argument_count) + ".", true);
		}
		if !is_string(_message) && !is_undefined(_message) {
			throw(instanceof(self) + ".assertFalse() \"_message\" expected either a string or undefined, received " + typeof(_message) + ".");
		}
		
		try {
			bool(_expr);
		}
		catch(err) {
			addLog(new CrispyLog(self, {
				pass: false,
				helper_text: "Unable to convert " + typeof(_expr) + " into boolean. Cannot evaluate.",
			}));
			return;
		}
		if !_expr {
			addLog(new CrispyLog(self, {
				pass: true,
			}));
		} else {
			addLog(new CrispyLog(self, {
				pass: false,
				msg: _message,
				helper_text: "Expression is not false.",
			}));
		}
	}

	/**
	 * Test whether the provided expression is noone
	 * @function assertIsNoone
	 * @param {Any} _expr - Expression to check
	 * @param {String} [_message] - Custom message to output on failure
	 */
	static assertIsNoone = function(_expr, _message) {
		// Check supplied arguments
		if argument_count < 1 {
			show_error(instanceof(self) + ".assertIsNoone() expected 1 argument, recieved " + string(argument_count) + ".", true);
		}
		if !is_string(_message) && !is_undefined(_message) {
			throw(instanceof(self) + ".assertIsNoone() \"_message\" expected either a string or undefined, received " + typeof(_message) + ".");
		}
		if _expr == noone {
			addLog(new CrispyLog(self, {
				pass: true,
			}));
		} else {
			addLog(new CrispyLog(self, {
				pass: false,
				msg: _message,
				helper_text: "Expression is not noone.",
			}));
		}
	}

	/**
	 * Test whether the provided expression is not noone
	 * @function assertIsNotNoone
	 * @param {Any} _expr - Expression to check
	 * @param {String} [_message] - Custom message to output on failure
	 */
	static assertIsNotNoone = function(_expr, _message) {
		// Check supplied arguments
		if argument_count < 1 {
			show_error(instanceof(self) + ".assertIsNotNoone() expected 1 argument, recieved " + string(argument_count) + ".", true);
		}
		if !is_string(_message) && !is_undefined(_message) {
			throw(instanceof(self) + ".assertIsNotNoone() \"_message\" expected either a string or undefined, received " + typeof(_message) + ".");
		}
		if _expr != noone {
			addLog(new CrispyLog(self, {
				pass: true,
			}));
		} else {
			addLog(new CrispyLog(self, {
				pass: false,
				msg: _message,
				helper_text: "Expression is noone.",
			}));
		}
	}

	/**
	 * Test whether the provided expression is undefined
	 * @function assertIsUndefined
	 * @param {Any} _expr - Expression to check
	 * @param {String} [_message] - Custom message to output on failure
	 */
	static assertIsUndefined = function(_expr, _message) {
		// Check supplied arguments
		if argument_count < 1 {
			show_error(instanceof(self) + ".assertIsUndefined() expected 1 argument, recieved " + string(argument_count) + ".", true);
		}
		if !is_string(_message) && !is_undefined(_message) {
			throw(instanceof(self) + ".assertIsUndefined() \"_message\" expected either a string or undefined, received " + typeof(_message) + ".");
		}
		if is_undefined(_expr) {
			addLog(new CrispyLog(self, {
				pass: true,
			}));
		} else {
			addLog(new CrispyLog(self, {
				pass: false,
				msg: _message,
				helper_text: "Expression is not undefined.",
			}));
		}
	}

	/**
	 * Test whether the provided expression is not undefined
	 * @function assertIsNotUndefined
	 * @param {Any} _expr - Expression to check
	 * @param {String} [_message] - Custom message to output on failure
	 */
	static assertIsNotUndefined = function(_expr, _message) {
		// Check supplied arguments
		if argument_count < 1 {
			show_error(instanceof(self) + ".assertIsNotUndefined() expected 1 argument, recieved " + string(argument_count) + ".", true);
		}
		if !is_string(_message) && !is_undefined(_message) {
			throw(instanceof(self) + ".assertIsNotUndefined() \"_message\" expected either a string or undefined, received " + typeof(_message) + ".");
		}
		if !is_undefined(_expr) {
			addLog(new CrispyLog(self, {
				pass: true,
			}));
		} else {
			addLog(new CrispyLog(self, {
				pass: false,
				msg: _message,
				helper_text: "Expression is undefined.",
			}));
		}
	}

	/**
	 * Test whether the provided function will throw an error message
	 * @function assertRaises
	 * @param {Function} _func - Function to check whether it throws an error message
	 * @param {String} [_message] - Custom message to output on failure
	 */
	static assertRaises = function(_func, _message) {
		// Check supplied arguments
		if argument_count < 1 {
			show_error(instanceof(self) + ".assertRaises() expected 1 argument, recieved " + string(argument_count) + ".", true);
		}
		if !is_method(_func) {
			throw(instanceof(self) + ".assertRaises() \"_func\" expected a function, received " + typeof(_func) + ".");
		}
		if !is_string(_message) && !is_undefined(_message) {
			throw(instanceof(self) + ".assertRaises() \"_message\" expected either a string or undefined, received " + typeof(_message) + ".");
		}
		try {
			_func();
			addLog(new CrispyLog(self, {
				pass: false,
				msg: _message,
				helper_text: "Error message was not thrown.",
			}));
		}
		catch(err) {
			addLog(new CrispyLog(self, {
				pass: true,
			}));
		}
	}

	/**
	 * Test the value of the error message thrown in the provided function
	 * @function assertRaiseErrorValue
	 * @param {Function} _func - Function ran to throw an error message
	 * @param {String} _value - Value of error message to check
	 * @param {String} [_message] - Custom message to output on failure
	 */
	static assertRaiseErrorValue = function(_func, _value, _message) {
		// Check supplied arguments
		if argument_count < 2 {
			show_error(instanceof(self) + ".assertRaiseErrorValue() expected 2 arguments, recieved " + string(argument_count) + ".", true);
		}
		if !is_method(_func) {
			throw(instanceof(self) + ".assertRaiseErrorValue() \"_func\" expected a function, received " + typeof(_func) + ".");
		}
		if !is_string(_value) {
			throw(instanceof(self) + ".assertRaiseErrorValue() \"_value\" expected a string, received " + typeof(_value) + ".");
		}
		if !is_string(_message) && !is_undefined(_message) {
			throw(instanceof(self) + ".assertRaiseErrorValue() \"_message\" expected either a string or undefined, received " + typeof(_message) + ".");
		}
		try {
			_func();
			addLog(new CrispyLog(self, {
				pass: false,
				helper_text: "Error message was not thrown.",
			}));
		}
		catch(err) {
			// If the error message was thrown using show_error, use the
			// message value from the exception struct for the assertion
			if is_struct(err) && variable_struct_exists(err, "message") && is_string(err.message) {
				err = err.message;
			}
			if err == _value {
				addLog(new CrispyLog(self, {
					pass: true,
				}));
			} else {
				addLog(new CrispyLog(self, {
					pass: false,
					msg: _message,
					helper_text: "Error message is not equal to value: \"" + err + "\" != \"" + _value + "\"",
				}));
			}
		}
	}

	/**
	 * Function ran before test, used to set up test
	 * @function setUp
	 * @param {Function} [_func] - Method to override __setUp__ with
	 */
	static setUp = function() {
		if argument_count > 0 {
			var _func = argument[0];
			if is_method(_func) {
				__setUp__ = method(self, _func);
			} else {
				throw(instanceof(self) + ".setUp() \"_func\" expected a function, received " + typeof(_func) + ".");
			}
		} else {
			clearLogs();
			if is_method(__setUp__) {
				__setUp__();
			}
		}
	}
	
	/**
	 * Function ran after test, used to clean up test
	 * @function tearDown
	 * @param {Function} [_func] - Method to override __tearDown__ with
	 */
	static tearDown = function() {
		if argument_count > 0 {
			var _func = argument[0];
			if is_method(_func) {
				__tearDown__ = method(self, _func);
			} else {
				throw(instanceof(self) + ".tearDown() \"_func\" expected a function, received " + typeof(_func) + ".");
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
		setUp();
		onRunBegin();
		test();
		onRunEnd();
		tearDown();
	}

	/**
	 * Sets up a discovered script to use as the test
	 * @function __discover__
	 * @param {Real} _script - Index ID of script
	 * @ignore
	 */
	static __discover__ = function(_script) {
		if !is_real(_script) {
			throw(string("{0}.__discover__() \"_script\" expected a real number, received {1}.", instanceof(self), typeof(_script)));
		}
		if !script_exists(_script) {
			throw(string("{0}.__discover__() asset of index {1} is not a script function.", instanceof(self), _script));
		}
		__discovered_script__ = _script;
		__is_discovered__ = true;
		test = method(self, _script);
	}

	/**
	 * @function toString
	 * @returns {String}
	 */
	static toString = function() {
		return string("<Crispy TestCase(\"{0}\")>", name);
	}

}

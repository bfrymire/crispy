/**
 * crispy();
 * @description Crispy is an automated unit testing framework built in GML for GameMaker Studio 2.3+
 * https://github.com/bfrymire/crispy
 * Copywrite (c) bfrymire
 */

#macro CRISPY_VERSION "0.0.1"
#macro CRISPY_DATE "12/5/2020"
#macro CRISPY_RUN true
#macro CRISPY_VERBOSITY 1 // {0|1|2}
#macro CRISPY_TIME_PRECISION 6
#macro CRISPY_PASS_MSG_SILENT "."
#macro CRISPY_FAIL_MSG_SILENT "F"
#macro CRISPY_PASS_MSG_VERBOSE "ok"
#macro CRISPY_FAIL_MSG_VERBOSE "Fail"

global.CRISPY_TIME = 0;
global.CRISPY_TIME_START = 0;
global.CRISPY_TIME_STOP = 0;

show_debug_message("Using Crispy automated unit testing framework version " + CRISPY_VERSION);


/**
 * Suite to hold tests and will run each test when instructed to.
 * @constructor
 */
function TestSuite() : crispyExtendStructUnpack() constructor {
	addLog = function(log) {
		logs[array_length(logs)] = log;
	}

	addTest = function(_case) {
		_case.parent = self;
		self.tests[array_length(tests)] = _case;
	}

	setUp = function() {
		global.crispyTimeStart();
	}

	tearDown = function() {
		global.crispyTimeStop();

		// Display test results
		var _passed_tests = 0;
		var _len = array_length(self.logs);
		var _t = "";
		for(var i = 0; i < _len; i++) {
			if self.logs[i].pass {
				_t += CRISPY_PASS_MSG_SILENT;
			} else {
				_t += CRISPY_FAIL_MSG_SILENT;
			}
		}
		show_debug_message(_t);

		// Horizontal row
		show_debug_message(hr());

		// Show individual log messages
		for(var i = 0; i < _len; i++) {
			if logs[i].pass {
				_passed_tests += 1;
			}
			var _msg = logs[i].getMsg();
			if _msg != "" {
				show_debug_message(_msg);
			}
		}

		// Finish by showing entire time it took to run the suite 
		show_debug_message("\n" + string(_len) + " tests ran in " + crispyGetTime() + "s");

		if _passed_tests == _len {
			show_debug_message(string_upper(CRISPY_PASS_MSG_VERBOSE));
		}
	}

	run = function() {
		self.setUp();
		var _len = array_length(self.tests);
		for(var i = 0; i < _len; i++) {
			self.tests[i].run();
		}
		self.tearDown();
	}

	hr = function() {
		var _str = (argument_count > 0 && is_string(argument[0])) ? argument[0] : "-";
		var _count = (argument_count > 1 && is_real(argument[1])) ? clamp(argument[1], 0, 120) : 70;
		var _hr = "";
		repeat(_count) {
			_hr += _str;
		}
		return _hr;
	}

	tests = [];
	logs = [];

	if argument_count > 0 {
		self.crispyStructUnpack(argument[0]);
	}

}

/**
 * Test case to run assertion.
 * @constructor
 * @param {function} fun - Function that holds the test.
 * @param [string] name - Name of the test.
 */
function TestCase(fun) constructor {
	if typeof(fun) != "method" {
		throw("TestCase expects a method function as its , received " + string(typeof(fun)));
	}

	/**
	 * Test that first and second are equal.
	 * The first and second will be checked for the same type first, then check if they're equal.
	 * @function
	 * @param {*} first - First value.
	 * @param {*} second - Second value to check against.
	 * @param {string} [_msg] - Custom message to output on failure.
	 */
	function assertEqual(first, second) {
		var _msg = (argument_count > 2) ? argument[2] : undefined;
		if typeof(first) != typeof(second) {
			self.parent.addLog(new crispyLog(self, {pass:false,msg:"Supplied typeof() values are not equal: " + typeof(first) + " and " + typeof(second) + "."}));
			return;
		}
		if first == second {
			self.parent.addLog(new crispyLog(self));
		} else {
			self.parent.addLog(new crispyLog(self, {pass:false,msg:_msg,helper_text:"first and second are not equal: " + string(first) + ", " + string(second)}));
		}
	}

	/**
	 * Test that first and second are not equal.
	 * @function
	 * @param {*} first - First type to check.
	 * @param {*} second - Second type to check against.
	 * @param {string} [_msg] - Custom message to output on failure.
	 */
	function assertNotEqual(first, second) {
		var _msg = (argument_count > 2) ? argument[2] : undefined;
		if first != second {
			self.parent.addLog(new crispyLog(self, {pass:true}));
		} else {
			self.parent.addLog(new crispyLog(self, {pass:false,msg:_msg,helper_text:"first and second are equal: " + string(first) + ", " + string(second)}));
		}
	}

	/**
	 * Test whether the provided expression is true.
	 * The test will first convert the expr to a boolean, then check if it equals true.
	 * @function
	 * @param {*} expr - Expression to check.
	 * @param {string} [_msg] - Custom message to output on failure.
	 */
	function assertTrue(expr) {
		var _msg = (argument_count > 1) ? argument[1] : undefined;
		try {
			var _bool = bool(expr);
		}
		catch(err) {
			self.parent.addLog(new crispyLog(self, {pass:false,helper_text:"Unable to convert " + typeof(expr) + " into boolean. Cannot evaluate."}));
			return;
		}
		if _bool == true {
			self.parent.addLog(new crispyLog(self, {pass:true}));
		} else {
			self.parent.addLog(new crispyLog(self, {pass:false,msg:_msg,helper_text:"expr is not true."}));
		}
	}

	/**
	 * Test whether the provided expression is false.
	 * The test will first convert the expr to a boolean, then check if it equals false.
	 * @function
	 * @param {*} expr - Expression to check.
	 * @param {string} [_msg] - Custom message to output on failure.
	 */
	function assertFalse(expr) {
		var _msg = (argument_count > 1) ? argument[1] : undefined;
		try {
			var _bool = bool(expr);
		}
		catch(err) {
			self.parent.addLog(new crispyLog(self, {pass:false,helper_text:"Unable to convert " + typeof(expr) + " into boolean. Cannot evaluate."}));
			return;
		}
		if _bool == false {
			self.parent.addLog(new crispyLog(self, {pass:true}));
		} else {
			self.parent.addLog(new crispyLog(self, {pass:false,msg:_msg,helper_text:"Expression is not false."}));
		}
	}

	updateName = function(name) {
		self.name = name;
	}

	run = function() {
		test();
	}

	name = (argument_count > 1 && !is_undefined(argument[1]) && is_string(argument[1])) ? argument[1] : undefined;
	class = instanceof(self);
	parent = undefined;
	test = method(self, fun);

}

/**
 * Save the current in-game's time as a starting position.
 * @function
 */
function crispyTimeStart() {
	global.CRISPY_TIME_START = get_timer();
}

/**
 * Save the current in-game's time as a stopping position and updates the difference.
 * @function
 */
function crispyTimeStop() {
	global.CRISPY_TIME_STOP = get_timer();
	crispyTimeUpdate();
}

/**
 * Updates the current crispy time in seconds
 * @function
 */
function crispyTimeUpdate() {
	global.CRISPY_TIME = (global.CRISPY_TIME_STOP - global.CRISPY_TIME_START) / 1000000;
}

/**
 * Returns the current crispy time difference as a string 
 * @function
 */
function crispyGetTime() {
	return string_format(global.CRISPY_TIME, 0, CRISPY_TIME_PRECISION);
}

/**
 * Saves the result and output of assertion.
 * @constructor
 * @param {TestCase} _case - Testcase struct that ran the assertion.
 * @param [struct] Structure to replace existing constructor values.
 */
function crispyLog(_case) : crispyExtendStructUnpack() constructor {
	getMsg = function() {
		if self.verbosity == 2 && self.display_name != "" {
			var _msg = self.display_name + " ";
		} else {
			var _msg = "";
		}
		switch(self.verbosity) {
			case 0:
				if self.pass {
					_msg += CRISPY_PASS_MSG_SILENT;
				} else {
					_msg += CRISPY_FAIL_MSG_SILENT;
				}
				break;
			case 1:
				/*
				if self.pass {
					_msg += CRISPY_PASS_MSG_VERBOSE;
				} else {
					_msg += CRISPY_FAIL_MSG_VERBOSE;
				}
				*/
				break;
			case 2:
				if self.pass {
					_msg += "..." + CRISPY_PASS_MSG_VERBOSE;
				} else {
					if !is_undefined(self.msg) && self.msg != "" {
						_msg += " - " + self.msg;
					} else {
						if !is_undefined(self.helper_text) {
							_msg += " - " + self.helper_text;
						}
					}
				}
				break;
		}
		return _msg;
	}

	self.verbosity = CRISPY_VERBOSITY;
	self.pass = true;
	self.msg = undefined;
	self.helper_text = undefined;
	self.class = _case.class;
	self.name = _case.name;

	if argument_count > 1 {
		self.crispyStructUnpack(argument[1]);
	}

	var _display_name = "";
	if !is_undefined(self.name) {
		_display_name += self.name;
	}
	if !is_undefined(self.class) {
		if _display_name != "" {
			_display_name += "." + self.class;
		} else {
			_display_name += self.class;
		}
	}
	self.display_name = _display_name;

}

/**
 * Helper function that extends structs to have crispyStructUnpack() function.
 * @function
 * @param {struct} _struct - Struct to give method veriable.
 */
function crispyExtendStructUnpack() constructor {
	crispyStructUnpack = method(self, crispyStructUnpack);
}

/**
 * Helper function for constructorts that will replace its values with the struct's.
 * @function
 * @param {struct} _struct - Struct to replace existing values with.
 */
function crispyStructUnpack(_struct) {
	if !is_struct(_struct) {
		throw("crispyStructUnpack() expectes a struct, received " + typeof(_struct) + ".");
	}
	var _names = variable_struct_get_names(_struct);
	var _len = array_length(_names);
	for(var i = 0; i < _len; i++) {
		var _value = variable_struct_get(_struct, _names[i]);
		if variable_struct_exists(self, _names[i]) {
			variable_struct_set(self, _names[i], _value);
		}
	}
}


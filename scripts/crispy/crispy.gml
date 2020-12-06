/**
 * crispy();
 * @description Crispy is an automated unit testing framework built in GML for GameMaker Studio 2.3+
 * https://github.com/bfrymire/crispy
 * Copywrite (c) 2020 bfrymire
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

show_debug_message("Using Crispy automated unit testing framework version " + CRISPY_VERSION);


/**
 * Runner to hold TestSuites and iterates through each TestSuite, running its TestUnits when instructed to.
 * @constructor
 */
function TestRunner() : crispyExtendStructUnpack() constructor {
	addLog = function(log) {
		logs[array_length(logs)] = log;
	}

	addSuite = function(suite) {
		if instanceof(suite) != "TestSuite" {
			try {
				throw(instanceof(self) + ".addSuite() expects a TestSuite instance, received " + instanceof(suite));
			}
			catch(err) {
				throw(instanceof(self) + ".addSuite() expects a TestSuite instance, received " + typeof(suite));
			}
		}
		suite.parent = self;
		self.suites[array_length(self.suites)] = suite;
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

  	run = function() {
		self.setUp();
		var _suites_len = array_length(self.suites);
		for(var k = 0; k < _suites_len; k++) {
			// self.suites[i].run();
			var _suite = self.suites[k];
			// _suite.setUp(); // TO-DO: Move the TestSuite's setUp and tearDown to the TestRunner
			var _tests_len = array_length(_suite.tests);
			for(var i = 0; i < _tests_len; i++) {
				var _test = _suite.tests[i];
				_test.run();
				var _logs_len = array_length(_test.logs);
				for(var j = 0; j < _logs_len; j++) {
					self.addLog(_test.logs[j]);
				}
			}
			// _suite.tearDown(); // TO-DO: Move the TestSuite's setUp and tearDown to the TestRunner
		}
		self.tearDown();
	}

	setUp = function() {
		self.start_time = crispyGetTime();
		if !is_undefined(self.__setUp) {
			self.__setUp();
		}
	}

	tearDown = function() {
		if !is_undefined(self.__tearDown) {
			self.__tearDown();
		}

		// Get total run time
		self.stop_time = crispyGetTime();
		self.total_time = crispyGetTimeDiff(self.start_time, self.stop_time);
		self.display_time = crispyTimeConvert(self.total_time);

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
		show_debug_message("\n" + string(_len) + " tests ran in " + self.display_time + "s");

		if _passed_tests == _len {
			show_debug_message(string_upper(CRISPY_PASS_MSG_VERBOSE));
		}
	}

	__setUp = undefined;
	__tearDown = undefined;
	name = (argument_count > 0 && !is_string(argument[0])) ? argument[0] : "TestRunner";
	start_time = 0;
	stop_time = 0;
	total_time = 0;
	display_time = "0";
	suites = [];
	logs = [];

	// Struct Unpacker
	if argument_count > 1 {
		self.crispyStructUnpack(argument[1]);
	}

}

/**
 * Suite to hold tests and will run each test when instructed to.
 * @constructor
 */
function TestSuite() : crispyExtendStructUnpack() constructor {
	addTest = function(_case) {
		_case.parent = self;
		self.tests[array_length(tests)] = _case;
	}

	setUp = function() {
		// Moved to TestRunner
	}

	tearDown = function() {
		// Moved to TestRunner
	}

	run = function() {
		// self.setUp();
		var _len = array_length(self.tests);
		for(var i = 0; i < _len; i++) {
			if !is_undefined(self.parent) && instance_exists(self.parent) {
				// self.tests[i].
			}
			self.tests[i].run();
		}
		// self.tearDown();
	}

	parent = undefined;
	tests = [];

	// Struct Unpacker
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
	if !is_method(fun) {
		throw(instanceof(self) + "() expected a method function as argument0, received " + typeof(fun));
	}

	addLog = function(log) {
		logs[array_length(logs)] = log;
	}

	/**
	 * Test that first and second are equal.
	 * The first and second will be checked for the same type first, then check if they're equal.
	 * @function
	 * @param {*} first - First value.
	 * @param {*} second - Second value to check against.
	 * @param {string} [_msg] - Custom message to output on failure.
	 */
	assertEqual = function(first, second) {
		var _msg = (argument_count > 2) ? argument[2] : undefined;
		if typeof(first) != typeof(second) {
			self.addLog(new crispyLog(self, {pass:false,msg:"Supplied typeof() values are not equal: " + typeof(first) + " and " + typeof(second) + "."}));
			return;
		}
		if first == second {
			self.addLog(new crispyLog(self));
		} else {
			self.addLog(new crispyLog(self, {pass:false,msg:_msg,helper_text:"first and second are not equal: " + string(first) + ", " + string(second)}));
		}
	}

	/**
	 * Test that first and second are not equal.
	 * @function
	 * @param {*} first - First type to check.
	 * @param {*} second - Second type to check against.
	 * @param {string} [_msg] - Custom message to output on failure.
	 */
	assertNotEqual = function(first, second) {
		var _msg = (argument_count > 2) ? argument[2] : undefined;
		if first != second {
			self.addLog(new crispyLog(self, {pass:true}));
		} else {
			self.addLog(new crispyLog(self, {pass:false,msg:_msg,helper_text:"first and second are equal: " + string(first) + ", " + string(second)}));
		}
	}

	/**
	 * Test whether the provided expression is true.
	 * The test will first convert the expr to a boolean, then check if it equals true.
	 * @function
	 * @param {*} expr - Expression to check.
	 * @param {string} [_msg] - Custom message to output on failure.
	 */
	assertTrue = function(expr) {
		var _msg = (argument_count > 1) ? argument[1] : undefined;
		try {
			var _bool = bool(expr);
		}
		catch(err) {
			self.addLog(new crispyLog(self, {pass:false,helper_text:"Unable to convert " + typeof(expr) + " into boolean. Cannot evaluate."}));
			return;
		}
		if _bool == true {
			self.addLog(new crispyLog(self, {pass:true}));
		} else {
			self.addLog(new crispyLog(self, {pass:false,msg:_msg,helper_text:"expr is not true."}));
		}
	}

	/**
	 * Test whether the provided expression is false.
	 * The test will first convert the expr to a boolean, then check if it equals false.
	 * @function
	 * @param {*} expr - Expression to check.
	 * @param {string} [_msg] - Custom message to output on failure.
	 */
	assertFalse = function(expr) {
		var _msg = (argument_count > 1) ? argument[1] : undefined;
		try {
			var _bool = bool(expr);
		}
		catch(err) {
			self.addLog(new crispyLog(self, {pass:false,helper_text:"Unable to convert " + typeof(expr) + " into boolean. Cannot evaluate."}));
			return;
		}
		if _bool == false {
			self.addLog(new crispyLog(self, {pass:true}));
		} else {
			self.addLog(new crispyLog(self, {pass:false,msg:_msg,helper_text:"Expression is not false."}));
		}
	}

	setUp = function() {
		if argument_count > 0 {
			if is_method(argument[0]) {
				self.__setUp = method(self, argument[0]);
			} else {
				throw(instanceof(self) + "().setUp() expected a method function, received " + typeof(argument[0]));
			}
		} else {
			if !is_undefined(self.__setUp) {
				self.__setUp();
			}
		}
	}
	__setUp = undefined;
	
	tearDown = function() {
		if argument_count > 0 {
			if is_method(argument[0]) {
				self.__tearDown = method(self, argument[0]);
			} else {
				throw(instanceof(self) + "().tearDown() expected a method function, received " + typeof(argument[0]));
			}
		} else {
			if !is_undefined(self.__tearDown) {
				self.__tearDown();
			}
		}
	}
	__tearDown = undefined;

	updateName = function(name) {
		self.name = name;
	}

	run = function() {
		self.setUp(); // TO-DO: When TestCase.setUp() is created, clear the logs
		self.test();
		self.tearDown();
	}

	name = (argument_count > 1 && !is_undefined(argument[1]) && is_string(argument[1])) ? argument[1] : undefined;
	class = instanceof(self);
	parent = undefined;
	test = method(self, fun);
	logs = [];

}

/**
 * Returns the current crispy time difference as a string 
 * @function
 */
function crispyGetTime() {
	return get_timer();
}

/**
 * Updates the current crispy time in seconds
 * @function
 */
function crispyGetTimeDiff(start_time, stop_time) {
	if !is_real(start_time) {
		throw("crispyGetTimeDiff() start_time expects a number, received " + typeof(start_time));
	}
	if !is_real(stop_time) {
		throw("crispyGetTimeDiff() stop_time expects a number, received " + typeof(stop_time));
	}
	return (stop_time - start_time) / 1000000;
}

/**
 * Returns the current crispy time difference as a string 
 * @function
 */
function crispyTimeConvert(time) {
	return string_format(time, 0, CRISPY_TIME_PRECISION);
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

	// Struct Unpacker
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
		throw("crispyStructUnpack() expected a struct, received " + typeof(_struct) + ".");
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

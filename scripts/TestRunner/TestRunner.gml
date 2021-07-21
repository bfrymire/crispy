/**
 * Runner to hold TestSuites and iterates through each TestSuite, running its TestUnits when instructed to.
 * @constructor
 * @param [name]
 * @param [struct] - Struct for crispyStructUnpack
 */
function TestRunner() constructor {

	// Give self cripsyStructUnpack() function
	crispyMixinStructUnpack(self);

	// @param log
	static addLog = function(_log) {
		array_push(logs, _log);
	}

	// @param instance
	static captureLogs = function(_inst) {
		switch (instanceof(_inst)) {
			case "CrispyLog":
				addLog(_inst);
				break;
			case "TestCase":
				var _logs_len = array_length(_inst.logs);
				for(var i = 0; i < _logs_len; i++) {
					addLog(_inst.logs[i]);
				}
				break;
			case "TestSuite":
				var _tests_len = array_length(_inst.tests);
				for(var k = 0; k < _tests_len; k++) {
					var _logs_len = array_length(_inst.tests[k].logs);
					for(var i = 0; i < _logs_len; i++) {
						addLog(_inst.tests[k].logs[i]);
					}
				}
				break;
			default:
				var _type = !is_undefined(instanceof(_inst)) ? instanceof(_inst) : typeof(_inst);
				crispyThrowExpected(self, "captureLogs", "{CrispyLog|TestCase|TestSuite}", _type);
				break;
		}
	}

	// @param suite
	static addTestSuite = function(_suite) {
		var _inst = instanceof(_suite);
		if _inst != "TestSuite" {
			var _type = !is_undefined(_inst) ? _inst : typeof(_inst);
			crispyThrowExpected(self, "addTestSuite", "TestSuite", _type);
		}
		_suite.parent = self;
		array_push(suites, _suite);
	}


	// @param [string]
	// @param [count]
	static hr = function() {
		var _str = (argument_count > 0 && is_string(argument[0])) ? argument[0] : "-";
		var _count = (argument_count > 1 && is_real(argument[1])) ? clamp(floor(argument[1]), 0, 120) : 70;
		var _hr = "";
		repeat(_count) {
			_hr += _str;
		}
		return _hr;
	}

  	static run = function() {
		setUp();
		var _len = array_length(suites);
		for(var i = 0; i < _len; i++) {
			suites[i].run();
			captureLogs(suites[i]);
		}
		tearDown();
	}

	// @param [function]
	static setUp = function() {
		if argument_count > 0 {
			if is_method(argument[0]) {
				__setUp__ = method(self, argument[0]);
			} else {
				crispyThrowExpected(self, "setUp", "method", typeof(argument[0]));
			}
		} else {
			logs = [];
			start_time = crispyGetTime();
			if is_method(__setUp__) {
				__setUp__();
			}
		}
	}

	// @param [name]
	// @param [function]
	static tearDown = function() {
		if argument_count > 0 {
			if is_method(argument[0]) {
				__tearDown__ = method(self, argument[0]);
			} else {
				crispyThrowExpected(self, "tearDown", "method", typeof(argument[0]));
			}
		} else {
			// Get total run time
			stop_time = crispyGetTime();
			total_time = crispyGetTimeDiff(start_time, stop_time);
			display_time = crispyTimeConvert(total_time);

			// Display silent test results
			var _passed_tests = 0;
			var _len = array_length(logs);
			var _t = "";
			for(var i = 0; i < _len; i++) {
				if logs[i].pass {
					_t += CRISPY_PASS_MSG_SILENT;
				} else {
					_t += CRISPY_FAIL_MSG_SILENT;
				}
			}
			output(_t);

			// Horizontal row
			output(hr());

			// Show individual log messages
			for(var i = 0; i < _len; i++) {
				if logs[i].pass {
					_passed_tests += 1;
				}
				var _msg = logs[i].getMsg();
				if _msg != "" {
					output(_msg);
				}
			}

			// Finish by showing entire time it took to run the tests
			var _string_tests = _len == 1 ? "test" : "tests";
			output("");
			output(string(_len) + " " + _string_tests + " ran in " + display_time + "s");

			if _passed_tests == _len {
				output(string_upper(CRISPY_PASS_MSG_VERBOSE));
			} else {
				output(string_upper(CRISPY_FAIL_MSG_VERBOSE) + "ED (failures==" + string(_len - _passed_tests) + ")");
			}

			if is_method(__tearDown__) {
				__tearDown__();
			}
			
		}

	}

	// @param message|function
	static output = function() {
		var _input = argument[0];
		if argument_count == 1 {
			switch (typeof(_input)) {
				case "string":
						__output__(_input);
					break;
				case "method":
						__output__ = method(self, _input);
					break;
				default:
					crispyThrowExpected(self, "output", "[string|method]", typeof(_input));
					break;
			}
		} else {
			throw(name + ".output() expected 1 argument, received " + string(argument_count) + " arguments.");
		}
	}

	// @param message
	static __output__ = function(_message) {
		show_debug_message(_message);
	}
	
	__setUp__ = undefined;
	__tearDown__ = undefined;
	name = (argument_count > 0 && !is_string(argument[0])) ? argument[0] : "TestRunner";
	start_time = 0;
	stop_time = 0;
	total_time = 0;
	display_time = "0";
	suites = [];
	logs = [];

	// Struct unpacker
	if argument_count > 1 {
		crispyStructUnpack(argument[1]);
	}

}

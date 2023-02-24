/**
 * Runner to hold test suites and iterates through each TestSuite, running its tests
 * @constructor TestRunner
 * @param {String} _name - Name of runner
 * @param {Struct} [_unpack=undefined] - Struct for crispyStructUnpack
 */
function TestRunner(_name, _unpack=undefined) : BaseTestClass(_name) constructor {

	start_time = 0;
	stop_time = 0;
	total_time = 0;
	display_time = "0";
	suites = [];
	logs = [];

	/**
	 * Run struct unpacker if unpack argument was provided
	 * Stays after all variables are initialized so they may be overwritten
	 */
	if !is_undefined(_unpack) {
		if is_struct(_unpack) {
			crispyStructUnpack(_unpack);
		} else {
			throw(instanceof(self) + " \"unpack\" expected a struct or undefined, recieved " + typeof(_unpack) + ".");
		}
	}

	// Methods

	/**
	 * Adds a Log to the array of logs
	 * @function addLog
	 * @param {Struct} _log - Log struct to add to logs
	 */
	static addLog = function(_log) {
		array_push(logs, _log);
	}

	/**
	 * Adds Logs to the array of logs
	 * @function captureLogs
	 * @param {Struct} _inst - Adds logs of inst to logs
	 */
	static captureLogs = function(_inst) {
		var i, _logs_len;
		switch (instanceof(_inst)) {
			case "CrispyLog":
				addLog(_inst);
				break;
			case "TestCase":
				_logs_len = array_length(_inst.logs);
				i = 0;
				repeat (_logs_len) {
					addLog(_inst.logs[i]);
					++i;
				}
				break;
			case "TestSuite":
				var _tests_len = array_length(_inst.tests);
				var k = 0;
				repeat (_tests_len) {
					_logs_len = array_length(_inst.tests[k].logs);
					i = 0;
					repeat (_logs_len) {
						addLog(_inst.tests[k].logs[i]);
						++i;
					}
					++k;
				}
				break;
			default:
				var _type = !is_undefined(instanceof(_inst)) ? instanceof(_inst) : typeof(_inst);
				throw(instanceof(self) + ".captureLogs() \"inst\" expected an instance of either CrispyLog, TestCase, or TestSuite, received " + _type + ".");
				break;
		}
	}

	/**
	 * Adds TestSuite to array of suites
	 * @function addTestSuite
	 * @param {Struct} _test_suite - TestSuite to add
	 */
	static addTestSuite = function(_test_suite) {
		if instanceof(_test_suite) != "TestSuite" {
			var _type = !is_undefined(instanceof(_test_suite)) ? instanceof(_test_suite) : typeof(_test_suite);
			throw(instanceof(self) + ".addTestSuite() \"test_suite\" expected an instance of TestSuite, received " + _type + ".");
		}
		_test_suite.parent = self;
		array_push(suites, _test_suite);
	}

	/**
	 * Creates a horizontal row string
	 * @function hr
	 * @param {string} [srt="-"] - String to concat n times
	 * @param {Real} [count=70] - Number of times to concat _str.
	 * @returns {String} String of horizontal row
	 */
	static hr = function() {
		var _str = (argument_count > 0 && is_string(argument[0])) ? argument[0] : "-";
		var _count = (argument_count > 1 && is_real(argument[1])) ? max(0, round(argument[1])) : 70;
		var _hr = "";
		repeat(_count) {
			_hr += _str;
		}
		return _hr;
	}

	/**
	 * Runs test suites and logs results
	 * @function run
	 */
  	static run = function() {
		setUp();
		var _len = array_length(suites);
		var i = 0;
		repeat (_len) {
			onRunBegin();
			suites[i].run();
			captureLogs(suites[i]);
			onRunEnd();
			++i;
		}
		tearDown();
	}

	/**
	 * Clears logs, starts timer, and runs __setUp__
	 * @function setUp
	 * @param {Function} [_func] - Method to override __setUp__ with
	 */
	static setUp = function() {
		if argument_count > 0 {
			var _func = argument[0];
			if is_method(_func) {
				__setUp__ = method(self, _func);
			} else {
				throw(instanceof(self) + ".setUp() \"func\" expected a method, received " + typeof(_func) + ".");
			}
		} else {
			logs = [];
			start_time = crispyGetTime();
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
		var i;
		if argument_count > 0 {
			var _func = argument[0];
			if is_method(_func) {
				__tearDown__ = method(self, _func);
			} else {
				throw(instanceof(self) + ".tearDown() \"func\" expected a method, received " + typeof(_func) + ".");
			}
		} else {
			if CRISPY_DEBUG && CRISPY_SILENCE_PASSING_TESTS_OUTPUT {
				crispyDebugMessage("Passing test messages are silenced.");
			}

			// Get total run time
			stop_time = crispyGetTime();
			total_time = crispyGetTimeDiff(start_time, stop_time);
			display_time = crispyTimeConvert(total_time);

			// Display silent test results
			var _passed_tests = 0;
			var _len = array_length(logs);
			var _t = "";
			i = 0;
			repeat (_len) {
				if logs[i].pass {
					_t += CRISPY_PASS_MSG_SILENT;
				} else {
					_t += CRISPY_FAIL_MSG_SILENT;
				}
				++i;
			}
			output(_t);

			// Horizontal row
			output(hr());

			// Show individual log messages
			i = 0;
			repeat (_len) {
				if logs[i].pass {
					_passed_tests += 1;
				}
				if !CRISPY_SILENCE_PASSING_TESTS_OUTPUT || !logs[i].pass {
					var _msg = logs[i].getMsg();
					if _msg != "" {
						output(_msg);
					}
				}
				++i;
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

	/**
	 * Function for discovering individual test functions within
	 * 		scripts, and adds them to a TestSuite
	 * @function discover
	 * @param {Struct} [_test_suite=undefined] - TestSuite to add
	 * 		discovered test script to, else create a temporary TestSuite
	 * @param {String} [_script_start_pattern="test_"] - String that script
	 * 		functions need to start with in order to be discoverable
	 */
	static discover = function(_test_suite, _script_start_pattern) {

		var _created_test_suite = is_undefined(_test_suite);
		// If value is passed for test_suite
		if !is_undefined(_test_suite) {
			if instanceof(_test_suite) != "TestSuite" {
				var _type = !is_undefined(instanceof(_test_suite)) ? instanceof(_test_suite) : typeof(_test_suite);
				throw(instanceof(self) + ".discover() \"test_suite\" expected an instance of TestSuite, received " + _type + ".");
			}
			// Throw error if test_suite was not previously added to test_runner
			if _test_suite.parent != self {
				throw(instanceof(self) + ".discover() \"test_suite\" parent is not self.\nProvided TestSuite may not have been added to " + self.name + " prior to running discover.");
			}
		} else {
			_test_suite = new TestSuite("__discovered_test_suite__");
		}

		if is_undefined(_script_start_pattern) {
			_script_start_pattern = "test_";
		}
		if !is_string(_script_start_pattern) {
			throw(instanceof(self) + ".discover() \"script_start_pattern\" expected a string, received " + typeof(_script_start_pattern) + ".");
		}
		// Throw error if function pattern is an empty string
		if _script_start_pattern == "" {
			show_error(instanceof(self) + ".discover() \"script_start_pattern\" cannot be an empty string.", true);
		}

		var _len = string_length(_script_start_pattern);
		var i = 100000;
		repeat (10000) { // Range of custom scripts is 100000 - 110000
			if script_exists(i) {
				var _script_name = script_get_name(i);
				if string_pos(_script_start_pattern, _script_name) == 1 && string_length(_script_name) > _len {
					if CRISPY_DEBUG {
						crispyDebugMessage("Discovered test script: " + _script_name + " (" + string(i) + ").");
					}
					var _test_case = new TestCase(_script_name, function(){});
					// Feather disable once GM1041
					_test_case.__discover__(i);
					_test_suite.addTestCase(_test_case);
				}
			}
			++i;
		}
		if _created_test_suite {
			if array_length(_test_suite.tests) == 0 {
				delete _test_suite;
				if CRISPY_DEBUG {
					crispyDebugMessage(name + ".discover() local TestSuite deleted.");
				}
			} else {
				addTestSuite(_test_suite);
				if CRISPY_DEBUG {
					crispyDebugMessage(name + ".discover() local TestSuite added: " + _test_suite.name);
				}
			}
		}
	}

	/**
	 * Pass input to __output__ if string. Overwrite __output__ if function
	 * @function output
	 * @param {String|Function} _input - String to output or function to
	 * 		overwrite __output__
	 */
	static output = function() {
		var _input = (argument_count > 0) ? argument[0] : undefined;
		if argument_count > 0 {
			switch (typeof(_input)) {
				case "string":
					__output__(_input);
					break;
				case "method":
					__output__ = method(self, _input);
					break;
				default:
					throw(instanceof(self) + ".output() \"input\" expected either a string or method, received " + typeof(_input) + ".");
					break;
			}
		} else {
			throw(instanceof(self) + ".output() expected 1 argument, received " + string(argument_count) + " argument(s).");
		}
	}

	/**
	 * Function that gets called on output
	 * @function __output__
	 * @param {String} _message - By default, prints string to Output Console
	 * @NOTE This function can be overwritten by a function passed into
	 *		 the output() function
	 * @ignore
	 */
	static __output__ = function(_message) {
		show_debug_message(_message);
	}

}

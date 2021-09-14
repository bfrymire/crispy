/**
 * Testing suite that holds tests
 * @constructor
 * @param {string} [name] - Name of runner
 * @param {struct} - Struct for crispyStructUnpack
 */
function TestSuite() : BaseTestClass() constructor {

	var _name = (argument_count > 0 && is_string(argument[0])) ? argument[0] : "TestSuite";

	name = _name;
	parent = undefined;
	tests = [];
	__discovered_tests__ = [];
	__test__ = undefined

	
	/**
	 * Adds test case to array of cases
	 * @function
	 * @param {TestCase} case - TestCase to add
	 */
	static addTestCase = function(_case) {
		var _inst = instanceof(_case);
		if _inst != "TestCase" {
			var _type = !is_undefined(_inst) ? _inst : typeof(_case);
			crispyThrowExpected(self, "addTestCase", "TestCase", _type);
		}
		_case.parent = self;
		array_push(tests, _case);
	}

	/**
	 * Event that runs before all tests to set up variables
	 * 		Can also overwrite __setUp__
	 * @function
	 * @param {method} [func] - Function to overwrite __setUp__
	 */
	static setUp = function() {
		if argument_count > 0 {
			var _func = argument[0];
			if is_method(_func) {
				__setUp__ = method(self, _func);
			} else {
				crispyThrowExpected(self, "setUp", "method", typeof(_func));
			}
		} else {
			if is_method(__setUp__) {
				__setUp__();
			}
		}
	}

	/**
	 * Event that runs after all tests to clean up variables
	 * 		Can also overwrite __tearDown__
	 * @function
	 * @param {method} [func] - Function to overwrite __tearDown__
	 */
	static tearDown = function() {
		if argument_count > 0 {
			var _func = argument[0];
			if is_method(_func) {
				__tearDown__ = method(self, _func);
			} else {
				crispyThrowExpected(self, "tearDown", "method", typeof(_func));
			}
		} else {
			if is_method(__tearDown__) {
				__tearDown__();
			}
		}
	}

	/**
	 * Runs tests
	 * @function
	 */
	static run = function() {
		setUp();
		var _len = array_length(tests);
		for(var i = 0; i < _len; i++) {
			tests[i].run();
		}
		tearDown();
	}

	/**
	 * Set the name of the TestCase
	 * @param {string} name - Name of the test
	 */
	static setName = function(_name) {
		if !is_string(_name) {
			crispyThrowExpected(self, "setName", "string", typeof(_name));
		}
		name = _name;
	}

	/**
	 * Adds a script ID to discovered tests array
	 * @param {real} script - ID of script
	 */
	static __addDiscoveredTest__ = function() {
		_script = (argument_count > 0) ? argument[0] : undefined;
		if !is_real(_script) {
			crispyThrowExpected(self, "__addDiscoveredTest__", "real", typeof(_script));
		}
		if !script_exists(_script) {
			throw("Script with ID " + string(_script) + " cannot be found.");
		}
		array_push(__discovered_tests__, _script);
	}

	// Struct unpacker if a struct was passed as unpack
	if argument_count > 1 {
		var _unpack = argument[1];
		if !is_struct(_unpack) {
			crispyThrowExpected(self, "", "struct", typeof(_unpack));
		}
		crispyStructUnpack(_unpack);
	}

}

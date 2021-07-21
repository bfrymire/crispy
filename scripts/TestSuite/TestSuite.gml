/**
 * Suite to hold tests and will run each test when instructed to.
 * @constructor
 * @param [name]
 * @param [struct] - Struct for crispyStructUnpack
 */
function TestSuite() constructor {

	// Give self cripsyStructUnpack() function
	crispyMixinStructUnpack(self);

	// @param case
	static addTestCase = function(_case) {
		var _inst = instanceof(_case);
		if _inst != "TestCase" {
			var _type = !is_undefined(_inst) ? _inst : typeof(_case);
			crispyThrowExpected(self, "addTestCase", "TestCase", _type);
		}
		_case.parent = self;
		array_push(tests, _case);
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
			if is_method(__setUp__) {
				__setUp__();
			}
		}
	}

	// @param [function]
	static tearDown = function() {
		if argument_count > 0 {
			if is_method(argument[0]) {
				__tearDown__ = method(self, argument[0]);
			} else {
				crispyThrowExpected(self, "tearDown", "method", typeof(argument[0]));
			}
		} else {
			if is_method(__tearDown__) {
				__tearDown__();
			}
		}
	}

	static run = function() {
		setUp();
		var _len = array_length(tests);
		for(var i = 0; i < _len; i++) {
			tests[i].run();
		}
		tearDown();
	}

	// @param name
	static setName = function(_name) {
		if !is_string(_name) {
			crispyThrowExpected(self, "setName", "string", typeof(_name));
		}
		name = _name;
	}

	__setUp__ = undefined;
	__tearDown__ = undefined;
	parent = undefined;
	tests = [];
	name = (argument_count > 0 && !is_string(argument[0])) ? argument[0] : "TestSuite";


	// Struct unpacker
	if argument_count > 1 {
		crispyStructUnpack(argument[1]);
	}

}

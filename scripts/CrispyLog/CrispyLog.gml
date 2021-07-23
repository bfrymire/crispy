/**
 * Saves the result and output of assertion
 * @constructor
 * @param {TestCase} case - TestCase struct that ran the assertion
 * @param {struct} [unpack] - Structure to use with crispyStructUnpack
 */
function CrispyLog() constructor {

	var _case = (argument_count > 0) ? argument[0] : undefined;
	var _unpack = (argument_count > 1 && is_struct(argument[1])) ? argument[1] : undefined;

	if instanceof(_case) != "TestCase" {
		try {
			var _type = instanceof(_case);
		} catch(_e) {
			var _type = typeof(_case);
		}
		crispyThrowExpected(self, "", "TestCase", _type);
	}

	// Give self cripsyStructUnpack() function
	crispyMixinStructUnpack(self);

	static getMsg = function() {
		if verbosity == 2 && display_name != "" {
			var _msg = display_name + " ";
		} else {
			var _msg = "";
		}
		switch(verbosity) {
			case 0:
				if pass {
					_msg += CRISPY_PASS_MSG_SILENT;
				} else {
					_msg += CRISPY_FAIL_MSG_SILENT;
				}
				break;
			case 1:
				/*
				if pass {
					_msg += CRISPY_PASS_MSG_VERBOSE;
				} else {
					_msg += CRISPY_FAIL_MSG_VERBOSE;
				}
				*/
				break;
			case 2:
				if pass {
					_msg += "..." + CRISPY_PASS_MSG_VERBOSE;
				} else {
					if !is_undefined(msg) && msg != "" {
						_msg += "- " + msg;
					} else {
						if !is_undefined(helper_text) {
							_msg += "- " + helper_text;
						}
					}
				}
				break;
		}
		return _msg;
	}

	verbosity = CRISPY_VERBOSITY;
	pass = true;
	msg = undefined;
	helper_text = undefined;
	class = _case.class;
	name = _case.name;

	var _display_name = "";
	if !is_undefined(name) {
		_display_name += name;
	}
	if !is_undefined(class) {
		if _display_name != "" {
			_display_name += "." + class;
		} else {
			_display_name += class;
		}
	}
	display_name = _display_name;

	// Struct unpacker
	if is_struct(_unpack) {
		crispyStructUnpack(_unpack);
	}

}

/**
 * Creates and returns struct containing new test cases.
 * @function fixture_crispy_tests
 * @returns {Struct}
 */
function fixture_crispy_tests() {
    return {
        new_case: new TestCase("test_crispy_new_case", function() {}),
        pass: new TestCase("test_crispy_passing_case", function() {
            assertEqual(1, 1);
        }),
        fail: new TestCase("test_crispy_failing_case", function() {
            assertEqual(1, 2);
        }),
        fail_with_message: new TestCase("test_crispy_failing_case_with_message", function() {
            assertEqual(1, 2, "Expected 1 to equal 1.");
        })
    };
}

/**
 * Testing crispyMixinStructUnpack
 */
/// @ignore
function test_crispy_crispyMixinStructUnpack_when_name_must_exists_is_false() {
    var _scope = {};
    with (_scope) {
        crispyMixinStructUnpack();
        crispyStructUnpack({ a: 1 }, false);
    }
    assertTrue(variable_struct_exists(_scope, "a") && _scope.a == 1);
}

/// @ignore
function test_crispy_crispyMixinStructUnpack_when_name_must_exists_is_true() {
    var _scope = {};
    with (_scope) {
        crispyMixinStructUnpack();
        crispyStructUnpack({ a: 1 });
    }
    assertFalse(variable_struct_exists(_scope, "a"));
}

/**
 * Testing BaseTestClass initialization
 */
/// @ignore
function test_crispy_BaseTestClass_init_name_as_number_raises_error() {
    assertRaises(function() {
        var _test = new BaseTestClass(5);
    });
}

/// @ignore
function test_cripsy_BaseTestClass_init_name_as_number_raise_error_value() {
    assertRaiseErrorValue(function() {
        var _test = new BaseTestClass(5);
    }, "BaseTestClass.setName() \"name\" expected a string, received number.");
}

/**
 * Testing BaseTestClass method functions
 */
/// @ignore
function test_crispy_BaseTestClass_setName_fluent_interface() {
    var _test_1 = parent.fixture.new_case;
    var _test_2 = _test_1.setName("renamed");
    assertEqual(_test_1, _test_2);
}

/// @ignore
function test_crispy_BaseTestClass_setName() {
    var _test = parent.fixture.new_case;
    _test.setName("renamed");
    assertEqual(_test.name, "renamed");
}

/// @ignore
function test_crispy_BaseTestClass_setName_passed_undefined_raises_error() {
    assertRaises(function() {
        var _test = parent.fixture.new_case.setName(undefined);
    });
}

/// @ignore
function test_crispy_BaseTestClass_setName_passed_undefined_raise_error_value() {
    assertRaiseErrorValue(function() {
        var _test = parent.fixture.new_case.setName(undefined);
    }, "TestCase.setName() \"name\" expected a string, received undefined.");
}

/// @ignore
function test_crispy_BaseTestClass_onRunBegin_fluent_interface() {
    var _test_1 = parent.fixture.new_case;
    var _test_2 = _test_1.onRunBegin();
    assertEqual(_test_1, _test_2);
}

/// @ignore
function test_crispy_BaseTestClass_onRunBegin_passing_function() {
    var _test = new BaseTestClass("test").onRunBegin(function() {});
    assertTrue(is_method(_test.__onRunBegin__));
}

/// @ignore
function test_crispy_BaseTestClass_onRunBegin_passing_string_raises_error() {
    assertRaises(function() {
        var _test = new BaseTestClass("test").onRunBegin("will fail");
    });
}

/// @ignore
function test_crispy_BaseTestClass_onRunBegin_passing_string_raise_error_value() {
    assertRaiseErrorValue(function() {
        var _test = new BaseTestClass("test").onRunBegin("will fail");
    }, "BaseTestClass.onRunBegin() \"func\" expected a function, received string.");
}

/// @ignore
function test_crispy_BaseTestClass_onRunEnd_fluent_interface() {
    var _test_1 = parent.fixture.new_case;
    var _test_2 = _test_1.onRunEnd();
    assertEqual(_test_1, _test_2);
}

/// @ignore
function test_crispy_BaseTestClass_onRunEnd_passing_function() {
    var _test = new BaseTestClass("test").onRunEnd(function() {});
    assertTrue(is_method(_test.__onRunEnd__));
}

/// @ignore
function test_crispy_BaseTestClass_onRunEnd_passing_string_raises_error() {
    assertRaises(function() {
        var _test = new BaseTestClass("test").onRunEnd("will fail");
    });
}

/// @ignore
function test_crispy_BaseTestClass_onRunEnd_passing_string_raise_error_value() {
    assertRaiseErrorValue(function() {
        var _test = new BaseTestClass("test").onRunEnd("will fail");
    }, "BaseTestClass.onRunEnd() \"func\" expected a function, received string.");
}

/**
 * Testing TestCase initialization
 */
/// @ignore
function test_crispy_TestCase_init_name_as_number_raises_error() {
    assertRaises(function() {
        var _test = new TestCase(5, function() {});
    });
}

/// @ignore
function test_crispy_TestCase_init_name_as_number_raise_error_value() {
    assertRaiseErrorValue(function() {
        var _test = new TestCase(5, function() {});
    }, "TestCase.setName() \"name\" expected a string, received number.");
}

/// @ignore
function test_crispy_TestCase_init_func_as_undefined_raises_error() {
    assertRaises(function() {
        var _test = new TestCase("test", undefined);
    });
}

/// @ignore
function test_crispy_TestCase_init_func_as_undefined_raise_error_value() {
    assertRaiseErrorValue(function() {
        var _test = new TestCase("test", undefined);
    }, "TestCase \"func\" expected a function, received undefined.");
}

/// @ignore
function test_crispy_TestCase_init_class() {
    var _test = parent.fixture.new_case;
    assertIsUndefined(_test.parent);
}

/// @ignore
function test_crispy_TestCase_init_log_length() {
    var _test = parent.fixture.new_case;
    assertEqual(array_length(_test.logs), 0);
}

/// @ignore
function test_crispy_TestCase_init_is_discovered() {
    var _test = parent.fixture.new_case;
    assertFalse(_test.__is_discovered__);
}

/// @ignore
function test_crispy_TestCase_init_discovered_script() {
    var _test = parent.fixture.new_case;
    assertIsUndefined(_test.__discovered_script__);
}

/// @ignore
function test_crispy_TestCase_init_unpack_as_string_raises_error() {
    assertRaises(function() {
        var _test = new TestCase("test", function() {}, "will fail");
    });
}

/// @ignore
function test_crispy_TestCase_init_unpack_as_string_raise_error_value() {
    assertRaiseErrorValue(function() {
        var _test = new TestCase("test", function() {}, "will fail");
    }, "TestCase \"unpack\" expected a struct or undefined, recieved string.");
}

/**
 * Testing TestCase method functions
 */
/// @ignore
function test_crispy_TestCase_addLog_fluent_interface() {
    var _test_1 = parent.fixture.new_case;
    var _test_2 = _test_1.addLog({});
    assertEqual(_test_1, _test_2);
}

/// @ignore
function test_crispy_TestCase_addLog() {
    var _test = parent.fixture.new_case;
    _test.addLog({});
    assertEqual(array_length(_test.logs), 1);
}

/// @ignore
function test_crispy_TestCase_addLog_when_passed_undefined_raises_error() {
    assertRaises(function() {
        var _test = parent.fixture.new_case;
        _test.addLog();
    });
}

/// @ignore
function test_crispy_TestCase_addLog_when_passed_undefined_raise_error_value() {
    assertRaises(function() {
        var _test = parent.fixture.new_case;
        _test.addLog();
    });
}

/// @ignore
function test_crispy_TestCase_clearLogs_fluent_interface() {
    var _test_1 = parent.fixture.new_case;
    var _test_2 = _test_1.clearLogs();
    assertEqual(_test_1, _test_2);
}

/// @ignore
function test_crispy_TestCase_clearLogs() {
    var _test = parent.fixture.new_case;
    _test.addLog({}).clearLogs();
    assertEqual(array_length(_test.logs), 0);
}

/// @ignore
function test_crispy_TestCase_toString() {
    var _test = parent.fixture.new_case;
    assertEqual(string(_test), "<Crispy TestCase(\"test_crispy_new_case\")>");
}

/// @ignore
function test_crispy_TestCase_setUp_fluent_interface() {
    var _test_1 = parent.fixture.new_case;
    var _test_2 = _test_1.setUp();
    assertEqual(_test_1, _test_2);
}

/// @ignore
function test_crispy_TestCase_setup() {
    var _test = parent.fixture.new_case.setUp(function() {});
    assertTrue(is_method(_test.__setUp__));
}

/// @ignore
function test_crispy_TestCase_setup_passed_undefined_raises_error() {
    assertRaises(function() {
        var _test = parent.fixture.new_case.setUp(undefined);
    });
}

/// @ignore
function test_crispy_TestCase_setup_passed_undefined_raise_error_value() {
    assertRaiseErrorValue(function() {
        var _test = parent.fixture.new_case.setUp(undefined);
    }, "TestCase.setUp() \"func\" expected a function, received undefined.");
}

/// @ignore
function test_crispy_TestCase_setup_clears_logs() {
    var _test = parent.fixture.new_case.addLog({}).setUp();
    assertEqual(array_length(_test.logs), 0);
}

/// @ignore
function test_crispy_TestCase_tearDown_fluent_interface() {
    var _test_1 = parent.fixture.new_case;
    var _test_2 = _test_1.tearDown();
    assertEqual(_test_1, _test_2);
}

/// @ignore
function test_crispy_TestCase_tearDown() {
    var _test = parent.fixture.new_case.tearDown(function() {});
    assertTrue(is_method(_test.__tearDown__));
}

/// @ignore
function test_crispy_TestCase_tearDown_passed_undefined_raises_error() {
    assertRaises(function() {
        var _test = parent.fixture.new_case.tearDown(undefined);
    });
}

/// @ignore
function test_crispy_TestCase_tearDown_passed_undefined_raise_error_value() {
    assertRaiseErrorValue(function() {
        var _test = parent.fixture.new_case.tearDown(undefined);
    }, "TestCase.tearDown() \"func\" expected a function, received undefined.");
}

/// @ignore
function test_crispy_TestCase_discover_fluent_interface() {
    var _test_1 = parent.fixture.new_case;
    var _test_2 = _test_1.__discover__(fixture_crispy_tests);
    assertEqual(_test_1, _test_2);
}

/// @ignore
function test_crispy_TestCase_discover_is_discovered() {
    var _test = parent.fixture.new_case.__discover__(fixture_crispy_tests);
    assertTrue(_test.__is_discovered__);
}

/// @ignore
function test_crispy_TestCase_discover_discovered_script_is_saved() {
    var _test = parent.fixture.new_case.__discover__(fixture_crispy_tests);
    assertEqual(_test.__discovered_script__, fixture_crispy_tests);
}

/// @ignore
function test_crispy_TestCase_discover_discovered_script_is_number() {
    var _test = parent.fixture.new_case.__discover__(fixture_crispy_tests);
    assertTrue(is_real(_test.__discovered_script__));
}

/**
 * Testing TestCase assertion method functions
 */
/// @ignore
function test_crispy_TestCase_assertEqual_pass_with_same_value() {
    var _test = new TestCase("test", function() {
        assertEqual(1, 1);
    });
    _test.run();
    assertTrue(_test.logs[0].pass);
}

/// @ignore
function test_crispy_TestCase_assertEqual_fail_with_different_values() {
    var _test = new TestCase("test", function() {
        assertEqual(1, 2);
    });
    _test.run();
    assertFalse(_test.logs[0].pass);
}

/// @ignore
function test_crispy_TestCase_assertEqual_fail_with_different_types() {
    var _test = new TestCase("test", function() {
        assertEqual(1, "test");
    });
    _test.run();
    assertFalse(_test.logs[0].pass);
}

/// @ignore
function test_crispy_TestCase_assertEqual_fail_with_different_types_message() {
    var _test = new TestCase("test", function() {
        assertEqual(1, "test");
    });
    _test.run();
    assertEqual(_test.logs[0].msg, "Supplied value types are not equal: number and string.");
}

/// @ignore
function test_crispy_TestCase_assertEqual_same_type_fail_with_helper_text() {
    var _test = new TestCase("test", function() {
        assertEqual(1, 2);
    });
    _test.run();
    assertEqual(_test.logs[0].helper_text, "first and second are not equal: 1, 2");
}

/// @ignore
function test_crispy_TestCase_assertEqual_message_passed_number_raises_error() {
    assertRaises(function() {
        var _test = new TestCase("test", function() {
            assertEqual(true, true, 1);
        });
        _test.run();
    });
}

/// @ignore
function test_crispy_TestCase_assertEqual_message_passed_number_raise_error_value() {
    assertRaiseErrorValue(function() {
        var _test = new TestCase("test", function() {
            assertEqual(true, true, 1);
        });
        _test.run();
    }, "TestCase.assertEqual() \"message\" expected either a string or undefined, received number.");
}

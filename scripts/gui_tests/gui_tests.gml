/**
 * Tests for GUI elements of example project
 * Example tests to be discovered by TestRunner
 */

function test_gui_box_position_x1() {
    return {
        test: function() {
            var _box = new gui_box(10, 20, 30, 40);
            assert_equal(_box.x1, 10);
        },
    }
}

function test_gui_box_position_y1() {
    return {
        test: function() {
            var _box = new gui_box(10, 20, 30, 40);
            assert_equal(_box.y1, 20);
        },
    }
}

function test_gui_box_position_x2() {
    return {
        test: function() {
            var _box = new gui_box(10, 20, 30, 40);
            assert_equal(_box.x2, 30);
        },
    }
}

function test_gui_box_position_y2() {
    return {
        test: function() {
            var _box = new gui_box(10, 20, 30, 40);
            assert_equal(_box.y2, 40);
        },
    }
}

function test_gui_box_width() {
    return {
        test: function() {
            var _box = new gui_box(10, 10, 20, 20);
            assert_equal(_box.get_width(), 10);
        },
    }
}

function test_gui_box_height() {
    return {
        test: function() {
            var _box = new gui_box(10, 10, 25, 25);
            assert_equal(_box.get_height(), 15);
        },
    }
}

function test_gui_box_get_x1() {
    return {
        test: function() {
            var _box = new gui_box(10, 10, 20, 20);
            assert_equal(_box.get_x1(), 10);
        },
    }
}

function test_gui_box_get_y1() {
    return {
        test: function() {
            var _box = new gui_box(10, 10, 20, 20);
            assert_equal(_box.get_y1(), 10);
        },
    }
}

function test_gui_box_get_x2() {
    return {
        test: function() {
            var _box = new gui_box(10, 10, 20, 20);
            assert_equal(_box.get_x2(), 20);
        },
    }
}

function test_gui_box_get_y2() {
    return {
        test: function() {
            var _box = new gui_box(10, 10, 20, 20);
            assert_equal(_box.get_y2(), 20);
        },
    }
}

function test_gui_box_set_x1() {
    return {
        test: function() {
            var _box = new gui_box(10, 10, 20, 20);
            _box.set_x1(15);
            assert_equal(_box.x1, 15);
        },
    }
}

function test_gui_box_set_y1() {
    return {
        test: function() {
            var _box = new gui_box(10, 10, 20, 20);
            _box.set_y1(15);
            assert_equal(_box.y1, 15);
        },
    }
}

function test_gui_box_set_x2() {
    return {
        test: function() {
            var _box = new gui_box(10, 10, 20, 20);
            _box.set_x2(15);
            assert_equal(_box.x2, 15);
        },
    }
}

function test_gui_box_set_y2() {
    return {
        test: function() {
            var _box = new gui_box(10, 10, 20, 20);
            _box.set_y2(15);
            assert_equal(_box.y2, 15);
        },
    }
}

/// @ignore
function test_gui_box_position_x1() {
    var _box = new GuiBox(10, 20, 30, 40);
    assertEqual(_box.x1, 10);
}

/// @ignore
function test_gui_box_position_y1() {
    var _box = new GuiBox(10, 20, 30, 40);
    assertEqual(_box.y1, 20);
}

/// @ignore
function test_gui_box_position_x2() {
    var _box = new GuiBox(10, 20, 30, 40);
    assertEqual(_box.x2, 30);
}

/// @ignore
function test_gui_box_position_y2() {
    var _box = new GuiBox(10, 20, 30, 40);
    assertEqual(_box.y2, 40);
}

/// @ignore
function test_gui_box_width() {
    var _box = new GuiBox(10, 10, 20, 20);
    assertEqual(_box.get_width(), 10);
}

/// @ignore
function test_gui_box_height() {
    var _box = new GuiBox(10, 10, 25, 25);
    assertEqual(_box.get_height(), 15);
}

/// @ignore
function test_gui_box_get_x1() {
    var _box = new GuiBox(10, 10, 20, 20);
    assertEqual(_box.get_x1(), 10);
}

/// @ignore
function test_gui_box_get_y1() {
    var _box = new GuiBox(10, 10, 20, 20);
    assertEqual(_box.get_y1(), 10);
}

/// @ignore
function test_gui_box_get_x2() {
    var _box = new GuiBox(10, 10, 20, 20);
    assertEqual(_box.get_x2(), 20);
}

/// @ignore
function test_gui_box_get_y2() {
    var _box = new GuiBox(10, 10, 20, 20);
    assertEqual(_box.get_y2(), 20);
}

/// @ignore
function test_gui_box_set_x1() {
    var _box = new GuiBox(10, 10, 20, 20);
    _box.set_x1(15);
    assertEqual(_box.x1, 15);
}

/// @ignore
function test_gui_box_set_y1() {
    var _box = new GuiBox(10, 10, 20, 20);
    _box.set_y1(15);
    assertEqual(_box.y1, 15);
}

/// @ignore
function test_gui_box_set_x2() {
    var _box = new GuiBox(10, 10, 20, 20);
    _box.set_x2(15);
    assertEqual(_box.x2, 15);
}

/// @ignore
function test_gui_box_set_y2() {
    var _box = new GuiBox(10, 10, 20, 20);
    _box.set_y2(15);
    assertEqual(_box.y2, 15);
}

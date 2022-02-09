// Run the TestRunner
if CRISPY_RUN {
	if can_run_tests {
		can_run_tests = false;
		runner.run();
		show_debug_message(runner.logs);
	} else {
		// Re-run tests
		if keyboard_check_pressed(ord("R")) {
			can_run_tests = true;
			reset_scroll_position();
		}
	}
}

// Clear test results
if keyboard_check_pressed(ord("C")) {
	global.results = [];
	reset_scroll_position();
}

// Scrolling through test results
scroll_dir = -(mouse_wheel_up() || keyboard_check_pressed(vk_up)) + (mouse_wheel_down() || keyboard_check_pressed(vk_down))
var _len = array_length(global.results);
if scroll_dir != 0 && _len > 0 {
	var _scroll_multiplier = 3;
	var _amount = scroll_dir * text_height * _scroll_multiplier;
	var _new_position = scroll_position + _amount;
	var _h = string_height("W");
	var _h_total = _h * _len;
	var _y1 = -_h_total + _h * _scroll_multiplier;
	var _y2 = results_box.get_height() - _h * _scroll_multiplier;
	if _new_position == clamp(_new_position, _y1, _y2) {
		scroll_position_want = _new_position;
	}
}

// Lerp scroll position
scroll_position = lerp(scroll_position, scroll_position_want, 0.15);

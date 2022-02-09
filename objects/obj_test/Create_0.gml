// Create TestRunner
runner = new TestRunner({
	name: "test_runner",
	// Update runner to output test results to Output Window and results ds_list
	output: function(_message) {
		show_debug_message(_message);
		ds_list_insert(results, 0, _message);
		while ds_list_size(results) > results_max {
			ds_list_delete(results, results_max - 1);
		}
	}
});

// Update runner to output test results to Output Window and results ds_list
/*
runner.output = function(_message) {
	show_debug_message(_message);
	ds_list_insert(results, 0, _message);
	while ds_list_size(results) > results_max {
		ds_list_delete(results, results_max - 1);
	}
}
*/

// Create GUI elements TestSuite
gui_test_suite = new TestSuite({
	name: "gui_suite",
});

// Add GUI elements TestSuite to TestRunner
runner.add_test_suite(gui_test_suite);

// Discover GUI element tests
// runner.discover(gui_test_suite, "test_gui_box");

// Create hamburger TestSuite
hamburger_suite = new TestSuite({
	name: "hamburger_suite",
});

// Set up hamburger for tests
hamburger_suite.set_up(function() {
	var _ingredients = [
		new Ingredient("bun"),
		new Ingredient("pickles", true),
		new Ingredient("tomato", true),
		new Ingredient("lettuce", true),
		new Ingredient("patty"),
		new Ingredient("bun"),
	];
	hamburger = new Food("hamburger", _ingredients);
});

// Add hamburger TestSuite to TestRunner
runner.add_test_suite(hamburger_suite);

// Discovering hamburger tests
// runner.discover(hamburger_suite, "test_hamburger_");

var _test = new TestCase({
	name: "test_hamburger_top_bun",
	class: "this is a test",
	test: function() {
		assert_equal(parent.hamburger.ingredients[0].name, "bun", "Expecting 'bun' as hamburger's top ingredient");
		assert_false(false, "Expecting 'bun' as hamburger's top ingredient");
		show_debug_message(name);
	},
});
hamburger_suite.add_test_case(_test);


// Flag for running tests
can_run_tests = true;

// Setting up text for Crispy info and controls
padding = 10;
info_text = CRISPY_NAME + " " + CRISPY_VERSION + "    " + CRISPY_DATE + "\n\n";
info_text += "Test results are displayed below and in the Output Window.\n";
info_text += "Press \"R\" to re-run tests." + "\n";
info_text += "Press \"C\" to clear test results." + "\n";
info_text += "Use mouse wheel or arrow keys to navigate test results.";
info_text_y = room_height - padding;
info_box = new gui_box(1, 1, room_width - 2, padding * 2 + string_height(info_text) - 1);

// Test results scrolling
scroll_position_default = 0;
scroll_position = scroll_position_default;
scroll_position_want = scroll_position;
text_height = string_height("W");
reset_scroll_position = function() {
	scroll_position = scroll_position_default;
	scroll_position_want = scroll_position;
}

results = ds_list_create();
results_max = 255;
results_box = new gui_box(info_box.x1, info_box.y2 + 3, info_box.x2, room_height - 2);


// Defining Dracula Theme colors
// https://github.com/dracula/dracula-theme#color-palette
dracula_theme = {
	background: make_color_rgb(40, 42, 54),
	current_line: make_color_rgb(68, 71, 90),
	selection: make_color_rgb(68, 71, 90),
	foreground: make_color_rgb(248, 248, 242),
	comment: make_color_rgb(98, 114, 164),
	cyan: make_color_rgb(139, 233, 253),
	green: make_color_rgb(80, 250, 123),
	orange: make_color_rgb(255, 184, 108),
	pink: make_color_rgb(255, 121, 198),
	purple: make_color_rgb(189, 147, 249),
	red: make_color_rgb(255, 85, 85),
	yellow: make_color_rgb(241, 250, 140),
}
colors = dracula_theme;

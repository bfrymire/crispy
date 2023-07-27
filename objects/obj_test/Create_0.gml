// Create TestRunner
runner = new TestRunner("runner");
// Update runner to output test results to Output Window and results ds_list
runner.output = function(_message) {
	show_debug_message(_message);
	ds_list_insert(results, 0, _message);
	while ds_list_size(results) > results_max {
		ds_list_delete(results, results_max - 1);
	}
}

// Create GUI elements TestSuite
gui_test_suite = new TestSuite("gui_suite");
// Add GUI elements TestSuite to TestRunner
runner.addTestSuite(gui_test_suite);
// Discover GUI element tests
runner.discover(gui_test_suite, "test_gui_box");

// Create hamburger TestSuite
hamburger_suite = new TestSuite("hamburger_suite");
// Set up hamburger for tests
hamburger_suite.setUp(function() {
	var _ingredients = [
		new Ingredient("bun"),
		new Ingredient("pickles", true),
		new Ingredient("tomato", true),
		new Ingredient("lettuce", true),
		new Ingredient("patty"),
		new Ingredient("bun")
	];
	hamburger = new Food("hamburger", _ingredients);
});
// Add hamburger TestSuite to TestRunner
runner.addTestSuite(hamburger_suite);
// Discovering hamburger tests
runner.discover(hamburger_suite, "test_hamburger_");

// Create Food TestSuite
food_suite = new TestSuite("food_suite");
// Add Food TestSuite to TestRunner
runner.addTestSuite(food_suite);
// Discovering Food tests
runner.discover(food_suite, "test_food_");

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
info_box = new GuiBox(1, 1, room_width - 2, padding * 2 + string_height(info_text) - 1);

// Test results scrolling
scroll_position = 0;
text_height = string_height("W");

results = ds_list_create();
results_max = 255;
results_box = new GuiBox(info_box.x1, info_box.y2 + 3, info_box.x2, room_height - 2);


// Defining colors
colors = {
	background: #282a36,
	current_line: #44475a,
	selection: #44475a,
	foreground: #f8f8f2,
	comment: #6272a4,
	cyan: #8be9fd,
	green: #50fa7b,
	orange: #ffb86c,
	pink: #ff79c6,
	purple: #bd93f9,
	red: #ff5555,
	yellow: #f1fa8c
}

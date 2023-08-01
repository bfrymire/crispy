function test_food_raises_error_when_passing_number_to_name() {
	assertRaises(function() {
		var _ = new Food(12, []);
	}, "Expected an error to raise when passing a number to Food name.");
}

function test_food_raise_error_value_when_passing_number_to_name() {
	assertRaiseErrorValue(function() {
		var _ = new Food(12, []);
	}, "Food \"_name\" expected a string, received number.");
}

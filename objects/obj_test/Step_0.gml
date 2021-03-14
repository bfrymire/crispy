// Run the TestRunner
if CRISPY_RUN {
	if can_run_tests {
		can_run_tests = false;
		runner.run();
	} else {
		if keyboard_check_pressed(ord("R")) {
			can_run_tests = true;
		}
	}
}

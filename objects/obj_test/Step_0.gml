// Run the TestRunner
if CRISPY_RUN {
	if can_run_tests {
		can_run_tests = false;
		log_text = intro_text;
		runner.run();
		var _len = array_length(runner.logs);
		for(var i = 0; i < _len; i++) {
			if i != 0 {
				log_text += "\n";
			}
			log_text += runner.logs[i].getMsg();
		}
	} else {
		if keyboard_check_pressed(ord("R")) {
			can_run_tests = true;
		}
	}
}

if CRISPY_RUN {
	var _len = array_length(runner.logs);
	var _padding = 2;
	var _h = string_height("M");
	for(var i = 0; i < _len; i++) {
		var _log = runner.logs[i];
		// var _str = _log.display_name ": " + _log.msg;
		var _str = _log.getMsg();
		draw_text(10, 10 + i * _h + i * _padding, _str);
	}
}

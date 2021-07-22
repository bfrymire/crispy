/**
 * Converts the given time milliseconds to seconds as a string
 * @function
 * @param {number} time - Time in milliseconds
 * @returns {string} time in seconds with CRISPY_TIME_PRECISION number
 * 		of decimal points as a string
 */
function crispyTimeConvert() {

    var _time = (argument_count > 0) ? argument[0] : undefined;

	if !is_real(_time) {
		crispyThrowExpected(self, "crispyTimeConvert", "number", typeof(_time));
	}

	return string_format(_time / 1000000, 0, CRISPY_TIME_PRECISION);

}

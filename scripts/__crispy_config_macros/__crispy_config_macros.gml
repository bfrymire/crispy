// Feather disable all

#macro CRISPY_NAME "Crispy"
#macro CRISPY_AUTHOR "Brent Frymire"
#macro CRISPY_REPO "https://github.com/bfrymire/crispy"
#macro CRISPY_VERSION "1.8.5" // major.minor.patch
#macro CRISPY_DATE "2023-09-04" // yyyy-mm-dd

#macro CRISPY_RUN true // Boolean flag that can be used to automatically run tests
#macro CRISPY_DEBUG false // Enables outputting extra context on some silent functions
#macro CRISPY_VERBOSITY 2 // Determines how verbose assertion outputs will be. Acceptable values are 0, 1, or 2

#macro CRISPY_TIME_PRECISION 6 // Number of decimal places timers will output to

#macro CRISPY_PASS_MSG_SILENT "." // Output string when an assertion passes silently
#macro CRISPY_FAIL_MSG_SILENT "F" // Output string when an assertion fails silently
#macro CRISPY_PASS_MSG_VERBOSE "ok" // Output string when an assertion passes verbosely
#macro CRISPY_FAIL_MSG_VERBOSE "Fail" // Output string when an assertion fails verbosely
#macro CRISPY_STATUS_OUTPUT_LENGTH 150 // Number of characters per line when outputting TestCase statuses

#macro CRISPY_SILENCE_PASSING_TESTS_OUTPUT false // Enables silencing passing test messages

#macro CRISPY_STRUCT_UNPACK_ALLOW_DUNDER false // Enables dunder variables to be overwritten when using crispyStructUnpack


show_debug_message("Using " + CRISPY_NAME + " unit testing framework by " + CRISPY_AUTHOR + ". This is version " + CRISPY_VERSION + ", released on " + CRISPY_DATE + ".");

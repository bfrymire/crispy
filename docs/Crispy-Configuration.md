# Crispy Configuration

There's a configuration file in the Crispy assets directory named `__crispy_config_macros`. This file holds constants that modify how Crispy handles different cases. For instance, what to print to the output when a test fails or whether passing tests should print out their test name.

> [!WARNING]
> When updating Crispy versions, if you made custom changes to this file, make sure to carry over the changes to the new version.

| Macro Name | Default Value | Description |
| ------------------------------------- | ------------- | -- |
| `CRISPY_RUN` | `true` | Boolean flag that can be used to automatically run tests.<br>**Note: Will be deprecated in the future.** |
| `CRISPY_DEBUG` | `false` | Enables outputting extra context on some silent functions |
| `CRISPY_VERBOSITY` | `2` | Determines how verbose assertion outputs will be. Acceptable values are 0, 1, or 2 |
| `CRISPY_TIME_PRECISION` | `6` | Number of decimal places timers will output to |
| `CRISPY_PASS_MSG_SILENT` | `"."` | Output string when an assertion passes silently |
| `CRISPY_FAIL_MSG_SILENT` | `"F"` | Output string when an assertion fails silently |
| `CRISPY_PASS_MSG_VERBOSE` | `"ok"` | Output string when an assertion passes verbosely |
| `CRISPY_FAIL_MSG_VERBOSE` | `"Fail"` | Output string when an assertion fails verbosely |
| `CRISPY_STATUS_OUTPUT_LENGTH` | `150` | Number of characters per line when outputting TestCase statuses |
| `CRISPY_SILENCE_PASSING_TESTS_OUTPUT` | `false` | Enables silencing passing test messages |
| `CRISPY_STRUCT_UNPACK_ALLOW_DUNDER` | `false` | Enables double underscore variables to be overwritten when using `crispyStructUnpack()`.<br>**Note: Will be deprecated in the future.** |

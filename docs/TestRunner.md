# TestRunner() and Methods

## TestRunner(name, [struct])

`TestRunner()` is a constructor that creates a runner that orchestrates the encapsulated TestSuites and TestCases to run their processes to perform the tests and display the outcome of the tests.

| Argument | Type | Description |
| -- | -- | -- |
| name | String | Unique String to name the runner|
| [struct] | Struct | Struct to be passed into `crispyStructUnpack()` |

<br>

## Methods

### .addLog(log)

Adds a Log to the array of logs.

**Returns:** N/A

| Argument | Type | Description |
| ---- | ---- | ---- |
| log | Struct | `crispyLog` struct to add to captured logs |

<br>

### .captureLogs(inst)

Adds a Log to the array of logs.

**Returns:** N/A

| Argument | Type | Description |
| ---- | ---- | ---- |
| log | Struct | `crispyLog` struct to add to captured logs |

<br>

### .addTestSuite(test_suite)

Adds TestSuite to array of suites.

**Returns:** N/A

| Argument | Type | Description |
| ---- | ---- | ---- |
| test_suite | Struct | TestSuite to add to suites |

<br>

### .hr([str="-"], [count=70])

Creates string to be used as a horizontal row to visually separate output messages.

**Returns:** String

| Argument | Type | Description |
| ---- | ---- | ---- |
| str | String | String to concat *n* times |
| count | Real | Number of times to concat *str* |

<br>

### .run()

Runs test suites and logs results of tests.

**Returns:** N/A

| Argument | Type | Description |
| ---- | ---- | ---- |
| None |  |  |

# TestCase() and Methods

## TestCase(name, func, [unpack])

`TestCase()` is a constructor that creates a container for running a test and logs the outcome of the test.

| Argument | Type | Description |
| -- | -- | -- |
| name | String | Unique String to name the test |
| func | Function | Function that runs the test assertion |
| [unpack] | Struct | Struct to be passed into `crispyStructUnpack()` |

<br>

## Methods

### .createTestMethod(func)

Turns the passed function into a method variable used for the test.

**Returns:** N/A

| Argument | Type | Description |
| -- | -- | -- |
| func | Function | Function that runs the test assertion |

<br>

### .addLog(log)

Adds a Log to the array of logs.

**Returns:** N/A

| Argument | Type | Description |
| -- | -- | -- |
| log | Struct | Log to add to logs |

<br>

### .clearLogs()

Clears array of Logs.

**Returns:** N/A

| Argument | Type | Description |
| -- | -- | -- |
| None |||

<br>

## Assertion Methods

Assertion methods are meant to be ran from within the `test` method that gets passed to `TestCase()` as the `func` argument.

Each time an assertion method is called for a `TestCase`, a new `crispyLog` is created to record the outcome of the `test` method.

While it is possible to use multiple assertion calls for a single `TestCase`, it is best practice to limit one assertion per `TestCase`.

<br>

### .assertEqual(first, second, [message])

Tests that `first` and `second` are equal.

If `first` and `second` are not the same data type, the assertion fails and logs a message.

> [!NOTE]
> This method may not work as expected for some data types because it compares if the direct values are equal. In GameMaker, the contents of data types such as arrays or structs cannot be compared using equals _(==)_. This can be tested on your own by running the following code:
>
> ```gml
> show_message("Equal arrays: " + ([] == [] ? "true" : "false"));  // "Equal arrays: false"
> show_message("Equal structs: " + ({} == {} ? "true" : "false")); // "Equal structs: false"
> ```
>
> However, [array_equals()](https://manual.yoyogames.com/GameMaker_Language/GML_Reference/Variable_Functions/array_equals.htm) is a built-in function in GameMaker that can check if two arrays are equal. At this point, using [assertTrue()](#asserttrueexpression-message) or [assertFalse()](#assertfalseexpression-message) would be a better assertion method to use for your `TestCase`.
>
> **Example:**
>
> ```gml
> new TestCase("test_equal_arrays", function() {
>     assertTrue(array_equals([], []), "Expected two empty arrays to have equal contents.");
> });
> ```
>
> There is currently no built-in function for checking if the contents of two structs are equal.

**Returns:** N/A

| Argument | Type | Description |
| -- | -- | -- |
| first | Any | First value for assertion |
| second | Any | Second value for assertion |
| [message] | String | Custom helper text to write to the log on failure |

**Example:**

```gml
new TestCase("test_example", function() {
    var _min = min(50, 5, 10);
    assertEqual(5, _min, "Expected the minimum to be 5.");
});
```

<br>

### .assertNotEqual(first, second, [message])

Tests that `first` and `second` are not equal.

> [!NOTE]
> See the note above in [assertEqual](#assertequalfirst-second-message).

**Returns:** N/A

| Argument | Type | Description |
| -- | -- | -- |
| first | Any | First value for assertion |
| second | Any | Second value for assertion |
| [message] | String | Custom helper text to write to the log on failure |

**Example:**

```gml
new TestCase("test_example", function() {
    assertEqual(10, "apple", "Expected 10 not to be equal to \"apple\".");
});
```

<br>

### .assertTrue(expression, [message])

Test whether the provided `expression` is true.

The function will first try and coerce the `expression` data type to a boolean. If the data type is unable to be successfully coerced to a boolean, the test fails and logs a message.

**Returns:** N/A

| Argument | Type | Description |
| -- | -- | -- |
| expression | Any | Expression to check |
| [message] | String | Custom helper text to write to the log on failure |

**Example:**

```gml
new TestCase("test_example", function() {
    assertTrue(10 > 2, "Expected 10 > 2 to be true.");
});
```

<br>

### .assertFalse(expression, [message])

Test whether the provided `expression` is false.

The function will first try and coerce the `expression` data type to a boolean. If the data type is unable to be successfully coerced to a boolean, the test fails and logs a message.

**Returns:** N/A

| Argument | Type | Description |
| -- | -- | -- |
| expression | Any | Expression to check |
| [message] | String | Custom helper text to write to the log on failure |

**Example:**

```gml
new TestCase("test_example", function() {
    assertFalse(10 == 3, "Expected 10 == 3 to be false.");
});
```

<br>

### .assertIsNoone(expression, [message])

Test whether the provided `expression` is noone.

**Returns:** N/A

| Argument | Type | Description |
| -- | -- | -- |
| expression | Any | Expression to check |
| [message] | String | Custom helper text to write to the log on failure |

**Example:**

```gml
new TestCase("test_global_surface_is_noone", function() {
    assertIsNoone(global.surf, "Expected global.surf to be noone.");
});
```

<br>

### .assertIsNotNoone(expression, [message])

Test whether the provided `expression` is not noone.

**Returns:** N/A

| Argument | Type | Description |
| -- | -- | -- |
| expression | Any | Expression to check |
| [message] | String | Custom helper text to write to the log on failure |

**Example:**

```gml
new TestCase("test_application_surface_is_not_noone", function() {
    assertIsNotNoone(application_surface, "Expected application_surface to not be noone.");
});
```

<br>

### .assertIsUndefined(expression, [message])

Test whether the provided `expression` is undefined.

**Returns:** N/A

| Argument | Type | Description |
| -- | -- | -- |
| expression | Any | Expression to check |
| [message] | String | Custom helper text to write to the log on failure |

**Example:**

```gml
new TestCase("test_player_variable_does_not_exist", function() {
    var _player = parent.player;
    assertIsUndefined(variable_instance_get(_player, "variable_does_not_exist"), "Expected \"player.variable_does_not_exist\" variable to return undefined by not existing.");
});
```

<br>

### .assertIsNotUndefined(expression, [message])

Test whether the provided `expression` is not undefined.

**Returns:** N/A

| Argument | Type | Description |
| -- | -- | -- |
| expression | Any | Expression to check |
| [message] | String | Custom helper text to write to the log on failure |

**Example:**

```gml
new TestCase("test_player_name_is_not_undefined", function() {
    var _player = parent.player;
    assertIsNotUndefined(_player.name, "Expected \"player.name\" variable to not be undefined.");
});
```

<br>

### .assertRaises(function, [message])

Test whether the provided `function` raises a `throw()` error message when ran.

The test will fail if no error message is raised.

**Returns:** N/A

| Argument | Type | Description |
| -- | -- | -- |
| function | Function | Function to run |
| [message] | String | Custom helper text to write to the log on failure when an error is raised |

**Example:**

```gml
new TestCase("test_player_set_name_when_passing_real_number_raises_error", function() {
    assertRaises(function() {
        var _player = new Player(42);
    }, "Expected error to raise when passing a number to Player name argument.");
});
```

<br>

### .assertRaiseErrorValue(function, value, [message])

Test whether the `value` is equal to the error message that is raised when running the `function`.

The test will fail if no error message is raised.

**Returns:** N/A

| Argument | Type | Description |
| -- | -- | -- |
| function | Function | Function to run |
| value | String |  |
| [message] | String | Custom helper text to write to the log on failure when an error is raised |

**Example:**

```gml
new TestCase("test_player_set_name_when_passing_real_number_raise_error_value", function() {
    assertRaises(function() {
        var _player = new Player(42);
    }, "Player \"name\" expected a string, received number.");
});
```

<br>

> [!NOTE]
> Once the function passed to [`assertRaises()`](#assertraisesfunction-message) or [`assertRaiseErrorValue()`](#assertraiseerrorvaluefunction-value-message) throws an error for whatever reason, the assertion method will step out of the function and not run any further code in the function.
>
> Behind the scenes, the function passed to the raise error assertion methods is called inside a [try / catch](https://manual.yoyogames.com/GameMaker_Language/GML_Overview/Language_Features/try_catch_finally.htm) block.
>
> In full, the test case runs, once an error message is caught in the test, the assert method will break out of the test early, the assertion will be ran against the error, and the outcome will be logged. Any remaining code in the `TestCase.test` function will cease to run after an error is thrown.
>
> **Example:**
>
> ```gml
> // Function to be tested
> function double(_num) {
>     if !is_real(_num) {
>         throw("double() \"_num\" expected a real number, received " + typeof(_num) + ".");
>     }
>     return _num * 2;
> }
>
> var _example_1 = new TestCase("double_example_1", function() {
>     assertRaises(function() {
>         double("make fail");
>         show_message("This message will not show!"); // Doesn't run
>     });
> });
> _example_1.run();
>
> var _example_2 = new TestCase("double_example_2", function() {
>     assertRaiseErrorValue(function() {
>         double("make fail again");
>         show_message("Like the previous TestCase, this message will not show!");  // Doesn't run
>     }, "double() \"_num\" expected a real number, received string.");
> });
> _example_2.run();
> ```

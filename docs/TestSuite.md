# TestSuite() and Methods

## TestSuite(name)

`TestSuite()` is a constructor that holds an array of [`TestCase`](./TestCase) to run, including instructions that can be ran before and after each test.

| Argument | Type | Description |
| -- | -- | -- |
| name | String | Unique String to name the suite |

<br>

## Methods

### .addTestCase(test_case)

Adds `TestCase()` to array of tests. If the `test_case` instance is not that of a `TestCase()`, an error message will be thrown.

**Returns:** N/A

| Argument | Type | Description |
| -- | -- | -- |
| test_case | Struct | `TestCase()` to add to tests |

<br>

### .setUp([func])

Event that runs once before any test is ran. This event is meant to set up any variables, structs, or objects that any of the children tests can reference during their test.

The `setUp()` event method can be overwritten by passing in a function as the optional `func` argument. If a function is passed to `setUp()`, the function is bound to the `TestSuite()` and will be ran when calling `setUp()` with no arguments through the `run()` event.

**Returns:** N/A

| Argument | Type | Description |
| -- | -- | -- |
| func | Function | Function to run on event execution |

**Example:**

```gml
suite = new TestSuite("test_suite_example");
suite.setUp(function() {
    // Creates a player instance that can be called by the children tests
    player = instance_create_depth(100, 100, 0, obj_player);
});
```

<br>

### .tearDown([func])

Event that runs once after all tests have ran. This event is meant to clean up any data structures or instances that may have been previously created in the `setUp()` event. If you do not clean up after persistent data structures or instances once you're done with them, they could cause a memory leak during your game.

The `tearDown()` event method can be overwritten by passing in a function as the optional `func` argument. If a function is passed to `tearDown()`, the function is bound to the `TestSuite()` and will be ran when calling `tearDown()` with no arguments through the `run()` event.

**Returns:** N/A

| Argument | Type | Description |
| -- | -- | -- |
| func | Function | Function to run on event execution |

**Example:**

```gml
suite = new TestSuite("test_suite_example");
suite.setUp(function() {
    // Creates a player instance that can be called by the children tests
    player = instance_create_depth(100, 100, 0, obj_player);
});
suite.tearDown(function() {
    // Destroys the player instance that was created in the setUp() event
    instance_destroy(player);
});
```

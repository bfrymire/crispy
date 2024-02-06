# Extending Crispy

## Configuring TestRunner Output

`TestRunner.output()` takes one argument that is either a string or a function.

By default, `output()` passes the `_input` string to `show_debug_message()`, which gets displayed to the [Output Window](https://manual.yoyogames.com/Introduction/The_Output_Window.htm) using `show_debug_message()`.

```gml
runner = new TestRunner("runner");
runner.output(function(_input) { // Pass a function to overwrite output method
    show_debug_message(_input);  // Default functionality built into Crispy
});
runner.output("This will be printed as a debug message.");
```

However, this can be extended by writing your own functions that handle the string being passed into `output()`. The string can even be written to an external file that logs everything `TestRunner` outputs.

## Quiet on Success, Verbose on Failure

As your project grows and more tests are added, more messages may be printed to the [Output Window](https://manual.yoyogames.com/Introduction/The_Output_Window.htm). This will make the Output Window filled with a bunch of noise. You'll adapt to seeing the messages and begin to ignore them. You can overcome this by having a message box pop up only if a test failed.

We can do so by passing a function to your `TestRunner.tearDown()`, which will override the `tearDown()` method of your `TestRunner`.

```gml
runner = new TestRunner("runner");
runner.tearDown(function() {
    // Quiet on success, verbose on failure
    var _failed_tests = 0;
    var _failed_test_names = "";
    var _len = array_length(logs);
    var i = 0;
    repeat (_len) {
        var _log = logs[i];
        if !_log.pass {
            ++_failed_tests;
            _failed_test_names += _log.name;
            if i != _len - 1 {
                _failed_test_names += "\n";
            }
        }
        ++i;
    }
    if _failed_tests {
        var _text = "Number of Failed Tests: " + string(_failed_tests) + "\n\nTest Names:\n" + _failed_test_names;
        output(_text);
        _text += "\n\nCheck output() location for more details of the failures.";
        show_message(_text);
    }
});
```

Now, if there happens to be any tests that fail after the runner is finished, a message will pop up on the screen showing the names of the tests that failed. You may still have to search the Output Window for any errors, but with this method, you'll be sure to know if something failed.

## Creating Fixtures

*to be continued...*

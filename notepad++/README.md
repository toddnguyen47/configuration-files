# How to Record Macro to Trim Lines with Whitespace Only & Right Trim White Space

- Macros &rarr; Start Recording
- Search &rarr; Replace...
- Make sure **Wrap Around** is checked.
- Under **Search Mode**, make sure to select **Regular expression**. Uncheck **. matches newline** if it is checked.
- In "Find What", put in

```regexp
^[ \t]+$
```

In "Replace with", put in nothing. This will remove any lines with only spaces and tabs.

- Click on "Replace All".
- In "Find What", put in

```regexp
^([\S \t]*\S)[ \t]+$
```

In "Replace with", put in

```regexp
\1
```

This will search for any lines with trailing whitespace, capture the characters before the trailing whitespace then put it in a capture group, and replace that line with the captured group.

- Click on "Replace All".
- Close the modal.
- File &rarr; Save.
- Macros &rarr; Stop Recording
- Macros &rarr; Save Current Recorded Macro..., then give your macro a name. _OPTIONAL_: You can also give your recorded macro a keyboard shortcut. You can also assign keyboard shortcuts later by going to Settings &rarr; Shortcut Mapper, then click on the Macros tab.
- All done!

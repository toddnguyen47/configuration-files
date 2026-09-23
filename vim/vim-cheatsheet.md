# Vim / Neovim Cheatsheet

A practical reference for the keys you'll actually use day to day.

> **The short version:** movement keys are the boring part. The leverage is in
> **operator + motion** and **text objects** (further down). If you only learn
> five things from this page, make them `.`, `ciw`, `ci"`, `di(`, and `f{char}`.

---

## Movement

### Basic

| Key | Does |
|-----|------|
| `h` `j` `k` `l` | left, down, up, right |
| `w` | forward one word |
| `b` | back one word |
| `e` | end of current/next word |
| `0` | start of line |
| `^` | first non-blank character |
| `$` | end of line |

### Jumping further

| Key | Does |
|-----|------|
| `gg` | top of file |
| `G` | bottom of file |
| `{n}G` or `:{n}` | go to line *n* |
| `{` / `}` | previous / next paragraph |
| `Ctrl-d` / `Ctrl-u` | half page down / up |
| `Ctrl-o` / `Ctrl-i` | back / forward through jump history |
| `%` | jump to matching bracket |

### Jumping within a line

| Key | Does |
|-----|------|
| `f{char}` | jump forward to next `{char}` |
| `F{char}` | jump backward to previous `{char}` |
| `t{char}` | jump to just *before* next `{char}` |
| `;` | repeat last `f`/`t` jump forward |
| `,` | repeat it backward |

### Searching

| Key | Does |
|-----|------|
| `/pattern` | search forward |
| `?pattern` | search backward |
| `n` / `N` | next / previous match |
| `*` / `#` | next / previous occurrence of word under cursor |

---

## Editing

### Entering insert mode

| Key | Does |
|-----|------|
| `i` / `a` | insert before / after cursor |
| `I` / `A` | insert at line start / append at line end |
| `o` / `O` | open new line below / above |

### Changing and deleting

| Key | Does |
|-----|------|
| `x` | delete character |
| `dd` | delete line |
| `D` | delete to end of line |
| `cc` | change whole line |
| `C` | change to end of line |
| `J` | join line below onto this one |
| `r{char}` | replace single character |

### Copy and paste

| Key | Does |
|-----|------|
| `yy` | yank (copy) line |
| `p` / `P` | paste after / before cursor |
| `"+y` | yank to system clipboard |
| `"+p` | paste from system clipboard |

### Undo

| Key | Does |
|-----|------|
| `u` | undo |
| `Ctrl-r` | redo |
| `.` | **repeat last change** |

`.` is the single highest-value key in Vim. Make a change once, then move and
press `.` to apply it again. Pairs especially well with `n` after a search.

---

## Operator + motion

This is where Vim stops being "arrow keys with extra steps."

Any **operator** combines with any **motion** from the Movement section:

| Operator | Means |
|----------|-------|
| `d` | delete |
| `c` | change (delete + enter insert mode) |
| `y` | yank |
| `>` / `<` | indent / dedent |
| `gu` / `gU` | lowercase / uppercase |

### Examples

```
dw        delete to next word
d$        delete to end of line
d}        delete to end of paragraph
df,       delete up to and including the next comma
dt)       delete up to but not including the next )
c3w       change the next 3 words
y%        yank to the matching bracket
>}        indent to end of paragraph
```

The grammar is `{operator}{count}{motion}` — and it composes, so you don't
memorise commands, you build them.

---

## Text objects

Text objects work with operators like motions do, but they select a *region*
regardless of where the cursor sits inside it.

> **Important:** a text object is never typed on its own. You always press an
> **operator first** — `c`, `d`, or `y` — and the text object tells it what to
> act on. Typing `iw` by itself does nothing useful.

Every text object command is three parts, typed in order:

```
c   i   w
│   │   └── the object: w = word
│   └────── inner (contents only) or a = around (contents + delimiters)
└────────── the operator: c = change, d = delete, y = yank
```

So `ciw` is three keystrokes: `c`, then `i`, then `w`.

### The objects

Each one below needs an operator in front of it. `w` means word, `(` means
parentheses, and so on — the `i` or `a` in the middle decides whether you
include the surrounding delimiters.

| Object | Selects | Example |
|--------|---------|---------|
| `iw` / `aw` | word | `ciw` change word |
| `is` / `as` | sentence | `das` delete sentence |
| `ip` / `ap` | paragraph | `dap` delete paragraph |
| `i"` / `a"` | double-quoted string | `ci"` change string contents |
| `i'` / `a'` | single-quoted string | `ci'` change string contents |
| `i(` `i)` `ib` | parentheses | `di(` delete inside parens |
| `i{` `i}` `iB` | braces | `ci{` change inside braces |
| `i[` / `i]` | brackets | `yi[` yank inside brackets |
| `it` / `at` | HTML/XML tag | `dit` delete tag contents |

Note that `i(` and `i)` do exactly the same thing, as do `i{` and `i}` — use
whichever bracket your fingers reach first.

### Examples

```
ciw       change the word the cursor is in
ci"       change everything inside the quotes
di(       delete inside the parens
ca{       change around the braces (braces included)
yi[       yank inside the brackets
dit       delete inside the HTML tag
```

`ci"` with the cursor anywhere inside a string replaces its contents. This one
alone is worth the learning curve.

### `i` versus `a`

`i` takes the contents. `a` takes the contents plus what surrounds them.

```
foo("hello")

ci"   →  foo("|")      quotes stay, you type between them
ca"   →  foo(|)        quotes deleted as well
```

For words, `a` also swallows the trailing space:

```
one two three          cursor anywhere on "two"

diw   →  one  three    word gone, both spaces left behind
daw   →  one three     word plus one space gone, spacing closes up
```

Rule of thumb: use `i` when replacing something with something else, and `a`
when removing it entirely.

---

## Visual mode

| Key | Does |
|-----|------|
| `v` | character-wise selection |
| `V` | line-wise selection |
| `Ctrl-v` | block (column) selection |
| `gv` | reselect the last selection |

Select first, then press an operator. `Vjjd` selects three lines and deletes
them. Text objects work here too — `vi{` selects everything inside the braces.

**Block mode trick:** `Ctrl-v`, select down several lines, press `I`, type,
then `Esc` — your text is inserted on every selected line at once. Good for
commenting out a block or adding a prefix to many lines.

---

## Files, buffers and windows

| Key | Does |
|-----|------|
| `:w` | write (save) |
| `:q` | quit |
| `:wq` or `ZZ` | write and quit |
| `:q!` | quit, discarding changes |
| `:e {file}` | open a file |
| `:bn` / `:bp` | next / previous buffer |
| `:ls` | list buffers |
| `Ctrl-w s` / `Ctrl-w v` | split horizontally / vertically |
| `Ctrl-w h j k l` | move between splits |

---

## A sensible learning order

1. **`hjkl`, `i`, `Esc`, `:w`, `:q`** — enough to survive
2. **`w` `b` `0` `$` `gg` `G`** — stop using arrow keys
3. **`dd` `yy` `p` `u`** — basic editing
4. **`.`** — start repeating instead of retyping
5. **`d` + motion** — `dw`, `d$`, `df,`
6. **Text objects** — `ciw`, `ci"`, `di(` — this is when it clicks
7. **`f` / `t` / `;`** — precise movement within a line
8. **Visual block mode** — multi-line edits

Most people quit somewhere around step 2, having concluded Vim is just a worse
way to move a cursor. Steps 5 and 6 are the payoff.

---

## Built-in tutorial

Run `:Tutor` in Neovim (or `vimtutor` from a shell). About 30 minutes, and it
covers roughly 80% of this page with hands-on practice.

---

## If you're using VS Code

Both major extensions support everything above:

- **VSCodeVim** — emulates Vim. Simpler setup, occasional edge-case differences.
- **vscode-neovim** — embeds a real Neovim process as the backend. Supports your
  existing `init.lua` and most Nvim plugins.

With either, keep VS Code's own explorer and `Ctrl+P` for file navigation rather
than installing tree or fuzzy-find plugins. Let Neovim handle editing and let VS
Code handle file management — you don't want to solve that problem twice.

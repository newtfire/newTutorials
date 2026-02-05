# Writing Your First ixml

## Understanding ixml Rules

An ixml **grammar** consists of rules. Each rule has a "left hand side" and a "right hand side". The left hand side is a single symbol, which is the title of something that's being defined. The right hand side is a list of one or more symbols that define it.

**What is a grammar?** A grammar is a collection of rules that defines how to match parts of the input text. Your entire ixml document is a grammar, and every rule contributes to describing the structure you expect in the input.


### Basic Syntax: How to Write a Grammar

A rule has the form of a name (the left hand side) followed by a colon, followed by one or more symbols (the right hand side) followed by a period. If more than one symbol appears on the right hand side, they must be separated by commas:

```shell
symbol-name: defining, symbols, here.
```

Invisible XML allows only a single rule for any given name. If you want to express that a symbol can have two or more definitions, separate the alternatives with semicolons.

This rule says a "thing" is a "this" followed by a "that":

```shell
thing: this, that.
```

This rule says a "thing" is a "this" OR a "that":

```shell
thing: this; that.
```

Whitespace around punctuation is insignificant: `"this;that"` is the same as `"this; that"`.

## Understanding ixml Symbols and Structure

**Nonterminals** are the symbols you define with rules — they're the names on the left-hand side, before the colon. They represent patterns or structures in your text that get converted to XML elements. For example, if you write:

```shell
month: "January"; "February"; "March".
```

Then `month` is a **nonterminal**. When the processor matches one of those month names in your input, it creates a `<month>` element in the XML output.

**Terminals** are the symbols that match characters explicitly in your input. In the example above, `"January"`, `"February"`, and `"March"` are **terminals** - they match those exact words in your input. 

### Mixing and Matching

A nonterminal may be defined using another nonterminal. Let's add to the previous example:

```shell
date: month.
month: "January"; "February", "March".
```
When a rule refers to other nonterminals, it might help to think of the output to better understand what's happening:

```
<date>
	<month>January</month>
</date>
```

Elements can contain other elements ("nesting"), so nonterminals can - and most likely will - contain other nonterminals.

## Organizing the Right Hand Side

### Building blocks
The right-hand side of a rule is organized into levels:

- **Factors** — the basic building blocks: terminals (quoted text like `"January"`), nonterminals (names of other rules), or grouped alternatives in parentheses
- **Terms** — separated by commas (`,`), forming a sequence
- **Alternatives** — separated by semicolons (`;`), offering different ways to match the same nonterminal


You can use parentheses to group alternatives together. For example:

```shell
memo: recipient, (date, sender ; sender, date), content.
```

Here, the middle part can match either date followed by sender, OR sender followed by date.

## Character Classes/Categories
For both letters and numbers, you can use a square brackets to indicate ranges. For instance:
```shell
num: ["0"-"5"].
```

The above code will match any digit from 0 to 5, inclusive. Keep in mind that the quotation marks are necessary.

## Exclusions
Adding a tilde ('\~') before a symbol changes a rule from matching that symbol to matching anything *except* for that symbol. This is called an **exclusion**. For example:

```shell
notNum: ~[N].
```
The above code will recognize a letter, whitespace, etc. as a `notNum`, but will not recognize any numerical digit.

### Excluding a nonterminal
There will be instances where the original file you're working with will have structural markers you don't want in your XML output. Take this situation:

```shell
1/2/3
```

Each number is separated by a slash, but maybe for our purposes, it isn't important to preserve this formatting. Our grammar might look like this:


```shell
line: num, slash, num, slash, num.
num: [N].
-slash: -#2F.
```

The hyphen `-` before the `slash` terminal means that the `<slash>` **element** will not appear in the final output. The hyphen `-` before `#2F` suppresses the slash itself.

## Unicode Characters and Hex Codes

**What is Unicode?** Unicode is a universal character encoding system that assigns every character—from all languages and symbol sets—a unique code point. This lets grammars reliably match a wide range of characters.

In ixml, you cannot put actual line breaks, tabs, or other special characters directly into quoted strings. To represent these invisible characters or symbols, ixml uses encoded characters written as a number sign ("#") followed by hexadecimal digits. Each encoded character can represent any Unicode character.

Most special character codes in ixml match the Unicode equivalent. A tab is represented in unicode as U+0009. Replacing "U+000" with "#" yields the ixml code, #9.

### Useful Character Codes

You may find the following values useful as you construct your ixml grammar:

| Character | Character Code (Hex value) |
|-----------|----------------------------|
| tab | `#9` |
| quotation mark (") | `#22` |
| newline (CR?, LF) | `#d?, #a` |

## The Data

There's a plain-text tab-delimited document at https://raw.githubusercontent.com/djbpitt/ixml/refs/heads/main/movies/movieData-short.txt that contains information about several films. Each line of the file contains four pieces of information about one film, separated by tab characters:

- title
- year
- country
- runtime

The first line of the file contains column headers; the remaining lines are actual data. You may want to open the file in <oXygen/> and look around in order to familiarize yourself with it before you start the assignment.

The format of the data is mostly straightforward, but here are a few details:

- Some titles are surrounded by quotation marks and others are not. The use of quotation marks around titles is arbitrary and not informational.
- The country value includes between one and seven countries, inclusive. If there are two or more, the individual countries are separated by a comma and space character and the whole value is surrounded by quotation marks, e.g., `"UK, USA"`. The quotation marks in the country field are used only when there are two or more countries.
- The runtime is either a number of minutes followed by a space character and the abbreviation `min` (e.g., `93 min`) or just the string `N/A` (which stands for not available). If a time is given, it is always given as a number of minutes (i.e., there is no reference to hours or any other unit of time except minutes).

## The Task

Your task is to create an ixml grammar that will convert the plain-text file to well-formed XML.


For example, for the plain text line:

```
Goodbye to All That	1930	UK	9 min
```

your ixml grammar should create:

```xml
<film>
    <title>Goodbye to All That</title>
    <year>1930</year>
    <country>UK</country>
    <runtime>9 min</runtime>
</film>
```

## How to Proceed

### Reading the Plain-Text Input

You can use CoffeePot, the jωixml workbench, or Markup Blitz to test your grammar. You can read your plain-text input file directly from the URL above or save it and then read your local copy.

**Using Markup Blitz (command line):**

Markup Blitz can read directly from a URL, so you can parse the remote file against your ixml grammar with:

```bash
blitz movies.ixml https://raw.githubusercontent.com/djbpitt/ixml/refs/heads/main/movies/movieData-short.txt
```

### Examining or Saving the XML Output

If you run the code above and your ixml tagging succeeds, the output will race across the screen. Here are two ways to examine the result more carefully:

- If you're on MacOS or in GitBash in Windows, you can pipe the output into `less`, a pager that displays one screen of data at a time. The command to do that is:

```bash
blitz movies.ixml https://raw.githubusercontent.com/djbpitt/ixml/refs/heads/main/movies/movieData-short.txt | less
```

Once the first screen is displayed in `less`, pressing the space bar moves forward to the next page. Press `q` to quit.

- To save the output to disk, you can redirect it to a file by appending `> movies.xml` to the command line, i.e.:

```bash
blitz movies.ixml https://raw.githubusercontent.com/djbpitt/ixml/refs/heads/main/movies/movieData-short.txt > movies.xml
```

This will create a file called `movies.xml`, which will contain the output of your ixml operation. If the file already exists, running the command will replace the old file with the new output.

## Handling Line Endings (Postel's Law)

Files from different systems use different line-ending conventions: Linux and macOS use `#a` (LF), while Windows uses `#d#a` (CRLF). Since you cannot predict which format an Internet file will use, you should write your grammar to accept both. The pattern `#d?#a` will match the end-of-line code in both Linux/macOS and Windows files. Using this pattern is a way of being liberal in what you accept.

Files may also end with or without a final newline. To handle both cases, you can use the separator pattern with an optional trailing newline:

```
doc: line++newline, newline?.
```

- `line++newline` matches one or more lines with newlines as separators between them
- The final `newline?` makes a trailing newline optional

### Repetition operators:

| Operator | Meaning |
|----------|---------|
| `*` | zero or more |
| `+` | one or more |
| `?` | optional (zero or one) |
| `++` | one or more with separator (e.g., `item++comma`) |

### XML Output

For the moment you don't have to worry about treating multiple countries specially. That is, where the input country value is something like `"US, UK"`, it's okay if your XML says `<country>"US, UK"</country>`. We'll process that value further, later in this unit, using XSLT within XProc.

Invisible XML doesn't create pretty-printed output by default, but we can take care of that later. For now, you can open the output in oXygen to pretty-print and check your work.


## What to Submit

Submit only your ixml grammar. Do not submit the tagged XML that it creates; we'll run it ourselves to examine the output.


# notes on bash syntax

## echo

### findings

regardless of spaces or variable references:
- can use no quotes OR double quotes for var OR double quotes for entire phrase
- single quotes always print variable reference literally

### experiment

```
command                 output          notes
-------                 ------          -----
echo hello goodbye      hello goodbye   whole phrase prints w/o quotes

a=hello                 
echo I said $a          I said hello    reference works w/o quotes

echo I said "$a"        I said hello    reference works with double quotes
echo "I said $a"        I said hello

echo I said '$a'        I said $a       reference doesn't work with single quotes
echo 'I said $a'        I said $a

```

## variable assignments and references

### findings

for variable assignment:
- if no spaces, can use no quotes / single / double
- if spaces, <u>must</u> use single / double

for variable reference:
- regardless of spaces, <u>must</u> use no quotes / double quotes
- single quotes always print the variable reference literally

### experiment

#### variable without spaces

1. effect of quotes in variable assignment

```
a=hello

command     output      notes
-------     ------      -----
echo $a     hello       assignment w/o quotes works
```

```
a='hello'

command     output      notes
-------     ------      -----
echo $a     hello       assignment with single quotes works
```

```
a="hello"

command     output      notes
-------     ------      -----
echo $a     hello       assignment with double quotes works
```

2. effect of quotes in reference to variable

```
a="hello"

command     output          notes
-------     ------          -----
echo $a     hello           reference w/o quotes works
echo "$a"   hello           reference with double quotes works 
echo '$a'   $a              reference with single quotes _doesn't_ work

```
#### variable with spaces

1. effect of quotes in variable assignment

```
a=hello goodbye

error - "goodbye: command not found"
so variable is not assigned

command     output          notes
-------     ------          -----
echo $a     blank line      because variable was never assigned
```

```
a='hello goodbye'

command     output          notes
-------     ------          -----
echo $a     hello goodbye   assignment with single quotes works
```

```
a="hello goodbye"

command     output          notes
-------     ------          -----
echo $a     hello goodbye   assignment with double quotes works
```

2. effect of quotes in reference to variable

```
a="hello goodbye"

command     output          notes
-------     ------          -----
echo $a     hello goodbye   reference w/o quotes works, even for spaced value
echo "$a"   hello goodbye   reference with double quotes works
echo '$a'   $a              reference with single quotes _doesn't_ work
```

## comparison with variable

if an empty string value would make a comparison invalid, then use quotes 

example:

```
if ["$a" = "hello"]; then
  echo something
fi
```
need quotes around `$a`
otherwise, if `$a` is empty, the test will be `[ = "hello"]`, which is invalid
no need for quotes around `hello` though

## variable concatenation

option 1. put each variable in its own quotes

```
a=hello
b=goodbye

value="$a"something"$b"
echo $value
```

option 2. put each variable name in curly braces, _not_ including the `$`

if there are spaces, use quotes
```
a=hello
b=goodbye

value=${a}something${b}   
echo $value
```

## command substitution

use `\` \`` or `$( )` to replace a command with its output 

```
`some_command` OR $(some_command)

var=`some_command` OR var=$(some_command)
```

example:
```
command             output      notes
echo expr 5 + 6       expr 5+6    prints literally; doesn't evaluate command
echo "expr 5 + 6"     expr 5+6    prints literally; doesn't evaluate command
echo `expr 5 + 6`     11          evaluates command
```




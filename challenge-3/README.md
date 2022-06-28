# Challenges #3

## Problem

We have a nested object; we would like a function that you pass in the object and a key and get back the value. How this is implemented is up to you.

**Example Inputs**

object = {"a":{"b":"{"c":"d"}"}}  
key = a/b/c  

object = {"x":{"y":"{"z":"a"}"}}  
key = x/y/z  
value = a

**Hints**

We would like to see some tests. [A quick read to help you along the way](https://hexdocs.pm/elixir/master/Kernel.html#get_in/2)

We would expect it in any other language apart from elixir.

## Solution

### Run Solution Code

```
python objectkeyvalue.py -o '{"x":{"y":{"z":"1"}}}' -v "x/y"
```

### Run Test

```
python test_objectkeyvalue.py
```
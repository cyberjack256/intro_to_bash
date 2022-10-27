## Simple AND/OR Constructs
```bash
# The double vertical bar represents an OR statement. The second command only runs if the first fails
echo hello || echo bye
# The AND is the double ampersand and the second command executes only if the first command succeeds
echo hello && echo bye
```

## Creating IF Statements
```bash 
# An if statement in BASH or ZSH has at least one condition to test followed by one or more actions. the `fi` ends the statement
declare -i days=30
if [ $days -lt 1 ]; then echo "Enter correct value"; fi
# Because we declared our variable to be an integer, we get our string echoed back to us
declare -i days=Monday
if [ $days -lt 1 ]; then echo "Enter correct value"; fi

```
## Extending IF with AND / OR
```bash
# Testing for values being less than 0 or greater than 30
declare -i days=31
if [ $days -lt 1 ] || [ $days -gt 30 ]; then echo "Enter correct value"; fi
```

## Arithmetic evaluations
```bash
# Using arithmetic notation allows for the use of > < symbols. the $ can be omitted from variable
declare -i days=31
if (( days < 1 || days > 30)); then echo "Enter correct value"; fi
```

## Extending IF with ELSE
```bash
# Adding an ELSE test allows for an action on both correct and incorrect input
declare -i days=30
if (( days < 1 || days > 30)); then echo "Enter correct value"; else echo "All good": fi
# Testing for more more than one condition--add ELIF to all other conditions and ELSE to the final
declare -i days
read days
if (( days < 1 )); 
    then echo "Enter numeric value"; 
    elif (( days > 30 )); 
        then echo "Too high of a value";
    else echo "The value is $days";
fi
```

## Comparing strings in evaluations
```bash
declare -l user_name
read user_name
# NOTE: You can use either = or == to test string equality. I prefer == to differentiate from assignment operator.
[ $user_name == 'bob' ] && echo "user is bob"
```

## Testing for Partial String Values
```bash
declare -l browser
read browser
# NOTE: Using the [[ syntax allows testing for partial values *
[[ $browser == *fox ]] && echo "The browser's Firefox"
```

## Using regular expressions as part of a test
```bash
declare -l test_var
read test_var
[[ $test_var =~ colou?r ]] && echo "You provided $test_var and either color or colour were acceptable answers"
```


## Testing file attributes
```bash
declare -l my_dir

echo -n "Enter a directory to create: "
read my_dir
if [[ !-d $my_dir ]]
    then
    mkdir $my_dir
    else
    echo "$my_dir already exists"
    exit 1
fi
```

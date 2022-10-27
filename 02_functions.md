# Functions in Shell

Shell functions encapsulate blocks of code in named elements that can be executed or called from scripts or directly at
the CLI. Functions live in memory. In bash, one of the most useful uses for the declare command is being able to display
functions. The `-f` and `-F` options for declare display definition and just function names if available, respectfully.

```bash
# Create a function to say, "hello"
function say_hello () { 
    echo hello
}
# Execute the function say_hello
say_hello
```

## Creating, Calling and Listing functions in the shell
```bash
# Create a function to say "goodbye"
function say_goodbye () { 
    echo buh-bye
}
# Display function name(s)
declare -F 
# Display function definition for say_goodbye
declare -f say_goodbye
```

## Exporting Functions
```bash
# Export the function so that it is available globally on the system
declare -xf say_hello
bash # <- starts a new bash session
say_hello
exit # <- returns me to my previous bash session
```

## Passing arguments to functions
```bash
function create_user () {
    if (getent passwd $1 > /dev/null ); # <- getent can interrogate databases (cat /etc/nsswitch.conf)
    then
        echo "The user $1 already exists";
    else 
        echo "Now creating user $1";
        sudo useradd $1;
    fi
}
create_user tux
```

## Working with return values
```bash
function remove_user () {
    if (getent passwd $1 > /dev/null ) ; # <- getent can interrogate databases (cat /etc/nsswitch.conf)
    then
        echo "User $1 exists, would you like to remove the user and their home directory and mail spool? [yes|no]" ;
        declare -l remove_name ;
        read remove_name ;
        if [[  "$remove_name" = "yes"  ]] ; 
        then
            sudo userdel --remove $1;
        elif [[ "$remove_name" = "no" ]] ;
        then
            echo "Thats okay, I'm glad we checked with you first! User $1 is safe and not deleted." ;
            return 0 ;
        else
            echo "Invalid entry please try again" ;
            return 1 ;
        fi
    else
        echo "User $1 does not exist, maybe check the spelling?" ;
    fi
}
```

## Best practice in functions

Functions should be standalone and not dependent on other elements such as variables from the master script. This limits
how much the function can be used in other scripts.

```bash
### DON'T DO THIS ###  Calling Variables from outside of functions
function print_age() {
    echo $age
}

# We can clear remove the variable and the function
unset age # <- remove the variable
unset - f print_age # <- remove the function


### DON'T DO THIS ### Call variables from within functions
function print_age() {
    age=$1
    echo $age
}

### DO THIS ### Call local variables from within functions
function print_age() {
    local age=$1
    echo $age
}
```


## Case Statements
Case statements can be much cleaner than writing multiple `elif` statements

```bash
function what_season() {
    declare -l month=$(date +%b)
        case $month in
        dec | jan | feb)
        echo "Winter";;
        mar | apr | may)
        echo "Spring";;
        jun | jul | aug) 
        echo "Summer";;
        sep | oct | nov)
        echo "Fall";;
        esac
}

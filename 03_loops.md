# Loops in Shell

Shell looping structures allow for the quick iteration through a list or group of items. A very simple loop could create
10 users that need similar properties. The code only needs to be written once and it runs across each user in the list.
This code is reusable in that a similar or identical task can be completed faster following the first use of the loop.

## Creating WHILE and UNTIL loops
```bash
# While loops will iterate while the test condition is true
declare -i x=10
while (( x > 0 )) ;
    do
        echo $x
        x=x-1 # <- decrements 1 each round of the loop
done

declare -i x=0
while (( x < 11 )) ;
    do
        echo $x
        x=x+1 # <- increments 1 each round of the loop
done

# Until loops will iterate until the condition becomes true

declare -i x=10
until (( x == 0 )) ;
    do
        echo $x 
        x=x-1 # <- decrements 1 each round of the loop
done
```

## Creating FOR loops
For loops iterate over a list. The list may be manually created or generated from a command

```bash
# C-style Loop: Takes 3 expressions (1) initiate the variable, (2) test the variable, (3) increment/decrement the variable
for ((i=0 ; i<5 ; i++));
    do 
    echo $i
done
# Three portions: for <condition>; do <action> ; done
for ((i=5 ; i>0 ; i--)); do echo $i; done
```
# Iterating an Array
```bash
# We can make an array manually
declare -a users=("bob" "joe" "sue")
echo ${#users[*]}
for ((i=0; i<${#users[*]}; i++)); do sudo useradd ${users[$i]}; done

# Classic FOR Loop and feed in the output of a command $(ls)
# See no output only errors
for f in $(ls); do stat -c "%n %F" $f 1>/dev/null; done
# See no errors only output
for f in $(ls); do stat -c "%n %F" $f 2>/dev/null; done
```

## Create/Delete files or directories with C-Style loop
```bash
# Create a directory to play in
mkdir play
cd play
ls -la
# Create 9 files
for ((i=1 ; i<10 ; i++));
    do
    touch file$i
done
ls -la
# Delete the files we just created
for ((i=9 ; i>0 ; i--));
    do
    rm file$i
done
ls -la
```

```bash
declare -a users=("bob" "sue" "ashley")
declare -p users
echo ${#users[*]}
for ((i=0 ; i<${#users[*]} ; i++)); do sudo adduser ${users[$i]}; done

# Let's call our remove_user function from earlier. If you don't have it, here it is for reference

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

# Delete the array of users created previously with our remove_user function
for ((i=0 ; i<${#users[*]} ; i++)); do remove_user ${users[$i]}; done
```

## Loop control with BREAK and CONTINUE
```bash
# Continue allows us to test the file read and if it is a directory ignore the read
for file in $(ls);
do
  if [[ -d $file ]];
    then
      continue
  fi
echo $file
done

# Break allows us to stop searching once a condition is met
for file in $(ls);
do
  if [[ -f $file ]]; 
    then
      break #<- as soon as the condition is met, the loop will exit. In this case when a file is read 
  fi
stat -c "%n %U %G" $file 2>/dev/null
done
```
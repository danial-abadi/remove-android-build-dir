#!/bin/bash
array=()
#----------------- Functions ----------------------
: '
add passed data to the last index of array if data be not be the last index data
$1 is data
'
function addNE()
{
    if [[ ${#array[@]} == 0 || ${array[$((${#array[@]}-1))]} != $1 ]]
    then
        array[${#array[@]}]=$1
    fi   
}
#--------------------------------------------------

read -p "path is : $(tput bold)$(tput rev) $(pwd) $(tput sgr0) , are you sure you want to remove build files? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
   input=($(find $(pwd) -type d  -iname build -exec rm -rvf {} 2> /dev/null \; ))
fi

for line in ${input[*]}
do
    #convert '/' to ' ' and because ' ' is in the array definition, it became an array
    words=(${line//// })
    for (( i=0; i < ${#words[@]}; i++ ))
    do
        if [ ${words[$i]} == "app" ]
        then
            addNE ${words[$i-1]}
        fi
    done
done

#show result
echo "build dirs is removed from these project:"
for ((i=0; i < ${#array[@]}; i++))
do
    echo $((i+1))")"${array[$i]}
done

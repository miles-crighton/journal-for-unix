#!/bin/bash
cd "$(dirname "$0")"

config() {
    #Grab value from config file for first arg of function ($1)
    #Returns default for arg if not found
    val=$((grep -E "^$1=" config.conf 2>/dev/null || echo "$1=__DEFAULT__") | head -n 1 | cut -d '=' -f 2-)

    if [[ $val == __DEFAULT__ ]]
    then
        case $1 in
            texteditor)
                echo -n "vim"
                ;;
        esac
    else
        echo -n $val
    fi
}

DAY=$(date +%d)
MONTH=$(date +%b)
YEAR=$(date +%Y)
FULL_DATE=$(date +%d-%m-%Y)
ENTRY_FILE="./$YEAR/$MONTH/$DAY-$MONTH.txt"

#Check for directories and files
if [ ! -d "./$YEAR" ]; then
    mkdir "./$YEAR"
fi
if [ ! -d "./$YEAR/$MONTH" ]; then
    mkdir "./$YEAR/$MONTH"
fi
if [ ! -f "$ENTRY_FILE" ]; then
    echo "- $DAY $MONTH -" > $ENTRY_FILE
    echo "Entry for $FULL_DATE created"
fi

#Ask user for their preferred text editor
if [ ! -f "./config.conf" ] || [ "$1" = "--change-editor" ]; then
    while :
    do
        read -p 'Choose a default text editor command: ' TEXTEDITOR
        if hash $TEXTEDITOR 2>/dev/null;
        then
            break
        fi
        echo 'Unable to use provided command, please try again.'
    done
    echo "texteditor=$TEXTEDITOR" > config.conf
fi

#Get a specific journal entry
if [ "$1" = "-d" ]; then
    #Read requested date from input arguments
    #Split into DATE_ARR of length 3
    IFS='-'
    read -ra DATE_ARR <<< "$2"
    MONTHS=(ZERO Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec)
    MONTH_STRING=${MONTHS[${DATE_ARR[1]}]}

    if [ -f "./${DATE_ARR[2]}/$MONTH_STRING/${DATE_ARR[0]}-$MONTH_STRING.txt" ]; 
    then
        DAY=${DATE_ARR[0]}
        MONTH=${DATE_ARR[1]}
        YEAR=${DATE_ARR[2]}
        echo "Found requested journal entry $DAY-$MONTH-$YEAR"
        FULL_DATE=$DAY-$MONTH-$YEAR
        ENTRY_FILE="./$YEAR/$MONTH_STRING/$DAY-$MONTH_STRING.txt"
    else
        echo 'Unable to find requested journal entry'
    fi
fi

echo "Opening entry for $FULL_DATE"
TIME=$(date +%H:%M)
printf "\n$TIME:" >> $ENTRY_FILE
$(config texteditor) "$ENTRY_FILE"
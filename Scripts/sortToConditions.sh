# This script sorts prompts to section

while read line
do
    
    # Parse the CSV file for each student
    CanvasID=$(echo $line | cut -d , -f 1)
    Email=$(echo $line | cut -d , -f 2)
    Lecture=$(echo $line | cut -d , -f 3)
    Condition=$(echo $line | cut -d , -f 4)
    CampusID=$(echo $line | cut -d , -f 5)

    # Check if the person turned in an essay. If they did not, note canvasID in
    # in "notFoundEssays" log and continue to next essay.
    file=$(find ../Renamed -name "*${CanvasID}*")
    if [ -z "$file" ]
        then
            echo "${CanvasID}" >> ../Lists/MissingEssays.csv
            continue
    fi

    # Check if We've Already Sorted the File to Condition, if so, don't sort it again
    found="$(grep -F -c "$CanvasID" ../Lists/SortedFiles.csv)"
    if [ $found -eq 1 ]
    then
        continue
    fi

    # If essay is turned in and not yet sorted, rename file path and copy file to appropriate folder
    echo $file
    echo $file >> ../Lists/SortedFiles.csv
    if [ $Condition -eq 1 ]
    then
        dest=$(echo $file | sed 's/Renamed/ConditionFiles\/GroupA/')
        cp $file "$dest"
    elif [ $Condition -eq 2 ]
    then
        dest=$(echo $file | sed 's/Renamed/ConditionFiles\/GroupB/')
        cp $file "$dest"
    elif [ $Condition -eq 3 ]
    then
        dest=$(echo $file | sed 's/Renamed/ConditionFiles\/GroupC/')
        cp $file "$dest"
    elif [ $Condition -eq 4 ]
    then
        dest=$(echo $file | sed 's/Renamed/ConditionFiles\/GroupD/')
        cp $file "$dest"
    else
        echo "ERROR"
    fi

    #Essay=$(find)


    #echo "Canvas ID = ${CanvasID}, Condition = ${Condition}"
done < ../Lists/Roster.csv
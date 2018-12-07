# This script renames prompts, restoring non-anonymous names, then sorts prompts to section

while read line
do

    # Parse the CSV file for each student
    CanvasID=$(echo $line | cut -d , -f 1)
    Email=$(echo $line | cut -d , -f 2)
    Lecture=$(echo $line | cut -d , -f 3)
    Condition=$(echo $line | cut -d , -f 4)
    CampusID=$(echo $line | cut -d , -f 5)

    # Check if the person turned in an essay. If they did not, continue to next essay.
    file="$(find ../GradedAnon -name "*${CanvasID}*")"
    if [ -z "$file" ]
        then
            #echo "${CanvasID} not found in graded work folder"
            continue
        fi

    # Update file path to contain the non-anon name, in the GradedAnon folder:
    regAnonPair="$(grep -F  "$CanvasID" ../Lists/AnonRegNames.txt)"
    regName="$(echo $regAnonPair | cut -d @ -f 2)"
    filename="${file##*/}"
    newPath="$(echo $file | sed "s/$filename/$regName/")"
    echo $newPath
    
    # Rename file path and copy file to appropriate section folder
    if [ $Lecture -eq 1 ]
    then
        dest="$(echo $newPath | sed 's/GradedAnon/ToUpload\/Section1/')"
        #echo $dest
        mv $file "$dest"
    elif [ $Lecture -eq 2 ]
    then
        dest="$(echo $newPath | sed 's/GradedAnon/ToUpload\/Section2/')"
        #echo $dest
        mv $file "$dest"
        
    elif [ $Lecture -eq 3 ]
    then
        dest="$(echo $newPath | sed 's/GradedAnon/ToUpload\/Section3/')"
        mv $file "$dest"
        #echo $dest
    elif [ $Lecture -eq 4 ]
    then
        dest="$(echo $newPath | sed 's/GradedAnon/ToUpload\/Section4/')"
        mv $file "$dest"
        #echo $dest
    elif [ $Lecture -eq 5 ]
    then
        dest="$(echo $newPath | sed 's/GradedAnon/ToUpload\/Section5/')"
        mv $file "$dest"
        #echo $dest
    elif [ $Lecture -eq 6 ]
    then
        dest="$(echo $newPath | sed 's/GradedAnon/ToUpload\/Section6/')"
        mv $file "$dest"
        #echo $dest
    else
        echo "ERROR"
    fi

    #Essay=$(find)


    #echo "Canvas ID = ${CanvasID}, Condition = ${Condition}"'
done < ../Lists/Roster.csv
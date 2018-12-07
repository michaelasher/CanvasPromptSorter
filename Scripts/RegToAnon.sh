# This File Converts regular ("reg") files from canvas to anonymized files, 
# which contain only canvas ID numbers

# Navigate to the FileManager folder for later convenience
cd ..

# Create AnonRegNames.txt if it doesn't already exist
touch ../Lists/AnonRegNames.txt

for file in ToBeRenamed/*
do
    # Extract the file name, canvas ID 
    regName=$(basename -- "$file")
    extension="${regName##*.}"
    # the next line matches the canvas ID number, which is always 4-6 digits, in between underscores. It then cuts off the underscores.
    canvasID="$(echo $regName | grep -E -o '_\d{4,6}_' | cut -d _ -f 2)" 
    found="$(grep -F -c "$canvasID" Lists/AnonRegNames.txt)"
    
    if [ $found -eq 1 ]
    then
        rm "$file"
    else
        anonName=$(echo "${canvasID}.${extension}")
        echo $anonName

        # Add the anonymous and regular names to the AnonRegNames csv file, for future reference
        echo "${anonName}@${regName}" >> Lists/AnonRegNames.txt

        # Move the file, with its anonymous name, to the "Renamed" folder
        mv "$file" "Renamed/${anonName}"
    fi    

done



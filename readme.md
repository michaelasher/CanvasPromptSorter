# Readme For Prompt Sorting

### Missing Files on GitHub

- `Roster.csv` is a list with 4 columns: CanvsID, Email, Lecture, Condition, CampusID. It's not on github and will need to be created for subsequent projects.

### Overview of Sorting Student Submissions into Conditions and Anonymizing Grades

- First, download all of the essays from all sections into the `ToBeRenamed` folder. At this point the files all have messy names with student names, Canvas ID numbers, and file names. Everything except for the Canvas ID number needs to be stripped.

- Next, to strip all identifying information from the files, navigate to the `Scripts` folder and run the `RegToAnon.sh`  script. This script does a few things:
    1. It replaces the old, non anonymous name, with a new, anonymous name (the Canvas ID number). 
    2. It notes the new, anonymous name and old, regular name in the `AnonRegNames.txt` file, in the `Lists` folder, separated by an "@" sign. This will allow us to change the names back after essays have been graded.
    3. It moves the file, with its new name to the `Renamed` folder.

- Next, to sort all of the anonymous essays into their corresponding conditions, navigate to the `Scripts` folder and run the `sortToConditions.sh` script. This will copy all of the files in the `Renamed` folder into the `ConditionFiles` folder, in either the `GroupA`, `GroupB`, `GroupC`, or `GroupD` subdirectory. At this point the essays can be moved from the "Group" folders into the UW Box folders for the graders.


- When essays come in late, follow the same procedure. The `RegToAnon.sh` script will use  `AnonRegNames.csv` file to only rename new essays. Next, when you run  `sortToConditions.sh`, it will sort all files, including the new ones, into the appropriate folders.

### Overview of How to Sort Graded, Anonymized Essays into Sections, and Convert them Back to Their Original Names for Uploading

- First, assemble a list of anonymous, graded essays in the `GradedAnon` folder. Make sure there aren't any duplicated essays in the folder, because the first copy of any duplicate will be overwritten when the second is moved into the sorted folder.

- Next, navigate to `Scripts` and run the `sortAnonToSections.sh` script. This will rename the anonymous essays in `GradedAnon` to their non-anonymous names and then move them to the corresponding section in the `ToUpload` folder.
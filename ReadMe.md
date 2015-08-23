------------------------------------------

run_analysis.R script reads data from the Samsung dataset and creates a new tidy dataset which may be used for further analysis.


Brief description of the script:
-------------------------------------------

The run_analysis.R script checks to see you have the right package installed (rshape2) then proceeds to separate the ids for the train subjects, test subject, train activities and test activities. These are combined into a single data set retaining only the mean/std values using the melt/cast function.

 A new tidy data set is created at the end.



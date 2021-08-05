# Pewlett-Hackard-Analysis

## Project Overview: 

Bobby's manager has two more assignments for us. Determine the number of retiring employees per title, and identify employees who are eligible to participate in a upcoming mentorship program, called “silver tsunami” as many current employees reach retirement age we must ensure the future generation is mentored.



## ERD (Entity Relationship Diagram): 
### ERD Pre Challenge 7
We begin by creating a Entity Relationship Diagram. Here is the diagram we created during the lessons throughout module 7. We will be adding additional tables and relationships throughout the challenge.

<img width="329" alt="Screen Shot 2021-08-03 at 12 12 12 PM" src="https://user-images.githubusercontent.com/83923903/128072581-a54616ed-d7ab-464b-955c-9f2584aaa0f6.png">


### ERD Post Challenge 7
Here we have our Diagram post Module 7 challenge.
<img width="972" alt="Screen Shot 2021-08-03 at 12 06 48 PM" src="https://user-images.githubusercontent.com/83923903/128071994-77fb07ae-4e66-486f-8a87-e22e3f526a16.png">


## Overview of Analysis:

- Create a Retirement Title Table with data from Current_Emp and Titles CSV
- Apply a filter to_where date for active employees
- De-dup the data by using a partition. Removing older roles and only keeping the most recent title.
- After we have partition the data. Create a new table to get the count of employees by their titles.
- Created a new table of employees who are eligible for Silver Tsunami mentorship program. 

### Number of Employees eligble for retirement:


We begin by INNER JOINING Current_emp and Titles merging on emp_no into a brand new table called ret_titles. We export this into a ret_title.csv please find it by reference the data folder.  This output had 54722 employees eligible for retirement. 

<img width="760" alt="Screen Shot 2021-08-03 at 12 28 23 PM" src="https://user-images.githubusercontent.com/83923903/128074571-0d1c8229-7584-473a-8111-3360633c9b97.png">

However this data includes duplications as we can see from the screenshot above. 


### Number of Unique Retiring titles Table:

to fix the duplications we PARTITIONED the data by emp_no. This created a new column "RN" that counted the number of titles with 1 being the most recent. We filtered "RN" = 1 be get only the most recent job title and export this into a unique_titles table. lowering the amount of rows from 54722 to only 33118. We exported this new table into the Unique_title.csv file. Please find it in the data folder.

<img width="765" alt="Screen Shot 2021-08-03 at 12 33 48 PM" src="https://user-images.githubusercontent.com/83923903/128075217-0f8c7870-db8d-4067-950d-78bb041fb782.png">


### Retirement Title Table:
Now that we have our unique list by titles. We re-formated the table to provide us the count based off job title. We exported this count table into retiring_titles.csv. Please find it in the data folder.

<img width="270" alt="Screen Shot 2021-08-03 at 12 05 06 PM" src="https://user-images.githubusercontent.com/83923903/128071857-850d66bf-980e-4a09-ad4a-34b70aa6104f.png">

## Results:

### "silver tsunami" Candidate eligibility: 
Based off our Unique title analysis we apply a filter for Birth_date between '1965-01-01' and '1965-12-31'. This new table has 2382 employees eligble for the Silver Tsunami mentorship program. We saved this table as mentorship.csv. Please reference it in data folder.


<img width="768" alt="Screen Shot 2021-08-03 at 12 35 21 PM" src="https://user-images.githubusercontent.com/83923903/128075535-4c4515d3-2978-4338-8fa1-e7fea78df29b.png">


## Summary: 

In this challenge, we applied queries and joins to create additional new tables to pgadmin as well as created a list of candidates who are eligible for the silver tsunami mentorship program. We exported our various tables to csv file located in the data folder. To Successfully complete this challenge, we applied our knowledge from mod 7. This means importing csv's, aliasing, apply filtering, and creating new tables. Exporting the new datasets into multiple readable CSV files. 



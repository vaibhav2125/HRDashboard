                                             -- Project : HR Analytics 

-- objective : Help an organization to improve employee performance to imrove retention (reduce attrition) by creating Hr analytics Dashboard

  
create database hr;
use hr;

select * from hr_database;

-- Rename column names

alter table hr_database
rename column `ï»¿EmpID` to `EmpID`;

-- concat km to column DistanceFromHome

alter table hr_database
modify column `DistanceFromHome` varchar(255);

update hr_database
set `DistanceFromHome` = 
concat(`DistanceFromHome`, ' ', 'KM');

                                                -- KPI
                                                
select count(`EmpID`) as Total_Employees
from hr_database
where `currently_working` = "Yes";


select round(avg(`MonthlyRate`),2) as average_salary
from hr_database;

-- departmentwise employee count

select `Department`, count(*) as Total_Employees
from hr_database
where `currently_working` = "Yes"
group by `Department`;



-- educationfield wise employee count

select `EducationField`, count(*) as Total_Employees
from hr_database
where `currently_working` = "Yes"
group by `EducationField`;


-- genderwise employee count

select `Gender`, count(*) as Total_Employees
from hr_database
where `currently_working` = "Yes"
group by `Gender`;

-- Gender Ratio

select `Gender`, count(*) as Total_Employee,
round((count(*) / sum(count(*)) over()) * 100,2) as gender_ratio
from hr_database
where `currently_working` = "Yes"
group by `Gender`;

-- agegroup wise employee count

select `AgeGroup`, count(*) as Total_Employees
from hr_database
where `currently_working` = "Yes"
group by `AgeGroup`;

-- compare gender & marital Status

select `Gender`, `MaritalStatus`, count(*) as Total_Employees
from hr_database
where `currently_working` = "Yes"
group by `Gender`, `MaritalStatus`;


-- employee leave count

select count(*) employee_leave_count
from hr_database
where `currently_working` = "No";


-- Retention rate
select concat(round((((select count(*) from hr_database where `currently_working` = "Yes") - 
(select count(*) from hr_database where `currently_working` = "No")) / count(*)) * 100,2), "%") as Retention_Rate
from hr_database;

                                    -- or

select concat(round(((count(case when `currently_working` = "Yes" then 1 else null end) -
count(case when `currently_working` = "No" then 1 else null end)) / count(*)) * 100,2), "%") as retentinrate
from hr_database;


-- attrition rate
select (count(*) / (select count(*) from hr_database)) * 100 as attrition_rate
from hr_database
where `currently_working` = "No";

-- attrition rate by department
select `department`, (count(*) / (select count(*) from hr_database)) * 100 as attrition_rate
from hr_database
where `currently_working` = "No"
group by `department`;


-- attrition rate by education field

select `EducationField`, (count(*) / (select count(*) from hr_database)) * 100 as attrition_rate
from hr_database
where `currently_working` = "No"
group by `EducationField`;


-- attrition rate by gender

select `Gender`, (count(*) / (select count(*) from hr_database)) * 100 as attrition_rate
from hr_database
where `currently_working` = "No"
group by `Gender`;


-- attrition rate by age group

select `AgeGroup`, (count(*) / (select count(*) from hr_database)) * 100 as attrition_rate
from hr_database
where `currently_working` = "No"
group by `AgeGroup`;

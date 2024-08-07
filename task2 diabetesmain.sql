create database diabeties;
use diabeties;
select count(Patient_id) from diabetes_prediction;

ALTER TABLE diabetes_prediction
CHANGE COLUMN `D.O.B` dob text;

UPDATE diabetes_prediction
SET smoking_history = 'Ex-smoker'
WHERE FLOOR(DATEDIFF('2024-08-03', STR_TO_DATE(dob, '%m/%d/%Y')) / 365.25) > 40;



-- 1. Retrieve the Patient_id and ages of all patients.
SELECT Patient_id,dob,FLOOR(DATEDIFF('2024-08-03', STR_TO_DATE(dob, '%d-%m-%Y')) / 365.25) AS age
FROM diabetes_prediction;


-- 2.Select all female patients who are olderthan 30.
SELECT Patient_id,dob,FLOOR(DATEDIFF('2024-08-03', STR_TO_DATE(dob, '%d-%m-%Y')) / 365.25) AS age 
FROM diabetes_prediction
WHERE gender = 'Female' AND FLOOR(DATEDIFF('2024-08-03', STR_TO_DATE(dob, '%d-%m-%Y')) / 365.25) > 30;


-- 3.Calculate the average BMI of patients.
select avg(bmi) 
from diabetes_prediction;

ALTER TABLE diabetes_prediction
CHANGE COLUMN `ï»¿EmployeeName` EmployeeName text;

-- 4.List patients in descending order of blood glucose levels
select Patient_id,EmployeeName ,blood_glucose_level
from diabetes_prediction
order by blood_glucose_level desc;


-- 5.Find patients who have hypertension and diabetes.
select Patient_id,EmployeeName ,hypertension,diabetes
from diabetes_prediction
where hypertension=1 and diabetes =1;


-- 6.Determine the number of patients with heart disease.
select count(Patient_id )as patients,heart_disease
from diabetes_prediction
where heart_disease =1
group by smoking_history;



-- 7.Group patients by smoking history and count how many smokers and non smokers there are.-- 
select count(Patient_id )as patients,smoking_history
from diabetes_prediction
group by smoking_history
order by patients desc;


-- 8.Retrieve the Patient_id of patients who have a BMI greaterthan the average BMI.
select Patient_id,bmi,FLOOR(DATEDIFF('2024-08-03', STR_TO_DATE(dob, '%d-%m-%Y')) / 365.25) AS age 
from  diabetes_prediction
where bmi>(select avg(bmi) 
from diabetes_prediction)
order by bmi desc;


-- 9.Find the patient with the highest HbA1c level and the patient with the lowest HbA1clevel
select Patient_id,EmployeeName,HbA1c_level,FLOOR(DATEDIFF('2024-08-03', STR_TO_DATE(dob, '%d-%m-%Y')) / 365.25) AS age 
from diabetes_prediction
where HbA1c_level  =(select max(HbA1c_level)
from  diabetes_prediction)
order by age desc;


select Patient_id,EmployeeName,HbA1c_level,FLOOR(DATEDIFF('2024-08-03', STR_TO_DATE(dob, '%d-%m-%Y')) / 365.25) AS age 
from diabetes_prediction
where HbA1c_level  =(select min(HbA1c_level)
from  diabetes_prediction)
order by age desc;

-- 10.Calculate the age of patients in years (assuming the current date as of now).
SELECT Patient_id,dob,FLOOR(DATEDIFF('2024-08-03', STR_TO_DATE(dob, '%d-%m-%Y')) / 365.25) AS age 
FROM diabetes_prediction;


-- 11.Rank patients by blood glucose level within each gender group
SELECT Patient_id,gender,blood_glucose_level,FLOOR(DATEDIFF('2024-08-03', STR_TO_DATE(dob, '%d-%m-%Y')) / 365.25) AS age ,
RANK() OVER (PARTITION BY gender ORDER BY blood_glucose_level DESC) AS rank_patients
FROM diabetes_prediction
ORDER BY gender, rank_patients,age;






-- Update the smoking history of patients who are olderthan 40 to "Ex-smoker."-- 
UPDATE diabetes_prediction
SET smoking_history = 'Ex-smoker'
WHERE FLOOR(DATEDIFF('2024-08-03', STR_TO_DATE(dob, '%m/%d/%Y')) / 365.25) > 40;



 -- 12.Insert a new patient into the database with sample data
INSERT INTO diabetes_prediction (EmployeeName, Patient_id, gender, dob, hypertension, heart_disease, smoking_history, bmi, HbA1c_level, blood_glucose_level, diabetes)
VALUES 
('DEEP', 'PS1301', 'Male', '15-08-1985', 120, 1, 'Never smoker', 23.15, 6.0, 95, '0'),
('ABC', 'PS13102', 'Male', '15-08-1985', 120, 0, 'Never smoker', 23.15, 6.0, 95, '1'),
('MANSI', 'PS13103', 'Female', '19-09-2000', 120, 0, 'Never smoker', 29.30, 6.2, 98, '0'),
('Shravani', 'PS13104', 'Female', '29-02-2004', 120, 1, 'Smoker', 47.72, 6.5, 95, '1'),
('Tanvi', 'PS1305', 'Female', '18-12-2006', 120, 1, 'Never smoker', 38.50, 6.0, 95, '0');


-- 13.Delete all patients with heart disease from the database
delete from  diabetes_prediction
where heart_disease=1;
select heart_disease from diabetes_prediction;

SET SQL_SAFE_UPDATES = 0;
-- 14.Find patients who have hypertension but not diabetes using the EXCEPT operator
SELECT Patient_id 
FROM diabetes_prediction
EXCEPT 
SELECT Patient_id 
FROM diabetes_prediction
WHERE diabetes = 0 
AND hypertension = 1


 -- Define a unique constraint on the "patient_id" column to ensure its values are unique.
-- Change the column type to VARCHAR with an appropriate length
ALTER TABLE diabetes_prediction
MODIFY Patient_id VARCHAR(255);
-- 15.Add the unique constraint after modifying the column type
ALTER TABLE diabetes_prediction
ADD CONSTRAINT unique_patient_id UNIQUE (Patient_id) ;



-- 15.Create a view that displays the Patient_ids, ages, and BMI of patients.
CREATE VIEW  view1 as 
select Patient_id,bmi,FLOOR(DATEDIFF('2024-08-03', STR_TO_DATE(dob, '%d-%m-%Y')) / 365.25) AS age 
from diabetes_prediction;
select * from view1 ;

-- extra
-- according blood suger having person is diabetic or not 
select Patient_id,blood_glucose_level,HbA1c_level,FLOOR(DATEDIFF('2024-08-03', STR_TO_DATE(dob, '%d-%m-%Y')) / 365.25) AS age ,diabetes
from diabetes_prediction
order by blood_glucose_level desc ,HbA1c_level desc;

-- smoking history ,age check patients is having heart disease or not 
select Patient_id,smoking_history,FLOOR(DATEDIFF('2024-08-03', STR_TO_DATE(dob, '%d-%m-%Y')) / 365.25) AS age,heart_disease
from diabetes_prediction
order by age desc;





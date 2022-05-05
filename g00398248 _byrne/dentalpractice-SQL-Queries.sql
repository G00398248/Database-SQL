-- Dr Mary Mulcahy runs a dental practice in a small town. She can treat most cases, although a few specialist cases are referred to larger practices IN Cork city WHERE the required expertise AND equipment are available.
-- With the below SQL queries one can have a quick look at the dental practices available in the Cork City with the expertise they provide as well as their addresses and contact details
SELECT * FROM dentalpractice.practices;


-- Mary arranges an appointment only if the bill amount is not exceeded or it's not due for too long
-- Below SQL query checks the above two conditions and sets isPaymentOverdue as a boolean 1 or 0 accordingly
UPDATE appointments a 
JOIN patientbills b ON a.PatientID = b.PatientID 				-- Join on FK PatientID in both tables
SET a.isPaymentOverdue = 										 -- Set isPaymentOverdue according to the result of the OR operation
	CASE 														-- CASE Statement starts
	   WHEN b.BillExceeded = 1 OR b.DaysAmountDue > 30 THEN 1 	-- Conditional OR
	   ELSE 0
	END; 														-- CASE Statement ends


--  Mary has to add a new chart if it's the patients first visit else she has to update the existing entry of that patient in the patients table
--  SQL query for getting first visit customers
SELECT * FROM `appointments` WHERE isFirstVisit = 1 -- returns rows of first visit patients
-- Mary  can now insert these customers in the patients table. An example would be
INSERT INTO `patient`(`PatientID`, `PatientName`, `PatientAddress`, `TreatmentID`, `TreatmentName`, `SpecialistID`, `BillID`, `AppointmentID`, `AppointmentType`, `FollowUpDetails`, `TreatmentPaid`, `AmountDue`, `isPaymentOverdue`) 
              VALUES ('8286','Fiona','Dublin 1','12','','','9001','6745','phone','','0','','','');
              
-- SQL query for getting customers with not being a first visit
SELECT * FROM `appointments` WHERE isFirstVisit = 0 -- returns rows of first visit patients
-- Mary can now update records of these customers in the patients table with their patient IDs with the WHERE clause. An example would be
UPDATE `patient` SET `TreatmentID`='12',`TreatmentName`='',`SpecialistID`='',`BillID`='9002',
`AppointmentID`='6746',`AppointmentType`='Drop in',`FollowUpDetails`='Consult a specialist for..',`TreatmentPaid`='0',
`AmountDue`='1050',`isPaymentOverdue`='1' WHERE 'patientID' = '8287';


-- Mary can now manage cancellations by deleting the booking in the appointments table and applying a late cancellation fee if applicable
-- Update AmountDue in patients table as amount + 10

-- SQL query for managing cancellations

DELETE FROM appointments WHERE AppointmentID = 6748;

UPDATE patient SET AmountDue=AmountDue + 10 WHERE AppointmentID = 6748;

 
-- Every Tuesday morning, Helen checks next week appointments from the appointments table and add it(INSERT) to the reminders table
-- SQL query to manage the following weeks appointments

SELECT * FROM `appointments` WHERE AppointmentDate BETWEEN STR_TO_DATE(CONCAT(YEAR(NOW()),WEEK(NOW(),7), ' Saturday'), '%X%V %W') AND STR_TO_DATE(CONCAT(YEAR(NOW()),WEEK(NOW(),7), ' Saturday'), '%X%V %W') + 8;

-- Helens notes down the IDs from the above query and puts them in below query.

UPDATE reminders a

JOIN appointments b ON a.AppointmentID = b.AppointmentID

SET a.AppointmentNextWeek =

Case

   WHEN a.AppointmentID IN ('6746', '6747') THEN 1

   ELSE 0

END;

 -- She puts a reminder to those where AppointmentNextWeek = 1

 
SELECT * FROM reminders where AppointmentNextWeek  = 1

-- Next, at about 2.30 p.m. she prepares bills by searching the patient charts to find details of any unpaid treatments. Then she looks up the Treatment Fees guidelines book, which Dr Mulcahy updates from time to time

-- Search from treatments table, fetch the fees and add it to the Amount Due

UPDATE `patient` a

JOIN treatments b ON a.TreatmentID = b.TreatmentID

SET AmountDue= a.AmountDue + b.TreatmentFees;

 

-- Patients pay by cheque, credit card or cash, either by post or by dropping in. The bill or the bill number is enclosed with the payment. Treatments which have been paid for are marked as such in the patient's file so that they will not be billed again

    SELECT * FROM patient WHERE AmountDue > 0; -- These patients have their bills paid

 

-- Helen takes the card and arranges appointments with the patient for any required follow-up treatments written on the card, and enters them into the appointments diary. 

-- Update patient table with follow-up details
-- SQL Query

UPDATE `patient` SET `FollowUpDetails`='Consult a Specialist for …. ' WHERE PatientID = '8286';

 

-- If the patient needs specialist treatment which Dr Mulcahy cannot provide, she writes the name of an appropriate specialist on the filled visit card and the secretary sends a patient referral to the specialist.

-- Update patient table with specialist details and join the specialist table

UPDATE `patient` SET `SpecialistID`='6294' WHERE PatientID = '8286';
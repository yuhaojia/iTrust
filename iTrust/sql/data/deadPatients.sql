/* **************************************************************
 PATIENT ID / GENDER / OFFICE VISIT DATE / DEATH CODE / DEATH DESCRIPTION

 <Already existed previously>
 2 / M / 1985-10-10 -...- 2005-10-10 -...- 2007-06-10 / 250.10 / Diabetes with ketoacidosis

 <New dead patients>
 2001 / F / 2007-03-10 / 250.10 / Diabetes with ketoacidosis
 2002 / M / 2005-03-10 / 250.10 / Diabetes with ketoacidosis
 2003 / M / 2005-03-10 / 250.10 / Diabetes with ketoacidosis
 2004 / F / 2007-03-10 / 487.00 / Influenza
 2005 / F / 2007-03-10 / 487.00 / Influenza
 2006 / M / 2007-03-10 / 487.00 / Influenza
 2007 / M / 2004-03-10 / 84.50 / Malaria
 2008 / M / 2004-03-10 / 84.50 / Malaria
 2009 / M / 2007-03-10 / 72.00 / Mumps
 ************************************************************** */


/* ******************************* */
/* PATIENT 2001 */
/* ******************************* */
INSERT INTO patients
(MID,
 firstName,
 lastName,
 email,
 address1,
 address2,
 city,
 state,
 zip,
 phone,
 eName,
 ePhone,
 iCName,
 iCAddress1,
 iCAddress2,
 iCCity,
 ICState,
 iCZip,
 iCPhone,
 iCID,
 DateOfBirth,
 DateOfDeath,
 CauseOfDeath,
 MotherMID,
 FatherMID,
 BloodType,
 Ethnicity,
 Gender,
 TopicalNotes
)
VALUES (
  2001,
  'Sandy1',
  'Programmer',
  'andy.programmer1@gmail.com',
  '344 Bob Street',
  '',
  'Raleigh',
  'NC',
  '27607',
  '555-555-5555',
  'Mr Emergency',
  '555-555-5551',
  'IC',
  'Street1',
  'Street2',
  'City',
  'PA',
  '19003-2715',
  '555-555-5555',
  '1',
  '1984-05-19',
  '2005-03-10',
  '250.10',
  1,
  0,
  'O-',
  'Caucasian',
  'Female',
  'This person is absolutely crazy. Do not touch them.'
)  ON DUPLICATE KEY UPDATE MID = MID;

INSERT INTO users(MID, password, role, sQuestion, sAnswer)
VALUES (2001, '30c952fab122c3f9759f02a6d95c3758b246b4fee239957b2d4fee46e26170c4', 'patient', 'how you doin?', 'good')
ON DUPLICATE KEY UPDATE MID = MID;
/*password: pw*/

INSERT INTO officevisits(id,visitDate,HCPID,notes,HospitalID,PatientID)
VALUES (20010,'2007-03-10',9000000000,'Yet another office visit.','1',2001)
ON DUPLICATE KEY UPDATE id = id;




/* ******************************* */
/* PATIENT 2002 */
/* ******************************* */
INSERT INTO patients
(MID,
 firstName,
 lastName,
 email,
 address1,
 address2,
 city,
 state,
 zip,
 phone,
 eName,
 ePhone,
 iCName,
 iCAddress1,
 iCAddress2,
 iCCity,
 ICState,
 iCZip,
 iCPhone,
 iCID,
 DateOfBirth,
 DateOfDeath,
 CauseOfDeath,
 MotherMID,
 FatherMID,
 BloodType,
 Ethnicity,
 Gender,
 TopicalNotes
)
VALUES (
  2002,
  'Andy2',
  'Programmer',
  'andy.programmer1@gmail.com',
  '344 Bob Street',
  '',
  'Raleigh',
  'NC',
  '27607',
  '555-555-5555',
  'Mr Emergency',
  '555-555-5551',
  'IC',
  'Street1',
  'Street2',
  'City',
  'PA',
  '19003-2715',
  '555-555-5555',
  '1',
  '1984-05-19',
  '2005-03-10',
  '250.10',
  1,
  0,
  'O-',
  'Caucasian',
  'Male',
  'This person is absolutely crazy. Do not touch them.'
)  ON DUPLICATE KEY UPDATE MID = MID;

INSERT INTO users(MID, password, role, sQuestion, sAnswer)
VALUES (2002, '30c952fab122c3f9759f02a6d95c3758b246b4fee239957b2d4fee46e26170c4', 'patient', 'how you doin?', 'good')
ON DUPLICATE KEY UPDATE MID = MID;
/*password: pw*/

INSERT INTO officevisits(id,visitDate,HCPID,notes,HospitalID,PatientID)
VALUES (20020,'2005-03-10',9000000000,'Yet another office visit.','1',2002)
ON DUPLICATE KEY UPDATE id = id;




/* ******************************* */
/* PATIENT 2003 */
/* ******************************* */
INSERT INTO patients
(MID,
 firstName,
 lastName,
 email,
 address1,
 address2,
 city,
 state,
 zip,
 phone,
 eName,
 ePhone,
 iCName,
 iCAddress1,
 iCAddress2,
 iCCity,
 ICState,
 iCZip,
 iCPhone,
 iCID,
 DateOfBirth,
 DateOfDeath,
 CauseOfDeath,
 MotherMID,
 FatherMID,
 BloodType,
 Ethnicity,
 Gender,
 TopicalNotes
)
VALUES (
  2003,
  'Andy3',
  'Programmer',
  'andy.programmer1@gmail.com',
  '344 Bob Street',
  '',
  'Raleigh',
  'NC',
  '27607',
  '555-555-5555',
  'Mr Emergency',
  '555-555-5551',
  'IC',
  'Street1',
  'Street2',
  'City',
  'PA',
  '19003-2715',
  '555-555-5555',
  '1',
  '1984-05-19',
  '2005-03-10',
  '250.10',
  1,
  0,
  'O-',
  'Caucasian',
  'Male',
  'This person is absolutely crazy. Do not touch them.'
)  ON DUPLICATE KEY UPDATE MID = MID;

INSERT INTO users(MID, password, role, sQuestion, sAnswer)
VALUES (2003, '30c952fab122c3f9759f02a6d95c3758b246b4fee239957b2d4fee46e26170c4', 'patient', 'how you doin?', 'good')
ON DUPLICATE KEY UPDATE MID = MID;
/*password: pw*/

INSERT INTO officevisits(id,visitDate,HCPID,notes,HospitalID,PatientID)
VALUES (20030,'2005-03-10',9000000000,'Yet another office visit.','1',2003)
ON DUPLICATE KEY UPDATE id = id;




/* ******************************* */
/* PATIENT 2004 */
/* ******************************* */
INSERT INTO patients
(MID,
 firstName,
 lastName,
 email,
 address1,
 address2,
 city,
 state,
 zip,
 phone,
 eName,
 ePhone,
 iCName,
 iCAddress1,
 iCAddress2,
 iCCity,
 ICState,
 iCZip,
 iCPhone,
 iCID,
 DateOfBirth,
 DateOfDeath,
 CauseOfDeath,
 MotherMID,
 FatherMID,
 BloodType,
 Ethnicity,
 Gender,
 TopicalNotes
)
VALUES (
  2004,
  'Sandy4',
  'Programmer',
  'andy.programmer1@gmail.com',
  '344 Bob Street',
  '',
  'Raleigh',
  'NC',
  '27607',
  '555-555-5555',
  'Mr Emergency',
  '555-555-5551',
  'IC',
  'Street1',
  'Street2',
  'City',
  'PA',
  '19003-2715',
  '555-555-5555',
  '1',
  '1984-05-19',
  '2005-03-10',
  '487.00',
  1,
  0,
  'O-',
  'Caucasian',
  'Female',
  'This person is absolutely crazy. Do not touch them.'
)  ON DUPLICATE KEY UPDATE MID = MID;

INSERT INTO users(MID, password, role, sQuestion, sAnswer)
VALUES (2004, '30c952fab122c3f9759f02a6d95c3758b246b4fee239957b2d4fee46e26170c4', 'patient', 'how you doin?', 'good')
ON DUPLICATE KEY UPDATE MID = MID;
/*password: pw*/

INSERT INTO officevisits(id,visitDate,HCPID,notes,HospitalID,PatientID)
VALUES (20040,'2007-03-10',9000000000,'Yet another office visit.','1',2004)
ON DUPLICATE KEY UPDATE id = id;




/* ******************************* */
/* PATIENT 2005 */
/* ******************************* */
INSERT INTO patients
(MID,
 firstName,
 lastName,
 email,
 address1,
 address2,
 city,
 state,
 zip,
 phone,
 eName,
 ePhone,
 iCName,
 iCAddress1,
 iCAddress2,
 iCCity,
 ICState,
 iCZip,
 iCPhone,
 iCID,
 DateOfBirth,
 DateOfDeath,
 CauseOfDeath,
 MotherMID,
 FatherMID,
 BloodType,
 Ethnicity,
 Gender,
 TopicalNotes
)
VALUES (
  2005,
  'Sandy5',
  'Programmer',
  'andy.programmer1@gmail.com',
  '344 Bob Street',
  '',
  'Raleigh',
  'NC',
  '27607',
  '555-555-5555',
  'Mr Emergency',
  '555-555-5551',
  'IC',
  'Street1',
  'Street2',
  'City',
  'PA',
  '19003-2715',
  '555-555-5555',
  '1',
  '1984-05-19',
  '2005-03-10',
  '487.00',
  1,
  0,
  'O-',
  'Caucasian',
  'Female',
  'This person is absolutely crazy. Do not touch them.'
)  ON DUPLICATE KEY UPDATE MID = MID;

INSERT INTO users(MID, password, role, sQuestion, sAnswer)
VALUES (2005, '30c952fab122c3f9759f02a6d95c3758b246b4fee239957b2d4fee46e26170c4', 'patient', 'how you doin?', 'good')
ON DUPLICATE KEY UPDATE MID = MID;
/*password: pw*/

INSERT INTO officevisits(id,visitDate,HCPID,notes,HospitalID,PatientID)
VALUES (20050,'2007-03-10',9000000000,'Yet another office visit.','1',2005)
ON DUPLICATE KEY UPDATE id = id;




/* ******************************* */
/* PATIENT 2006 */
/* ******************************* */
INSERT INTO patients
(MID,
 firstName,
 lastName,
 email,
 address1,
 address2,
 city,
 state,
 zip,
 phone,
 eName,
 ePhone,
 iCName,
 iCAddress1,
 iCAddress2,
 iCCity,
 ICState,
 iCZip,
 iCPhone,
 iCID,
 DateOfBirth,
 DateOfDeath,
 CauseOfDeath,
 MotherMID,
 FatherMID,
 BloodType,
 Ethnicity,
 Gender,
 TopicalNotes
)
VALUES (
  2006,
  'Andy6',
  'Programmer',
  'andy.programmer1@gmail.com',
  '344 Bob Street',
  '',
  'Raleigh',
  'NC',
  '27607',
  '555-555-5555',
  'Mr Emergency',
  '555-555-5551',
  'IC',
  'Street1',
  'Street2',
  'City',
  'PA',
  '19003-2715',
  '555-555-5555',
  '1',
  '1984-05-19',
  '2005-03-10',
  '487.00',
  1,
  0,
  'O-',
  'Caucasian',
  'Male',
  'This person is absolutely crazy. Do not touch them.'
)  ON DUPLICATE KEY UPDATE MID = MID;

INSERT INTO users(MID, password, role, sQuestion, sAnswer)
VALUES (2006, '30c952fab122c3f9759f02a6d95c3758b246b4fee239957b2d4fee46e26170c4', 'patient', 'how you doin?', 'good')
ON DUPLICATE KEY UPDATE MID = MID;
/*password: pw*/

INSERT INTO officevisits(id,visitDate,HCPID,notes,HospitalID,PatientID)
VALUES (20060,'2007-03-10',9000000000,'Yet another office visit.','1',2006)
ON DUPLICATE KEY UPDATE id = id;




/* ******************************* */
/* PATIENT 2007 */
/* ******************************* */
INSERT INTO patients
(MID,
 firstName,
 lastName,
 email,
 address1,
 address2,
 city,
 state,
 zip,
 phone,
 eName,
 ePhone,
 iCName,
 iCAddress1,
 iCAddress2,
 iCCity,
 ICState,
 iCZip,
 iCPhone,
 iCID,
 DateOfBirth,
 DateOfDeath,
 CauseOfDeath,
 MotherMID,
 FatherMID,
 BloodType,
 Ethnicity,
 Gender,
 TopicalNotes
)
VALUES (
  2007,
  'Andy7',
  'Programmer',
  'andy.programmer1@gmail.com',
  '344 Bob Street',
  '',
  'Raleigh',
  'NC',
  '27607',
  '555-555-5555',
  'Mr Emergency',
  '555-555-5551',
  'IC',
  'Street1',
  'Street2',
  'City',
  'PA',
  '19003-2715',
  '555-555-5555',
  '1',
  '1984-05-19',
  '2005-03-10',
  '84.50',
  1,
  0,
  'O-',
  'Caucasian',
  'Male',
  'This person is absolutely crazy. Do not touch them.'
)  ON DUPLICATE KEY UPDATE MID = MID;

INSERT INTO users(MID, password, role, sQuestion, sAnswer)
VALUES (2007, '30c952fab122c3f9759f02a6d95c3758b246b4fee239957b2d4fee46e26170c4', 'patient', 'how you doin?', 'good')
ON DUPLICATE KEY UPDATE MID = MID;
/*password: pw*/

INSERT INTO officevisits(id,visitDate,HCPID,notes,HospitalID,PatientID)
VALUES (20070,'2004-03-10',9000000000,'Yet another office visit.','1',2007)
ON DUPLICATE KEY UPDATE id = id;




/* ******************************* */
/* PATIENT 2008 */
/* ******************************* */
INSERT INTO patients
(MID,
 firstName,
 lastName,
 email,
 address1,
 address2,
 city,
 state,
 zip,
 phone,
 eName,
 ePhone,
 iCName,
 iCAddress1,
 iCAddress2,
 iCCity,
 ICState,
 iCZip,
 iCPhone,
 iCID,
 DateOfBirth,
 DateOfDeath,
 CauseOfDeath,
 MotherMID,
 FatherMID,
 BloodType,
 Ethnicity,
 Gender,
 TopicalNotes
)
VALUES (
  2008,
  'Andy8',
  'Programmer',
  'andy.programmer1@gmail.com',
  '344 Bob Street',
  '',
  'Raleigh',
  'NC',
  '27607',
  '555-555-5555',
  'Mr Emergency',
  '555-555-5551',
  'IC',
  'Street1',
  'Street2',
  'City',
  'PA',
  '19003-2715',
  '555-555-5555',
  '1',
  '1984-05-19',
  '2005-03-10',
  '84.50',
  1,
  0,
  'O-',
  'Caucasian',
  'Male',
  'This person is absolutely crazy. Do not touch them.'
)  ON DUPLICATE KEY UPDATE MID = MID;

INSERT INTO users(MID, password, role, sQuestion, sAnswer)
VALUES (2008, '30c952fab122c3f9759f02a6d95c3758b246b4fee239957b2d4fee46e26170c4', 'patient', 'how you doin?', 'good')
ON DUPLICATE KEY UPDATE MID = MID;
/*password: pw*/

INSERT INTO officevisits(id,visitDate,HCPID,notes,HospitalID,PatientID)
VALUES (20080,'2004-03-10',9000000000,'Yet another office visit.','1',2008)
ON DUPLICATE KEY UPDATE id = id;




/* ******************************* */
/* PATIENT 2009 */
/* ******************************* */
INSERT INTO patients
(MID,
 firstName,
 lastName,
 email,
 address1,
 address2,
 city,
 state,
 zip,
 phone,
 eName,
 ePhone,
 iCName,
 iCAddress1,
 iCAddress2,
 iCCity,
 ICState,
 iCZip,
 iCPhone,
 iCID,
 DateOfBirth,
 DateOfDeath,
 CauseOfDeath,
 MotherMID,
 FatherMID,
 BloodType,
 Ethnicity,
 Gender,
 TopicalNotes
)
VALUES (
  2009,
  'Andy9',
  'Programmer',
  'andy.programmer1@gmail.com',
  '344 Bob Street',
  '',
  'Raleigh',
  'NC',
  '27607',
  '555-555-5555',
  'Mr Emergency',
  '555-555-5551',
  'IC',
  'Street1',
  'Street2',
  'City',
  'PA',
  '19003-2715',
  '555-555-5555',
  '1',
  '1984-05-19',
  '2005-03-10',
  '72.00',
  1,
  0,
  'O-',
  'Caucasian',
  'Male',
  'This person is absolutely crazy. Do not touch them.'
)  ON DUPLICATE KEY UPDATE MID = MID;

INSERT INTO users(MID, password, role, sQuestion, sAnswer)
VALUES (2009, '30c952fab122c3f9759f02a6d95c3758b246b4fee239957b2d4fee46e26170c4', 'patient', 'how you doin?', 'good')
ON DUPLICATE KEY UPDATE MID = MID;
/*password: pw*/

INSERT INTO officevisits(id,visitDate,HCPID,notes,HospitalID,PatientID)
VALUES (20090,'2007-03-10',9000000000,'Yet another office visit.','1',2009)
ON DUPLICATE KEY UPDATE id = id;

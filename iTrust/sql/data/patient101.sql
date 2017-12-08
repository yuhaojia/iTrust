INSERT INTO patients
(MID,
lastName,
firstName,
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
dateofbirth,
mothermid,
fathermid,
bloodtype,
ethnicity,
gender,
topicalnotes)
VALUES
(101,
'Appt',
'Reminder',
'appt@reminder.com',
'1247 Noname Dr',
'Suite 106',
'Raleigh',
'NC',
'27606-1234',
'919-971-0000',
'Mommy Person',
'704-532-2117',
'Aetna',
'1234 Aetna Blvd',
'Suite 602',
'Charlotte',
'NC',
'28215',
'704-555-1234',
'ChetumNHowe',
'1950-05-10',
0,
0,
'AB+',
'African American',
'Female',
'')
 ON DUPLICATE KEY UPDATE MID = MID;

INSERT INTO users(MID, password, role, sQuestion, sAnswer)
			VALUES (1, '30c952fab122c3f9759f02a6d95c3758b246b4fee239957b2d4fee46e26170c4', 'patient', 'what is your favorite color?', 'blue')
 ON DUPLICATE KEY UPDATE MID = MID;
 /*password: pw*/

INSERT INTO appointment(doctor_id,patient_id,sched_date,appt_type,comment)
VALUES
('9000000003', '101', CONCAT(YEAR(NOW())+1, '-04-03 15:00:00'), 'Physical', 'This is your yearly physical.');

INSERT INTO declaredhcp(PatientID,HCPID) VALUE(101, 9000000003)
 ON DUPLICATE KEY UPDATE PatientID = PatientID;

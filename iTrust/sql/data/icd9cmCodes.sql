INSERT INTO icdcodes(Code, Description, Chronic, URL) VALUES
('250.10', 'Diabetes with ketoacidosis', 'yes','https://en.wikipedia.org/wiki/Diabetic_ketoacidosis'),
('250.30','Diabetes with other coma', 'yes','https://en.wikipedia.org/wiki/Diabetic_coma'),
('487.00', 'Influenza', 'no',''),
('79.10', 'Echovirus', 'no','https://en.wikipedia.org/wiki/Echovirus'),
('84.50', 'Malaria', 'no','https://en.wikipedia.org/wiki/Malaria'),
('79.30', 'Coxsackie', 'yes','https://en.wikipedia.org/wiki/Coxsackievirus'),
('11.40', 'Tuberculosis of the lung', 'no','https://en.wikipedia.org/wiki/Tuberculosis#Pulmonary'),
('15.00', 'Tuberculosis of vertebral column', 'no','https://en.wikipedia.org/wiki/Tuberculosis'),
('42.00', 'Human Immunodeficiency Virus', 'yes','https://en.wikipedia.org/wiki/HIV'),
('70.10', 'Viral hepatitis A, infectious', 'yes','https://en.wikipedia.org/wiki/Hepatitis_A'),
('250.00','Acute Lycanthropy', 'yes','https://en.wikipedia.org/wiki/Clinical_lycanthropy'),
('715.09', 'Osteoarthrosis, generalized, multiple sites', 'yes','https://en.wikipedia.org/wiki/Osteoarthritis'),
('72.00','Mumps', 'no','https://en.wikipedia.org/wiki/Mumps')  ON DUPLICATE KEY UPDATE Code = Code;
INSERT INTO icdcodes(Code, Description, Chronic, URL, Ophthalmology) VALUES
('26.8', 'Cataracts', 'yes','https://en.wikipedia.org/wiki/Cataract','yes'),
('35.30','Age-Related Macular Degeneration', 'yes','https://en.wikipedia.org/wiki/Macular_degeneration','yes'),
('35.001', 'Amblyopia', 'no','https://en.wikipedia.org/wiki/Amblyopia','yes'),
('40.89', 'Glaucoma', 'no','https://en.wikipedia.org/wiki/Glaucoma','yes') ON DUPLICATE KEY UPDATE Code = Code;
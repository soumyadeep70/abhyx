-- 130_aptitude_data_interpretation.sql
-- Topic: Data Interpretation (aptitude) -- 25 questions.
-- Idempotent: re-running updates these rows in place (matched on topic + title).
-- Requires the helpers in 010_question_helpers.sql (run in the same session by `npm run seed`).

-- 01 | easy | Weekly Sales Total
SELECT pg_temp.seed_aptitude($q$Data Interpretation$q$, 'easy', $q$Weekly Sales Total$q$, $q$The number of units sold by a shop on five days is given below.

Day | Mon | Tue | Wed | Thu | Fri
Units | 120 | 150 | 90 | 180 | 160

What is the total number of units sold over the five days?$q$,
  $j$["650","690","700","720"]$j$::jsonb, $q$700$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['tables','totals']::text[]);

-- 02 | easy | Students Choosing Science
SELECT pg_temp.seed_aptitude($q$Data Interpretation$q$, 'easy', $q$Students Choosing Science$q$, $q$A college has 500 students. 36% of them have chosen the Science stream. How many students chose Science?$q$,
  $j$["150","180","190","216"]$j$::jsonb, $q$180$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['percentages']::text[]);

-- 03 | easy | Average Marks
SELECT pg_temp.seed_aptitude($q$Data Interpretation$q$, 'easy', $q$Average Marks$q$, $q$A student's marks in five subjects are: 72, 68, 85, 90, 75. What is the average mark per subject?$q$,
  $j$["75","76","78","80"]$j$::jsonb, $q$78$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['averages']::text[]);

-- 04 | easy | Production Growth
SELECT pg_temp.seed_aptitude($q$Data Interpretation$q$, 'easy', $q$Production Growth$q$, $q$A factory produced 400 units in 2019 and 460 units in 2020. What is the percentage increase in production?$q$,
  $j$["12%","13.04%","15%","60%"]$j$::jsonb, $q$15%$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['percentage-change']::text[]);

-- 05 | easy | Revenue Ratio
SELECT pg_temp.seed_aptitude($q$Data Interpretation$q$, 'easy', $q$Revenue Ratio$q$, $q$Company A earned Rs. 240 crore and Company B earned Rs. 180 crore in a year. What is the ratio of A's revenue to B's revenue in its simplest form?$q$,
  $j$["3 : 2","4 : 3","5 : 4","6 : 5"]$j$::jsonb, $q$4 : 3$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['ratio']::text[]);

-- 06 | easy | Budget Pie Chart
SELECT pg_temp.seed_aptitude($q$Data Interpretation$q$, 'easy', $q$Budget Pie Chart$q$, $q$A family's monthly income of Rs. 60,000 is spent as follows: Rent 30%, Food 25%, Transport 15%, Savings 20%, Others 10%. How much is spent on Food each month?$q$,
  $j$["Rs. 18,000","Rs. 12,000","Rs. 15,000","Rs. 9,000"]$j$::jsonb, $q$Rs. 15,000$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['pie-chart','percentages']::text[]);

-- 07 | easy | Largest Daily Temperature Change
SELECT pg_temp.seed_aptitude($q$Data Interpretation$q$, 'easy', $q$Largest Daily Temperature Change$q$, $q$Noon temperatures (in °C) recorded on five consecutive days:

Day | Mon | Tue | Wed | Thu | Fri
Temp | 24 | 27 | 22 | 29 | 26

Between which two consecutive days was the change in temperature the largest?$q$,
  $j$["Thursday to Friday","Wednesday to Thursday","Tuesday to Wednesday","Monday to Tuesday"]$j$::jsonb, $q$Wednesday to Thursday$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['tables','line-graph']::text[]);

-- 08 | easy | Quarterly Revenue Share
SELECT pg_temp.seed_aptitude($q$Data Interpretation$q$, 'easy', $q$Quarterly Revenue Share$q$, $q$A company's revenue (in Rs. lakh) in the four quarters of a year was: Q1 = 20, Q2 = 25, Q3 = 30, Q4 = 25. What percentage of the annual revenue was earned in Q3?$q$,
  $j$["25%","28%","30%","35%"]$j$::jsonb, $q$30%$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['tables','percentages']::text[]);

-- 09 | medium | Highest Profit Ratio
SELECT pg_temp.seed_aptitude($q$Data Interpretation$q$, 'medium', $q$Highest Profit Ratio$q$, $q$Profits (in Rs. crore) of two companies X and Y:

Year | 2019 | 2020 | 2021 | 2022
X | 40 | 50 | 66 | 72
Y | 32 | 40 | 48 | 60

In which year was the ratio of X's profit to Y's profit the highest?$q$,
  $j$["2019","2020","2021","2022"]$j$::jsonb, $q$2021$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['tables','ratio']::text[]);

-- 10 | medium | Highest Percentage Growth
SELECT pg_temp.seed_aptitude($q$Data Interpretation$q$, 'medium', $q$Highest Percentage Growth$q$, $q$Annual sales (in Rs. lakh) of a firm:

Year | 2018 | 2019 | 2020 | 2021 | 2022
Sales | 150 | 165 | 198 | 220 | 242

Between which two consecutive years was the percentage increase in sales the highest?$q$,
  $j$["2018 to 2019","2019 to 2020","2020 to 2021","2021 to 2022"]$j$::jsonb, $q$2019 to 2020$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['tables','percentage-change']::text[]);

-- 11 | medium | Combined Class Average
SELECT pg_temp.seed_aptitude($q$Data Interpretation$q$, 'medium', $q$Combined Class Average$q$, $q$Class A has 30 students with an average score of 60. Class B has 20 students with an average score of 70. What is the average score of all 50 students combined?$q$,
  $j$["63","64","65","66"]$j$::jsonb, $q$64$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['averages','weighted-average']::text[]);

-- 12 | medium | Pie Chart Angles
SELECT pg_temp.seed_aptitude($q$Data Interpretation$q$, 'medium', $q$Pie Chart Angles$q$, $q$A pie chart shows how a total expenditure of Rs. 2,40,000 is divided: Education 90°, Housing 120°, Food 60°, Others 90°. How much money is spent on Housing?$q$,
  $j$["Rs. 72,000","Rs. 60,000","Rs. 80,000","Rs. 90,000"]$j$::jsonb, $q$Rs. 80,000$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['pie-chart']::text[]);

-- 13 | medium | Overall Percentage Across Subjects
SELECT pg_temp.seed_aptitude($q$Data Interpretation$q$, 'medium', $q$Overall Percentage Across Subjects$q$, $q$Marks obtained by four students (maximum marks: Maths 100, Science 50, English 50):

Student | Maths | Science | English
P | 80 | 40 | 30
Q | 70 | 45 | 40
R | 90 | 35 | 25
S | 60 | 48 | 45

Who has the highest overall percentage?$q$,
  $j$["P (75%)","R (75%)","S (76.5%)","Q (77.5%)"]$j$::jsonb, $q$Q (77.5%)$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['tables','percentages']::text[]);

-- 14 | medium | Largest Trade Deficit
SELECT pg_temp.seed_aptitude($q$Data Interpretation$q$, 'medium', $q$Largest Trade Deficit$q$, $q$Exports and imports of a country (in Rs. crore):

Year | 2019 | 2020 | 2021 | 2022
Exports | 340 | 360 | 420 | 500
Imports | 410 | 380 | 520 | 540

In which year was the trade deficit (imports minus exports) the largest?$q$,
  $j$["2019","2020","2021","2022"]$j$::jsonb, $q$2021$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['tables']::text[]);

-- 15 | medium | Graduates Among Employees
SELECT pg_temp.seed_aptitude($q$Data Interpretation$q$, 'medium', $q$Graduates Among Employees$q$, $q$A company has 600 employees, of whom 55% are male. 40% of the males and 30% of the females are graduates. How many employees are graduates?$q$,
  $j$["198","210","213","230"]$j$::jsonb, $q$213$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['percentages']::text[]);

-- 16 | medium | Highest Average Speed
SELECT pg_temp.seed_aptitude($q$Data Interpretation$q$, 'medium', $q$Highest Average Speed$q$, $q$Four trips were made with the following distances and times:

Trip | A | B | C | D
Distance (km) | 120 | 150 | 200 | 195
Time (hours) | 2 | 3 | 4 | 3

Which trip had the highest average speed?$q$,
  $j$["Trip D","Trip C","Trip A","Trip B"]$j$::jsonb, $q$Trip D$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['tables','speed']::text[]);

-- 17 | medium | Percentage Points vs Percent
SELECT pg_temp.seed_aptitude($q$Data Interpretation$q$, 'medium', $q$Percentage Points vs Percent$q$, $q$The pass percentage of a school was 64% in 2021 and 72% in 2022. By what percent did the pass percentage increase in 2022 compared with 2021?$q$,
  $j$["8%","11.1%","12.5%","14%"]$j$::jsonb, $q$12.5%$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['percentage-change']::text[]);

-- 18 | medium | Salary Bands
SELECT pg_temp.seed_aptitude($q$Data Interpretation$q$, 'medium', $q$Salary Bands$q$, $q$The monthly salaries of 100 employees are distributed as follows:

Band (Rs.) | Employees
Below 20k | 15
20k-40k | 35
40k-60k | 30
Above 60k | 20

What percentage of employees earn less than Rs. 40,000?$q$,
  $j$["35%","45%","50%","65%"]$j$::jsonb, $q$50%$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['tables','frequency']::text[]);

-- 19 | medium | Average of Selected Months
SELECT pg_temp.seed_aptitude($q$Data Interpretation$q$, 'medium', $q$Average of Selected Months$q$, $q$Monthly rainfall (in mm):

Month | Jan | Feb | Mar | Apr | May | Jun
Rain | 20 | 35 | 50 | 45 | 80 | 70

What is the average rainfall of only those months in which the rainfall exceeded 40 mm?$q$,
  $j$["50 mm","56.67 mm","61.25 mm","66.25 mm"]$j$::jsonb, $q$61.25 mm$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['tables','averages']::text[]);

-- 20 | hard | Shrinking Share, Growing Sales
SELECT pg_temp.seed_aptitude($q$Data Interpretation$q$, 'hard', $q$Shrinking Share, Growing Sales$q$, $q$A company's total sales were Rs. 500 crore in a year, of which Product X contributed 28%. The next year total sales rose by 20% but Product X's share fell to 25%. By how many crore rupees did Product X's sales increase?$q$,
  $j$["Rs. 28 crore","Rs. 5 crore","Rs. 15 crore","Rs. 10 crore"]$j$::jsonb, $q$Rs. 10 crore$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['percentages','pie-chart']::text[]);

-- 21 | hard | Girls Across Three Classes
SELECT pg_temp.seed_aptitude($q$Data Interpretation$q$, 'hard', $q$Girls Across Three Classes$q$, $q$The ratio of boys to girls in three classes is given below along with the total strength:

Class | Boys : Girls | Total students
I | 3 : 2 | 50
II | 4 : 5 | 90
III | 7 : 3 | 100

How many girls are there in the three classes together?$q$,
  $j$["90","100","110","120"]$j$::jsonb, $q$100$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['ratio','tables']::text[]);

-- 22 | hard | Chained Growth Rates
SELECT pg_temp.seed_aptitude($q$Data Interpretation$q$, 'hard', $q$Chained Growth Rates$q$, $q$A firm's revenue grew by 20% in year 1, fell by 10% in year 2 and grew by 25% in year 3. If the revenue at the end of year 3 is Rs. 135 lakh, what was the revenue at the start of year 1?$q$,
  $j$["Rs. 90 lakh","Rs. 100 lakh","Rs. 120 lakh","Rs. 108 lakh"]$j$::jsonb, $q$Rs. 100 lakh$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['percentage-change']::text[]);

-- 23 | hard | Science minus Commerce Enrolment
SELECT pg_temp.seed_aptitude($q$Data Interpretation$q$, 'hard', $q$Science minus Commerce Enrolment$q$, $q$Number of students enrolled in three streams in three colleges:

College | Arts | Science | Commerce
P | 120 | 180 | 100
Q | 150 | 120 | 130
R | 90 | 200 | 110

How many more students are enrolled in Science than in Commerce across all three colleges?$q$,
  $j$["140","150","160","180"]$j$::jsonb, $q$160$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['tables','totals']::text[]);

-- 24 | hard | Profit from Cost Structure
SELECT pg_temp.seed_aptitude($q$Data Interpretation$q$, 'hard', $q$Profit from Cost Structure$q$, $q$A manufacturer has fixed costs of Rs. 60,000. Each unit costs Rs. 40 to make and is sold for Rs. 100. What is the profit if 1,500 units are sold?$q$,
  $j$["Rs. 30,000","Rs. 90,000","Rs. 1,50,000","Rs. 60,000"]$j$::jsonb, $q$Rs. 30,000$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['profit-loss','cost']::text[]);

-- 25 | hard | Survey Satisfaction
SELECT pg_temp.seed_aptitude($q$Data Interpretation$q$, 'hard', $q$Survey Satisfaction$q$, $q$In a survey of 800 respondents, 40% are from City A, 35% from City B and the rest from City C. The percentage who said they were satisfied was 70% in City A, 60% in City B and 80% in City C. How many respondents in total said they were satisfied?$q$,
  $j$["528","552","560","576"]$j$::jsonb, $q$552$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['percentages','weighted-average']::text[]);


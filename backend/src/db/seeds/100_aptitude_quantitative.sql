-- 100_aptitude_quantitative.sql
-- Topic: Quantitative Aptitude (aptitude) -- 25 questions.
-- Idempotent: re-running updates these rows in place (matched on topic + title).
-- Requires the helpers in 010_question_helpers.sql (run in the same session by `npm run seed`).

-- 01 | easy | Simple Interest Basics
SELECT pg_temp.seed_aptitude($q$Quantitative Aptitude$q$, 'easy', $q$Simple Interest Basics$q$, $q$A sum of money doubles itself in 8 years at simple interest. In how many years will it triple?$q$,
  $j$["12 years","16 years","20 years","24 years"]$j$::jsonb, $q$16 years$q$,
  ARRAY['TCS']::text[], ARRAY['simple-interest']::text[]);

-- 02 | easy | Percentage Up Then Down
SELECT pg_temp.seed_aptitude($q$Quantitative Aptitude$q$, 'easy', $q$Percentage Up Then Down$q$, $q$The price of an article is first increased by 20% and then decreased by 20%. What is the net change in the price?$q$,
  $j$["2% decrease","4% decrease","No change","4% increase"]$j$::jsonb, $q$4% decrease$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['percentages']::text[]);

-- 03 | easy | Average After Adding a Number
SELECT pg_temp.seed_aptitude($q$Quantitative Aptitude$q$, 'easy', $q$Average After Adding a Number$q$, $q$The average of five numbers is 27. When a sixth number is added, the average becomes 29. What is the sixth number?$q$,
  $j$["29","35","39","45"]$j$::jsonb, $q$39$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['averages']::text[]);

-- 04 | easy | Sharing in a Ratio
SELECT pg_temp.seed_aptitude($q$Quantitative Aptitude$q$, 'easy', $q$Sharing in a Ratio$q$, $q$Rs. 1,050 is divided among A, B and C in the ratio 2 : 3 : 5. What is C's share?$q$,
  $j$["Rs. 420","Rs. 315","Rs. 525","Rs. 210"]$j$::jsonb, $q$Rs. 525$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['ratio-proportion']::text[]);

-- 05 | easy | LCM of Three Numbers
SELECT pg_temp.seed_aptitude($q$Quantitative Aptitude$q$, 'easy', $q$LCM of Three Numbers$q$, $q$What is the LCM of 12, 18 and 30?$q$,
  $j$["90","120","180","360"]$j$::jsonb, $q$180$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['lcm-hcf']::text[]);

-- 06 | easy | Profit Percentage
SELECT pg_temp.seed_aptitude($q$Quantitative Aptitude$q$, 'easy', $q$Profit Percentage$q$, $q$An article bought for Rs. 800 is sold for Rs. 920. What is the profit percentage?$q$,
  $j$["12%","14%","15%","20%"]$j$::jsonb, $q$15%$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['profit-loss']::text[]);

-- 07 | easy | Two Workers Together
SELECT pg_temp.seed_aptitude($q$Quantitative Aptitude$q$, 'easy', $q$Two Workers Together$q$, $q$A can complete a job in 12 days and B can complete it in 15 days. Working together, in how many days will they complete it?$q$,
  $j$["6 2/3 days","6 days","7 1/2 days","13 1/2 days"]$j$::jsonb, $q$6 2/3 days$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['time-and-work']::text[]);

-- 08 | easy | Unit Digit of a Power
SELECT pg_temp.seed_aptitude($q$Quantitative Aptitude$q$, 'easy', $q$Unit Digit of a Power$q$, $q$What is the unit digit of 7^123?$q$,
  $j$["1","3","7","9"]$j$::jsonb, $q$3$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['number-system']::text[]);

-- 09 | medium | Train Speed Problem
SELECT pg_temp.seed_aptitude($q$Quantitative Aptitude$q$, 'medium', $q$Train Speed Problem$q$, $q$Two trains 120m and 180m long run at 54 km/hr and 36 km/hr in opposite directions. In how many seconds will they cross each other?$q$,
  $j$["10s","12s","14s","16s"]$j$::jsonb, $q$12s$q$,
  ARRAY['TCS']::text[], ARRAY['time-speed-distance']::text[]);

-- 10 | medium | Compound Interest Two Years
SELECT pg_temp.seed_aptitude($q$Quantitative Aptitude$q$, 'medium', $q$Compound Interest Two Years$q$, $q$What is the compound interest on Rs. 8,000 for 2 years at 10% per annum, compounded annually?$q$,
  $j$["Rs. 1,600","Rs. 1,720","Rs. 1,640","Rs. 1,680"]$j$::jsonb, $q$Rs. 1,680$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['compound-interest']::text[]);

-- 11 | medium | Boat Round Trip
SELECT pg_temp.seed_aptitude($q$Quantitative Aptitude$q$, 'medium', $q$Boat Round Trip$q$, $q$A boat goes 60 km downstream and returns the same 60 km upstream. Its speed in still water is 15 km/h and the stream flows at 5 km/h. How long does the whole round trip take?$q$,
  $j$["6 hours","8 hours","9 hours","10 hours"]$j$::jsonb, $q$9 hours$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['boats-streams']::text[]);

-- 12 | medium | Alligation: Equalising a Mixture
SELECT pg_temp.seed_aptitude($q$Quantitative Aptitude$q$, 'medium', $q$Alligation: Equalising a Mixture$q$, $q$A 60-litre mixture contains milk and water in the ratio 2 : 1. How much water must be added to make the ratio of milk to water 1 : 1?$q$,
  $j$["10 litres","15 litres","20 litres","30 litres"]$j$::jsonb, $q$20 litres$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['mixtures-alligation']::text[]);

-- 13 | medium | Pipes and Leak
SELECT pg_temp.seed_aptitude($q$Quantitative Aptitude$q$, 'medium', $q$Pipes and Leak$q$, $q$Pipe A fills a tank in 10 hours and pipe B fills it in 15 hours. An outlet pipe C empties the full tank in 30 hours. If all three are opened together, how long will the empty tank take to fill?$q$,
  $j$["6 hours","7.5 hours","9 hours","12 hours"]$j$::jsonb, $q$7.5 hours$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['pipes-cisterns']::text[]);

-- 14 | medium | Arrangements of LEVEL
SELECT pg_temp.seed_aptitude($q$Quantitative Aptitude$q$, 'medium', $q$Arrangements of LEVEL$q$, $q$In how many distinct ways can the letters of the word LEVEL be arranged?$q$,
  $j$["24","30","60","120"]$j$::jsonb, $q$30$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['permutations']::text[]);

-- 15 | medium | Dice Sum Probability
SELECT pg_temp.seed_aptitude($q$Quantitative Aptitude$q$, 'medium', $q$Dice Sum Probability$q$, $q$Two fair dice are thrown together. What is the probability that the sum of the numbers shown is 8?$q$,
  $j$["1/6","1/9","5/36","7/36"]$j$::jsonb, $q$5/36$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['probability']::text[]);

-- 16 | medium | Father and Son Ages
SELECT pg_temp.seed_aptitude($q$Quantitative Aptitude$q$, 'medium', $q$Father and Son Ages$q$, $q$A father is three times as old as his son. After 12 years he will be twice as old as his son. What is the father's present age?$q$,
  $j$["30 years","36 years","42 years","48 years"]$j$::jsonb, $q$36 years$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['ages']::text[]);

-- 17 | medium | Successive Discounts
SELECT pg_temp.seed_aptitude($q$Quantitative Aptitude$q$, 'medium', $q$Successive Discounts$q$, $q$A shirt marked at Rs. 1,000 is sold after successive discounts of 20% and 10%. What is the selling price?$q$,
  $j$["Rs. 700","Rs. 750","Rs. 720","Rs. 770"]$j$::jsonb, $q$Rs. 720$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['discount']::text[]);

-- 18 | medium | Partnership with Different Durations
SELECT pg_temp.seed_aptitude($q$Quantitative Aptitude$q$, 'medium', $q$Partnership with Different Durations$q$, $q$A invests Rs. 6,000 for 12 months and B invests Rs. 8,000 for 9 months in a business. The profit at the end is Rs. 13,000. What is A's share?$q$,
  $j$["Rs. 5,570","Rs. 6,500","Rs. 7,800","Rs. 7,429"]$j$::jsonb, $q$Rs. 6,500$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['partnership']::text[]);

-- 19 | medium | Average Speed for a Round Trip
SELECT pg_temp.seed_aptitude($q$Quantitative Aptitude$q$, 'medium', $q$Average Speed for a Round Trip$q$, $q$A car travels from city P to city Q at 60 km/h and returns along the same road at 40 km/h. What is its average speed for the whole journey?$q$,
  $j$["45 km/h","48 km/h","50 km/h","52 km/h"]$j$::jsonb, $q$48 km/h$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['time-speed-distance','averages']::text[]);

-- 20 | hard | CI minus SI Difference
SELECT pg_temp.seed_aptitude($q$Quantitative Aptitude$q$, 'hard', $q$CI minus SI Difference$q$, $q$What is the difference between the compound interest and the simple interest on Rs. 5,000 for 2 years at 8% per annum?$q$,
  $j$["Rs. 16","Rs. 64","Rs. 32","Rs. 40"]$j$::jsonb, $q$Rs. 32$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['compound-interest','simple-interest']::text[]);

-- 21 | hard | Work Done in Pairs
SELECT pg_temp.seed_aptitude($q$Quantitative Aptitude$q$, 'hard', $q$Work Done in Pairs$q$, $q$A and B together can finish a job in 12 days, B and C together in 15 days, and C and A together in 20 days. In how many days can A alone finish it?$q$,
  $j$["20 days","24 days","30 days","40 days"]$j$::jsonb, $q$30 days$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['time-and-work']::text[]);

-- 22 | hard | Trailing Zeros in a Factorial
SELECT pg_temp.seed_aptitude($q$Quantitative Aptitude$q$, 'hard', $q$Trailing Zeros in a Factorial$q$, $q$How many trailing zeros are there in 100! ?$q$,
  $j$["20","22","24","25"]$j$::jsonb, $q$24$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['number-system']::text[]);

-- 23 | hard | Number of Divisors
SELECT pg_temp.seed_aptitude($q$Quantitative Aptitude$q$, 'hard', $q$Number of Divisors$q$, $q$How many positive divisors does 360 have?$q$,
  $j$["18","20","24","30"]$j$::jsonb, $q$24$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['number-system']::text[]);

-- 24 | hard | Race Beaten-By Chain
SELECT pg_temp.seed_aptitude($q$Quantitative Aptitude$q$, 'hard', $q$Race Beaten-By Chain$q$, $q$In a 1 km race, A beats B by 100 m and B beats C by 100 m. By how many metres does A beat C?$q$,
  $j$["180 m","190 m","200 m","210 m"]$j$::jsonb, $q$190 m$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['races']::text[]);

-- 25 | hard | Same-Colour Draw
SELECT pg_temp.seed_aptitude($q$Quantitative Aptitude$q$, 'hard', $q$Same-Colour Draw$q$, $q$A bag has 5 red and 4 blue balls. Two balls are drawn at random without replacement. What is the probability that both are of the same colour?$q$,
  $j$["1/2","2/9","4/9","5/9"]$j$::jsonb, $q$4/9$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['probability','combinations']::text[]);


-- 110_aptitude_logical_reasoning.sql
-- Topic: Logical Reasoning (aptitude) -- 25 questions.
-- Idempotent: re-running updates these rows in place (matched on topic + title).
-- Requires the helpers in 010_question_helpers.sql (run in the same session by `npm run seed`).

-- 01 | easy | Blood Relations
SELECT pg_temp.seed_aptitude($q$Logical Reasoning$q$, 'easy', $q$Blood Relations$q$, $q$Pointing to a man, a woman said, "His mother is the only daughter of my mother." How is the woman related to the man?$q$,
  $j$["Mother","Sister","Aunt","Grandmother"]$j$::jsonb, $q$Mother$q$,
  ARRAY['TCS']::text[], ARRAY['blood-relations']::text[]);

-- 02 | easy | Number Series: Products of Consecutive Integers
SELECT pg_temp.seed_aptitude($q$Logical Reasoning$q$, 'easy', $q$Number Series: Products of Consecutive Integers$q$, $q$Find the next term in the series: 2, 6, 12, 20, 30, ?$q$,
  $j$["36","40","42","44"]$j$::jsonb, $q$42$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['number-series']::text[]);

-- 03 | easy | Coding-Decoding: Shift by One
SELECT pg_temp.seed_aptitude($q$Logical Reasoning$q$, 'easy', $q$Coding-Decoding: Shift by One$q$, $q$In a certain code, CAT is written as DBU. How is DOG written in that code?$q$,
  $j$["DPH","EPG","CNF","EPH"]$j$::jsonb, $q$EPH$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['coding-decoding']::text[]);

-- 04 | easy | Odd One Out: Cubes
SELECT pg_temp.seed_aptitude($q$Logical Reasoning$q$, 'easy', $q$Odd One Out: Cubes$q$, $q$Find the odd one out: 8, 27, 64, 100, 125$q$,
  $j$["8","64","100","125"]$j$::jsonb, $q$100$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['odd-one-out']::text[]);

-- 05 | easy | Direction Sense: U-Turn Walk
SELECT pg_temp.seed_aptitude($q$Logical Reasoning$q$, 'easy', $q$Direction Sense: U-Turn Walk$q$, $q$A man walks 5 km north, turns right and walks 3 km, then turns right again and walks 5 km. How far and in which direction is he from his starting point?$q$,
  $j$["3 km East","3 km West","5 km East","13 km North-East"]$j$::jsonb, $q$3 km East$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['direction-sense']::text[]);

-- 06 | easy | Rank from the Bottom
SELECT pg_temp.seed_aptitude($q$Logical Reasoning$q$, 'easy', $q$Rank from the Bottom$q$, $q$In a class of 40 students, Rohit's rank from the top is 12. What is his rank from the bottom?$q$,
  $j$["27","28","29","30"]$j$::jsonb, $q$29$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['ranking']::text[]);

-- 07 | easy | Syllogism: Chain of All
SELECT pg_temp.seed_aptitude($q$Logical Reasoning$q$, 'easy', $q$Syllogism: Chain of All$q$, $q$Statements: All pens are books. All books are bags.
Conclusions:
I. All pens are bags.
II. Some bags are pens.
Which of the following is correct?$q$,
  $j$["Only I follows","Only II follows","Both I and II follow","Neither I nor II follows"]$j$::jsonb, $q$Both I and II follow$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['syllogism']::text[]);

-- 08 | easy | Alphabet Position
SELECT pg_temp.seed_aptitude($q$Logical Reasoning$q$, 'easy', $q$Alphabet Position$q$, $q$Which letter is the 5th to the right of the 10th letter from the left end of the English alphabet?$q$,
  $j$["P","O","N","T"]$j$::jsonb, $q$O$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['alphabet']::text[]);

-- 09 | medium | Calendar: Across a Leap Year
SELECT pg_temp.seed_aptitude($q$Logical Reasoning$q$, 'medium', $q$Calendar: Across a Leap Year$q$, $q$5 September 2023 fell on a Tuesday. On which day of the week will 5 September 2024 fall?$q$,
  $j$["Friday","Thursday","Wednesday","Saturday"]$j$::jsonb, $q$Thursday$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['calendar']::text[]);

-- 10 | medium | Clock Angle at 3:40
SELECT pg_temp.seed_aptitude($q$Logical Reasoning$q$, 'medium', $q$Clock Angle at 3:40$q$, $q$What is the angle between the hour hand and the minute hand of a clock at 3:40?$q$,
  $j$["120°","130°","140°","150°"]$j$::jsonb, $q$130°$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['clocks']::text[]);

-- 11 | medium | Seating in a Row
SELECT pg_temp.seed_aptitude($q$Logical Reasoning$q$, 'medium', $q$Seating in a Row$q$, $q$Five people P, Q, R, S and T sit in a row facing north.
- Q sits at the extreme right end.
- P sits immediately to the left of S.
- R does not sit next to Q.
- T sits at one of the two extreme ends.
Who sits in the middle?$q$,
  $j$["R","P","S","T"]$j$::jsonb, $q$P$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['seating-arrangement']::text[]);

-- 12 | medium | Syllogism: Some and All
SELECT pg_temp.seed_aptitude($q$Logical Reasoning$q$, 'medium', $q$Syllogism: Some and All$q$, $q$Statements: All managers are graduates. Some graduates are engineers.
Conclusions:
I. Some managers are engineers.
II. Some engineers are graduates.
Which of the following is correct?$q$,
  $j$["Only I follows","Only II follows","Both I and II follow","Neither I nor II follows"]$j$::jsonb, $q$Only II follows$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['syllogism']::text[]);

-- 13 | medium | Coding-Decoding: Increasing Shift
SELECT pg_temp.seed_aptitude($q$Logical Reasoning$q$, 'medium', $q$Coding-Decoding: Increasing Shift$q$, $q$In a certain code language, TIGER is written as UKJIW. How will LION be written in that language?$q$,
  $j$["MKRS","MKQR","MJQR","MKRR"]$j$::jsonb, $q$MKRR$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['coding-decoding']::text[]);

-- 14 | medium | Number Series: Double and Add One
SELECT pg_temp.seed_aptitude($q$Logical Reasoning$q$, 'medium', $q$Number Series: Double and Add One$q$, $q$Find the next term in the series: 3, 7, 15, 31, 63, ?$q$,
  $j$["125","126","127","128"]$j$::jsonb, $q$127$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['number-series']::text[]);

-- 15 | medium | Venn Diagram: Tea and Coffee
SELECT pg_temp.seed_aptitude($q$Logical Reasoning$q$, 'medium', $q$Venn Diagram: Tea and Coffee$q$, $q$In a group of 100 people, 60 like tea, 45 like coffee and 20 like both. How many people like neither tea nor coffee?$q$,
  $j$["5","10","15","20"]$j$::jsonb, $q$15$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['venn-diagrams','sets']::text[]);

-- 16 | medium | Direction Sense: Four-Leg Walk
SELECT pg_temp.seed_aptitude($q$Logical Reasoning$q$, 'medium', $q$Direction Sense: Four-Leg Walk$q$, $q$Ravi starts walking west and covers 10 m. He turns left and walks 6 m, turns left again and walks 10 m, then turns right and walks 4 m. How far and in which direction is he from the starting point?$q$,
  $j$["6 m South","10 m South","10 m North","14 m South-West"]$j$::jsonb, $q$10 m South$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['direction-sense']::text[]);

-- 17 | medium | Height Ordering
SELECT pg_temp.seed_aptitude($q$Logical Reasoning$q$, 'medium', $q$Height Ordering$q$, $q$A is taller than B but shorter than C. D is taller than C but shorter than E. Who is the second shortest of the five?$q$,
  $j$["D","C","A","B"]$j$::jsonb, $q$A$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['ranking','ordering']::text[]);

-- 18 | medium | Data Sufficiency: Value of x
SELECT pg_temp.seed_aptitude($q$Logical Reasoning$q$, 'medium', $q$Data Sufficiency: Value of x$q$, $q$What is the value of x?
Statement I: x² = 9.
Statement II: x > 0.$q$,
  $j$["Statement I alone is sufficient","Statement II alone is sufficient","Both statements together are sufficient, but neither alone is","Even both statements together are not sufficient"]$j$::jsonb, $q$Both statements together are sufficient, but neither alone is$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['data-sufficiency']::text[]);

-- 19 | hard | Painted Cube Cut into 64
SELECT pg_temp.seed_aptitude($q$Logical Reasoning$q$, 'hard', $q$Painted Cube Cut into 64$q$, $q$A cube painted red on all six faces is cut into 64 equal smaller cubes. How many of the smaller cubes have exactly two faces painted?$q$,
  $j$["8","16","24","32"]$j$::jsonb, $q$24$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['cubes']::text[]);

-- 20 | hard | Truth-Tellers and Liars
SELECT pg_temp.seed_aptitude($q$Logical Reasoning$q$, 'hard', $q$Truth-Tellers and Liars$q$, $q$Each of A, B and C either always tells the truth or always lies.
A says: "B is a liar."
B says: "C is a liar."
C says: "A and B are both liars."
Who is telling the truth?$q$,
  $j$["Only C","Only B","A and C","Only A"]$j$::jsonb, $q$Only B$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['puzzles','truth-liar']::text[]);

-- 21 | hard | Circular Table with a Pair Together
SELECT pg_temp.seed_aptitude($q$Logical Reasoning$q$, 'hard', $q$Circular Table with a Pair Together$q$, $q$In how many ways can 6 people be seated around a circular table so that A and B always sit next to each other?$q$,
  $j$["24","48","72","120"]$j$::jsonb, $q$48$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['circular-arrangement','permutations']::text[]);

-- 22 | hard | Interleaved Series
SELECT pg_temp.seed_aptitude($q$Logical Reasoning$q$, 'hard', $q$Interleaved Series$q$, $q$Find the next term in the series: 1, 4, 2, 8, 3, 16, 4, ?$q$,
  $j$["5","20","24","32"]$j$::jsonb, $q$32$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['number-series']::text[]);

-- 23 | hard | Blood Relations: Four Generations
SELECT pg_temp.seed_aptitude($q$Logical Reasoning$q$, 'hard', $q$Blood Relations: Four Generations$q$, $q$A is the sister of B. C is the mother of B. D is the father of C. E is the mother of D. How is E related to A?$q$,
  $j$["Grandmother","Great-grandmother","Great-aunt","Aunt"]$j$::jsonb, $q$Great-grandmother$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['blood-relations']::text[]);

-- 24 | hard | Clock Hands Coincide in a Day
SELECT pg_temp.seed_aptitude($q$Logical Reasoning$q$, 'hard', $q$Clock Hands Coincide in a Day$q$, $q$How many times do the hour hand and the minute hand of a clock coincide in a full day of 24 hours?$q$,
  $j$["22","23","24","44"]$j$::jsonb, $q$22$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['clocks']::text[]);

-- 25 | hard | Symbol Substitution
SELECT pg_temp.seed_aptitude($q$Logical Reasoning$q$, 'hard', $q$Symbol Substitution$q$, $q$If '+' means '−', '−' means '×', '×' means '÷' and '÷' means '+', what is the value of 18 ÷ 6 × 3 − 4 + 2 ?$q$,
  $j$["18","22","24","26"]$j$::jsonb, $q$24$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['symbol-substitution','bodmas']::text[]);


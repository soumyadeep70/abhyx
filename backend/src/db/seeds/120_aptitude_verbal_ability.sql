-- 120_aptitude_verbal_ability.sql
-- Topic: Verbal Ability (aptitude) -- 25 questions.
-- Idempotent: re-running updates these rows in place (matched on topic + title).
-- Requires the helpers in 010_question_helpers.sql (run in the same session by `npm run seed`).

-- 01 | easy | Synonym
SELECT pg_temp.seed_aptitude($q$Verbal Ability$q$, 'easy', $q$Synonym$q$, $q$Choose the word most similar in meaning to "Meticulous".$q$,
  $j$["Careful","Careless","Quick","Casual"]$j$::jsonb, $q$Careful$q$,
  ARRAY['TCS']::text[], ARRAY['synonyms']::text[]);

-- 02 | easy | Antonym: Scarce
SELECT pg_temp.seed_aptitude($q$Verbal Ability$q$, 'easy', $q$Antonym: Scarce$q$, $q$Choose the word most opposite in meaning to "Scarce".$q$,
  $j$["Abundant","Meagre","Rare","Limited"]$j$::jsonb, $q$Abundant$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['antonyms']::text[]);

-- 03 | easy | Synonym: Ephemeral
SELECT pg_temp.seed_aptitude($q$Verbal Ability$q$, 'easy', $q$Synonym: Ephemeral$q$, $q$Choose the word most similar in meaning to "Ephemeral".$q$,
  $j$["Short-lived","Ornate","Fragile","Eternal"]$j$::jsonb, $q$Short-lived$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['synonyms']::text[]);

-- 04 | easy | Spelling Check
SELECT pg_temp.seed_aptitude($q$Verbal Ability$q$, 'easy', $q$Spelling Check$q$, $q$Choose the correctly spelt word.$q$,
  $j$["Acommodate","Accomodate","Acomodate","Accommodate"]$j$::jsonb, $q$Accommodate$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['spelling']::text[]);

-- 05 | easy | Articles: An Honest Woman
SELECT pg_temp.seed_aptitude($q$Verbal Ability$q$, 'easy', $q$Articles: An Honest Woman$q$, $q$Fill in the blank: She is ____ honest woman who never takes credit for others' work.$q$,
  $j$["the","a","no article is needed","an"]$j$::jsonb, $q$an$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['articles','grammar']::text[]);

-- 06 | easy | Subject-Verb Agreement: The List of Items
SELECT pg_temp.seed_aptitude($q$Verbal Ability$q$, 'easy', $q$Subject-Verb Agreement: The List of Items$q$, $q$Fill in the blank: The list of items ____ on the table near the window.$q$,
  $j$["were","have been","is","are"]$j$::jsonb, $q$is$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['subject-verb-agreement','grammar']::text[]);

-- 07 | easy | Prepositions: Since or For
SELECT pg_temp.seed_aptitude($q$Verbal Ability$q$, 'easy', $q$Prepositions: Since or For$q$, $q$Fill in the blank: He has been working at this company ____ 2019.$q$,
  $j$["for","since","by","from"]$j$::jsonb, $q$since$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['prepositions','grammar']::text[]);

-- 08 | easy | One-Word Substitution: Many Languages
SELECT pg_temp.seed_aptitude($q$Verbal Ability$q$, 'easy', $q$One-Word Substitution: Many Languages$q$, $q$Choose one word for: a person who can speak many languages.$q$,
  $j$["Polyglot","Misanthrope","Philanthropist","Pedant"]$j$::jsonb, $q$Polyglot$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['one-word-substitution']::text[]);

-- 09 | medium | Idiom: Burn the Midnight Oil
SELECT pg_temp.seed_aptitude($q$Verbal Ability$q$, 'medium', $q$Idiom: Burn the Midnight Oil$q$, $q$What does the idiom "to burn the midnight oil" mean?$q$,
  $j$["To waste valuable resources","To study or work late into the night","To lose one's temper suddenly","To start a fire after dark"]$j$::jsonb, $q$To study or work late into the night$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['idioms']::text[]);

-- 10 | medium | Idiom: Blessing in Disguise
SELECT pg_temp.seed_aptitude($q$Verbal Ability$q$, 'medium', $q$Idiom: Blessing in Disguise$q$, $q$What does the idiom "a blessing in disguise" mean?$q$,
  $j$["Something that seems bad but turns out to be good","A surprise party that was carefully planned","A promise that is never kept","A hidden danger behind a kind gesture"]$j$::jsonb, $q$Something that seems bad but turns out to be good$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['idioms']::text[]);

-- 11 | medium | Error Spotting: Neither of the Two
SELECT pg_temp.seed_aptitude($q$Verbal Ability$q$, 'medium', $q$Error Spotting: Neither of the Two$q$, $q$Find the part of the sentence that contains an error.
"Neither of the two candidates / were selected / for the final round."$q$,
  $j$["Neither of the two candidates","were selected","for the final round","No error"]$j$::jsonb, $q$were selected$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['error-spotting']::text[]);

-- 12 | medium | Error Spotting: Embedded Question
SELECT pg_temp.seed_aptitude($q$Verbal Ability$q$, 'medium', $q$Error Spotting: Embedded Question$q$, $q$Find the part of the sentence that contains an error.
"He did not know / where was the library / located on the campus."$q$,
  $j$["He did not know","where was the library","located on the campus","No error"]$j$::jsonb, $q$where was the library$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['error-spotting']::text[]);

-- 13 | medium | Sentence Completion: Reserved Nature
SELECT pg_temp.seed_aptitude($q$Verbal Ability$q$, 'medium', $q$Sentence Completion: Reserved Nature$q$, $q$Choose the word that best completes the sentence.
Despite his ____ nature, he became the life of the party after a few minutes.$q$,
  $j$["flamboyant","gregarious","reserved","boisterous"]$j$::jsonb, $q$reserved$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['sentence-completion','vocabulary']::text[]);

-- 14 | medium | Sentence Completion: Abstruse Theory
SELECT pg_temp.seed_aptitude($q$Verbal Ability$q$, 'medium', $q$Sentence Completion: Abstruse Theory$q$, $q$Choose the word that best completes the sentence.
The scientist's theory was so ____ that even other experts struggled to follow it.$q$,
  $j$["candid","abstruse","lucid","trivial"]$j$::jsonb, $q$abstruse$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['sentence-completion','vocabulary']::text[]);

-- 15 | medium | Active to Passive Voice
SELECT pg_temp.seed_aptitude($q$Verbal Ability$q$, 'medium', $q$Active to Passive Voice$q$, $q$Choose the correct passive form of: "The chef prepared the meal."$q$,
  $j$["The meal was prepared by the chef.","The meal has been prepared by the chef.","The meal is prepared by the chef.","The chef was prepared by the meal."]$j$::jsonb, $q$The meal was prepared by the chef.$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['voice','grammar']::text[]);

-- 16 | medium | Direct to Indirect Speech
SELECT pg_temp.seed_aptitude($q$Verbal Ability$q$, 'medium', $q$Direct to Indirect Speech$q$, $q$Choose the correct indirect form of: She said to me, "I will meet you tomorrow."$q$,
  $j$["She told me that I would meet her the next day.","She told me that she would meet me the next day.","She told me that she will meet you tomorrow.","She said me that she would meet me the next day."]$j$::jsonb, $q$She told me that she would meet me the next day.$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['reported-speech','grammar']::text[]);

-- 17 | medium | Verbal Analogy: Creator and Work
SELECT pg_temp.seed_aptitude($q$Verbal Ability$q$, 'medium', $q$Verbal Analogy: Creator and Work$q$, $q$Choose the pair that completes the analogy.
Author : Book :: Composer : ?$q$,
  $j$["Audience","Symphony","Concert","Orchestra"]$j$::jsonb, $q$Symphony$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['analogies']::text[]);

-- 18 | medium | Para Jumble: The Novel
SELECT pg_temp.seed_aptitude($q$Verbal Ability$q$, 'medium', $q$Para Jumble: The Novel$q$, $q$Arrange the sentences in the most logical order.
P. It was an immediate success.
Q. The novel was published in 1925.
R. Critics praised its portrayal of the era.
S. Readers still study it today.$q$,
  $j$["SRPQ","RPQS","QPRS","PQRS"]$j$::jsonb, $q$QPRS$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['para-jumbles']::text[]);

-- 19 | medium | Reading Comprehension: Urban Bees
SELECT pg_temp.seed_aptitude($q$Verbal Ability$q$, 'medium', $q$Reading Comprehension: Urban Bees$q$, $q$Read the passage and answer the question.
"Urban beekeeping has grown quickly in recent years. Studies suggest that city bees often produce honey more reliably than their rural cousins, because parks and gardens bloom at different times of the year, whereas a farm may offer a single crop that flowers only briefly. Urban hives, however, can be threatened by air pollution and by complaints from neighbours."

According to the passage, why can city bees outperform rural bees?$q$,
  $j$["City bees belong to a hardier species","Cities have fewer pesticides than farms","Urban green spaces provide flowers across more of the year","Neighbours feed the bees in the city"]$j$::jsonb, $q$Urban green spaces provide flowers across more of the year$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['reading-comprehension']::text[]);

-- 20 | medium | Reading Comprehension: Library Hours
SELECT pg_temp.seed_aptitude($q$Verbal Ability$q$, 'medium', $q$Reading Comprehension: Library Hours$q$, $q$Read the passage and answer the question.
"The college library extended its opening hours after a survey showed that most students preferred to study late in the evening. Within a month, evening visits rose by 40 percent, while morning attendance stayed exactly the same."

Which of the following can be inferred from the passage?$q$,
  $j$["The longer hours did not reduce morning attendance","Morning attendance fell after the change","The survey was carried out in the morning","Students dislike studying in the morning"]$j$::jsonb, $q$The longer hours did not reduce morning attendance$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['reading-comprehension','inference']::text[]);

-- 21 | hard | Affect or Effect
SELECT pg_temp.seed_aptitude($q$Verbal Ability$q$, 'hard', $q$Affect or Effect$q$, $q$Choose the word that correctly completes the sentence.
The new attendance policy will ____ every employee in the company.$q$,
  $j$["effect","effecting","affect","affects"]$j$::jsonb, $q$affect$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['confusing-words','grammar']::text[]);

-- 22 | hard | Neither Nor Agreement
SELECT pg_temp.seed_aptitude($q$Verbal Ability$q$, 'hard', $q$Neither Nor Agreement$q$, $q$Choose the grammatically correct sentence.$q$,
  $j$["Neither the manager nor the employees is informed.","Neither the manager nor the employees has been informed.","Neither the manager nor the employees were informed.","Neither the manager nor the employees was informed."]$j$::jsonb, $q$Neither the manager nor the employees were informed.$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['subject-verb-agreement','grammar']::text[]);

-- 23 | hard | Synonym: Obsequious
SELECT pg_temp.seed_aptitude($q$Verbal Ability$q$, 'hard', $q$Synonym: Obsequious$q$, $q$Choose the word most similar in meaning to "Obsequious".$q$,
  $j$["Generous","Servile","Defiant","Talkative"]$j$::jsonb, $q$Servile$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['synonyms','vocabulary']::text[]);

-- 24 | hard | Antonym: Capricious
SELECT pg_temp.seed_aptitude($q$Verbal Ability$q$, 'hard', $q$Antonym: Capricious$q$, $q$Choose the word most opposite in meaning to "Capricious".$q$,
  $j$["Erratic","Steadfast","Fickle","Whimsical"]$j$::jsonb, $q$Steadfast$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['antonyms','vocabulary']::text[]);

-- 25 | hard | One-Word Substitution: Rule by the Few
SELECT pg_temp.seed_aptitude($q$Verbal Ability$q$, 'hard', $q$One-Word Substitution: Rule by the Few$q$, $q$Choose one word for: a system of government in which power rests with a small group of people.$q$,
  $j$["Monarchy","Anarchy","Democracy","Oligarchy"]$j$::jsonb, $q$Oligarchy$q$,
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['one-word-substitution']::text[]);


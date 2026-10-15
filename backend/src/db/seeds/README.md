# Seed data

`npm run seed` runs every `*.sql` file in this folder in filename order, on **one
connection inside one transaction** (a failure rolls the whole seed back).

| Files | What |
|---|---|
| `000_reference_data.sql` | companies, tiers, topics, badges (the app needs these to function) |
| `010_question_helpers.sql` | session-local helper functions (`pg_temp.seed_aptitude`, `pg_temp.seed_coding`) used by the question files |
| `100`–`130` `_aptitude_*.sql` | 4 aptitude topics × 25 MCQs |
| `200`–`310` `_coding_*.sql` | 12 coding topics × 22–24 Judge0-graded problems |

## Re-running is safe

The helpers upsert on **(topic, title)**: the first run inserts, later runs update the
prompt / difficulty / options / starter code / test cases / company + tag links in place.
`is_active` is never touched, so a question an admin deactivated stays deactivated.
Consequence: edit seeded questions **in these files** if you want the edit to survive a re-seed.
(Stale same-title duplicates left by the old, non-idempotent seed are set inactive, not deleted.)

## Coding question contract (what the grader expects)

Judge0 runs the **whole submission as a program**: `test_cases[i].input` is fed to stdin and
stdout is compared to `test_cases[i].expected`. So every coding seed is a stdin → stdout program and
the starter code already contains the input parsing and output printing; the student only fills in
the marked function. Rules the files follow, and new questions should too:

* Input is whitespace-token based (arrays are `n` then `n` values; a matrix is `r c` then the rows;
  trees are level-order with `null`; linked lists are `n` then the values).
* `expected` must never be empty (Judge0 treats an empty expected output as "nothing to compare").
* The first test case is the one the API exposes as the sample; the rest are hidden.
* Languages: Python 71, JavaScript 63, Java 62, C++ 54 — except **SQL**, which is SQLite (82): the
  starter holds the table setup, the student appends a query, and the script's printed rows are the output.
  SQLite on Judge0 is 3.27, so no `RIGHT/FULL JOIN`, `FILTER`, `NULLS LAST`, `RETURNING`, `IIF`.

OS, DBMS and OOP are `coding` topics in the schema (a question's `type` must equal its topic's
`category`), so they are written as runnable simulations (scheduling, page replacement, FD/normal-form
reasoning, schedule serializability, class-design command streams) rather than theory MCQs.

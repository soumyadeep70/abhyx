-- 300_coding_dbms.sql
-- Topic: DBMS (coding) -- 22 questions.
-- Idempotent: re-running updates these rows in place (matched on topic + title).
-- Requires the helpers in 010_question_helpers.sql (run in the same session by `npm run seed`).

-- 01 | easy | Attribute Closure
SELECT pg_temp.seed_coding($q$DBMS$q$, 'easy', $q$Attribute Closure$q$, $q$Compute the closure X+ of the attribute set X under the given functional dependencies and print its attributes in alphabetical order. Attributes are single uppercase letters; a functional dependency such as AB->C is written as one token.

Input Format:
- fds: an integer n, then n space-separated strings
- attrs: a single string (no spaces)

Output Format:
Print the resulting string.

Example:
Input:
2
A->B B->C
A
Output:
ABC$q$,
  $q$def attribute_closure(fds: List[str], attrs: str) -> str$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef attribute_closure(fds: List[str], attrs: str) -> str:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    fds = [next(it) for _ in range(int(next(it)))]\n    attrs = next(it)\n    result = attribute_closure(fds, attrs)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction attributeClosure(fds, attrs) {\n  // Write your solution here\n}\n\nconst fds = Array.from({ length: parseInt(next()) }, () => next());\nconst attrs = next();\nconst result = attributeClosure(fds, attrs);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static String attributeClosure(String[] fds, String attrs) {\n        // Write your solution here\n        return \"\";\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String[] fds = new String[scanner.nextInt()];\n        for (int i = 0; i < fds.length; i++) fds[i] = scanner.next();\n        String attrs = scanner.next();\n        String result = attributeClosure(fds, attrs);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nstring attributeClosure(vector<string> fds, string attrs) {\n    // Write your solution here\n    return \"\";\n}\n\nint main() {\n    int fdsN;\n    cin >> fdsN;\n    vector<string> fds(fdsN);\n    for (string& x : fds) cin >> x;\n    string attrs;\n    cin >> attrs;\n    auto result = attributeClosure(fds, attrs);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"2\nA->B B->C\nA","expected":"ABC"},{"input":"2\nAB->C C->D\nA","expected":"A"},{"input":"2\nA->BC CD->E\nAD","expected":"ABCDE"},{"input":"4\nC->D E->F CF->B DF->C\nEA","expected":"AEF"},{"input":"3\nAD->B B->E AD->B\nCB","expected":"BCE"},{"input":"4\nBE->C AF->D BF->A A->B\nF","expected":"F"}]$j$::jsonb,
  $q$1 <= number of FDs <= 20$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['functional-dependencies','closure']::text[]);

-- 02 | easy | Is It a Superkey?
SELECT pg_temp.seed_coding($q$DBMS$q$, 'easy', $q$Is It a Superkey?$q$, $q$R has the attributes in `universe`. Print true if the attribute set X is a SUPERKEY of R, i.e. its closure contains every attribute of R. Attributes are single uppercase letters; a functional dependency such as AB->C is written as one token.

Input Format:
- universe: a single string (no spaces)
- fds: an integer n, then n space-separated strings
- attrs: a single string (no spaces)

Output Format:
Print true or false (lowercase).

Example:
Input:
ABCD
3
A->B B->C C->D
A
Output:
true$q$,
  $q$def is_superkey(universe: str, fds: List[str], attrs: str) -> bool$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef is_superkey(universe: str, fds: List[str], attrs: str) -> bool:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    universe = next(it)\n    fds = [next(it) for _ in range(int(next(it)))]\n    attrs = next(it)\n    result = is_superkey(universe, fds, attrs)\n    print('true' if result else 'false')\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction isSuperkey(universe, fds, attrs) {\n  // Write your solution here\n}\n\nconst universe = next();\nconst fds = Array.from({ length: parseInt(next()) }, () => next());\nconst attrs = next();\nconst result = isSuperkey(universe, fds, attrs);\nconsole.log(result ? 'true' : 'false');\n","java":"import java.util.*;\n\npublic class Main {\n    static boolean isSuperkey(String universe, String[] fds, String attrs) {\n        // Write your solution here\n        return false;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String universe = scanner.next();\n        String[] fds = new String[scanner.nextInt()];\n        for (int i = 0; i < fds.length; i++) fds[i] = scanner.next();\n        String attrs = scanner.next();\n        boolean result = isSuperkey(universe, fds, attrs);\n        System.out.println(result ? \"true\" : \"false\");\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nbool isSuperkey(string universe, vector<string> fds, string attrs) {\n    // Write your solution here\n    return false;\n}\n\nint main() {\n    string universe;\n    cin >> universe;\n    int fdsN;\n    cin >> fdsN;\n    vector<string> fds(fdsN);\n    for (string& x : fds) cin >> x;\n    string attrs;\n    cin >> attrs;\n    auto result = isSuperkey(universe, fds, attrs);\n    cout << (result ? \"true\" : \"false\") << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"ABCD\n3\nA->B B->C C->D\nA","expected":"true"},{"input":"ABCD\n3\nA->B B->C C->D\nB","expected":"false"},{"input":"ABC\n1\nAB->C\nAB","expected":"true"},{"input":"ABCDE\n2\nD->B A->C\nEB","expected":"false"},{"input":"ABCD\n2\nAC->B AC->D\nCDB","expected":"false"},{"input":"ABCD\n3\nD->C C->A A->D\nCBD","expected":"true"}]$j$::jsonb,
  $q$1 <= |R| <= 10$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['functional-dependencies','keys']::text[]);

-- 03 | easy | Static Hashing: Overflow Records
SELECT pg_temp.seed_coding($q$DBMS$q$, 'easy', $q$Static Hashing: Overflow Records$q$, $q$A static hash file has `buckets` primary buckets numbered 0..buckets-1 with room for `capacity` records each. A record with key k goes to bucket k mod buckets. Print how many records do not fit in their primary bucket and must live in overflow pages.

Input Format:
- keys: an integer n, then a line of n space-separated integers
- buckets: a single integer
- capacity: a single integer

Output Format:
Print a single integer.

Example:
Input:
6
10 20 30 4 14 24
10
2
Output:
2$q$,
  $q$def overflow_records(keys: List[int], buckets: int, capacity: int) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef overflow_records(keys: List[int], buckets: int, capacity: int) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    keys = [int(next(it)) for _ in range(int(next(it)))]\n    buckets = int(next(it))\n    capacity = int(next(it))\n    result = overflow_records(keys, buckets, capacity)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction overflowRecords(keys, buckets, capacity) {\n  // Write your solution here\n}\n\nconst keys = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst buckets = parseInt(next());\nconst capacity = parseInt(next());\nconst result = overflowRecords(keys, buckets, capacity);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int overflowRecords(int[] keys, int buckets, int capacity) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int[] keys = new int[scanner.nextInt()];\n        for (int i = 0; i < keys.length; i++) keys[i] = scanner.nextInt();\n        int buckets = scanner.nextInt();\n        int capacity = scanner.nextInt();\n        int result = overflowRecords(keys, buckets, capacity);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint overflowRecords(vector<int> keys, int buckets, int capacity) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int keysN;\n    cin >> keysN;\n    vector<int> keys(keysN);\n    for (int& x : keys) cin >> x;\n    int buckets;\n    cin >> buckets;\n    int capacity;\n    cin >> capacity;\n    auto result = overflowRecords(keys, buckets, capacity);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"6\n10 20 30 4 14 24\n10\n2","expected":"2"},{"input":"3\n1 2 3\n5\n1","expected":"0"},{"input":"4\n5 10 15 20\n5\n1","expected":"3"},{"input":"7\n2 37 1 53 21 9 16\n3\n2","expected":"1"},{"input":"7\n49 26 10 36 8 58 58\n4\n3","expected":"1"},{"input":"12\n22 10 31 51 29 42 6 43 15 11 43 5\n6\n2","expected":"2"}]$j$::jsonb,
  $q$1 <= buckets <= 1000; keys >= 0$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['hashing','indexing']::text[]);

-- 04 | easy | Blocking Factor and Binary Search Cost
SELECT pg_temp.seed_coding($q$DBMS$q$, 'easy', $q$Blocking Factor and Binary Search Cost$q$, $q$A sorted file stores fixed-length, unspanned records. Print three numbers: the blocking factor (records per block = floor(blockSize / recordSize)), the number of blocks needed for all records, and the number of block accesses for a binary search on the file, taken as max(1, ceil(log2(blocks))).

Input Format:
- block_size: a single integer
- record_size: a single integer
- num_records: a single integer

Output Format:
Print the integers on one line, separated by single spaces.

Example:
Input:
1024
100
30000
Output:
10 3000 12$q$,
  $q$def file_block_stats(block_size: int, record_size: int, num_records: int) -> List[int]$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef file_block_stats(block_size: int, record_size: int, num_records: int) -> List[int]:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    block_size = int(next(it))\n    record_size = int(next(it))\n    num_records = int(next(it))\n    result = file_block_stats(block_size, record_size, num_records)\n    print(' '.join(map(str, result)))\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction fileBlockStats(block_size, record_size, num_records) {\n  // Write your solution here\n}\n\nconst block_size = parseInt(next());\nconst record_size = parseInt(next());\nconst num_records = parseInt(next());\nconst result = fileBlockStats(block_size, record_size, num_records);\nconsole.log(result.join(' '));\n","java":"import java.util.*;\n\npublic class Main {\n    static int[] fileBlockStats(int block_size, int record_size, int num_records) {\n        // Write your solution here\n        return new int[0];\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int block_size = scanner.nextInt();\n        int record_size = scanner.nextInt();\n        int num_records = scanner.nextInt();\n        int[] result = fileBlockStats(block_size, record_size, num_records);\n        StringBuilder sb = new StringBuilder();\n        for (int i = 0; i < result.length; i++) {\n            if (i > 0) sb.append(' ');\n            sb.append(result[i]);\n        }\n        System.out.println(sb);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nvector<int> fileBlockStats(int block_size, int record_size, int num_records) {\n    // Write your solution here\n    return {};\n}\n\nint main() {\n    int block_size;\n    cin >> block_size;\n    int record_size;\n    cin >> record_size;\n    int num_records;\n    cin >> num_records;\n    auto result = fileBlockStats(block_size, record_size, num_records);\n    for (size_t i = 0; i < result.size(); i++) {\n        if (i) cout << ' ';\n        cout << result[i];\n    }\n    cout << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"1024\n100\n30000","expected":"10 3000 12"},{"input":"512\n128\n10","expected":"4 3 2"},{"input":"4096\n64\n1000000","expected":"64 15625 14"},{"input":"2048\n30\n44935","expected":"68 661 10"},{"input":"512\n30\n5387","expected":"17 317 9"},{"input":"4096\n128\n36100","expected":"32 1129 11"}]$j$::jsonb,
  $q$recordSize <= blockSize$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['file-organization','disk-blocks']::text[]);

-- 05 | easy | Equi-Join Cardinality
SELECT pg_temp.seed_coding($q$DBMS$q$, 'easy', $q$Equi-Join Cardinality$q$, $q$Relation R has the join-column values `r` and relation S has `s` (duplicates allowed). Print the number of tuples produced by the equi-join R JOIN S on that column (every pair of an R tuple and an S tuple with equal values counts once).

Input Format:
- r: an integer n, then a line of n space-separated integers
- s: an integer n, then a line of n space-separated integers

Output Format:
Print a single integer.

Example:
Input:
4
1 2 2 3
4
2 2 3 4
Output:
5$q$,
  $q$def join_size(r: List[int], s: List[int]) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef join_size(r: List[int], s: List[int]) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    r = [int(next(it)) for _ in range(int(next(it)))]\n    s = [int(next(it)) for _ in range(int(next(it)))]\n    result = join_size(r, s)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction joinSize(r, s) {\n  // Write your solution here\n}\n\nconst r = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst s = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst result = joinSize(r, s);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int joinSize(int[] r, int[] s) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int[] r = new int[scanner.nextInt()];\n        for (int i = 0; i < r.length; i++) r[i] = scanner.nextInt();\n        int[] s = new int[scanner.nextInt()];\n        for (int i = 0; i < s.length; i++) s[i] = scanner.nextInt();\n        int result = joinSize(r, s);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint joinSize(vector<int> r, vector<int> s) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int rN;\n    cin >> rN;\n    vector<int> r(rN);\n    for (int& x : r) cin >> x;\n    int sN;\n    cin >> sN;\n    vector<int> s(sN);\n    for (int& x : s) cin >> x;\n    auto result = joinSize(r, s);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"4\n1 2 2 3\n4\n2 2 3 4","expected":"5"},{"input":"1\n1\n1\n2","expected":"0"},{"input":"2\n5 5\n3\n5 5 5","expected":"6"},{"input":"6\n3 3 1 3 1 1\n4\n4 5 4 4","expected":"0"},{"input":"5\n3 5 3 2 2\n4\n4 2 3 2","expected":"6"},{"input":"4\n4 4 3 4\n3\n1 1 5","expected":"0"}]$j$::jsonb,
  $q$1 <= |R|, |S| <= 10^5$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['joins','query-processing']::text[]);

-- 06 | easy | Block Nested-Loop Join Cost
SELECT pg_temp.seed_coding($q$DBMS$q$, 'easy', $q$Block Nested-Loop Join Cost$q$, $q$Relation R (the OUTER relation) occupies br blocks and relation S occupies bs blocks. The buffer has M pages: M - 2 hold a chunk of R, one reads S and one is for output. Print the number of block transfers of a block nested-loop join: br + ceil(br / (M - 2)) * bs.

Input Format:
- br: a single integer
- bs: a single integer
- m: a single integer

Output Format:
Print a single integer.

Example:
Input:
100
400
12
Output:
4100$q$,
  $q$def block_nested_loop_cost(br: int, bs: int, m: int) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef block_nested_loop_cost(br: int, bs: int, m: int) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    br = int(next(it))\n    bs = int(next(it))\n    m = int(next(it))\n    result = block_nested_loop_cost(br, bs, m)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction blockNestedLoopCost(br, bs, m) {\n  // Write your solution here\n}\n\nconst br = parseInt(next());\nconst bs = parseInt(next());\nconst m = parseInt(next());\nconst result = blockNestedLoopCost(br, bs, m);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int blockNestedLoopCost(int br, int bs, int m) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int br = scanner.nextInt();\n        int bs = scanner.nextInt();\n        int m = scanner.nextInt();\n        int result = blockNestedLoopCost(br, bs, m);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint blockNestedLoopCost(int br, int bs, int m) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int br;\n    cin >> br;\n    int bs;\n    cin >> bs;\n    int m;\n    cin >> m;\n    auto result = blockNestedLoopCost(br, bs, m);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"100\n400\n12","expected":"4100"},{"input":"10\n10\n3","expected":"110"},{"input":"50\n5\n52","expected":"55"},{"input":"287\n73\n29","expected":"1090"},{"input":"291\n88\n3","expected":"25899"},{"input":"493\n467\n6","expected":"58401"}]$j$::jsonb,
  $q$M >= 3$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['joins','cost-estimation']::text[]);

-- 07 | medium | Number of Candidate Keys
SELECT pg_temp.seed_coding($q$DBMS$q$, 'medium', $q$Number of Candidate Keys$q$, $q$A candidate key is a minimal superkey. Print how many candidate keys R has under the given dependencies. Attributes are single uppercase letters; a functional dependency such as AB->C is written as one token.

Input Format:
- universe: a single string (no spaces)
- fds: an integer n, then n space-separated strings

Output Format:
Print a single integer.

Example:
Input:
ABCD
3
A->B B->C C->D
Output:
1$q$,
  $q$def count_candidate_keys(universe: str, fds: List[str]) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef count_candidate_keys(universe: str, fds: List[str]) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    universe = next(it)\n    fds = [next(it) for _ in range(int(next(it)))]\n    result = count_candidate_keys(universe, fds)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction countCandidateKeys(universe, fds) {\n  // Write your solution here\n}\n\nconst universe = next();\nconst fds = Array.from({ length: parseInt(next()) }, () => next());\nconst result = countCandidateKeys(universe, fds);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int countCandidateKeys(String universe, String[] fds) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String universe = scanner.next();\n        String[] fds = new String[scanner.nextInt()];\n        for (int i = 0; i < fds.length; i++) fds[i] = scanner.next();\n        int result = countCandidateKeys(universe, fds);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint countCandidateKeys(string universe, vector<string> fds) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    string universe;\n    cin >> universe;\n    int fdsN;\n    cin >> fdsN;\n    vector<string> fds(fdsN);\n    for (string& x : fds) cin >> x;\n    auto result = countCandidateKeys(universe, fds);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"ABCD\n3\nA->B B->C C->D","expected":"1"},{"input":"ABC\n2\nAB->C C->A","expected":"2"},{"input":"ABCD\n3\nAB->C C->D D->A","expected":"3"},{"input":"ABCDE\n4\nE->C BD->E B->E CE->A","expected":"1"},{"input":"ABCD\n4\nA->C D->A AC->D BC->D","expected":"3"},{"input":"ABCDE\n3\nAE->B AE->D A->E","expected":"1"}]$j$::jsonb,
  $q$1 <= |R| <= 8$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','TCS','Infosys','Accenture']::text[], ARRAY['functional-dependencies','keys']::text[]);

-- 08 | medium | Is the Relation in BCNF?
SELECT pg_temp.seed_coding($q$DBMS$q$, 'medium', $q$Is the Relation in BCNF?$q$, $q$R is in BCNF when, for every NON-TRIVIAL dependency X->Y in the given set, X is a superkey of R (a dependency is trivial when Y is a subset of X). Print true or false. Attributes are single uppercase letters; a functional dependency such as AB->C is written as one token.

Input Format:
- universe: a single string (no spaces)
- fds: an integer n, then n space-separated strings

Output Format:
Print true or false (lowercase).

Example:
Input:
ABC
2
A->B B->C
Output:
false$q$,
  $q$def is_bcnf(universe: str, fds: List[str]) -> bool$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef is_bcnf(universe: str, fds: List[str]) -> bool:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    universe = next(it)\n    fds = [next(it) for _ in range(int(next(it)))]\n    result = is_bcnf(universe, fds)\n    print('true' if result else 'false')\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction isBcnf(universe, fds) {\n  // Write your solution here\n}\n\nconst universe = next();\nconst fds = Array.from({ length: parseInt(next()) }, () => next());\nconst result = isBcnf(universe, fds);\nconsole.log(result ? 'true' : 'false');\n","java":"import java.util.*;\n\npublic class Main {\n    static boolean isBcnf(String universe, String[] fds) {\n        // Write your solution here\n        return false;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String universe = scanner.next();\n        String[] fds = new String[scanner.nextInt()];\n        for (int i = 0; i < fds.length; i++) fds[i] = scanner.next();\n        boolean result = isBcnf(universe, fds);\n        System.out.println(result ? \"true\" : \"false\");\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nbool isBcnf(string universe, vector<string> fds) {\n    // Write your solution here\n    return false;\n}\n\nint main() {\n    string universe;\n    cin >> universe;\n    int fdsN;\n    cin >> fdsN;\n    vector<string> fds(fdsN);\n    for (string& x : fds) cin >> x;\n    auto result = isBcnf(universe, fds);\n    cout << (result ? \"true\" : \"false\") << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"ABC\n2\nA->B B->C","expected":"false"},{"input":"ABC\n1\nA->BC","expected":"true"},{"input":"ABC\n2\nAB->C C->A","expected":"false"},{"input":"ABCD\n1\nD->C","expected":"false"},{"input":"ABCD\n1\nAC->B","expected":"false"},{"input":"ABCD\n3\nAC->B AD->C BC->A","expected":"false"}]$j$::jsonb,
  $q$1 <= |R| <= 8$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','TCS','Infosys','Accenture']::text[], ARRAY['normalization','bcnf']::text[]);

-- 09 | medium | Is the Relation in 3NF?
SELECT pg_temp.seed_coding($q$DBMS$q$, 'medium', $q$Is the Relation in 3NF?$q$, $q$R is in 3NF when, for every given dependency X->A with A not in X (consider each attribute of the right side separately), either X is a superkey or A is a PRIME attribute (a member of at least one candidate key). Print true or false. Attributes are single uppercase letters; a functional dependency such as AB->C is written as one token.

Input Format:
- universe: a single string (no spaces)
- fds: an integer n, then n space-separated strings

Output Format:
Print true or false (lowercase).

Example:
Input:
ABC
2
AB->C C->A
Output:
true$q$,
  $q$def is_3nf(universe: str, fds: List[str]) -> bool$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef is_3nf(universe: str, fds: List[str]) -> bool:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    universe = next(it)\n    fds = [next(it) for _ in range(int(next(it)))]\n    result = is_3nf(universe, fds)\n    print('true' if result else 'false')\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction is3Nf(universe, fds) {\n  // Write your solution here\n}\n\nconst universe = next();\nconst fds = Array.from({ length: parseInt(next()) }, () => next());\nconst result = is3Nf(universe, fds);\nconsole.log(result ? 'true' : 'false');\n","java":"import java.util.*;\n\npublic class Main {\n    static boolean is3Nf(String universe, String[] fds) {\n        // Write your solution here\n        return false;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String universe = scanner.next();\n        String[] fds = new String[scanner.nextInt()];\n        for (int i = 0; i < fds.length; i++) fds[i] = scanner.next();\n        boolean result = is3Nf(universe, fds);\n        System.out.println(result ? \"true\" : \"false\");\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nbool is3Nf(string universe, vector<string> fds) {\n    // Write your solution here\n    return false;\n}\n\nint main() {\n    string universe;\n    cin >> universe;\n    int fdsN;\n    cin >> fdsN;\n    vector<string> fds(fdsN);\n    for (string& x : fds) cin >> x;\n    auto result = is3Nf(universe, fds);\n    cout << (result ? \"true\" : \"false\") << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"ABC\n2\nAB->C C->A","expected":"true"},{"input":"ABC\n2\nA->B B->C","expected":"false"},{"input":"ABCD\n3\nA->B B->C C->D","expected":"false"},{"input":"ABCD\n1\nD->C","expected":"false"},{"input":"ABCD\n3\nA->B AD->C AB->D","expected":"true"},{"input":"ABCD\n2\nAC->B C->B","expected":"false"}]$j$::jsonb,
  $q$1 <= |R| <= 8$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','TCS','Infosys','Accenture']::text[], ARRAY['normalization','3nf']::text[]);

-- 10 | hard | Highest Normal Form
SELECT pg_temp.seed_coding($q$DBMS$q$, 'hard', $q$Highest Normal Form$q$, $q$Assuming every attribute is atomic (so R is at least in 1NF), print the HIGHEST normal form of R among 1NF, 2NF, 3NF and BCNF. R violates 2NF when a non-prime attribute depends on a PROPER subset of some candidate key. Use the closure of attribute sets, not only the listed dependencies. Attributes are single uppercase letters; a functional dependency such as AB->C is written as one token.

Input Format:
- universe: a single string (no spaces)
- fds: an integer n, then n space-separated strings

Output Format:
Print the resulting string.

Example:
Input:
ABC
2
AB->C C->A
Output:
3NF$q$,
  $q$def highest_normal_form(universe: str, fds: List[str]) -> str$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef highest_normal_form(universe: str, fds: List[str]) -> str:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    universe = next(it)\n    fds = [next(it) for _ in range(int(next(it)))]\n    result = highest_normal_form(universe, fds)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction highestNormalForm(universe, fds) {\n  // Write your solution here\n}\n\nconst universe = next();\nconst fds = Array.from({ length: parseInt(next()) }, () => next());\nconst result = highestNormalForm(universe, fds);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static String highestNormalForm(String universe, String[] fds) {\n        // Write your solution here\n        return \"\";\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String universe = scanner.next();\n        String[] fds = new String[scanner.nextInt()];\n        for (int i = 0; i < fds.length; i++) fds[i] = scanner.next();\n        String result = highestNormalForm(universe, fds);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nstring highestNormalForm(string universe, vector<string> fds) {\n    // Write your solution here\n    return \"\";\n}\n\nint main() {\n    string universe;\n    cin >> universe;\n    int fdsN;\n    cin >> fdsN;\n    vector<string> fds(fdsN);\n    for (string& x : fds) cin >> x;\n    auto result = highestNormalForm(universe, fds);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"ABC\n2\nAB->C C->A","expected":"3NF"},{"input":"ABC\n2\nA->B B->C","expected":"2NF"},{"input":"ABCD\n2\nAB->C B->D","expected":"1NF"},{"input":"ABC\n1\nA->BC","expected":"BCNF"},{"input":"ABCDE\n4\nB->A BE->A B->E AC->E","expected":"1NF"},{"input":"ABCD\n3\nA->C AD->B A->B","expected":"1NF"},{"input":"ABCDE\n3\nA->B A->D BC->E","expected":"1NF"},{"input":"ABCD\n2\nD->A BD->A","expected":"1NF"}]$j$::jsonb,
  $q$1 <= |R| <= 8$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','TCS','Infosys','Accenture']::text[], ARRAY['normalization','2nf','3nf','bcnf']::text[]);

-- 11 | medium | Equivalence of Two FD Sets
SELECT pg_temp.seed_coding($q$DBMS$q$, 'medium', $q$Equivalence of Two FD Sets$q$, $q$Two sets of dependencies F and G are equivalent when every dependency of F follows from G and every dependency of G follows from F. Print true or false. Attributes are single uppercase letters; a functional dependency such as AB->C is written as one token.

Input Format:
- f: an integer n, then n space-separated strings
- g: an integer n, then n space-separated strings

Output Format:
Print true or false (lowercase).

Example:
Input:
2
A->B B->C
2
A->BC B->C
Output:
true$q$,
  $q$def fd_sets_equivalent(f: List[str], g: List[str]) -> bool$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef fd_sets_equivalent(f: List[str], g: List[str]) -> bool:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    f = [next(it) for _ in range(int(next(it)))]\n    g = [next(it) for _ in range(int(next(it)))]\n    result = fd_sets_equivalent(f, g)\n    print('true' if result else 'false')\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction fdSetsEquivalent(f, g) {\n  // Write your solution here\n}\n\nconst f = Array.from({ length: parseInt(next()) }, () => next());\nconst g = Array.from({ length: parseInt(next()) }, () => next());\nconst result = fdSetsEquivalent(f, g);\nconsole.log(result ? 'true' : 'false');\n","java":"import java.util.*;\n\npublic class Main {\n    static boolean fdSetsEquivalent(String[] f, String[] g) {\n        // Write your solution here\n        return false;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String[] f = new String[scanner.nextInt()];\n        for (int i = 0; i < f.length; i++) f[i] = scanner.next();\n        String[] g = new String[scanner.nextInt()];\n        for (int i = 0; i < g.length; i++) g[i] = scanner.next();\n        boolean result = fdSetsEquivalent(f, g);\n        System.out.println(result ? \"true\" : \"false\");\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nbool fdSetsEquivalent(vector<string> f, vector<string> g) {\n    // Write your solution here\n    return false;\n}\n\nint main() {\n    int fN;\n    cin >> fN;\n    vector<string> f(fN);\n    for (string& x : f) cin >> x;\n    int gN;\n    cin >> gN;\n    vector<string> g(gN);\n    for (string& x : g) cin >> x;\n    auto result = fdSetsEquivalent(f, g);\n    cout << (result ? \"true\" : \"false\") << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"2\nA->B B->C\n2\nA->BC B->C","expected":"true"},{"input":"1\nA->B\n1\nA->C","expected":"false"},{"input":"3\nA->B B->C A->C\n2\nA->B B->C","expected":"true"},{"input":"3\nAB->C CD->B AD->C\n3\nD->B BC->A BC->A","expected":"false"},{"input":"3\nBD->C B->C BD->A\n2\nAB->C B->D","expected":"false"},{"input":"2\nD->C BD->A\n3\nC->B C->D AB->C","expected":"false"}]$j$::jsonb,
  $q$1 <= |F|, |G| <= 20$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Infosys','Accenture']::text[], ARRAY['functional-dependencies','canonical-cover']::text[]);

-- 12 | medium | Lossless-Join Decomposition
SELECT pg_temp.seed_coding($q$DBMS$q$, 'medium', $q$Lossless-Join Decomposition$q$, $q$R is decomposed into R1 and R2 (their attributes together cover R). The decomposition is lossless exactly when (R1 intersect R2) functionally determines all of R1 or all of R2. Print true or false. Attributes are single uppercase letters; a functional dependency such as AB->C is written as one token.

Input Format:
- r1: a single string (no spaces)
- r2: a single string (no spaces)
- fds: an integer n, then n space-separated strings

Output Format:
Print true or false (lowercase).

Example:
Input:
AB
BC
1
B->C
Output:
true$q$,
  $q$def is_lossless(r1: str, r2: str, fds: List[str]) -> bool$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef is_lossless(r1: str, r2: str, fds: List[str]) -> bool:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    r1 = next(it)\n    r2 = next(it)\n    fds = [next(it) for _ in range(int(next(it)))]\n    result = is_lossless(r1, r2, fds)\n    print('true' if result else 'false')\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction isLossless(r1, r2, fds) {\n  // Write your solution here\n}\n\nconst r1 = next();\nconst r2 = next();\nconst fds = Array.from({ length: parseInt(next()) }, () => next());\nconst result = isLossless(r1, r2, fds);\nconsole.log(result ? 'true' : 'false');\n","java":"import java.util.*;\n\npublic class Main {\n    static boolean isLossless(String r1, String r2, String[] fds) {\n        // Write your solution here\n        return false;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String r1 = scanner.next();\n        String r2 = scanner.next();\n        String[] fds = new String[scanner.nextInt()];\n        for (int i = 0; i < fds.length; i++) fds[i] = scanner.next();\n        boolean result = isLossless(r1, r2, fds);\n        System.out.println(result ? \"true\" : \"false\");\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nbool isLossless(string r1, string r2, vector<string> fds) {\n    // Write your solution here\n    return false;\n}\n\nint main() {\n    string r1;\n    cin >> r1;\n    string r2;\n    cin >> r2;\n    int fdsN;\n    cin >> fdsN;\n    vector<string> fds(fdsN);\n    for (string& x : fds) cin >> x;\n    auto result = isLossless(r1, r2, fds);\n    cout << (result ? \"true\" : \"false\") << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"AB\nBC\n1\nB->C","expected":"true"},{"input":"AB\nBC\n1\nA->B","expected":"false"},{"input":"ABC\nCD\n1\nC->D","expected":"true"},{"input":"ABD\nADE\n2\nDE->C AB->E","expected":"false"},{"input":"CDE\nACD\n2\nCD->B B->D","expected":"false"},{"input":"BCE\nACE\n2\nAC->B E->A","expected":"true"}]$j$::jsonb,
  $q$1 <= |R| <= 10$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','TCS','Infosys','Accenture']::text[], ARRAY['normalization','decomposition']::text[]);

-- 13 | hard | Dependency-Preserving Decomposition
SELECT pg_temp.seed_coding($q$DBMS$q$, 'hard', $q$Dependency-Preserving Decomposition$q$, $q$R is decomposed into R1 and R2. A decomposition preserves dependencies when every given dependency can be derived from the dependencies that hold within R1 and R2 alone. Test each X->Y with this loop: Z = X; repeat for each Ri: Z = Z union (closure_F(Z intersect Ri) intersect Ri) until Z stops growing; the dependency is preserved if Y is a subset of Z. Print true if all dependencies are preserved. Attributes are single uppercase letters; a functional dependency such as AB->C is written as one token.

Input Format:
- r1: a single string (no spaces)
- r2: a single string (no spaces)
- fds: an integer n, then n space-separated strings

Output Format:
Print true or false (lowercase).

Example:
Input:
AB
BC
2
A->B B->C
Output:
true$q$,
  $q$def is_dependency_preserving(r1: str, r2: str, fds: List[str]) -> bool$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef is_dependency_preserving(r1: str, r2: str, fds: List[str]) -> bool:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    r1 = next(it)\n    r2 = next(it)\n    fds = [next(it) for _ in range(int(next(it)))]\n    result = is_dependency_preserving(r1, r2, fds)\n    print('true' if result else 'false')\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction isDependencyPreserving(r1, r2, fds) {\n  // Write your solution here\n}\n\nconst r1 = next();\nconst r2 = next();\nconst fds = Array.from({ length: parseInt(next()) }, () => next());\nconst result = isDependencyPreserving(r1, r2, fds);\nconsole.log(result ? 'true' : 'false');\n","java":"import java.util.*;\n\npublic class Main {\n    static boolean isDependencyPreserving(String r1, String r2, String[] fds) {\n        // Write your solution here\n        return false;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String r1 = scanner.next();\n        String r2 = scanner.next();\n        String[] fds = new String[scanner.nextInt()];\n        for (int i = 0; i < fds.length; i++) fds[i] = scanner.next();\n        boolean result = isDependencyPreserving(r1, r2, fds);\n        System.out.println(result ? \"true\" : \"false\");\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nbool isDependencyPreserving(string r1, string r2, vector<string> fds) {\n    // Write your solution here\n    return false;\n}\n\nint main() {\n    string r1;\n    cin >> r1;\n    string r2;\n    cin >> r2;\n    int fdsN;\n    cin >> fdsN;\n    vector<string> fds(fdsN);\n    for (string& x : fds) cin >> x;\n    auto result = isDependencyPreserving(r1, r2, fds);\n    cout << (result ? \"true\" : \"false\") << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"AB\nBC\n2\nA->B B->C","expected":"true"},{"input":"AB\nAC\n2\nA->B B->C","expected":"false"},{"input":"ABC\nCD\n2\nA->B C->D","expected":"true"},{"input":"ABE\nACD\n2\nC->A B->D","expected":"false"},{"input":"CDE\nABC\n3\nC->E D->A AB->D","expected":"false"},{"input":"ACE\nACD\n3\nDE->A DE->C B->D","expected":"false"}]$j$::jsonb,
  $q$1 <= |R| <= 10$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Infosys','Accenture']::text[], ARRAY['normalization','decomposition']::text[]);

-- 14 | medium | Conflict Serializability
SELECT pg_temp.seed_coding($q$DBMS$q$, 'medium', $q$Conflict Serializability$q$, $q$A schedule is a list of tokens such as R1(A) (transaction 1 reads A), W2(B) (transaction 2 writes B) and C1 (commit; ignore it here). Two operations conflict when they belong to different transactions, touch the same item and at least one is a write. Build the precedence graph (edge Ti -> Tj if a conflicting operation of Ti comes before one of Tj) and print true if the schedule is conflict-serializable (the graph has no cycle).

Input Format:
- schedule: an integer n, then n space-separated strings

Output Format:
Print true or false (lowercase).

Example:
Input:
3
R1(A) W2(A) W1(A)
Output:
false$q$,
  $q$def is_conflict_serializable(schedule: List[str]) -> bool$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef is_conflict_serializable(schedule: List[str]) -> bool:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    schedule = [next(it) for _ in range(int(next(it)))]\n    result = is_conflict_serializable(schedule)\n    print('true' if result else 'false')\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction isConflictSerializable(schedule) {\n  // Write your solution here\n}\n\nconst schedule = Array.from({ length: parseInt(next()) }, () => next());\nconst result = isConflictSerializable(schedule);\nconsole.log(result ? 'true' : 'false');\n","java":"import java.util.*;\n\npublic class Main {\n    static boolean isConflictSerializable(String[] schedule) {\n        // Write your solution here\n        return false;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String[] schedule = new String[scanner.nextInt()];\n        for (int i = 0; i < schedule.length; i++) schedule[i] = scanner.next();\n        boolean result = isConflictSerializable(schedule);\n        System.out.println(result ? \"true\" : \"false\");\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nbool isConflictSerializable(vector<string> schedule) {\n    // Write your solution here\n    return false;\n}\n\nint main() {\n    int scheduleN;\n    cin >> scheduleN;\n    vector<string> schedule(scheduleN);\n    for (string& x : schedule) cin >> x;\n    auto result = isConflictSerializable(schedule);\n    cout << (result ? \"true\" : \"false\") << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"3\nR1(A) W2(A) W1(A)","expected":"false"},{"input":"4\nR1(A) W1(A) R2(A) W2(A)","expected":"true"},{"input":"4\nW1(A) R2(B) W2(A) R1(B)","expected":"true"},{"input":"7\nW3(B) R3(A) W2(B) W2(B) W1(A) W1(B) W2(B)","expected":"false"},{"input":"8\nW3(B) W1(B) W3(B) R3(A) W1(A) R1(B) R2(B) R2(B)","expected":"false"},{"input":"7\nR2(B) R3(A) R3(A) W2(A) W1(A) R1(B) R1(A)","expected":"true"},{"input":"9\nR2(A) R2(A) R1(B) W3(A) W3(A) W3(B) W2(A) R1(B) R1(B)","expected":"false"}]$j$::jsonb,
  $q$1 <= n <= 200$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','TCS','Infosys','Accenture']::text[], ARRAY['transactions','serializability']::text[]);

-- 15 | hard | Recoverable Schedule
SELECT pg_temp.seed_coding($q$DBMS$q$, 'hard', $q$Recoverable Schedule$q$, $q$Tokens: R1(A), W2(B), and C1 for 'transaction 1 commits' (every transaction commits exactly once). Transaction Tj READS FROM Ti when Tj reads an item whose most recent write (before that read) was by a different transaction Ti. A schedule is RECOVERABLE when, whenever Tj reads from Ti, Ti commits before Tj commits. Print true or false.

Input Format:
- schedule: an integer n, then n space-separated strings

Output Format:
Print true or false (lowercase).

Example:
Input:
4
W1(A) R2(A) C2 C1
Output:
false$q$,
  $q$def is_recoverable(schedule: List[str]) -> bool$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef is_recoverable(schedule: List[str]) -> bool:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    schedule = [next(it) for _ in range(int(next(it)))]\n    result = is_recoverable(schedule)\n    print('true' if result else 'false')\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction isRecoverable(schedule) {\n  // Write your solution here\n}\n\nconst schedule = Array.from({ length: parseInt(next()) }, () => next());\nconst result = isRecoverable(schedule);\nconsole.log(result ? 'true' : 'false');\n","java":"import java.util.*;\n\npublic class Main {\n    static boolean isRecoverable(String[] schedule) {\n        // Write your solution here\n        return false;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String[] schedule = new String[scanner.nextInt()];\n        for (int i = 0; i < schedule.length; i++) schedule[i] = scanner.next();\n        boolean result = isRecoverable(schedule);\n        System.out.println(result ? \"true\" : \"false\");\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nbool isRecoverable(vector<string> schedule) {\n    // Write your solution here\n    return false;\n}\n\nint main() {\n    int scheduleN;\n    cin >> scheduleN;\n    vector<string> schedule(scheduleN);\n    for (string& x : schedule) cin >> x;\n    auto result = isRecoverable(schedule);\n    cout << (result ? \"true\" : \"false\") << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"4\nW1(A) R2(A) C2 C1","expected":"false"},{"input":"4\nW1(A) R2(A) C1 C2","expected":"true"},{"input":"4\nR1(A) W2(A) C1 C2","expected":"true"},{"input":"11\nR1(A) W1(A) R2(A) W3(A) R2(B) R3(A) W1(A) C1 C2 W3(A) C3","expected":"true"},{"input":"10\nW2(B) R1(A) R3(B) W1(A) R3(B) C3 R2(A) C2 R1(A) C1","expected":"false"},{"input":"10\nR2(A) W1(A) W3(B) W3(B) R1(A) C3 R1(A) C1 R2(A) C2","expected":"true"},{"input":"11\nR3(A) W2(B) W2(A) W1(A) C2 W1(B) R1(A) R3(A) C1 W3(B) C3","expected":"true"},{"input":"10\nR1(B) R2(A) W2(B) W3(B) R1(A) W3(B) C3 R2(B) C1 C2","expected":"true"}]$j$::jsonb,
  $q$1 <= n <= 200$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','TCS','Infosys','Accenture']::text[], ARRAY['transactions','recoverability']::text[]);

-- 16 | hard | Cascadeless Schedule
SELECT pg_temp.seed_coding($q$DBMS$q$, 'hard', $q$Cascadeless Schedule$q$, $q$Use the same tokens and 'reads from' definition as for recoverable schedules. A schedule is CASCADELESS (avoids cascading aborts) when every transaction reads only values written by transactions that have ALREADY committed at the moment of the read. Print true or false.

Input Format:
- schedule: an integer n, then n space-separated strings

Output Format:
Print true or false (lowercase).

Example:
Input:
4
W1(A) R2(A) C1 C2
Output:
false$q$,
  $q$def is_cascadeless(schedule: List[str]) -> bool$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef is_cascadeless(schedule: List[str]) -> bool:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    schedule = [next(it) for _ in range(int(next(it)))]\n    result = is_cascadeless(schedule)\n    print('true' if result else 'false')\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction isCascadeless(schedule) {\n  // Write your solution here\n}\n\nconst schedule = Array.from({ length: parseInt(next()) }, () => next());\nconst result = isCascadeless(schedule);\nconsole.log(result ? 'true' : 'false');\n","java":"import java.util.*;\n\npublic class Main {\n    static boolean isCascadeless(String[] schedule) {\n        // Write your solution here\n        return false;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String[] schedule = new String[scanner.nextInt()];\n        for (int i = 0; i < schedule.length; i++) schedule[i] = scanner.next();\n        boolean result = isCascadeless(schedule);\n        System.out.println(result ? \"true\" : \"false\");\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nbool isCascadeless(vector<string> schedule) {\n    // Write your solution here\n    return false;\n}\n\nint main() {\n    int scheduleN;\n    cin >> scheduleN;\n    vector<string> schedule(scheduleN);\n    for (string& x : schedule) cin >> x;\n    auto result = isCascadeless(schedule);\n    cout << (result ? \"true\" : \"false\") << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"4\nW1(A) R2(A) C1 C2","expected":"false"},{"input":"4\nW1(A) C1 R2(A) C2","expected":"true"},{"input":"4\nR1(A) R2(A) C1 C2","expected":"true"},{"input":"12\nR2(B) R1(B) R2(A) R1(B) W1(A) C1 R2(A) C2 W3(A) W3(A) W3(A) C3","expected":"true"},{"input":"10\nR2(B) R2(A) W3(B) R3(B) C2 R1(B) C3 R1(B) R1(A) C1","expected":"false"},{"input":"10\nR1(B) W3(A) W3(B) R2(A) R1(A) R3(B) C1 R2(B) C3 C2","expected":"false"},{"input":"11\nW1(A) W2(B) R1(A) W3(A) W1(A) C1 W2(A) C2 W3(B) W3(B) C3","expected":"true"},{"input":"10\nR3(B) W3(B) C3 R2(A) R2(B) W1(A) R2(A) R1(B) C2 C1","expected":"false"}]$j$::jsonb,
  $q$1 <= n <= 200$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Infosys','Accenture']::text[], ARRAY['transactions','recoverability']::text[]);

-- 17 | easy | Two-Phase Locking Check
SELECT pg_temp.seed_coding($q$DBMS$q$, 'easy', $q$Two-Phase Locking Check$q$, $q$Tokens L1(A) (transaction 1 locks A) and U1(A) (unlocks A). A transaction obeys two-phase locking when it never acquires a lock after releasing any lock. Print true if EVERY transaction in the sequence obeys 2PL.

Input Format:
- ops: an integer n, then n space-separated strings

Output Format:
Print true or false (lowercase).

Example:
Input:
4
L1(A) L1(B) U1(A) U1(B)
Output:
true$q$,
  $q$def obeys_two_phase_locking(ops: List[str]) -> bool$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef obeys_two_phase_locking(ops: List[str]) -> bool:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    ops = [next(it) for _ in range(int(next(it)))]\n    result = obeys_two_phase_locking(ops)\n    print('true' if result else 'false')\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction obeysTwoPhaseLocking(ops) {\n  // Write your solution here\n}\n\nconst ops = Array.from({ length: parseInt(next()) }, () => next());\nconst result = obeysTwoPhaseLocking(ops);\nconsole.log(result ? 'true' : 'false');\n","java":"import java.util.*;\n\npublic class Main {\n    static boolean obeysTwoPhaseLocking(String[] ops) {\n        // Write your solution here\n        return false;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String[] ops = new String[scanner.nextInt()];\n        for (int i = 0; i < ops.length; i++) ops[i] = scanner.next();\n        boolean result = obeysTwoPhaseLocking(ops);\n        System.out.println(result ? \"true\" : \"false\");\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nbool obeysTwoPhaseLocking(vector<string> ops) {\n    // Write your solution here\n    return false;\n}\n\nint main() {\n    int opsN;\n    cin >> opsN;\n    vector<string> ops(opsN);\n    for (string& x : ops) cin >> x;\n    auto result = obeysTwoPhaseLocking(ops);\n    cout << (result ? \"true\" : \"false\") << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"4\nL1(A) L1(B) U1(A) U1(B)","expected":"true"},{"input":"4\nL1(A) U1(A) L1(B) U1(B)","expected":"false"},{"input":"4\nL1(A) L2(B) U2(B) U1(A)","expected":"true"},{"input":"5\nL1(A) U1(A) L2(A) L2(A) U2(B)","expected":"true"},{"input":"9\nL2(B) L1(B) U1(B) U2(A) U2(B) U1(A) L2(B) U2(A) U1(B)","expected":"false"},{"input":"7\nU1(A) U1(B) U1(A) L2(A) U2(B) U2(A) L2(A)","expected":"false"}]$j$::jsonb,
  $q$1 <= n <= 200$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['transactions','locking','2pl']::text[]);

-- 18 | hard | Basic Timestamp Ordering
SELECT pg_temp.seed_coding($q$DBMS$q$, 'hard', $q$Basic Timestamp Ordering$q$, $q$Transaction Ti has timestamp i. Keep, per item X, the largest timestamp that has read it (RTS) and written it (WTS), both initially 0. Process the operations in order: R_i(X) is REJECTED if i < WTS(X), otherwise RTS(X) = max(RTS(X), i). W_i(X) is REJECTED if i < RTS(X) or i < WTS(X), otherwise WTS(X) = i. Print the 1-based position of the FIRST rejected operation, or 0 if every operation is accepted.

Input Format:
- ops: an integer n, then n space-separated strings

Output Format:
Print a single integer.

Example:
Input:
3
R2(A) W1(A) R3(A)
Output:
2$q$,
  $q$def first_rejected_operation(ops: List[str]) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef first_rejected_operation(ops: List[str]) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    ops = [next(it) for _ in range(int(next(it)))]\n    result = first_rejected_operation(ops)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction firstRejectedOperation(ops) {\n  // Write your solution here\n}\n\nconst ops = Array.from({ length: parseInt(next()) }, () => next());\nconst result = firstRejectedOperation(ops);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int firstRejectedOperation(String[] ops) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String[] ops = new String[scanner.nextInt()];\n        for (int i = 0; i < ops.length; i++) ops[i] = scanner.next();\n        int result = firstRejectedOperation(ops);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint firstRejectedOperation(vector<string> ops) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int opsN;\n    cin >> opsN;\n    vector<string> ops(opsN);\n    for (string& x : ops) cin >> x;\n    auto result = firstRejectedOperation(ops);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"3\nR2(A) W1(A) R3(A)","expected":"2"},{"input":"4\nR1(A) W2(A) R3(A) W3(A)","expected":"0"},{"input":"2\nW3(A) R1(A)","expected":"2"},{"input":"7\nR1(B) W3(B) R2(A) W1(A) W3(B) W2(B) R1(A)","expected":"4"},{"input":"7\nW3(A) R3(A) R1(A) R1(B) W2(A) R2(A) R2(B)","expected":"3"},{"input":"6\nW2(B) W2(A) R3(A) W3(A) R1(B) R1(A)","expected":"5"},{"input":"7\nR3(B) W3(A) R1(B) R1(A) W1(B) R2(A) W2(B)","expected":"4"},{"input":"8\nW3(B) R2(A) W2(B) R1(B) W1(B) W3(A) W1(B) W3(A)","expected":"3"}]$j$::jsonb,
  $q$1 <= n <= 200$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Infosys','Accenture']::text[], ARRAY['transactions','timestamp-ordering']::text[]);

-- 19 | hard | Log-Based Crash Recovery
SELECT pg_temp.seed_coding($q$DBMS$q$, 'hard', $q$Log-Based Crash Recovery$q$, $q$Items are numbered 0..k-1 with initial values `initial`. The log lists updates in order as rows [transaction, item, newValue]; before the crash ALL logged updates were applied to the database. The transactions in `committed` finished; every other transaction did not. Recover with this exact procedure: (1) UNDO every update of an uncommitted transaction, going through the log from last to first and restoring the value the item held just before that update; (2) REDO every update of a committed transaction, from first to last. Print the final value of every item in order.

Input Format:
- initial: an integer n, then a line of n space-separated integers
- log: two integers r and c, then r lines of c space-separated integers
- committed: an integer n, then a line of n space-separated integers

Output Format:
Print the integers on one line, separated by single spaces.

Example:
Input:
2
5 7
3 3
1 0 10
2 1 20
1 1 30
1
1
Output:
10 30$q$,
  $q$def recover_database(initial: List[int], log: List[List[int]], committed: List[int]) -> List[int]$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef recover_database(initial: List[int], log: List[List[int]], committed: List[int]) -> List[int]:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    initial = [int(next(it)) for _ in range(int(next(it)))]\n    rows, cols = int(next(it)), int(next(it))\n    log = [[int(next(it)) for _ in range(cols)] for _ in range(rows)]\n    committed = [int(next(it)) for _ in range(int(next(it)))]\n    result = recover_database(initial, log, committed)\n    print(' '.join(map(str, result)))\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction recoverDatabase(initial, log, committed) {\n  // Write your solution here\n}\n\nconst initial = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst logRows = parseInt(next());\nconst logCols = parseInt(next());\nconst log = Array.from({ length: logRows }, () => Array.from({ length: logCols }, () => parseInt(next())));\nconst committed = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst result = recoverDatabase(initial, log, committed);\nconsole.log(result.join(' '));\n","java":"import java.util.*;\n\npublic class Main {\n    static int[] recoverDatabase(int[] initial, int[][] log, int[] committed) {\n        // Write your solution here\n        return new int[0];\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int[] initial = new int[scanner.nextInt()];\n        for (int i = 0; i < initial.length; i++) initial[i] = scanner.nextInt();\n        int logRows = scanner.nextInt(), logCols = scanner.nextInt();\n        int[][] log = new int[logRows][logCols];\n        for (int i = 0; i < logRows; i++)\n            for (int j = 0; j < logCols; j++) log[i][j] = scanner.nextInt();\n        int[] committed = new int[scanner.nextInt()];\n        for (int i = 0; i < committed.length; i++) committed[i] = scanner.nextInt();\n        int[] result = recoverDatabase(initial, log, committed);\n        StringBuilder sb = new StringBuilder();\n        for (int i = 0; i < result.length; i++) {\n            if (i > 0) sb.append(' ');\n            sb.append(result[i]);\n        }\n        System.out.println(sb);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nvector<int> recoverDatabase(vector<int> initial, vector<vector<int>> log, vector<int> committed) {\n    // Write your solution here\n    return {};\n}\n\nint main() {\n    int initialN;\n    cin >> initialN;\n    vector<int> initial(initialN);\n    for (int& x : initial) cin >> x;\n    int logRows, logCols;\n    cin >> logRows >> logCols;\n    vector<vector<int>> log(logRows, vector<int>(logCols));\n    for (auto& row : log) for (int& x : row) cin >> x;\n    int committedN;\n    cin >> committedN;\n    vector<int> committed(committedN);\n    for (int& x : committed) cin >> x;\n    auto result = recoverDatabase(initial, log, committed);\n    for (size_t i = 0; i < result.size(); i++) {\n        if (i) cout << ' ';\n        cout << result[i];\n    }\n    cout << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"2\n5 7\n3 3\n1 0 10\n2 1 20\n1 1 30\n1\n1","expected":"10 30"},{"input":"2\n1 2\n1 3\n1 0 9\n1\n1","expected":"9 2"},{"input":"1\n4\n2 3\n2 0 8\n1 0 6\n1\n1","expected":"6"},{"input":"2\n5 7\n7 3\n1 0 31\n2 0 24\n2 0 63\n2 0 98\n3 0 32\n2 1 42\n3 0 58\n1\n1","expected":"31 7"},{"input":"2\n5 4\n7 3\n3 1 87\n2 0 64\n1 0 70\n2 0 43\n1 0 87\n2 1 74\n1 1 26\n2\n1 3","expected":"87 26"},{"input":"2\n4 9\n5 3\n2 1 53\n3 1 44\n1 0 58\n2 1 70\n3 1 30\n1\n1","expected":"58 9"}]$j$::jsonb,
  $q$1 <= k <= 100$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Infosys','Accenture']::text[], ARRAY['recovery','write-ahead-logging']::text[]);

-- 20 | medium | External Merge Sort: Passes and I/O
SELECT pg_temp.seed_coding($q$DBMS$q$, 'medium', $q$External Merge Sort: Passes and I/O$q$, $q$A relation occupies N pages and the buffer pool has B pages. Pass 0 sorts B pages at a time, producing ceil(N / B) sorted runs; each later pass merges up to B - 1 runs into one. Print the total number of passes and the total page I/Os (each pass reads and writes every page once: 2 * N * passes).

Input Format:
- n: a single integer
- b: a single integer

Output Format:
Print the integers on one line, separated by single spaces.

Example:
Input:
1000
5
Output:
5 10000$q$,
  $q$def external_sort_cost(n: int, b: int) -> List[int]$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef external_sort_cost(n: int, b: int) -> List[int]:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    n = int(next(it))\n    b = int(next(it))\n    result = external_sort_cost(n, b)\n    print(' '.join(map(str, result)))\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction externalSortCost(n, b) {\n  // Write your solution here\n}\n\nconst n = parseInt(next());\nconst b = parseInt(next());\nconst result = externalSortCost(n, b);\nconsole.log(result.join(' '));\n","java":"import java.util.*;\n\npublic class Main {\n    static int[] externalSortCost(int n, int b) {\n        // Write your solution here\n        return new int[0];\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int n = scanner.nextInt();\n        int b = scanner.nextInt();\n        int[] result = externalSortCost(n, b);\n        StringBuilder sb = new StringBuilder();\n        for (int i = 0; i < result.length; i++) {\n            if (i > 0) sb.append(' ');\n            sb.append(result[i]);\n        }\n        System.out.println(sb);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nvector<int> externalSortCost(int n, int b) {\n    // Write your solution here\n    return {};\n}\n\nint main() {\n    int n;\n    cin >> n;\n    int b;\n    cin >> b;\n    auto result = externalSortCost(n, b);\n    for (size_t i = 0; i < result.size(); i++) {\n        if (i) cout << ' ';\n        cout << result[i];\n    }\n    cout << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"1000\n5","expected":"5 10000"},{"input":"10\n10","expected":"1 20"},{"input":"108\n5","expected":"4 864"},{"input":"1669\n6","expected":"5 16690"},{"input":"3067\n3","expected":"11 67474"},{"input":"1189\n7","expected":"4 9512"}]$j$::jsonb,
  $q$B >= 3$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Infosys','Accenture']::text[], ARRAY['query-processing','external-sorting']::text[]);

-- 21 | easy | Relational Difference
SELECT pg_temp.seed_coding($q$DBMS$q$, 'easy', $q$Relational Difference$q$, $q$Relations A and B have the same two columns. Print A - B: the distinct tuples of A that do not appear in B (set semantics), one tuple per line, sorted ascending. At least one tuple remains in every test.

Input Format:
- a: two integers r and c, then r lines of c space-separated integers
- b: two integers r and c, then r lines of c space-separated integers

Output Format:
Print each row on its own line, values separated by single spaces.

Example:
Input:
3 2
1 2
3 4
1 2
1 2
3 4
Output:
1 2$q$,
  $q$def relational_difference(a: List[List[int]], b: List[List[int]]) -> List[List[int]]$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef relational_difference(a: List[List[int]], b: List[List[int]]) -> List[List[int]]:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    rows, cols = int(next(it)), int(next(it))\n    a = [[int(next(it)) for _ in range(cols)] for _ in range(rows)]\n    rows, cols = int(next(it)), int(next(it))\n    b = [[int(next(it)) for _ in range(cols)] for _ in range(rows)]\n    result = relational_difference(a, b)\n    print('\\n'.join(' '.join(map(str, row)) for row in result))\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction relationalDifference(a, b) {\n  // Write your solution here\n}\n\nconst aRows = parseInt(next());\nconst aCols = parseInt(next());\nconst a = Array.from({ length: aRows }, () => Array.from({ length: aCols }, () => parseInt(next())));\nconst bRows = parseInt(next());\nconst bCols = parseInt(next());\nconst b = Array.from({ length: bRows }, () => Array.from({ length: bCols }, () => parseInt(next())));\nconst result = relationalDifference(a, b);\nconsole.log(result.map((row) => row.join(' ')).join('\\n'));\n","java":"import java.util.*;\n\npublic class Main {\n    static int[][] relationalDifference(int[][] a, int[][] b) {\n        // Write your solution here\n        return new int[0][];\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int aRows = scanner.nextInt(), aCols = scanner.nextInt();\n        int[][] a = new int[aRows][aCols];\n        for (int i = 0; i < aRows; i++)\n            for (int j = 0; j < aCols; j++) a[i][j] = scanner.nextInt();\n        int bRows = scanner.nextInt(), bCols = scanner.nextInt();\n        int[][] b = new int[bRows][bCols];\n        for (int i = 0; i < bRows; i++)\n            for (int j = 0; j < bCols; j++) b[i][j] = scanner.nextInt();\n        int[][] result = relationalDifference(a, b);\n        StringBuilder sb = new StringBuilder();\n        for (int[] row : result) {\n            for (int j = 0; j < row.length; j++) {\n                if (j > 0) sb.append(' ');\n                sb.append(row[j]);\n            }\n            sb.append('\\n');\n        }\n        System.out.print(sb);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nvector<vector<int>> relationalDifference(vector<vector<int>> a, vector<vector<int>> b) {\n    // Write your solution here\n    return {};\n}\n\nint main() {\n    int aRows, aCols;\n    cin >> aRows >> aCols;\n    vector<vector<int>> a(aRows, vector<int>(aCols));\n    for (auto& row : a) for (int& x : row) cin >> x;\n    int bRows, bCols;\n    cin >> bRows >> bCols;\n    vector<vector<int>> b(bRows, vector<int>(bCols));\n    for (auto& row : b) for (int& x : row) cin >> x;\n    auto result = relationalDifference(a, b);\n    for (auto& row : result) {\n        for (size_t j = 0; j < row.size(); j++) {\n            if (j) cout << ' ';\n            cout << row[j];\n        }\n        cout << '\\n';\n    }\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"3 2\n1 2\n3 4\n1 2\n1 2\n3 4","expected":"1 2"},{"input":"1 2\n1 1\n1 2\n2 2","expected":"1 1"},{"input":"2 2\n2 1\n1 2\n1 2\n1 2","expected":"2 1"},{"input":"6 2\n1 2\n3 1\n1 2\n2 1\n1 2\n2 3\n3 2\n1 3\n3 3\n2 3","expected":"1 2\n2 1\n3 1"},{"input":"6 2\n3 1\n1 1\n3 3\n2 3\n2 3\n2 2\n4 2\n1 3\n1 3\n1 1\n1 1","expected":"2 2\n2 3\n3 1\n3 3"},{"input":"4 2\n3 2\n3 1\n3 3\n3 1\n3 2\n2 3\n3 1\n2 1","expected":"3 2\n3 3"}]$j$::jsonb,
  $q$1 <= rows <= 1000$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['relational-algebra','set-operations']::text[]);

-- 22 | medium | Relational Division
SELECT pg_temp.seed_coding($q$DBMS$q$, 'medium', $q$Relational Division$q$, $q$R(student, course) lists which student took which course (rows [student, course]) and S lists required courses. Print, in ascending order, the students who took EVERY course in S (R divided by S). Print -1 if there is no such student.

Input Format:
- r: two integers r and c, then r lines of c space-separated integers
- s: an integer n, then a line of n space-separated integers

Output Format:
Print the integers on one line, separated by single spaces.

Example:
Input:
6 2
1 10
1 20
2 10
3 10
3 20
3 30
2
10 20
Output:
1 3$q$,
  $q$def relational_division(r: List[List[int]], s: List[int]) -> List[int]$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef relational_division(r: List[List[int]], s: List[int]) -> List[int]:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    rows, cols = int(next(it)), int(next(it))\n    r = [[int(next(it)) for _ in range(cols)] for _ in range(rows)]\n    s = [int(next(it)) for _ in range(int(next(it)))]\n    result = relational_division(r, s)\n    print(' '.join(map(str, result)))\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction relationalDivision(r, s) {\n  // Write your solution here\n}\n\nconst rRows = parseInt(next());\nconst rCols = parseInt(next());\nconst r = Array.from({ length: rRows }, () => Array.from({ length: rCols }, () => parseInt(next())));\nconst s = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst result = relationalDivision(r, s);\nconsole.log(result.join(' '));\n","java":"import java.util.*;\n\npublic class Main {\n    static int[] relationalDivision(int[][] r, int[] s) {\n        // Write your solution here\n        return new int[0];\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int rRows = scanner.nextInt(), rCols = scanner.nextInt();\n        int[][] r = new int[rRows][rCols];\n        for (int i = 0; i < rRows; i++)\n            for (int j = 0; j < rCols; j++) r[i][j] = scanner.nextInt();\n        int[] s = new int[scanner.nextInt()];\n        for (int i = 0; i < s.length; i++) s[i] = scanner.nextInt();\n        int[] result = relationalDivision(r, s);\n        StringBuilder sb = new StringBuilder();\n        for (int i = 0; i < result.length; i++) {\n            if (i > 0) sb.append(' ');\n            sb.append(result[i]);\n        }\n        System.out.println(sb);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nvector<int> relationalDivision(vector<vector<int>> r, vector<int> s) {\n    // Write your solution here\n    return {};\n}\n\nint main() {\n    int rRows, rCols;\n    cin >> rRows >> rCols;\n    vector<vector<int>> r(rRows, vector<int>(rCols));\n    for (auto& row : r) for (int& x : row) cin >> x;\n    int sN;\n    cin >> sN;\n    vector<int> s(sN);\n    for (int& x : s) cin >> x;\n    auto result = relationalDivision(r, s);\n    for (size_t i = 0; i < result.size(); i++) {\n        if (i) cout << ' ';\n        cout << result[i];\n    }\n    cout << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"6 2\n1 10\n1 20\n2 10\n3 10\n3 20\n3 30\n2\n10 20","expected":"1 3"},{"input":"1 2\n1 5\n1\n6","expected":"-1"},{"input":"2 2\n2 1\n2 2\n1\n1","expected":"2"},{"input":"12 2\n2 3\n1 2\n1 2\n1 2\n2 1\n4 1\n3 3\n2 1\n4 3\n2 2\n2 1\n3 1\n2\n1 3","expected":"2 3 4"},{"input":"8 2\n2 3\n2 2\n4 3\n3 1\n4 2\n1 2\n4 1\n2 3\n1\n1","expected":"3 4"},{"input":"8 2\n4 2\n1 2\n2 2\n1 2\n4 2\n1 2\n3 2\n4 2\n2\n2 3","expected":"-1"}]$j$::jsonb,
  $q$1 <= rows <= 1000$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','TCS','Infosys','Accenture']::text[], ARRAY['relational-algebra','division']::text[]);


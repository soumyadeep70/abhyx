-- 260_coding_recursion_backtracking.sql
-- Topic: Recursion & Backtracking (coding) -- 23 questions.
-- Idempotent: re-running updates these rows in place (matched on topic + title).
-- Requires the helpers in 010_question_helpers.sql (run in the same session by `npm run seed`).

-- 01 | easy | Factorial
SELECT pg_temp.seed_coding($q$Recursion & Backtracking$q$, 'easy', $q$Factorial$q$, $q$Compute n! recursively and print it. The result fits in a 32-bit integer for the given range.

Input Format:
- n: a single integer

Output Format:
Print a single integer.

Example:
Input:
5
Output:
120$q$,
  $q$def factorial(n: int) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef factorial(n: int) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    n = int(next(it))\n    result = factorial(n)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction factorial(n) {\n  // Write your solution here\n}\n\nconst n = parseInt(next());\nconst result = factorial(n);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int factorial(int n) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int n = scanner.nextInt();\n        int result = factorial(n);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint factorial(int n) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int n;\n    cin >> n;\n    auto result = factorial(n);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"5","expected":"120"},{"input":"0","expected":"1"},{"input":"12","expected":"479001600"},{"input":"9","expected":"362880"},{"input":"8","expected":"40320"},{"input":"1","expected":"1"}]$j$::jsonb,
  $q$0 <= n <= 12$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['recursion','math']::text[]);

-- 02 | easy | Fast Power (Modular Exponentiation)
SELECT pg_temp.seed_coding($q$Recursion & Backtracking$q$, 'easy', $q$Fast Power (Modular Exponentiation)$q$, $q$Print (base ^ exp) mod m. Use the square-and-multiply idea (recursively halve the exponent) so it runs in O(log exp).

Input Format:
- base: a single integer
- exp: a single integer
- m: a single integer

Output Format:
Print a single integer.

Example:
Input:
2
10
1000
Output:
24$q$,
  $q$def power_mod(base: int, exp: int, m: int) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef power_mod(base: int, exp: int, m: int) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    base = int(next(it))\n    exp = int(next(it))\n    m = int(next(it))\n    result = power_mod(base, exp, m)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction powerMod(base, exp, m) {\n  // Write your solution here\n}\n\nconst base = parseInt(next());\nconst exp = parseInt(next());\nconst m = parseInt(next());\nconst result = powerMod(base, exp, m);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int powerMod(int base, int exp, int m) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int base = scanner.nextInt();\n        int exp = scanner.nextInt();\n        int m = scanner.nextInt();\n        int result = powerMod(base, exp, m);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint powerMod(int base, int exp, int m) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int base;\n    cin >> base;\n    int exp;\n    cin >> exp;\n    int m;\n    cin >> m;\n    auto result = powerMod(base, exp, m);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"2\n10\n1000","expected":"24"},{"input":"3\n0\n7","expected":"1"},{"input":"7\n1000000000\n13","expected":"9"},{"input":"37\n24764\n70498","expected":"38209"},{"input":"4\n715084\n18273","expected":"1705"},{"input":"39\n561840\n79560","expected":"10881"}]$j$::jsonb,
  $q$0 <= base, exp <= 10^9; 1 < m <= 10^9$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Infosys','Accenture']::text[], ARRAY['recursion','divide-and-conquer']::text[]);

-- 03 | easy | Sum of Digits (Recursive)
SELECT pg_temp.seed_coding($q$Recursion & Backtracking$q$, 'easy', $q$Sum of Digits (Recursive)$q$, $q$Print the sum of the decimal digits of n using recursion (no loops, no string conversion).

Input Format:
- n: a single integer

Output Format:
Print a single integer.

Example:
Input:
12345
Output:
15$q$,
  $q$def sum_of_digits(n: int) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef sum_of_digits(n: int) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    n = int(next(it))\n    result = sum_of_digits(n)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction sumOfDigits(n) {\n  // Write your solution here\n}\n\nconst n = parseInt(next());\nconst result = sumOfDigits(n);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int sumOfDigits(int n) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int n = scanner.nextInt();\n        int result = sumOfDigits(n);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint sumOfDigits(int n) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int n;\n    cin >> n;\n    auto result = sumOfDigits(n);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"12345","expected":"15"},{"input":"0","expected":"0"},{"input":"999999999","expected":"81"},{"input":"1754236571","expected":"41"},{"input":"1976131333","expected":"37"},{"input":"1966318876","expected":"55"}]$j$::jsonb,
  $q$0 <= n <= 2 * 10^9$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['recursion']::text[]);

-- 04 | easy | Tower of Hanoi
SELECT pg_temp.seed_coding($q$Recursion & Backtracking$q$, 'easy', $q$Tower of Hanoi$q$, $q$Three pegs are numbered 1, 2 and 3. n disks are stacked on peg 1 (smallest on top) and must be moved to peg 3, one disk at a time, never placing a larger disk on a smaller one. Print the moves of the (unique) shortest solution, one per line, as 'from to'.

Input Format:
- n: a single integer

Output Format:
Print each row on its own line, values separated by single spaces.

Example:
Input:
3
Output:
1 3
1 2
3 2
1 3
2 1
2 3
1 3$q$,
  $q$def hanoi_moves(n: int) -> List[List[int]]$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef hanoi_moves(n: int) -> List[List[int]]:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    n = int(next(it))\n    result = hanoi_moves(n)\n    print('\\n'.join(' '.join(map(str, row)) for row in result))\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction hanoiMoves(n) {\n  // Write your solution here\n}\n\nconst n = parseInt(next());\nconst result = hanoiMoves(n);\nconsole.log(result.map((row) => row.join(' ')).join('\\n'));\n","java":"import java.util.*;\n\npublic class Main {\n    static int[][] hanoiMoves(int n) {\n        // Write your solution here\n        return new int[0][];\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int n = scanner.nextInt();\n        int[][] result = hanoiMoves(n);\n        StringBuilder sb = new StringBuilder();\n        for (int[] row : result) {\n            for (int j = 0; j < row.length; j++) {\n                if (j > 0) sb.append(' ');\n                sb.append(row[j]);\n            }\n            sb.append('\\n');\n        }\n        System.out.print(sb);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nvector<vector<int>> hanoiMoves(int n) {\n    // Write your solution here\n    return {};\n}\n\nint main() {\n    int n;\n    cin >> n;\n    auto result = hanoiMoves(n);\n    for (auto& row : result) {\n        for (size_t j = 0; j < row.size(); j++) {\n            if (j) cout << ' ';\n            cout << row[j];\n        }\n        cout << '\\n';\n    }\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"3","expected":"1 3\n1 2\n3 2\n1 3\n2 1\n2 3\n1 3"},{"input":"1","expected":"1 3"},{"input":"4","expected":"1 2\n1 3\n2 3\n1 2\n3 1\n3 2\n1 2\n1 3\n2 3\n2 1\n3 1\n2 3\n1 2\n1 3\n2 3"},{"input":"2","expected":"1 2\n1 3\n2 3"},{"input":"5","expected":"1 3\n1 2\n3 2\n1 3\n2 1\n2 3\n1 3\n1 2\n3 2\n3 1\n2 1\n3 2\n1 3\n1 2\n3 2\n1 3\n2 1\n2 3\n1 3\n2 1\n3 2\n3 1\n2 1\n2 3\n1 3\n1 2\n3 2\n1 3\n2 1\n2 3\n1 3"},{"input":"6","expected":"1 2\n1 3\n2 3\n1 2\n3 1\n3 2\n1 2\n1 3\n2 3\n2 1\n3 1\n2 3\n1 2\n1 3\n2 3\n1 2\n3 1\n3 2\n1 2\n3 1\n2 3\n2 1\n3 1\n3 2\n1 2\n1 3\n2 3\n1 2\n3 1\n3 2\n1 2\n1 3\n2 3\n2 1\n3 1\n2 3\n1 2\n1 3\n2 3\n2 1\n3 1\n3 2\n1 2\n3 1\n2 3\n2 1\n3 1\n2 3\n1 2\n1 3\n2 3\n1 2\n3 1\n3 2\n1 2\n1 3\n2 3\n2 1\n3 1\n2 3\n1 2\n1 3\n2 3"}]$j$::jsonb,
  $q$1 <= n <= 10$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Wipro','Accenture']::text[], ARRAY['recursion']::text[]);

-- 05 | easy | Gray Code
SELECT pg_temp.seed_coding($q$Recursion & Backtracking$q$, 'easy', $q$Gray Code$q$, $q$A Gray code sequence of n bits has 2^n integers where consecutive values differ in exactly one bit. Print the standard reflected sequence that starts at 0 (the sequence for n is the sequence for n-1, followed by that sequence reversed with the top bit set).

Input Format:
- n: a single integer

Output Format:
Print the integers on one line, separated by single spaces.

Example:
Input:
2
Output:
0 1 3 2$q$,
  $q$def gray_code(n: int) -> List[int]$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef gray_code(n: int) -> List[int]:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    n = int(next(it))\n    result = gray_code(n)\n    print(' '.join(map(str, result)))\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction grayCode(n) {\n  // Write your solution here\n}\n\nconst n = parseInt(next());\nconst result = grayCode(n);\nconsole.log(result.join(' '));\n","java":"import java.util.*;\n\npublic class Main {\n    static int[] grayCode(int n) {\n        // Write your solution here\n        return new int[0];\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int n = scanner.nextInt();\n        int[] result = grayCode(n);\n        StringBuilder sb = new StringBuilder();\n        for (int i = 0; i < result.length; i++) {\n            if (i > 0) sb.append(' ');\n            sb.append(result[i]);\n        }\n        System.out.println(sb);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nvector<int> grayCode(int n) {\n    // Write your solution here\n    return {};\n}\n\nint main() {\n    int n;\n    cin >> n;\n    auto result = grayCode(n);\n    for (size_t i = 0; i < result.size(); i++) {\n        if (i) cout << ' ';\n        cout << result[i];\n    }\n    cout << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"2","expected":"0 1 3 2"},{"input":"1","expected":"0 1"},{"input":"3","expected":"0 1 3 2 6 7 5 4"},{"input":"7","expected":"0 1 3 2 6 7 5 4 12 13 15 14 10 11 9 8 24 25 27 26 30 31 29 28 20 21 23 22 18 19 17 16 48 49 51 50 54 55 53 52 60 61 63 62 58 59 57 56 40 41 43 42 46 47 45 44 36 37 39 38 34 35 33 32 96 97 99 98 102 103 101 100 108 109 111 110 106 107 105 104 120 121 123 122 126 127 125 124 116 117 119 118 114 115 113 112 80 81 83 82 86 87 85 84 92 93 95 94 90 91 89 88 72 73 75 74 78 79 77 76 68 69 71 70 66 67 65 64"},{"input":"5","expected":"0 1 3 2 6 7 5 4 12 13 15 14 10 11 9 8 24 25 27 26 30 31 29 28 20 21 23 22 18 19 17 16"},{"input":"8","expected":"0 1 3 2 6 7 5 4 12 13 15 14 10 11 9 8 24 25 27 26 30 31 29 28 20 21 23 22 18 19 17 16 48 49 51 50 54 55 53 52 60 61 63 62 58 59 57 56 40 41 43 42 46 47 45 44 36 37 39 38 34 35 33 32 96 97 99 98 102 103 101 100 108 109 111 110 106 107 105 104 120 121 123 122 126 127 125 124 116 117 119 118 114 115 113 112 80 81 83 82 86 87 85 84 92 93 95 94 90 91 89 88 72 73 75 74 78 79 77 76 68 69 71 70 66 67 65 64 192 193 195 194 198 199 197 196 204 205 207 206 202 203 201 200 216 217 219 218 222 223 221 220 212 213 215 214 210 211 209 208 240 241 243 242 246 247 245 244 252 253 255 254 250 251 249 248 232 233 235 234 238 239 237 236 228 229 231 230 226 227 225 224 160 161 163 162 166 167 165 164 172 173 175 174 170 171 169 168 184 185 187 186 190 191 189 188 180 181 183 182 178 179 177 176 144 145 147 146 150 151 149 148 156 157 159 158 154 155 153 152 136 137 139 138 142 143 141 140 132 133 135 134 130 131 129 128"}]$j$::jsonb,
  $q$1 <= n <= 12$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Accenture','Infosys']::text[], ARRAY['recursion','bit-manipulation']::text[]);

-- 06 | medium | Subsets
SELECT pg_temp.seed_coding($q$Recursion & Backtracking$q$, 'medium', $q$Subsets$q$, $q$Print every NON-EMPTY subset of the distinct integers, one per line. Sort each subset in ascending order, and list the subsets in lexicographic order (compare element by element; a shorter prefix comes first).

Input Format:
- nums: an integer n, then a line of n space-separated integers

Output Format:
Print each row on its own line, values separated by single spaces.

Example:
Input:
3
1 2 3
Output:
1
1 2
1 2 3
1 3
2
2 3
3$q$,
  $q$def subsets(nums: List[int]) -> List[List[int]]$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef subsets(nums: List[int]) -> List[List[int]]:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    nums = [int(next(it)) for _ in range(int(next(it)))]\n    result = subsets(nums)\n    print('\\n'.join(' '.join(map(str, row)) for row in result))\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction subsets(nums) {\n  // Write your solution here\n}\n\nconst nums = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst result = subsets(nums);\nconsole.log(result.map((row) => row.join(' ')).join('\\n'));\n","java":"import java.util.*;\n\npublic class Main {\n    static int[][] subsets(int[] nums) {\n        // Write your solution here\n        return new int[0][];\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int[] nums = new int[scanner.nextInt()];\n        for (int i = 0; i < nums.length; i++) nums[i] = scanner.nextInt();\n        int[][] result = subsets(nums);\n        StringBuilder sb = new StringBuilder();\n        for (int[] row : result) {\n            for (int j = 0; j < row.length; j++) {\n                if (j > 0) sb.append(' ');\n                sb.append(row[j]);\n            }\n            sb.append('\\n');\n        }\n        System.out.print(sb);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nvector<vector<int>> subsets(vector<int> nums) {\n    // Write your solution here\n    return {};\n}\n\nint main() {\n    int numsN;\n    cin >> numsN;\n    vector<int> nums(numsN);\n    for (int& x : nums) cin >> x;\n    auto result = subsets(nums);\n    for (auto& row : result) {\n        for (size_t j = 0; j < row.size(); j++) {\n            if (j) cout << ' ';\n            cout << row[j];\n        }\n        cout << '\\n';\n    }\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"3\n1 2 3","expected":"1\n1 2\n1 2 3\n1 3\n2\n2 3\n3"},{"input":"1\n5","expected":"5"},{"input":"2\n3 1","expected":"1\n1 3\n3"},{"input":"5\n3 8 4 7 6","expected":"3\n3 4\n3 4 6\n3 4 6 7\n3 4 6 7 8\n3 4 6 8\n3 4 7\n3 4 7 8\n3 4 8\n3 6\n3 6 7\n3 6 7 8\n3 6 8\n3 7\n3 7 8\n3 8\n4\n4 6\n4 6 7\n4 6 7 8\n4 6 8\n4 7\n4 7 8\n4 8\n6\n6 7\n6 7 8\n6 8\n7\n7 8\n8"},{"input":"4\n2 3 1 9","expected":"1\n1 2\n1 2 3\n1 2 3 9\n1 2 9\n1 3\n1 3 9\n1 9\n2\n2 3\n2 3 9\n2 9\n3\n3 9\n9"},{"input":"4\n6 7 11 10","expected":"6\n6 7\n6 7 10\n6 7 10 11\n6 7 11\n6 10\n6 10 11\n6 11\n7\n7 10\n7 10 11\n7 11\n10\n10 11\n11"}]$j$::jsonb,
  $q$1 <= n <= 8; values distinct$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Accenture','Infosys']::text[], ARRAY['backtracking','bitmask']::text[]);

-- 07 | medium | Permutations
SELECT pg_temp.seed_coding($q$Recursion & Backtracking$q$, 'medium', $q$Permutations$q$, $q$Print every permutation of the distinct integers, one per line, in lexicographic order.

Input Format:
- nums: an integer n, then a line of n space-separated integers

Output Format:
Print each row on its own line, values separated by single spaces.

Example:
Input:
3
1 2 3
Output:
1 2 3
1 3 2
2 1 3
2 3 1
3 1 2
3 2 1$q$,
  $q$def permutations(nums: List[int]) -> List[List[int]]$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef permutations(nums: List[int]) -> List[List[int]]:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    nums = [int(next(it)) for _ in range(int(next(it)))]\n    result = permutations(nums)\n    print('\\n'.join(' '.join(map(str, row)) for row in result))\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction permutations(nums) {\n  // Write your solution here\n}\n\nconst nums = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst result = permutations(nums);\nconsole.log(result.map((row) => row.join(' ')).join('\\n'));\n","java":"import java.util.*;\n\npublic class Main {\n    static int[][] permutations(int[] nums) {\n        // Write your solution here\n        return new int[0][];\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int[] nums = new int[scanner.nextInt()];\n        for (int i = 0; i < nums.length; i++) nums[i] = scanner.nextInt();\n        int[][] result = permutations(nums);\n        StringBuilder sb = new StringBuilder();\n        for (int[] row : result) {\n            for (int j = 0; j < row.length; j++) {\n                if (j > 0) sb.append(' ');\n                sb.append(row[j]);\n            }\n            sb.append('\\n');\n        }\n        System.out.print(sb);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nvector<vector<int>> permutations(vector<int> nums) {\n    // Write your solution here\n    return {};\n}\n\nint main() {\n    int numsN;\n    cin >> numsN;\n    vector<int> nums(numsN);\n    for (int& x : nums) cin >> x;\n    auto result = permutations(nums);\n    for (auto& row : result) {\n        for (size_t j = 0; j < row.size(); j++) {\n            if (j) cout << ' ';\n            cout << row[j];\n        }\n        cout << '\\n';\n    }\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"3\n1 2 3","expected":"1 2 3\n1 3 2\n2 1 3\n2 3 1\n3 1 2\n3 2 1"},{"input":"2\n0 1","expected":"0 1\n1 0"},{"input":"1\n4","expected":"4"},{"input":"4\n4 10 8 2","expected":"2 4 8 10\n2 4 10 8\n2 8 4 10\n2 8 10 4\n2 10 4 8\n2 10 8 4\n4 2 8 10\n4 2 10 8\n4 8 2 10\n4 8 10 2\n4 10 2 8\n4 10 8 2\n8 2 4 10\n8 2 10 4\n8 4 2 10\n8 4 10 2\n8 10 2 4\n8 10 4 2\n10 2 4 8\n10 2 8 4\n10 4 2 8\n10 4 8 2\n10 8 2 4\n10 8 4 2"},{"input":"4\n5 2 0 8","expected":"0 2 5 8\n0 2 8 5\n0 5 2 8\n0 5 8 2\n0 8 2 5\n0 8 5 2\n2 0 5 8\n2 0 8 5\n2 5 0 8\n2 5 8 0\n2 8 0 5\n2 8 5 0\n5 0 2 8\n5 0 8 2\n5 2 0 8\n5 2 8 0\n5 8 0 2\n5 8 2 0\n8 0 2 5\n8 0 5 2\n8 2 0 5\n8 2 5 0\n8 5 0 2\n8 5 2 0"},{"input":"4\n6 3 10 7","expected":"3 6 7 10\n3 6 10 7\n3 7 6 10\n3 7 10 6\n3 10 6 7\n3 10 7 6\n6 3 7 10\n6 3 10 7\n6 7 3 10\n6 7 10 3\n6 10 3 7\n6 10 7 3\n7 3 6 10\n7 3 10 6\n7 6 3 10\n7 6 10 3\n7 10 3 6\n7 10 6 3\n10 3 6 7\n10 3 7 6\n10 6 3 7\n10 6 7 3\n10 7 3 6\n10 7 6 3"}]$j$::jsonb,
  $q$1 <= n <= 6; values distinct$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Accenture','Infosys']::text[], ARRAY['backtracking']::text[]);

-- 08 | medium | Combinations
SELECT pg_temp.seed_coding($q$Recursion & Backtracking$q$, 'medium', $q$Combinations$q$, $q$Print every combination of k numbers chosen from 1..n, one per line, each in ascending order, listed in lexicographic order.

Input Format:
- n: a single integer
- k: a single integer

Output Format:
Print each row on its own line, values separated by single spaces.

Example:
Input:
4
2
Output:
1 2
1 3
1 4
2 3
2 4
3 4$q$,
  $q$def combine(n: int, k: int) -> List[List[int]]$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef combine(n: int, k: int) -> List[List[int]]:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    n = int(next(it))\n    k = int(next(it))\n    result = combine(n, k)\n    print('\\n'.join(' '.join(map(str, row)) for row in result))\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction combine(n, k) {\n  // Write your solution here\n}\n\nconst n = parseInt(next());\nconst k = parseInt(next());\nconst result = combine(n, k);\nconsole.log(result.map((row) => row.join(' ')).join('\\n'));\n","java":"import java.util.*;\n\npublic class Main {\n    static int[][] combine(int n, int k) {\n        // Write your solution here\n        return new int[0][];\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int n = scanner.nextInt();\n        int k = scanner.nextInt();\n        int[][] result = combine(n, k);\n        StringBuilder sb = new StringBuilder();\n        for (int[] row : result) {\n            for (int j = 0; j < row.length; j++) {\n                if (j > 0) sb.append(' ');\n                sb.append(row[j]);\n            }\n            sb.append('\\n');\n        }\n        System.out.print(sb);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nvector<vector<int>> combine(int n, int k) {\n    // Write your solution here\n    return {};\n}\n\nint main() {\n    int n;\n    cin >> n;\n    int k;\n    cin >> k;\n    auto result = combine(n, k);\n    for (auto& row : result) {\n        for (size_t j = 0; j < row.size(); j++) {\n            if (j) cout << ' ';\n            cout << row[j];\n        }\n        cout << '\\n';\n    }\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"4\n2","expected":"1 2\n1 3\n1 4\n2 3\n2 4\n3 4"},{"input":"1\n1","expected":"1"},{"input":"5\n4","expected":"1 2 3 4\n1 2 3 5\n1 2 4 5\n1 3 4 5\n2 3 4 5"},{"input":"6\n3","expected":"1 2 3\n1 2 4\n1 2 5\n1 2 6\n1 3 4\n1 3 5\n1 3 6\n1 4 5\n1 4 6\n1 5 6\n2 3 4\n2 3 5\n2 3 6\n2 4 5\n2 4 6\n2 5 6\n3 4 5\n3 4 6\n3 5 6\n4 5 6"},{"input":"5\n2","expected":"1 2\n1 3\n1 4\n1 5\n2 3\n2 4\n2 5\n3 4\n3 5\n4 5"},{"input":"6\n2","expected":"1 2\n1 3\n1 4\n1 5\n1 6\n2 3\n2 4\n2 5\n2 6\n3 4\n3 5\n3 6\n4 5\n4 6\n5 6"}]$j$::jsonb,
  $q$1 <= k <= n <= 10$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Accenture']::text[], ARRAY['backtracking']::text[]);

-- 09 | medium | Combination Sum
SELECT pg_temp.seed_coding($q$Recursion & Backtracking$q$, 'medium', $q$Combination Sum$q$, $q$Candidates are distinct positive integers that may each be used any number of times. Print every unique combination (each in ascending order) that sums to target, one per line, in lexicographic order. At least one combination exists in every test.

Input Format:
- candidates: an integer n, then a line of n space-separated integers
- target: a single integer

Output Format:
Print each row on its own line, values separated by single spaces.

Example:
Input:
4
2 3 6 7
7
Output:
2 2 3
7$q$,
  $q$def combination_sum(candidates: List[int], target: int) -> List[List[int]]$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef combination_sum(candidates: List[int], target: int) -> List[List[int]]:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    candidates = [int(next(it)) for _ in range(int(next(it)))]\n    target = int(next(it))\n    result = combination_sum(candidates, target)\n    print('\\n'.join(' '.join(map(str, row)) for row in result))\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction combinationSum(candidates, target) {\n  // Write your solution here\n}\n\nconst candidates = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst target = parseInt(next());\nconst result = combinationSum(candidates, target);\nconsole.log(result.map((row) => row.join(' ')).join('\\n'));\n","java":"import java.util.*;\n\npublic class Main {\n    static int[][] combinationSum(int[] candidates, int target) {\n        // Write your solution here\n        return new int[0][];\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int[] candidates = new int[scanner.nextInt()];\n        for (int i = 0; i < candidates.length; i++) candidates[i] = scanner.nextInt();\n        int target = scanner.nextInt();\n        int[][] result = combinationSum(candidates, target);\n        StringBuilder sb = new StringBuilder();\n        for (int[] row : result) {\n            for (int j = 0; j < row.length; j++) {\n                if (j > 0) sb.append(' ');\n                sb.append(row[j]);\n            }\n            sb.append('\\n');\n        }\n        System.out.print(sb);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nvector<vector<int>> combinationSum(vector<int> candidates, int target) {\n    // Write your solution here\n    return {};\n}\n\nint main() {\n    int candidatesN;\n    cin >> candidatesN;\n    vector<int> candidates(candidatesN);\n    for (int& x : candidates) cin >> x;\n    int target;\n    cin >> target;\n    auto result = combinationSum(candidates, target);\n    for (auto& row : result) {\n        for (size_t j = 0; j < row.size(); j++) {\n            if (j) cout << ' ';\n            cout << row[j];\n        }\n        cout << '\\n';\n    }\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"4\n2 3 6 7\n7","expected":"2 2 3\n7"},{"input":"3\n2 3 5\n8","expected":"2 2 2 2\n2 3 3\n3 5"},{"input":"1\n2\n4","expected":"2 2"},{"input":"3\n3 6 7\n12","expected":"3 3 3 3\n3 3 6\n6 6"},{"input":"3\n2 5 7\n11","expected":"2 2 2 5\n2 2 7"},{"input":"3\n3 4 8\n16","expected":"3 3 3 3 4\n4 4 4 4\n4 4 8\n8 8"}]$j$::jsonb,
  $q$1 <= n <= 30; 1 <= target <= 40$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Accenture']::text[], ARRAY['backtracking']::text[]);

-- 10 | medium | Combination Sum II
SELECT pg_temp.seed_coding($q$Recursion & Backtracking$q$, 'medium', $q$Combination Sum II$q$, $q$Candidates may contain duplicates and each element can be used at most once. Print every UNIQUE combination (ascending, no repeated combination) that sums to target, one per line, in lexicographic order. At least one combination exists in every test.

Input Format:
- candidates: an integer n, then a line of n space-separated integers
- target: a single integer

Output Format:
Print each row on its own line, values separated by single spaces.

Example:
Input:
7
10 1 2 7 6 1 5
8
Output:
1 1 6
1 2 5
1 7
2 6$q$,
  $q$def combination_sum2(candidates: List[int], target: int) -> List[List[int]]$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef combination_sum2(candidates: List[int], target: int) -> List[List[int]]:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    candidates = [int(next(it)) for _ in range(int(next(it)))]\n    target = int(next(it))\n    result = combination_sum2(candidates, target)\n    print('\\n'.join(' '.join(map(str, row)) for row in result))\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction combinationSum2(candidates, target) {\n  // Write your solution here\n}\n\nconst candidates = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst target = parseInt(next());\nconst result = combinationSum2(candidates, target);\nconsole.log(result.map((row) => row.join(' ')).join('\\n'));\n","java":"import java.util.*;\n\npublic class Main {\n    static int[][] combinationSum2(int[] candidates, int target) {\n        // Write your solution here\n        return new int[0][];\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int[] candidates = new int[scanner.nextInt()];\n        for (int i = 0; i < candidates.length; i++) candidates[i] = scanner.nextInt();\n        int target = scanner.nextInt();\n        int[][] result = combinationSum2(candidates, target);\n        StringBuilder sb = new StringBuilder();\n        for (int[] row : result) {\n            for (int j = 0; j < row.length; j++) {\n                if (j > 0) sb.append(' ');\n                sb.append(row[j]);\n            }\n            sb.append('\\n');\n        }\n        System.out.print(sb);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nvector<vector<int>> combinationSum2(vector<int> candidates, int target) {\n    // Write your solution here\n    return {};\n}\n\nint main() {\n    int candidatesN;\n    cin >> candidatesN;\n    vector<int> candidates(candidatesN);\n    for (int& x : candidates) cin >> x;\n    int target;\n    cin >> target;\n    auto result = combinationSum2(candidates, target);\n    for (auto& row : result) {\n        for (size_t j = 0; j < row.size(); j++) {\n            if (j) cout << ' ';\n            cout << row[j];\n        }\n        cout << '\\n';\n    }\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"7\n10 1 2 7 6 1 5\n8","expected":"1 1 6\n1 2 5\n1 7\n2 6"},{"input":"5\n2 5 2 1 2\n5","expected":"1 2 2\n5"},{"input":"2\n3 3\n6","expected":"3 3"},{"input":"6\n4 4 2 1 5 3\n5","expected":"1 4\n2 3\n5"},{"input":"8\n3 3 4 5 6 6 3 1\n6","expected":"1 5\n3 3\n6"},{"input":"8\n6 3 1 2 3 4 5 2\n10","expected":"1 2 2 5\n1 2 3 4\n1 3 6\n1 4 5\n2 2 3 3\n2 2 6\n2 3 5\n3 3 4\n4 6"}]$j$::jsonb,
  $q$1 <= n <= 100; 1 <= target <= 30$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Accenture']::text[], ARRAY['backtracking','deduplication']::text[]);

-- 11 | medium | Letter Combinations of a Phone Number
SELECT pg_temp.seed_coding($q$Recursion & Backtracking$q$, 'medium', $q$Letter Combinations of a Phone Number$q$, $q$On a phone keypad 2=abc, 3=def, 4=ghi, 5=jkl, 6=mno, 7=pqrs, 8=tuv, 9=wxyz. Print every letter combination the digit string (digits 2-9) could represent, in lexicographic order, separated by spaces.

Input Format:
- digits: a single string (no spaces)

Output Format:
Print the strings on one line, separated by single spaces.

Example:
Input:
23
Output:
ad ae af bd be bf cd ce cf$q$,
  $q$def letter_combinations(digits: str) -> List[str]$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef letter_combinations(digits: str) -> List[str]:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    digits = next(it)\n    result = letter_combinations(digits)\n    print(' '.join(result))\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction letterCombinations(digits) {\n  // Write your solution here\n}\n\nconst digits = next();\nconst result = letterCombinations(digits);\nconsole.log(result.join(' '));\n","java":"import java.util.*;\n\npublic class Main {\n    static String[] letterCombinations(String digits) {\n        // Write your solution here\n        return new String[0];\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String digits = scanner.next();\n        String[] result = letterCombinations(digits);\n        System.out.println(String.join(\" \", result));\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nvector<string> letterCombinations(string digits) {\n    // Write your solution here\n    return {};\n}\n\nint main() {\n    string digits;\n    cin >> digits;\n    auto result = letterCombinations(digits);\n    for (size_t i = 0; i < result.size(); i++) {\n        if (i) cout << ' ';\n        cout << result[i];\n    }\n    cout << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"23","expected":"ad ae af bd be bf cd ce cf"},{"input":"2","expected":"a b c"},{"input":"79","expected":"pw px py pz qw qx qy qz rw rx ry rz sw sx sy sz"},{"input":"9","expected":"w x y z"},{"input":"8","expected":"t u v"},{"input":"4","expected":"g h i"}]$j$::jsonb,
  $q$1 <= length <= 4$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Accenture','Infosys']::text[], ARRAY['backtracking']::text[]);

-- 12 | medium | Generate Parentheses
SELECT pg_temp.seed_coding($q$Recursion & Backtracking$q$, 'medium', $q$Generate Parentheses$q$, $q$Print all well-formed strings of n pairs of parentheses, in lexicographic order ('(' sorts before ')'), separated by spaces.

Input Format:
- n: a single integer

Output Format:
Print the strings on one line, separated by single spaces.

Example:
Input:
3
Output:
((())) (()()) (())() ()(()) ()()()$q$,
  $q$def generate_parentheses(n: int) -> List[str]$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef generate_parentheses(n: int) -> List[str]:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    n = int(next(it))\n    result = generate_parentheses(n)\n    print(' '.join(result))\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction generateParentheses(n) {\n  // Write your solution here\n}\n\nconst n = parseInt(next());\nconst result = generateParentheses(n);\nconsole.log(result.join(' '));\n","java":"import java.util.*;\n\npublic class Main {\n    static String[] generateParentheses(int n) {\n        // Write your solution here\n        return new String[0];\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int n = scanner.nextInt();\n        String[] result = generateParentheses(n);\n        System.out.println(String.join(\" \", result));\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nvector<string> generateParentheses(int n) {\n    // Write your solution here\n    return {};\n}\n\nint main() {\n    int n;\n    cin >> n;\n    auto result = generateParentheses(n);\n    for (size_t i = 0; i < result.size(); i++) {\n        if (i) cout << ' ';\n        cout << result[i];\n    }\n    cout << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"3","expected":"((())) (()()) (())() ()(()) ()()()"},{"input":"1","expected":"()"},{"input":"2","expected":"(()) ()()"},{"input":"4","expected":"(((()))) ((()())) ((())()) ((()))() (()(())) (()()()) (()())() (())(()) (())()() ()((())) ()(()()) ()(())() ()()(()) ()()()()"},{"input":"5","expected":"((((())))) (((()()))) (((())())) (((()))()) (((())))() ((()(()))) ((()()())) ((()())()) ((()()))() ((())(())) ((())()()) ((())())() ((()))(()) ((()))()() (()((()))) (()(()())) (()(())()) (()(()))() (()()(())) (()()()()) (()()())() (()())(()) (()())()() (())((())) (())(()()) (())(())() (())()(()) (())()()() ()(((()))) ()((()())) ()((())()) ()((()))() ()(()(())) ()(()()()) ()(()())() ()(())(()) ()(())()() ()()((())) ()()(()()) ()()(())() ()()()(()) ()()()()()"}]$j$::jsonb,
  $q$1 <= n <= 8$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Accenture']::text[], ARRAY['backtracking']::text[]);

-- 13 | medium | Palindrome Partitioning
SELECT pg_temp.seed_coding($q$Recursion & Backtracking$q$, 'medium', $q$Palindrome Partitioning$q$, $q$Print the NUMBER of ways to cut the string into pieces such that every piece is a palindrome.

Input Format:
- s: a single string (no spaces)

Output Format:
Print a single integer.

Example:
Input:
aab
Output:
2$q$,
  $q$def count_palindrome_partitions(s: str) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef count_palindrome_partitions(s: str) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    s = next(it)\n    result = count_palindrome_partitions(s)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction countPalindromePartitions(s) {\n  // Write your solution here\n}\n\nconst s = next();\nconst result = countPalindromePartitions(s);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int countPalindromePartitions(String s) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String s = scanner.next();\n        int result = countPalindromePartitions(s);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint countPalindromePartitions(string s) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    string s;\n    cin >> s;\n    auto result = countPalindromePartitions(s);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"aab","expected":"2"},{"input":"a","expected":"1"},{"input":"aaaa","expected":"8"},{"input":"bbbbbbabb","expected":"88"},{"input":"baabbbaab","expected":"28"},{"input":"bbaaa","expected":"8"}]$j$::jsonb,
  $q$1 <= length <= 16$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Accenture']::text[], ARRAY['backtracking','dp']::text[]);

-- 14 | hard | N-Queens
SELECT pg_temp.seed_coding($q$Recursion & Backtracking$q$, 'hard', $q$N-Queens$q$, $q$Print the number of distinct ways to place n queens on an n x n chessboard so that no two queens attack each other (same row, column or diagonal).

Input Format:
- n: a single integer

Output Format:
Print a single integer.

Example:
Input:
4
Output:
2$q$,
  $q$def total_n_queens(n: int) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef total_n_queens(n: int) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    n = int(next(it))\n    result = total_n_queens(n)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction totalNQueens(n) {\n  // Write your solution here\n}\n\nconst n = parseInt(next());\nconst result = totalNQueens(n);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int totalNQueens(int n) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int n = scanner.nextInt();\n        int result = totalNQueens(n);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint totalNQueens(int n) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int n;\n    cin >> n;\n    auto result = totalNQueens(n);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"4","expected":"2"},{"input":"1","expected":"1"},{"input":"6","expected":"4"},{"input":"8","expected":"92"},{"input":"5","expected":"10"},{"input":"7","expected":"40"}]$j$::jsonb,
  $q$1 <= n <= 9$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Accenture']::text[], ARRAY['backtracking']::text[]);

-- 15 | medium | Word Search
SELECT pg_temp.seed_coding($q$Recursion & Backtracking$q$, 'medium', $q$Word Search$q$, $q$The board is given as rows of letters. Print true if the word can be traced through horizontally or vertically adjacent cells, using each cell at most once.

Input Format:
- board: an integer n, then n space-separated strings
- word: a single string (no spaces)

Output Format:
Print true or false (lowercase).

Example:
Input:
3
ABCE SFCS ADEE
ABCCED
Output:
true$q$,
  $q$def exist(board: List[str], word: str) -> bool$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef exist(board: List[str], word: str) -> bool:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    board = [next(it) for _ in range(int(next(it)))]\n    word = next(it)\n    result = exist(board, word)\n    print('true' if result else 'false')\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction exist(board, word) {\n  // Write your solution here\n}\n\nconst board = Array.from({ length: parseInt(next()) }, () => next());\nconst word = next();\nconst result = exist(board, word);\nconsole.log(result ? 'true' : 'false');\n","java":"import java.util.*;\n\npublic class Main {\n    static boolean exist(String[] board, String word) {\n        // Write your solution here\n        return false;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String[] board = new String[scanner.nextInt()];\n        for (int i = 0; i < board.length; i++) board[i] = scanner.next();\n        String word = scanner.next();\n        boolean result = exist(board, word);\n        System.out.println(result ? \"true\" : \"false\");\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nbool exist(vector<string> board, string word) {\n    // Write your solution here\n    return false;\n}\n\nint main() {\n    int boardN;\n    cin >> boardN;\n    vector<string> board(boardN);\n    for (string& x : board) cin >> x;\n    string word;\n    cin >> word;\n    auto result = exist(board, word);\n    cout << (result ? \"true\" : \"false\") << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"3\nABCE SFCS ADEE\nABCCED","expected":"true"},{"input":"3\nABCE SFCS ADEE\nSEE","expected":"true"},{"input":"3\nABCE SFCS ADEE\nABCB","expected":"false"},{"input":"3\nACC BCA ACB\nCCB","expected":"true"},{"input":"3\nBBC CCB ABB\nABBBBA","expected":"false"},{"input":"3\nBBA AAC CAA\nBAABA","expected":"true"}]$j$::jsonb,
  $q$1 <= rows, cols <= 6; 1 <= word length <= 15$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Accenture']::text[], ARRAY['backtracking','grid']::text[]);

-- 16 | medium | Rat in a Maze
SELECT pg_temp.seed_coding($q$Recursion & Backtracking$q$, 'medium', $q$Rat in a Maze$q$, $q$A rat starts at the top-left of an n x n maze and wants to reach the bottom-right. Cells with 1 are open, 0 are walls. The rat moves up, down, left or right and may not visit a cell twice on the same path. Print the number of distinct paths.

Input Format:
- maze: two integers r and c, then r lines of c space-separated integers

Output Format:
Print a single integer.

Example:
Input:
3 3
1 1 1
1 0 1
1 1 1
Output:
2$q$,
  $q$def count_maze_paths(maze: List[List[int]]) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef count_maze_paths(maze: List[List[int]]) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    rows, cols = int(next(it)), int(next(it))\n    maze = [[int(next(it)) for _ in range(cols)] for _ in range(rows)]\n    result = count_maze_paths(maze)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction countMazePaths(maze) {\n  // Write your solution here\n}\n\nconst mazeRows = parseInt(next());\nconst mazeCols = parseInt(next());\nconst maze = Array.from({ length: mazeRows }, () => Array.from({ length: mazeCols }, () => parseInt(next())));\nconst result = countMazePaths(maze);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int countMazePaths(int[][] maze) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int mazeRows = scanner.nextInt(), mazeCols = scanner.nextInt();\n        int[][] maze = new int[mazeRows][mazeCols];\n        for (int i = 0; i < mazeRows; i++)\n            for (int j = 0; j < mazeCols; j++) maze[i][j] = scanner.nextInt();\n        int result = countMazePaths(maze);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint countMazePaths(vector<vector<int>> maze) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int mazeRows, mazeCols;\n    cin >> mazeRows >> mazeCols;\n    vector<vector<int>> maze(mazeRows, vector<int>(mazeCols));\n    for (auto& row : maze) for (int& x : row) cin >> x;\n    auto result = countMazePaths(maze);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"3 3\n1 1 1\n1 0 1\n1 1 1","expected":"2"},{"input":"2 2\n1 0\n0 1","expected":"0"},{"input":"1 1\n1","expected":"1"},{"input":"4 4\n1 1 1 1\n1 1 0 1\n1 1 1 1\n1 0 1 1","expected":"14"},{"input":"4 4\n1 1 0 1\n1 1 1 1\n1 1 1 0\n1 1 1 1","expected":"22"},{"input":"4 4\n1 1 1 1\n1 1 1 1\n1 1 1 1\n1 0 1 1","expected":"67"}]$j$::jsonb,
  $q$1 <= n <= 6$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','TCS','Accenture']::text[], ARRAY['backtracking','grid']::text[]);

-- 17 | easy | Count Subsets with Given Sum
SELECT pg_temp.seed_coding($q$Recursion & Backtracking$q$, 'easy', $q$Count Subsets with Given Sum$q$, $q$Print how many subsets (chosen by index, so equal values at different positions count separately; the empty subset counts only if target is 0) add up to target.

Input Format:
- nums: an integer n, then a line of n space-separated integers
- target: a single integer

Output Format:
Print a single integer.

Example:
Input:
5
1 2 3 4 5
5
Output:
3$q$,
  $q$def count_subsets(nums: List[int], target: int) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef count_subsets(nums: List[int], target: int) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    nums = [int(next(it)) for _ in range(int(next(it)))]\n    target = int(next(it))\n    result = count_subsets(nums, target)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction countSubsets(nums, target) {\n  // Write your solution here\n}\n\nconst nums = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst target = parseInt(next());\nconst result = countSubsets(nums, target);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int countSubsets(int[] nums, int target) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int[] nums = new int[scanner.nextInt()];\n        for (int i = 0; i < nums.length; i++) nums[i] = scanner.nextInt();\n        int target = scanner.nextInt();\n        int result = countSubsets(nums, target);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint countSubsets(vector<int> nums, int target) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int numsN;\n    cin >> numsN;\n    vector<int> nums(numsN);\n    for (int& x : nums) cin >> x;\n    int target;\n    cin >> target;\n    auto result = countSubsets(nums, target);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"5\n1 2 3 4 5\n5","expected":"3"},{"input":"3\n1 1 1\n2","expected":"3"},{"input":"2\n2 4\n3","expected":"0"},{"input":"8\n6 4 1 5 6 5 1 3\n6","expected":"7"},{"input":"6\n1 1 6 3 2 1\n11","expected":"5"},{"input":"5\n1 1 1 3 2\n6","expected":"4"}]$j$::jsonb,
  $q$1 <= n <= 20; 0 <= nums[i] <= 100$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['recursion','subsets']::text[]);

-- 18 | medium | Unique Permutations
SELECT pg_temp.seed_coding($q$Recursion & Backtracking$q$, 'medium', $q$Unique Permutations$q$, $q$The array may contain duplicates. Print every UNIQUE permutation, one per line, in lexicographic order.

Input Format:
- nums: an integer n, then a line of n space-separated integers

Output Format:
Print each row on its own line, values separated by single spaces.

Example:
Input:
3
1 1 2
Output:
1 1 2
1 2 1
2 1 1$q$,
  $q$def permute_unique(nums: List[int]) -> List[List[int]]$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef permute_unique(nums: List[int]) -> List[List[int]]:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    nums = [int(next(it)) for _ in range(int(next(it)))]\n    result = permute_unique(nums)\n    print('\\n'.join(' '.join(map(str, row)) for row in result))\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction permuteUnique(nums) {\n  // Write your solution here\n}\n\nconst nums = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst result = permuteUnique(nums);\nconsole.log(result.map((row) => row.join(' ')).join('\\n'));\n","java":"import java.util.*;\n\npublic class Main {\n    static int[][] permuteUnique(int[] nums) {\n        // Write your solution here\n        return new int[0][];\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int[] nums = new int[scanner.nextInt()];\n        for (int i = 0; i < nums.length; i++) nums[i] = scanner.nextInt();\n        int[][] result = permuteUnique(nums);\n        StringBuilder sb = new StringBuilder();\n        for (int[] row : result) {\n            for (int j = 0; j < row.length; j++) {\n                if (j > 0) sb.append(' ');\n                sb.append(row[j]);\n            }\n            sb.append('\\n');\n        }\n        System.out.print(sb);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nvector<vector<int>> permuteUnique(vector<int> nums) {\n    // Write your solution here\n    return {};\n}\n\nint main() {\n    int numsN;\n    cin >> numsN;\n    vector<int> nums(numsN);\n    for (int& x : nums) cin >> x;\n    auto result = permuteUnique(nums);\n    for (auto& row : result) {\n        for (size_t j = 0; j < row.size(); j++) {\n            if (j) cout << ' ';\n            cout << row[j];\n        }\n        cout << '\\n';\n    }\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"3\n1 1 2","expected":"1 1 2\n1 2 1\n2 1 1"},{"input":"3\n1 2 3","expected":"1 2 3\n1 3 2\n2 1 3\n2 3 1\n3 1 2\n3 2 1"},{"input":"2\n2 2","expected":"2 2"},{"input":"3\n2 2 2","expected":"2 2 2"},{"input":"4\n2 3 2 2","expected":"2 2 2 3\n2 2 3 2\n2 3 2 2\n3 2 2 2"},{"input":"3\n1 2 1","expected":"1 1 2\n1 2 1\n2 1 1"}]$j$::jsonb,
  $q$1 <= n <= 8$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Accenture']::text[], ARRAY['backtracking','deduplication']::text[]);

-- 19 | medium | Beautiful Arrangement
SELECT pg_temp.seed_coding($q$Recursion & Backtracking$q$, 'medium', $q$Beautiful Arrangement$q$, $q$A permutation p of 1..n is beautiful if for every position i (1-based), p[i] is divisible by i OR i is divisible by p[i]. Print how many beautiful permutations exist.

Input Format:
- n: a single integer

Output Format:
Print a single integer.

Example:
Input:
2
Output:
2$q$,
  $q$def count_arrangement(n: int) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef count_arrangement(n: int) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    n = int(next(it))\n    result = count_arrangement(n)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction countArrangement(n) {\n  // Write your solution here\n}\n\nconst n = parseInt(next());\nconst result = countArrangement(n);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int countArrangement(int n) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int n = scanner.nextInt();\n        int result = countArrangement(n);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint countArrangement(int n) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int n;\n    cin >> n;\n    auto result = countArrangement(n);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"2","expected":"2"},{"input":"3","expected":"3"},{"input":"4","expected":"8"},{"input":"8","expected":"132"},{"input":"5","expected":"10"}]$j$::jsonb,
  $q$1 <= n <= 12$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon']::text[], ARRAY['backtracking']::text[]);

-- 20 | hard | Partition to K Equal Sum Subsets
SELECT pg_temp.seed_coding($q$Recursion & Backtracking$q$, 'hard', $q$Partition to K Equal Sum Subsets$q$, $q$Print true if the array can be divided into k non-empty subsets whose sums are all equal (every element used exactly once).

Input Format:
- nums: an integer n, then a line of n space-separated integers
- k: a single integer

Output Format:
Print true or false (lowercase).

Example:
Input:
7
4 3 2 3 5 2 1
4
Output:
true$q$,
  $q$def can_partition_k_subsets(nums: List[int], k: int) -> bool$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef can_partition_k_subsets(nums: List[int], k: int) -> bool:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    nums = [int(next(it)) for _ in range(int(next(it)))]\n    k = int(next(it))\n    result = can_partition_k_subsets(nums, k)\n    print('true' if result else 'false')\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction canPartitionKSubsets(nums, k) {\n  // Write your solution here\n}\n\nconst nums = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst k = parseInt(next());\nconst result = canPartitionKSubsets(nums, k);\nconsole.log(result ? 'true' : 'false');\n","java":"import java.util.*;\n\npublic class Main {\n    static boolean canPartitionKSubsets(int[] nums, int k) {\n        // Write your solution here\n        return false;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int[] nums = new int[scanner.nextInt()];\n        for (int i = 0; i < nums.length; i++) nums[i] = scanner.nextInt();\n        int k = scanner.nextInt();\n        boolean result = canPartitionKSubsets(nums, k);\n        System.out.println(result ? \"true\" : \"false\");\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nbool canPartitionKSubsets(vector<int> nums, int k) {\n    // Write your solution here\n    return false;\n}\n\nint main() {\n    int numsN;\n    cin >> numsN;\n    vector<int> nums(numsN);\n    for (int& x : nums) cin >> x;\n    int k;\n    cin >> k;\n    auto result = canPartitionKSubsets(nums, k);\n    cout << (result ? \"true\" : \"false\") << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"7\n4 3 2 3 5 2 1\n4","expected":"true"},{"input":"4\n1 2 3 4\n3","expected":"false"},{"input":"4\n2 2 2 2\n2","expected":"true"},{"input":"9\n5 3 5 4 3 3 3 1 2\n3","expected":"false"},{"input":"6\n3 1 2 3 2 4\n2","expected":"false"},{"input":"9\n4 4 3 1 1 1 1 2 2\n2","expected":"false"}]$j$::jsonb,
  $q$1 <= k <= n <= 16; 1 <= nums[i] <= 10^4$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon']::text[], ARRAY['backtracking','bitmask']::text[]);

-- 21 | medium | Restore IP Addresses
SELECT pg_temp.seed_coding($q$Recursion & Backtracking$q$, 'medium', $q$Restore IP Addresses$q$, $q$Insert three dots into the digit string to form every valid IPv4 address: four numbers from 0 to 255, no leading zeros (the number 0 itself is fine). Print all addresses in lexicographic order separated by spaces, or -1 if none exists.

Input Format:
- s: a single string (no spaces)

Output Format:
Print the strings on one line, separated by single spaces.

Example:
Input:
25525511135
Output:
255.255.11.135 255.255.111.35$q$,
  $q$def restore_ip_addresses(s: str) -> List[str]$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef restore_ip_addresses(s: str) -> List[str]:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    s = next(it)\n    result = restore_ip_addresses(s)\n    print(' '.join(result))\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction restoreIpAddresses(s) {\n  // Write your solution here\n}\n\nconst s = next();\nconst result = restoreIpAddresses(s);\nconsole.log(result.join(' '));\n","java":"import java.util.*;\n\npublic class Main {\n    static String[] restoreIpAddresses(String s) {\n        // Write your solution here\n        return new String[0];\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String s = scanner.next();\n        String[] result = restoreIpAddresses(s);\n        System.out.println(String.join(\" \", result));\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nvector<string> restoreIpAddresses(string s) {\n    // Write your solution here\n    return {};\n}\n\nint main() {\n    string s;\n    cin >> s;\n    auto result = restoreIpAddresses(s);\n    for (size_t i = 0; i < result.size(); i++) {\n        if (i) cout << ' ';\n        cout << result[i];\n    }\n    cout << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"25525511135","expected":"255.255.11.135 255.255.111.35"},{"input":"0000","expected":"0.0.0.0"},{"input":"101023","expected":"1.0.10.23 1.0.102.3 10.1.0.23 10.10.2.3 101.0.2.3"},{"input":"111","expected":"-1"},{"input":"12332","expected":"1.2.3.32 1.2.33.2 1.23.3.2 12.3.3.2"},{"input":"01132131","expected":"0.1.132.131 0.11.32.131 0.113.2.131 0.113.21.31 0.113.213.1"},{"input":"30222","expected":"3.0.2.22 3.0.22.2 30.2.2.2"}]$j$::jsonb,
  $q$1 <= length <= 20$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Accenture']::text[], ARRAY['backtracking','strings']::text[]);

-- 22 | hard | Expression Add Operators
SELECT pg_temp.seed_coding($q$Recursion & Backtracking$q$, 'hard', $q$Expression Add Operators$q$, $q$Insert '+', '-' or '*' between the digits of num (or nothing, to join digits into a bigger number) so the expression equals target. Operands may not have leading zeros (except the single digit 0). Print the NUMBER of expressions that evaluate to target.

Input Format:
- num: a single string (no spaces)
- target: a single integer

Output Format:
Print a single integer.

Example:
Input:
123
6
Output:
2$q$,
  $q$def count_expressions(num: str, target: int) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef count_expressions(num: str, target: int) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    num = next(it)\n    target = int(next(it))\n    result = count_expressions(num, target)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction countExpressions(num, target) {\n  // Write your solution here\n}\n\nconst num = next();\nconst target = parseInt(next());\nconst result = countExpressions(num, target);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int countExpressions(String num, int target) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String num = scanner.next();\n        int target = scanner.nextInt();\n        int result = countExpressions(num, target);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint countExpressions(string num, int target) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    string num;\n    cin >> num;\n    int target;\n    cin >> target;\n    auto result = countExpressions(num, target);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"123\n6","expected":"2"},{"input":"232\n8","expected":"2"},{"input":"105\n5","expected":"2"},{"input":"00\n0","expected":"3"},{"input":"3456237490\n9191","expected":"0"},{"input":"025835\n11","expected":"2"},{"input":"733851\n13","expected":"3"},{"input":"335373\n15","expected":"3"}]$j$::jsonb,
  $q$1 <= length <= 10$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon']::text[], ARRAY['backtracking','math']::text[]);

-- 23 | hard | Sudoku Solver
SELECT pg_temp.seed_coding($q$Recursion & Backtracking$q$, 'hard', $q$Sudoku Solver$q$, $q$Fill the 9 x 9 grid so every row, every column and every 3 x 3 box contains each digit 1-9 exactly once. Empty cells are 0. Each puzzle has exactly one solution. Print the completed grid.

Input Format:
- board: two integers r and c, then r lines of c space-separated integers

Output Format:
Print each row on its own line, values separated by single spaces.

Example:
Input:
9 9
5 3 0 0 7 0 0 0 0
6 0 0 1 9 5 0 0 0
0 9 8 0 0 0 0 6 0
8 0 0 0 6 0 0 0 3
4 0 0 8 0 3 0 0 1
7 0 0 0 2 0 0 0 6
0 6 0 0 0 0 2 8 0
0 0 0 4 1 9 0 0 5
0 0 0 0 8 0 0 7 9
Output:
5 3 4 6 7 8 9 1 2
6 7 2 1 9 5 3 4 8
1 9 8 3 4 2 5 6 7
8 5 9 7 6 1 4 2 3
4 2 6 8 5 3 7 9 1
7 1 3 9 2 4 8 5 6
9 6 1 5 3 7 2 8 4
2 8 7 4 1 9 6 3 5
3 4 5 2 8 6 1 7 9$q$,
  $q$def solve_sudoku(board: List[List[int]]) -> List[List[int]]$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef solve_sudoku(board: List[List[int]]) -> List[List[int]]:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    rows, cols = int(next(it)), int(next(it))\n    board = [[int(next(it)) for _ in range(cols)] for _ in range(rows)]\n    result = solve_sudoku(board)\n    print('\\n'.join(' '.join(map(str, row)) for row in result))\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction solveSudoku(board) {\n  // Write your solution here\n}\n\nconst boardRows = parseInt(next());\nconst boardCols = parseInt(next());\nconst board = Array.from({ length: boardRows }, () => Array.from({ length: boardCols }, () => parseInt(next())));\nconst result = solveSudoku(board);\nconsole.log(result.map((row) => row.join(' ')).join('\\n'));\n","java":"import java.util.*;\n\npublic class Main {\n    static int[][] solveSudoku(int[][] board) {\n        // Write your solution here\n        return new int[0][];\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int boardRows = scanner.nextInt(), boardCols = scanner.nextInt();\n        int[][] board = new int[boardRows][boardCols];\n        for (int i = 0; i < boardRows; i++)\n            for (int j = 0; j < boardCols; j++) board[i][j] = scanner.nextInt();\n        int[][] result = solveSudoku(board);\n        StringBuilder sb = new StringBuilder();\n        for (int[] row : result) {\n            for (int j = 0; j < row.length; j++) {\n                if (j > 0) sb.append(' ');\n                sb.append(row[j]);\n            }\n            sb.append('\\n');\n        }\n        System.out.print(sb);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nvector<vector<int>> solveSudoku(vector<vector<int>> board) {\n    // Write your solution here\n    return {};\n}\n\nint main() {\n    int boardRows, boardCols;\n    cin >> boardRows >> boardCols;\n    vector<vector<int>> board(boardRows, vector<int>(boardCols));\n    for (auto& row : board) for (int& x : row) cin >> x;\n    auto result = solveSudoku(board);\n    for (auto& row : result) {\n        for (size_t j = 0; j < row.size(); j++) {\n            if (j) cout << ' ';\n            cout << row[j];\n        }\n        cout << '\\n';\n    }\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"9 9\n5 3 0 0 7 0 0 0 0\n6 0 0 1 9 5 0 0 0\n0 9 8 0 0 0 0 6 0\n8 0 0 0 6 0 0 0 3\n4 0 0 8 0 3 0 0 1\n7 0 0 0 2 0 0 0 6\n0 6 0 0 0 0 2 8 0\n0 0 0 4 1 9 0 0 5\n0 0 0 0 8 0 0 7 9","expected":"5 3 4 6 7 8 9 1 2\n6 7 2 1 9 5 3 4 8\n1 9 8 3 4 2 5 6 7\n8 5 9 7 6 1 4 2 3\n4 2 6 8 5 3 7 9 1\n7 1 3 9 2 4 8 5 6\n9 6 1 5 3 7 2 8 4\n2 8 7 4 1 9 6 3 5\n3 4 5 2 8 6 1 7 9"},{"input":"9 9\n0 3 4 6 0 8 9 1 2\n6 0 2 1 9 5 3 0 8\n1 9 0 3 4 0 5 6 7\n8 5 9 0 6 1 4 2 0\n0 2 6 8 0 3 7 9 1\n7 1 0 9 2 4 0 5 6\n9 0 1 5 3 0 2 8 4\n2 8 7 0 1 9 6 3 0\n0 4 5 2 8 6 0 7 9","expected":"5 3 4 6 7 8 9 1 2\n6 7 2 1 9 5 3 4 8\n1 9 8 3 4 2 5 6 7\n8 5 9 7 6 1 4 2 3\n4 2 6 8 5 3 7 9 1\n7 1 3 9 2 4 8 5 6\n9 6 1 5 3 7 2 8 4\n2 8 7 4 1 9 6 3 5\n3 4 5 2 8 6 1 7 9"}]$j$::jsonb,
  $q$9 x 9 grid; the puzzle has a unique solution$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon']::text[], ARRAY['backtracking','constraint-satisfaction']::text[]);


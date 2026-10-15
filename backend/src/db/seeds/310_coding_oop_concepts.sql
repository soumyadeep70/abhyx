-- 310_coding_oop_concepts.sql
-- Topic: OOP Concepts (coding) -- 22 questions.
-- Idempotent: re-running updates these rows in place (matched on topic + title).
-- Requires the helpers in 010_question_helpers.sql (run in the same session by `npm run seed`).

-- 01 | easy | Bank Account
SELECT pg_temp.seed_coding($q$OOP Concepts$q$, 'easy', $q$Bank Account$q$, $q$Encapsulate a bank account whose balance starts at 0 and can never become negative. Commands: DEPOSIT x (add x, no output); WITHDRAW x (subtract x only if the balance is at least x, output 1 on success and 0 on failure); BALANCE (output the balance). Input: ops[i] is a command and (args[i][0], args[i][1]) are its two integer arguments (arguments a command does not use are 0). Model the system with proper classes (for example a base class or interface plus subclasses, or a class that hides its state) and have your function drive them. Print the output of the commands that produce output, in order.

Input Format:
- ops: an integer n, then n space-separated strings
- args: two integers r and c, then r lines of c space-separated integers

Output Format:
Print the integers on one line, separated by single spaces.

Example:
Input:
4
DEPOSIT WITHDRAW WITHDRAW BALANCE
4 2
100 0
30 0
100 0
0 0
Output:
1 0 70$q$,
  $q$def run_bank(ops: List[str], args: List[List[int]]) -> List[int]$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef run_bank(ops: List[str], args: List[List[int]]) -> List[int]:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    ops = [next(it) for _ in range(int(next(it)))]\n    rows, cols = int(next(it)), int(next(it))\n    args = [[int(next(it)) for _ in range(cols)] for _ in range(rows)]\n    result = run_bank(ops, args)\n    print(' '.join(map(str, result)))\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction runBank(ops, args) {\n  // Write your solution here\n}\n\nconst ops = Array.from({ length: parseInt(next()) }, () => next());\nconst argsRows = parseInt(next());\nconst argsCols = parseInt(next());\nconst args = Array.from({ length: argsRows }, () => Array.from({ length: argsCols }, () => parseInt(next())));\nconst result = runBank(ops, args);\nconsole.log(result.join(' '));\n","java":"import java.util.*;\n\npublic class Main {\n    static int[] runBank(String[] ops, int[][] args) {\n        // Write your solution here\n        return new int[0];\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String[] ops = new String[scanner.nextInt()];\n        for (int i = 0; i < ops.length; i++) ops[i] = scanner.next();\n        int argsRows = scanner.nextInt(), argsCols = scanner.nextInt();\n        int[][] args = new int[argsRows][argsCols];\n        for (int i = 0; i < argsRows; i++)\n            for (int j = 0; j < argsCols; j++) args[i][j] = scanner.nextInt();\n        int[] result = runBank(ops, args);\n        StringBuilder sb = new StringBuilder();\n        for (int i = 0; i < result.length; i++) {\n            if (i > 0) sb.append(' ');\n            sb.append(result[i]);\n        }\n        System.out.println(sb);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nvector<int> runBank(vector<string> ops, vector<vector<int>> args) {\n    // Write your solution here\n    return {};\n}\n\nint main() {\n    int opsN;\n    cin >> opsN;\n    vector<string> ops(opsN);\n    for (string& x : ops) cin >> x;\n    int argsRows, argsCols;\n    cin >> argsRows >> argsCols;\n    vector<vector<int>> args(argsRows, vector<int>(argsCols));\n    for (auto& row : args) for (int& x : row) cin >> x;\n    auto result = runBank(ops, args);\n    for (size_t i = 0; i < result.size(); i++) {\n        if (i) cout << ' ';\n        cout << result[i];\n    }\n    cout << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"4\nDEPOSIT WITHDRAW WITHDRAW BALANCE\n4 2\n100 0\n30 0\n100 0\n0 0","expected":"1 0 70"},{"input":"1\nBALANCE\n1 2\n0 0","expected":"0"},{"input":"3\nWITHDRAW DEPOSIT WITHDRAW\n3 2\n5 0\n5 0\n5 0","expected":"0 1"},{"input":"12\nDEPOSIT WITHDRAW BALANCE WITHDRAW DEPOSIT BALANCE WITHDRAW BALANCE DEPOSIT BALANCE BALANCE BALANCE\n12 2\n8 0\n59 0\n0 0\n23 0\n9 0\n0 0\n3 0\n0 0\n23 0\n0 0\n0 0\n0 0","expected":"0 8 0 17 1 14 37 37 37"},{"input":"15\nBALANCE DEPOSIT DEPOSIT WITHDRAW WITHDRAW BALANCE BALANCE BALANCE BALANCE WITHDRAW DEPOSIT WITHDRAW WITHDRAW DEPOSIT BALANCE\n15 2\n0 0\n31 0\n43 0\n37 0\n43 0\n0 0\n0 0\n0 0\n0 0\n3 0\n12 0\n50 0\n1 0\n20 0\n0 0","expected":"0 1 0 37 37 37 37 1 0 1 65"},{"input":"9\nBALANCE BALANCE WITHDRAW WITHDRAW WITHDRAW WITHDRAW WITHDRAW WITHDRAW BALANCE\n9 2\n0 0\n0 0\n45 0\n17 0\n52 0\n48 0\n19 0\n18 0\n0 0","expected":"0 0 0 0 0 0 0 0 0"}]$j$::jsonb,
  $q$1 <= n <= 10^4$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['encapsulation','classes']::text[]);

-- 02 | easy | Shapes and Polymorphism
SELECT pg_temp.seed_coding($q$OOP Concepts$q$, 'easy', $q$Shapes and Polymorphism$q$, $q$Design an abstract Shape with a method that returns TWICE its area (so triangles stay integral), and subclasses Rectangle, Square and Triangle. Commands: RECT w h, SQUARE s (second argument unused) and TRIANGLE b h add a shape (no output); TOTAL outputs twice the total area of all shapes added so far (rectangle 2*w*h, square 2*s*s, triangle b*h). Input: ops[i] is a command and (args[i][0], args[i][1]) are its two integer arguments (arguments a command does not use are 0). Model the system with proper classes (for example a base class or interface plus subclasses, or a class that hides its state) and have your function drive them. Print the output of the commands that produce output, in order.

Input Format:
- ops: an integer n, then n space-separated strings
- args: two integers r and c, then r lines of c space-separated integers

Output Format:
Print the integers on one line, separated by single spaces.

Example:
Input:
4
RECT SQUARE TRIANGLE TOTAL
4 2
3 4
5 0
6 3
0 0
Output:
92$q$,
  $q$def total_double_area(ops: List[str], args: List[List[int]]) -> List[int]$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef total_double_area(ops: List[str], args: List[List[int]]) -> List[int]:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    ops = [next(it) for _ in range(int(next(it)))]\n    rows, cols = int(next(it)), int(next(it))\n    args = [[int(next(it)) for _ in range(cols)] for _ in range(rows)]\n    result = total_double_area(ops, args)\n    print(' '.join(map(str, result)))\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction totalDoubleArea(ops, args) {\n  // Write your solution here\n}\n\nconst ops = Array.from({ length: parseInt(next()) }, () => next());\nconst argsRows = parseInt(next());\nconst argsCols = parseInt(next());\nconst args = Array.from({ length: argsRows }, () => Array.from({ length: argsCols }, () => parseInt(next())));\nconst result = totalDoubleArea(ops, args);\nconsole.log(result.join(' '));\n","java":"import java.util.*;\n\npublic class Main {\n    static int[] totalDoubleArea(String[] ops, int[][] args) {\n        // Write your solution here\n        return new int[0];\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String[] ops = new String[scanner.nextInt()];\n        for (int i = 0; i < ops.length; i++) ops[i] = scanner.next();\n        int argsRows = scanner.nextInt(), argsCols = scanner.nextInt();\n        int[][] args = new int[argsRows][argsCols];\n        for (int i = 0; i < argsRows; i++)\n            for (int j = 0; j < argsCols; j++) args[i][j] = scanner.nextInt();\n        int[] result = totalDoubleArea(ops, args);\n        StringBuilder sb = new StringBuilder();\n        for (int i = 0; i < result.length; i++) {\n            if (i > 0) sb.append(' ');\n            sb.append(result[i]);\n        }\n        System.out.println(sb);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nvector<int> totalDoubleArea(vector<string> ops, vector<vector<int>> args) {\n    // Write your solution here\n    return {};\n}\n\nint main() {\n    int opsN;\n    cin >> opsN;\n    vector<string> ops(opsN);\n    for (string& x : ops) cin >> x;\n    int argsRows, argsCols;\n    cin >> argsRows >> argsCols;\n    vector<vector<int>> args(argsRows, vector<int>(argsCols));\n    for (auto& row : args) for (int& x : row) cin >> x;\n    auto result = totalDoubleArea(ops, args);\n    for (size_t i = 0; i < result.size(); i++) {\n        if (i) cout << ' ';\n        cout << result[i];\n    }\n    cout << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"4\nRECT SQUARE TRIANGLE TOTAL\n4 2\n3 4\n5 0\n6 3\n0 0","expected":"92"},{"input":"3\nTOTAL SQUARE TOTAL\n3 2\n0 0\n2 0\n0 0","expected":"0 8"},{"input":"2\nTRIANGLE TOTAL\n2 2\n1 1\n0 0","expected":"1"},{"input":"12\nRECT TRIANGLE TRIANGLE TRIANGLE SQUARE TRIANGLE TRIANGLE SQUARE SQUARE TOTAL TOTAL TOTAL\n12 2\n3 7\n6 1\n3 8\n1 4\n8 0\n1 5\n8 2\n5 0\n8 0\n0 0\n0 0\n0 0","expected":"403 403 403"},{"input":"12\nRECT RECT SQUARE TOTAL SQUARE SQUARE SQUARE RECT TOTAL TOTAL SQUARE TOTAL\n12 2\n4 8\n9 1\n4 0\n0 0\n6 0\n2 0\n9 0\n2 5\n0 0\n0 0\n4 0\n0 0","expected":"114 376 376 408"},{"input":"15\nTOTAL RECT TOTAL TRIANGLE SQUARE TRIANGLE TOTAL SQUARE SQUARE SQUARE RECT SQUARE TRIANGLE TRIANGLE TOTAL\n15 2\n0 0\n7 7\n0 0\n3 7\n9 0\n4 9\n0 0\n7 0\n4 0\n4 0\n7 3\n2 0\n3 8\n6 4\n0 0","expected":"0 98 317 577"}]$j$::jsonb,
  $q$1 <= n <= 10^4$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['polymorphism','inheritance','abstract-class']::text[]);

-- 03 | easy | Stack Class
SELECT pg_temp.seed_coding($q$OOP Concepts$q$, 'easy', $q$Stack Class$q$, $q$Implement a Stack class that hides its storage. Commands: PUSH x (no output); POP (output the removed top, or -1 if empty); PEEK (output the top without removing it, or -1 if empty); SIZE (output the number of items). Input: ops[i] is a command and (args[i][0], args[i][1]) are its two integer arguments (arguments a command does not use are 0). Model the system with proper classes (for example a base class or interface plus subclasses, or a class that hides its state) and have your function drive them. Print the output of the commands that produce output, in order.

Input Format:
- ops: an integer n, then n space-separated strings
- args: two integers r and c, then r lines of c space-separated integers

Output Format:
Print the integers on one line, separated by single spaces.

Example:
Input:
7
PUSH PUSH PEEK POP POP POP SIZE
7 2
1 0
2 0
0 0
0 0
0 0
0 0
0 0
Output:
2 2 1 -1 0$q$,
  $q$def run_stack(ops: List[str], args: List[List[int]]) -> List[int]$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef run_stack(ops: List[str], args: List[List[int]]) -> List[int]:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    ops = [next(it) for _ in range(int(next(it)))]\n    rows, cols = int(next(it)), int(next(it))\n    args = [[int(next(it)) for _ in range(cols)] for _ in range(rows)]\n    result = run_stack(ops, args)\n    print(' '.join(map(str, result)))\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction runStack(ops, args) {\n  // Write your solution here\n}\n\nconst ops = Array.from({ length: parseInt(next()) }, () => next());\nconst argsRows = parseInt(next());\nconst argsCols = parseInt(next());\nconst args = Array.from({ length: argsRows }, () => Array.from({ length: argsCols }, () => parseInt(next())));\nconst result = runStack(ops, args);\nconsole.log(result.join(' '));\n","java":"import java.util.*;\n\npublic class Main {\n    static int[] runStack(String[] ops, int[][] args) {\n        // Write your solution here\n        return new int[0];\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String[] ops = new String[scanner.nextInt()];\n        for (int i = 0; i < ops.length; i++) ops[i] = scanner.next();\n        int argsRows = scanner.nextInt(), argsCols = scanner.nextInt();\n        int[][] args = new int[argsRows][argsCols];\n        for (int i = 0; i < argsRows; i++)\n            for (int j = 0; j < argsCols; j++) args[i][j] = scanner.nextInt();\n        int[] result = runStack(ops, args);\n        StringBuilder sb = new StringBuilder();\n        for (int i = 0; i < result.length; i++) {\n            if (i > 0) sb.append(' ');\n            sb.append(result[i]);\n        }\n        System.out.println(sb);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nvector<int> runStack(vector<string> ops, vector<vector<int>> args) {\n    // Write your solution here\n    return {};\n}\n\nint main() {\n    int opsN;\n    cin >> opsN;\n    vector<string> ops(opsN);\n    for (string& x : ops) cin >> x;\n    int argsRows, argsCols;\n    cin >> argsRows >> argsCols;\n    vector<vector<int>> args(argsRows, vector<int>(argsCols));\n    for (auto& row : args) for (int& x : row) cin >> x;\n    auto result = runStack(ops, args);\n    for (size_t i = 0; i < result.size(); i++) {\n        if (i) cout << ' ';\n        cout << result[i];\n    }\n    cout << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"7\nPUSH PUSH PEEK POP POP POP SIZE\n7 2\n1 0\n2 0\n0 0\n0 0\n0 0\n0 0\n0 0","expected":"2 2 1 -1 0"},{"input":"1\nSIZE\n1 2\n0 0","expected":"0"},{"input":"2\nPUSH SIZE\n2 2\n9 0\n0 0","expected":"1"},{"input":"15\nPUSH POP PEEK SIZE POP SIZE PEEK PUSH PEEK POP PEEK PUSH POP PEEK SIZE\n15 2\n31 0\n0 0\n0 0\n0 0\n0 0\n0 0\n0 0\n30 0\n0 0\n0 0\n0 0\n8 0\n0 0\n0 0\n0 0","expected":"31 -1 0 -1 0 -1 30 30 -1 8 -1 0"},{"input":"13\nPOP POP PEEK SIZE PUSH PEEK SIZE POP POP POP PEEK PUSH SIZE\n13 2\n0 0\n0 0\n0 0\n0 0\n45 0\n0 0\n0 0\n0 0\n0 0\n0 0\n0 0\n45 0\n0 0","expected":"-1 -1 -1 0 45 1 45 -1 -1 -1 1"},{"input":"11\nPEEK PUSH POP PUSH PUSH SIZE PUSH PEEK POP PEEK SIZE\n11 2\n0 0\n36 0\n0 0\n10 0\n49 0\n0 0\n38 0\n0 0\n0 0\n0 0\n0 0","expected":"-1 36 2 38 38 49 2"}]$j$::jsonb,
  $q$1 <= n <= 10^4$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['encapsulation','data-structures']::text[]);

-- 04 | medium | Decorator Pattern: Coffee Order
SELECT pg_temp.seed_coding($q$OOP Concepts$q$, 'medium', $q$Decorator Pattern: Coffee Order$q$, $q$Model a coffee order with the Decorator pattern: BASE p starts a new order costing p (replacing any previous order); each decorator wraps the current order and adds to its cost: MILK +20, SUGAR +5, CARAMEL +35 and WHIP adds one tenth of the CURRENT cost (integer division) - so the ORDER of decorators matters. COST outputs the current cost. Input: ops[i] is a command and (args[i][0], args[i][1]) are its two integer arguments (arguments a command does not use are 0). Model the system with proper classes (for example a base class or interface plus subclasses, or a class that hides its state) and have your function drive them. Print the output of the commands that produce output, in order.

Input Format:
- ops: an integer n, then n space-separated strings
- args: two integers r and c, then r lines of c space-separated integers

Output Format:
Print the integers on one line, separated by single spaces.

Example:
Input:
4
BASE MILK WHIP COST
4 2
100 0
0 0
0 0
0 0
Output:
132$q$,
  $q$def run_coffee(ops: List[str], args: List[List[int]]) -> List[int]$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef run_coffee(ops: List[str], args: List[List[int]]) -> List[int]:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    ops = [next(it) for _ in range(int(next(it)))]\n    rows, cols = int(next(it)), int(next(it))\n    args = [[int(next(it)) for _ in range(cols)] for _ in range(rows)]\n    result = run_coffee(ops, args)\n    print(' '.join(map(str, result)))\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction runCoffee(ops, args) {\n  // Write your solution here\n}\n\nconst ops = Array.from({ length: parseInt(next()) }, () => next());\nconst argsRows = parseInt(next());\nconst argsCols = parseInt(next());\nconst args = Array.from({ length: argsRows }, () => Array.from({ length: argsCols }, () => parseInt(next())));\nconst result = runCoffee(ops, args);\nconsole.log(result.join(' '));\n","java":"import java.util.*;\n\npublic class Main {\n    static int[] runCoffee(String[] ops, int[][] args) {\n        // Write your solution here\n        return new int[0];\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String[] ops = new String[scanner.nextInt()];\n        for (int i = 0; i < ops.length; i++) ops[i] = scanner.next();\n        int argsRows = scanner.nextInt(), argsCols = scanner.nextInt();\n        int[][] args = new int[argsRows][argsCols];\n        for (int i = 0; i < argsRows; i++)\n            for (int j = 0; j < argsCols; j++) args[i][j] = scanner.nextInt();\n        int[] result = runCoffee(ops, args);\n        StringBuilder sb = new StringBuilder();\n        for (int i = 0; i < result.length; i++) {\n            if (i > 0) sb.append(' ');\n            sb.append(result[i]);\n        }\n        System.out.println(sb);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nvector<int> runCoffee(vector<string> ops, vector<vector<int>> args) {\n    // Write your solution here\n    return {};\n}\n\nint main() {\n    int opsN;\n    cin >> opsN;\n    vector<string> ops(opsN);\n    for (string& x : ops) cin >> x;\n    int argsRows, argsCols;\n    cin >> argsRows >> argsCols;\n    vector<vector<int>> args(argsRows, vector<int>(argsCols));\n    for (auto& row : args) for (int& x : row) cin >> x;\n    auto result = runCoffee(ops, args);\n    for (size_t i = 0; i < result.size(); i++) {\n        if (i) cout << ' ';\n        cout << result[i];\n    }\n    cout << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"4\nBASE MILK WHIP COST\n4 2\n100 0\n0 0\n0 0\n0 0","expected":"132"},{"input":"4\nBASE WHIP MILK COST\n4 2\n100 0\n0 0\n0 0\n0 0","expected":"130"},{"input":"5\nBASE COST BASE SUGAR COST\n5 2\n50 0\n0 0\n80 0\n0 0\n0 0","expected":"50 85"},{"input":"15\nMILK WHIP MILK COST WHIP CARAMEL COST SUGAR SUGAR WHIP SUGAR BASE SUGAR COST COST\n15 2\n0 0\n0 0\n0 0\n0 0\n0 0\n0 0\n0 0\n0 0\n0 0\n0 0\n0 0\n92 0\n0 0\n0 0\n0 0","expected":"42 81 97 97"},{"input":"10\nCARAMEL CARAMEL SUGAR BASE BASE SUGAR SUGAR WHIP CARAMEL COST\n10 2\n0 0\n0 0\n0 0\n130 0\n54 0\n0 0\n0 0\n0 0\n0 0\n0 0","expected":"105"},{"input":"14\nWHIP SUGAR SUGAR SUGAR WHIP SUGAR BASE CARAMEL COST COST COST BASE BASE COST\n14 2\n0 0\n0 0\n0 0\n0 0\n0 0\n0 0\n166 0\n0 0\n0 0\n0 0\n0 0\n110 0\n158 0\n0 0","expected":"201 201 201 158"}]$j$::jsonb,
  $q$1 <= n <= 10^4$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Infosys','Accenture']::text[], ARRAY['decorator-pattern','composition']::text[]);

-- 05 | easy | Strategy Pattern: Discounts
SELECT pg_temp.seed_coding($q$OOP Concepts$q$, 'easy', $q$Strategy Pattern: Discounts$q$, $q$A checkout uses a swappable discount strategy: 0 = no discount, 1 = 10% off (pay amount - amount/10), 2 = flat 50 off (never below 0), 3 = 20% off (pay amount - amount/5) only when the amount is at least 1000, otherwise no discount. Division is integer division. SET c selects strategy c (initially 0, no output); CHECKOUT a outputs the amount to pay. Input: ops[i] is a command and (args[i][0], args[i][1]) are its two integer arguments (arguments a command does not use are 0). Model the system with proper classes (for example a base class or interface plus subclasses, or a class that hides its state) and have your function drive them. Print the output of the commands that produce output, in order.

Input Format:
- ops: an integer n, then n space-separated strings
- args: two integers r and c, then r lines of c space-separated integers

Output Format:
Print the integers on one line, separated by single spaces.

Example:
Input:
8
CHECKOUT SET CHECKOUT SET CHECKOUT SET CHECKOUT CHECKOUT
8 2
500 0
1 0
500 0
2 0
30 0
3 0
999 0
1000 0
Output:
500 450 0 999 800$q$,
  $q$def run_checkout(ops: List[str], args: List[List[int]]) -> List[int]$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef run_checkout(ops: List[str], args: List[List[int]]) -> List[int]:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    ops = [next(it) for _ in range(int(next(it)))]\n    rows, cols = int(next(it)), int(next(it))\n    args = [[int(next(it)) for _ in range(cols)] for _ in range(rows)]\n    result = run_checkout(ops, args)\n    print(' '.join(map(str, result)))\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction runCheckout(ops, args) {\n  // Write your solution here\n}\n\nconst ops = Array.from({ length: parseInt(next()) }, () => next());\nconst argsRows = parseInt(next());\nconst argsCols = parseInt(next());\nconst args = Array.from({ length: argsRows }, () => Array.from({ length: argsCols }, () => parseInt(next())));\nconst result = runCheckout(ops, args);\nconsole.log(result.join(' '));\n","java":"import java.util.*;\n\npublic class Main {\n    static int[] runCheckout(String[] ops, int[][] args) {\n        // Write your solution here\n        return new int[0];\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String[] ops = new String[scanner.nextInt()];\n        for (int i = 0; i < ops.length; i++) ops[i] = scanner.next();\n        int argsRows = scanner.nextInt(), argsCols = scanner.nextInt();\n        int[][] args = new int[argsRows][argsCols];\n        for (int i = 0; i < argsRows; i++)\n            for (int j = 0; j < argsCols; j++) args[i][j] = scanner.nextInt();\n        int[] result = runCheckout(ops, args);\n        StringBuilder sb = new StringBuilder();\n        for (int i = 0; i < result.length; i++) {\n            if (i > 0) sb.append(' ');\n            sb.append(result[i]);\n        }\n        System.out.println(sb);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nvector<int> runCheckout(vector<string> ops, vector<vector<int>> args) {\n    // Write your solution here\n    return {};\n}\n\nint main() {\n    int opsN;\n    cin >> opsN;\n    vector<string> ops(opsN);\n    for (string& x : ops) cin >> x;\n    int argsRows, argsCols;\n    cin >> argsRows >> argsCols;\n    vector<vector<int>> args(argsRows, vector<int>(argsCols));\n    for (auto& row : args) for (int& x : row) cin >> x;\n    auto result = runCheckout(ops, args);\n    for (size_t i = 0; i < result.size(); i++) {\n        if (i) cout << ' ';\n        cout << result[i];\n    }\n    cout << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"8\nCHECKOUT SET CHECKOUT SET CHECKOUT SET CHECKOUT CHECKOUT\n8 2\n500 0\n1 0\n500 0\n2 0\n30 0\n3 0\n999 0\n1000 0","expected":"500 450 0 999 800"},{"input":"2\nSET CHECKOUT\n2 2\n3 0\n2000 0","expected":"1600"},{"input":"1\nCHECKOUT\n1 2\n1 0","expected":"1"},{"input":"12\nCHECKOUT CHECKOUT SET CHECKOUT SET SET SET SET CHECKOUT SET SET CHECKOUT\n12 2\n434 0\n2155 0\n0 0\n2085 0\n3 0\n3 0\n3 0\n2 0\n960 0\n0 0\n1 0\n1200 0","expected":"434 2155 2085 910 1080"},{"input":"12\nCHECKOUT SET CHECKOUT SET CHECKOUT SET CHECKOUT SET CHECKOUT SET CHECKOUT CHECKOUT\n12 2\n1905 0\n1 0\n1343 0\n1 0\n1039 0\n3 0\n441 0\n0 0\n2419 0\n1 0\n2053 0\n1200 0","expected":"1905 1209 936 441 2419 1848 1080"},{"input":"10\nSET CHECKOUT SET CHECKOUT SET CHECKOUT CHECKOUT CHECKOUT SET CHECKOUT\n10 2\n2 0\n1175 0\n2 0\n863 0\n0 0\n703 0\n2367 0\n55 0\n3 0\n1200 0","expected":"1125 813 703 2367 55 960"}]$j$::jsonb,
  $q$1 <= n <= 10^4$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['strategy-pattern','interfaces']::text[]);

-- 06 | medium | Savings and Current Accounts
SELECT pg_temp.seed_coding($q$OOP Concepts$q$, 'medium', $q$Savings and Current Accounts$q$, $q$Create a base Account class and two subclasses that override the withdrawal rule: a SavingsAccount must keep a balance of at least 100 after a withdrawal, a CurrentAccount may go down to -500 (an overdraft limit). Accounts are numbered 0, 1, 2, ... in the order they are opened. Commands: OPEN_SAVINGS b and OPEN_CURRENT b (initial balance b, no output); DEPOSIT id amount (no output); WITHDRAW id amount (output 1 if allowed and applied, else 0); BALANCE id (output the balance). Input: ops[i] is a command and (args[i][0], args[i][1]) are its two integer arguments (arguments a command does not use are 0). Model the system with proper classes (for example a base class or interface plus subclasses, or a class that hides its state) and have your function drive them. Print the output of the commands that produce output, in order.

Input Format:
- ops: an integer n, then n space-separated strings
- args: two integers r and c, then r lines of c space-separated integers

Output Format:
Print the integers on one line, separated by single spaces.

Example:
Input:
6
OPEN_SAVINGS OPEN_CURRENT WITHDRAW WITHDRAW BALANCE BALANCE
6 2
150 0
100 0
0 60
1 550
1 0
0 0
Output:
0 1 -450 150$q$,
  $q$def run_accounts(ops: List[str], args: List[List[int]]) -> List[int]$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef run_accounts(ops: List[str], args: List[List[int]]) -> List[int]:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    ops = [next(it) for _ in range(int(next(it)))]\n    rows, cols = int(next(it)), int(next(it))\n    args = [[int(next(it)) for _ in range(cols)] for _ in range(rows)]\n    result = run_accounts(ops, args)\n    print(' '.join(map(str, result)))\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction runAccounts(ops, args) {\n  // Write your solution here\n}\n\nconst ops = Array.from({ length: parseInt(next()) }, () => next());\nconst argsRows = parseInt(next());\nconst argsCols = parseInt(next());\nconst args = Array.from({ length: argsRows }, () => Array.from({ length: argsCols }, () => parseInt(next())));\nconst result = runAccounts(ops, args);\nconsole.log(result.join(' '));\n","java":"import java.util.*;\n\npublic class Main {\n    static int[] runAccounts(String[] ops, int[][] args) {\n        // Write your solution here\n        return new int[0];\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String[] ops = new String[scanner.nextInt()];\n        for (int i = 0; i < ops.length; i++) ops[i] = scanner.next();\n        int argsRows = scanner.nextInt(), argsCols = scanner.nextInt();\n        int[][] args = new int[argsRows][argsCols];\n        for (int i = 0; i < argsRows; i++)\n            for (int j = 0; j < argsCols; j++) args[i][j] = scanner.nextInt();\n        int[] result = runAccounts(ops, args);\n        StringBuilder sb = new StringBuilder();\n        for (int i = 0; i < result.length; i++) {\n            if (i > 0) sb.append(' ');\n            sb.append(result[i]);\n        }\n        System.out.println(sb);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nvector<int> runAccounts(vector<string> ops, vector<vector<int>> args) {\n    // Write your solution here\n    return {};\n}\n\nint main() {\n    int opsN;\n    cin >> opsN;\n    vector<string> ops(opsN);\n    for (string& x : ops) cin >> x;\n    int argsRows, argsCols;\n    cin >> argsRows >> argsCols;\n    vector<vector<int>> args(argsRows, vector<int>(argsCols));\n    for (auto& row : args) for (int& x : row) cin >> x;\n    auto result = runAccounts(ops, args);\n    for (size_t i = 0; i < result.size(); i++) {\n        if (i) cout << ' ';\n        cout << result[i];\n    }\n    cout << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"6\nOPEN_SAVINGS OPEN_CURRENT WITHDRAW WITHDRAW BALANCE BALANCE\n6 2\n150 0\n100 0\n0 60\n1 550\n1 0\n0 0","expected":"0 1 -450 150"},{"input":"3\nOPEN_SAVINGS WITHDRAW BALANCE\n3 2\n100 0\n0 1\n0 0","expected":"0 100"},{"input":"4\nOPEN_CURRENT DEPOSIT WITHDRAW BALANCE\n4 2\n0 0\n0 20\n0 520\n0 0","expected":"1 -500"},{"input":"10\nOPEN_SAVINGS OPEN_CURRENT DEPOSIT WITHDRAW BALANCE DEPOSIT WITHDRAW DEPOSIT BALANCE BALANCE\n10 2\n479 0\n242 0\n0 254\n0 88\n1 0\n0 217\n0 355\n1 96\n0 0\n1 0","expected":"1 242 1 507 338"},{"input":"11\nOPEN_SAVINGS OPEN_CURRENT DEPOSIT DEPOSIT WITHDRAW DEPOSIT BALANCE DEPOSIT WITHDRAW BALANCE BALANCE\n11 2\n203 0\n219 0\n1 22\n0 86\n1 348\n1 213\n1 0\n0 353\n1 139\n0 0\n1 0","expected":"1 106 1 642 -33"},{"input":"10\nOPEN_SAVINGS OPEN_CURRENT WITHDRAW WITHDRAW DEPOSIT BALANCE WITHDRAW BALANCE BALANCE BALANCE\n10 2\n288 0\n163 0\n1 237\n0 366\n1 42\n0 0\n1 367\n1 0\n0 0\n1 0","expected":"1 0 288 1 -399 288 -399"}]$j$::jsonb,
  $q$1 <= n <= 10^4$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Infosys','Accenture']::text[], ARRAY['inheritance','polymorphism','method-overriding']::text[]);

-- 07 | medium | Employee Payroll Hierarchy
SELECT pg_temp.seed_coding($q$OOP Concepts$q$, 'medium', $q$Employee Payroll Hierarchy$q$, $q$An abstract Employee has a monthly pay() method implemented by each subclass: Intern pays the given stipend; Engineer pays base + base/10; Manager pays base + base/5 + 1000 (integer division). Commands: INTERN x, ENGINEER x, MANAGER x hire an employee with that stipend/base (no output); PAYROLL outputs the total monthly pay of everyone hired so far. Input: ops[i] is a command and (args[i][0], args[i][1]) are its two integer arguments (arguments a command does not use are 0). Model the system with proper classes (for example a base class or interface plus subclasses, or a class that hides its state) and have your function drive them. Print the output of the commands that produce output, in order.

Input Format:
- ops: an integer n, then n space-separated strings
- args: two integers r and c, then r lines of c space-separated integers

Output Format:
Print the integers on one line, separated by single spaces.

Example:
Input:
4
INTERN ENGINEER MANAGER PAYROLL
4 2
1000 0
5000 0
8000 0
0 0
Output:
17100$q$,
  $q$def run_payroll(ops: List[str], args: List[List[int]]) -> List[int]$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef run_payroll(ops: List[str], args: List[List[int]]) -> List[int]:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    ops = [next(it) for _ in range(int(next(it)))]\n    rows, cols = int(next(it)), int(next(it))\n    args = [[int(next(it)) for _ in range(cols)] for _ in range(rows)]\n    result = run_payroll(ops, args)\n    print(' '.join(map(str, result)))\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction runPayroll(ops, args) {\n  // Write your solution here\n}\n\nconst ops = Array.from({ length: parseInt(next()) }, () => next());\nconst argsRows = parseInt(next());\nconst argsCols = parseInt(next());\nconst args = Array.from({ length: argsRows }, () => Array.from({ length: argsCols }, () => parseInt(next())));\nconst result = runPayroll(ops, args);\nconsole.log(result.join(' '));\n","java":"import java.util.*;\n\npublic class Main {\n    static int[] runPayroll(String[] ops, int[][] args) {\n        // Write your solution here\n        return new int[0];\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String[] ops = new String[scanner.nextInt()];\n        for (int i = 0; i < ops.length; i++) ops[i] = scanner.next();\n        int argsRows = scanner.nextInt(), argsCols = scanner.nextInt();\n        int[][] args = new int[argsRows][argsCols];\n        for (int i = 0; i < argsRows; i++)\n            for (int j = 0; j < argsCols; j++) args[i][j] = scanner.nextInt();\n        int[] result = runPayroll(ops, args);\n        StringBuilder sb = new StringBuilder();\n        for (int i = 0; i < result.length; i++) {\n            if (i > 0) sb.append(' ');\n            sb.append(result[i]);\n        }\n        System.out.println(sb);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nvector<int> runPayroll(vector<string> ops, vector<vector<int>> args) {\n    // Write your solution here\n    return {};\n}\n\nint main() {\n    int opsN;\n    cin >> opsN;\n    vector<string> ops(opsN);\n    for (string& x : ops) cin >> x;\n    int argsRows, argsCols;\n    cin >> argsRows >> argsCols;\n    vector<vector<int>> args(argsRows, vector<int>(argsCols));\n    for (auto& row : args) for (int& x : row) cin >> x;\n    auto result = runPayroll(ops, args);\n    for (size_t i = 0; i < result.size(); i++) {\n        if (i) cout << ' ';\n        cout << result[i];\n    }\n    cout << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"4\nINTERN ENGINEER MANAGER PAYROLL\n4 2\n1000 0\n5000 0\n8000 0\n0 0","expected":"17100"},{"input":"3\nPAYROLL ENGINEER PAYROLL\n3 2\n0 0\n100 0\n0 0","expected":"0 110"},{"input":"2\nMANAGER PAYROLL\n2 2\n0 0\n0 0","expected":"1000"},{"input":"10\nMANAGER INTERN MANAGER PAYROLL PAYROLL MANAGER PAYROLL PAYROLL MANAGER PAYROLL\n10 2\n13600 0\n1900 0\n10000 0\n0 0\n0 0\n9700 0\n0 0\n0 0\n11200 0\n0 0","expected":"32220 32220 44860 44860 59300"},{"input":"11\nMANAGER ENGINEER PAYROLL PAYROLL ENGINEER PAYROLL ENGINEER MANAGER INTERN ENGINEER PAYROLL\n11 2\n9100 0\n5800 0\n0 0\n0 0\n6800 0\n0 0\n8900 0\n10300 0\n1400 0\n4100 0\n0 0","expected":"18300 18300 25780 54840"},{"input":"10\nENGINEER INTERN MANAGER PAYROLL INTERN PAYROLL ENGINEER INTERN MANAGER PAYROLL\n10 2\n6800 0\n1200 0\n8200 0\n0 0\n1600 0\n0 0\n3900 0\n1500 0\n11900 0\n0 0","expected":"19520 21120 42190"}]$j$::jsonb,
  $q$1 <= n <= 10^4$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Infosys','Accenture']::text[], ARRAY['inheritance','polymorphism','abstract-class']::text[]);

-- 08 | medium | Queue Using Two Stacks
SELECT pg_temp.seed_coding($q$OOP Concepts$q$, 'medium', $q$Queue Using Two Stacks$q$, $q$Implement a FIFO Queue class that stores its items in two internal stacks. Commands: ENQ x (no output); DEQ (output the removed front item, or -1 if empty); FRONT (output the front item without removing it, or -1 if empty); SIZE (output the number of items). Input: ops[i] is a command and (args[i][0], args[i][1]) are its two integer arguments (arguments a command does not use are 0). Model the system with proper classes (for example a base class or interface plus subclasses, or a class that hides its state) and have your function drive them. Print the output of the commands that produce output, in order.

Input Format:
- ops: an integer n, then n space-separated strings
- args: two integers r and c, then r lines of c space-separated integers

Output Format:
Print the integers on one line, separated by single spaces.

Example:
Input:
9
ENQ ENQ FRONT DEQ ENQ DEQ DEQ DEQ SIZE
9 2
1 0
2 0
0 0
0 0
3 0
0 0
0 0
0 0
0 0
Output:
1 1 2 3 -1 0$q$,
  $q$def run_queue(ops: List[str], args: List[List[int]]) -> List[int]$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef run_queue(ops: List[str], args: List[List[int]]) -> List[int]:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    ops = [next(it) for _ in range(int(next(it)))]\n    rows, cols = int(next(it)), int(next(it))\n    args = [[int(next(it)) for _ in range(cols)] for _ in range(rows)]\n    result = run_queue(ops, args)\n    print(' '.join(map(str, result)))\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction runQueue(ops, args) {\n  // Write your solution here\n}\n\nconst ops = Array.from({ length: parseInt(next()) }, () => next());\nconst argsRows = parseInt(next());\nconst argsCols = parseInt(next());\nconst args = Array.from({ length: argsRows }, () => Array.from({ length: argsCols }, () => parseInt(next())));\nconst result = runQueue(ops, args);\nconsole.log(result.join(' '));\n","java":"import java.util.*;\n\npublic class Main {\n    static int[] runQueue(String[] ops, int[][] args) {\n        // Write your solution here\n        return new int[0];\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String[] ops = new String[scanner.nextInt()];\n        for (int i = 0; i < ops.length; i++) ops[i] = scanner.next();\n        int argsRows = scanner.nextInt(), argsCols = scanner.nextInt();\n        int[][] args = new int[argsRows][argsCols];\n        for (int i = 0; i < argsRows; i++)\n            for (int j = 0; j < argsCols; j++) args[i][j] = scanner.nextInt();\n        int[] result = runQueue(ops, args);\n        StringBuilder sb = new StringBuilder();\n        for (int i = 0; i < result.length; i++) {\n            if (i > 0) sb.append(' ');\n            sb.append(result[i]);\n        }\n        System.out.println(sb);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nvector<int> runQueue(vector<string> ops, vector<vector<int>> args) {\n    // Write your solution here\n    return {};\n}\n\nint main() {\n    int opsN;\n    cin >> opsN;\n    vector<string> ops(opsN);\n    for (string& x : ops) cin >> x;\n    int argsRows, argsCols;\n    cin >> argsRows >> argsCols;\n    vector<vector<int>> args(argsRows, vector<int>(argsCols));\n    for (auto& row : args) for (int& x : row) cin >> x;\n    auto result = runQueue(ops, args);\n    for (size_t i = 0; i < result.size(); i++) {\n        if (i) cout << ' ';\n        cout << result[i];\n    }\n    cout << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"9\nENQ ENQ FRONT DEQ ENQ DEQ DEQ DEQ SIZE\n9 2\n1 0\n2 0\n0 0\n0 0\n3 0\n0 0\n0 0\n0 0\n0 0","expected":"1 1 2 3 -1 0"},{"input":"1\nDEQ\n1 2\n0 0","expected":"-1"},{"input":"2\nENQ SIZE\n2 2\n4 0\n0 0","expected":"1"},{"input":"13\nFRONT FRONT ENQ DEQ SIZE FRONT SIZE SIZE DEQ DEQ ENQ FRONT SIZE\n13 2\n0 0\n0 0\n29 0\n0 0\n0 0\n0 0\n0 0\n0 0\n0 0\n0 0\n16 0\n0 0\n0 0","expected":"-1 -1 29 0 -1 0 0 -1 -1 16 1"},{"input":"10\nENQ DEQ DEQ SIZE SIZE ENQ ENQ ENQ FRONT SIZE\n10 2\n41 0\n0 0\n0 0\n0 0\n0 0\n40 0\n48 0\n23 0\n0 0\n0 0","expected":"41 -1 0 0 40 3"},{"input":"9\nFRONT DEQ DEQ SIZE ENQ SIZE FRONT DEQ SIZE\n9 2\n0 0\n0 0\n0 0\n0 0\n11 0\n0 0\n0 0\n0 0\n0 0","expected":"-1 -1 -1 0 1 11 11 0"}]$j$::jsonb,
  $q$1 <= n <= 10^4$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','TCS','Infosys','Accenture']::text[], ARRAY['data-structures','encapsulation']::text[]);

-- 09 | medium | Min Stack
SELECT pg_temp.seed_coding($q$OOP Concepts$q$, 'medium', $q$Min Stack$q$, $q$Design a stack that supports retrieving its minimum in O(1). Commands: PUSH x (no output); POP (output the removed top, or -1 if empty); TOP (output the top, or -1 if empty); MIN (output the smallest value currently in the stack, or -1 if empty). Input: ops[i] is a command and (args[i][0], args[i][1]) are its two integer arguments (arguments a command does not use are 0). Model the system with proper classes (for example a base class or interface plus subclasses, or a class that hides its state) and have your function drive them. Print the output of the commands that produce output, in order.

Input Format:
- ops: an integer n, then n space-separated strings
- args: two integers r and c, then r lines of c space-separated integers

Output Format:
Print the integers on one line, separated by single spaces.

Example:
Input:
8
PUSH PUSH PUSH MIN POP POP MIN TOP
8 2
5 0
2 0
8 0
0 0
0 0
0 0
0 0
0 0
Output:
2 8 2 5 5$q$,
  $q$def run_min_stack(ops: List[str], args: List[List[int]]) -> List[int]$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef run_min_stack(ops: List[str], args: List[List[int]]) -> List[int]:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    ops = [next(it) for _ in range(int(next(it)))]\n    rows, cols = int(next(it)), int(next(it))\n    args = [[int(next(it)) for _ in range(cols)] for _ in range(rows)]\n    result = run_min_stack(ops, args)\n    print(' '.join(map(str, result)))\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction runMinStack(ops, args) {\n  // Write your solution here\n}\n\nconst ops = Array.from({ length: parseInt(next()) }, () => next());\nconst argsRows = parseInt(next());\nconst argsCols = parseInt(next());\nconst args = Array.from({ length: argsRows }, () => Array.from({ length: argsCols }, () => parseInt(next())));\nconst result = runMinStack(ops, args);\nconsole.log(result.join(' '));\n","java":"import java.util.*;\n\npublic class Main {\n    static int[] runMinStack(String[] ops, int[][] args) {\n        // Write your solution here\n        return new int[0];\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String[] ops = new String[scanner.nextInt()];\n        for (int i = 0; i < ops.length; i++) ops[i] = scanner.next();\n        int argsRows = scanner.nextInt(), argsCols = scanner.nextInt();\n        int[][] args = new int[argsRows][argsCols];\n        for (int i = 0; i < argsRows; i++)\n            for (int j = 0; j < argsCols; j++) args[i][j] = scanner.nextInt();\n        int[] result = runMinStack(ops, args);\n        StringBuilder sb = new StringBuilder();\n        for (int i = 0; i < result.length; i++) {\n            if (i > 0) sb.append(' ');\n            sb.append(result[i]);\n        }\n        System.out.println(sb);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nvector<int> runMinStack(vector<string> ops, vector<vector<int>> args) {\n    // Write your solution here\n    return {};\n}\n\nint main() {\n    int opsN;\n    cin >> opsN;\n    vector<string> ops(opsN);\n    for (string& x : ops) cin >> x;\n    int argsRows, argsCols;\n    cin >> argsRows >> argsCols;\n    vector<vector<int>> args(argsRows, vector<int>(argsCols));\n    for (auto& row : args) for (int& x : row) cin >> x;\n    auto result = runMinStack(ops, args);\n    for (size_t i = 0; i < result.size(); i++) {\n        if (i) cout << ' ';\n        cout << result[i];\n    }\n    cout << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"8\nPUSH PUSH PUSH MIN POP POP MIN TOP\n8 2\n5 0\n2 0\n8 0\n0 0\n0 0\n0 0\n0 0\n0 0","expected":"2 8 2 5 5"},{"input":"1\nMIN\n1 2\n0 0","expected":"-1"},{"input":"4\nPUSH PUSH POP MIN\n4 2\n3 0\n3 0\n0 0\n0 0","expected":"3 3"},{"input":"13\nPOP TOP TOP PUSH PUSH MIN PUSH PUSH MIN TOP PUSH PUSH MIN\n13 2\n0 0\n0 0\n0 0\n4 0\n8 0\n0 0\n17 0\n16 0\n0 0\n0 0\n12 0\n18 0\n0 0","expected":"-1 -1 -1 4 4 16 4"},{"input":"11\nPUSH POP POP POP TOP TOP POP PUSH POP PUSH MIN\n11 2\n8 0\n0 0\n0 0\n0 0\n0 0\n0 0\n0 0\n1 0\n0 0\n11 0\n0 0","expected":"8 -1 -1 -1 -1 -1 1 11"},{"input":"10\nPUSH POP MIN PUSH PUSH TOP MIN MIN MIN MIN\n10 2\n18 0\n0 0\n0 0\n12 0\n8 0\n0 0\n0 0\n0 0\n0 0\n0 0","expected":"18 -1 8 8 8 8 8"}]$j$::jsonb,
  $q$1 <= n <= 10^4$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Infosys','Accenture']::text[], ARRAY['data-structures','design']::text[]);

-- 10 | hard | LRU Cache
SELECT pg_temp.seed_coding($q$OOP Concepts$q$, 'hard', $q$LRU Cache$q$, $q$Design a fixed-capacity cache that evicts the LEAST RECENTLY USED key when full. A key is 'used' by both GET and PUT. Commands: INIT cap (always first, no output); PUT k v (insert or update, no output; evict the least recently used key first if a NEW key arrives while full); GET k (output the value, or -1 if absent). Input: ops[i] is a command and (args[i][0], args[i][1]) are its two integer arguments (arguments a command does not use are 0). Model the system with proper classes (for example a base class or interface plus subclasses, or a class that hides its state) and have your function drive them. Print the output of the commands that produce output, in order.

Input Format:
- ops: an integer n, then n space-separated strings
- args: two integers r and c, then r lines of c space-separated integers

Output Format:
Print the integers on one line, separated by single spaces.

Example:
Input:
10
INIT PUT PUT GET PUT GET PUT GET GET GET
10 2
2 0
1 1
2 2
1 0
3 3
2 0
4 4
1 0
3 0
4 0
Output:
1 -1 -1 3 4$q$,
  $q$def run_lru(ops: List[str], args: List[List[int]]) -> List[int]$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef run_lru(ops: List[str], args: List[List[int]]) -> List[int]:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    ops = [next(it) for _ in range(int(next(it)))]\n    rows, cols = int(next(it)), int(next(it))\n    args = [[int(next(it)) for _ in range(cols)] for _ in range(rows)]\n    result = run_lru(ops, args)\n    print(' '.join(map(str, result)))\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction runLru(ops, args) {\n  // Write your solution here\n}\n\nconst ops = Array.from({ length: parseInt(next()) }, () => next());\nconst argsRows = parseInt(next());\nconst argsCols = parseInt(next());\nconst args = Array.from({ length: argsRows }, () => Array.from({ length: argsCols }, () => parseInt(next())));\nconst result = runLru(ops, args);\nconsole.log(result.join(' '));\n","java":"import java.util.*;\n\npublic class Main {\n    static int[] runLru(String[] ops, int[][] args) {\n        // Write your solution here\n        return new int[0];\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String[] ops = new String[scanner.nextInt()];\n        for (int i = 0; i < ops.length; i++) ops[i] = scanner.next();\n        int argsRows = scanner.nextInt(), argsCols = scanner.nextInt();\n        int[][] args = new int[argsRows][argsCols];\n        for (int i = 0; i < argsRows; i++)\n            for (int j = 0; j < argsCols; j++) args[i][j] = scanner.nextInt();\n        int[] result = runLru(ops, args);\n        StringBuilder sb = new StringBuilder();\n        for (int i = 0; i < result.length; i++) {\n            if (i > 0) sb.append(' ');\n            sb.append(result[i]);\n        }\n        System.out.println(sb);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nvector<int> runLru(vector<string> ops, vector<vector<int>> args) {\n    // Write your solution here\n    return {};\n}\n\nint main() {\n    int opsN;\n    cin >> opsN;\n    vector<string> ops(opsN);\n    for (string& x : ops) cin >> x;\n    int argsRows, argsCols;\n    cin >> argsRows >> argsCols;\n    vector<vector<int>> args(argsRows, vector<int>(argsCols));\n    for (auto& row : args) for (int& x : row) cin >> x;\n    auto result = runLru(ops, args);\n    for (size_t i = 0; i < result.size(); i++) {\n        if (i) cout << ' ';\n        cout << result[i];\n    }\n    cout << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"10\nINIT PUT PUT GET PUT GET PUT GET GET GET\n10 2\n2 0\n1 1\n2 2\n1 0\n3 3\n2 0\n4 4\n1 0\n3 0\n4 0","expected":"1 -1 -1 3 4"},{"input":"5\nINIT PUT GET PUT GET\n5 2\n1 0\n5 9\n5 0\n6 1\n5 0","expected":"9 -1"},{"input":"2\nINIT GET\n2 2\n2 0\n7 0","expected":"-1"},{"input":"13\nINIT PUT GET PUT PUT GET GET GET GET GET GET PUT GET\n13 2\n3 0\n3 70\n4 0\n1 99\n4 29\n3 0\n1 0\n3 0\n4 0\n1 0\n5 0\n2 29\n1 0","expected":"-1 70 99 70 29 99 -1 99"},{"input":"16\nINIT PUT GET PUT GET PUT PUT GET GET GET GET GET GET GET GET GET\n16 2\n3 0\n4 97\n4 0\n1 36\n4 0\n4 92\n4 84\n3 0\n4 0\n1 0\n3 0\n1 0\n2 0\n5 0\n3 0\n1 0","expected":"97 97 -1 84 36 -1 36 -1 -1 -1 36"},{"input":"11\nINIT GET GET GET PUT PUT PUT GET PUT GET GET\n11 2\n2 0\n3 0\n4 0\n2 0\n4 48\n1 46\n5 19\n4 0\n2 85\n1 0\n1 0","expected":"-1 -1 -1 -1 -1 -1"}]$j$::jsonb,
  $q$1 <= cap <= 3000$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Infosys','Accenture']::text[], ARRAY['design','hashing','linked-list']::text[]);

-- 11 | medium | Circular Queue
SELECT pg_temp.seed_coding($q$OOP Concepts$q$, 'medium', $q$Circular Queue$q$, $q$Design a circular queue with a fixed capacity. Commands: INIT cap (always first, no output); ENQ x (output 1 if added, 0 if the queue is full); DEQ (output 1 if an item was removed, 0 if empty); FRONT / REAR (output the front / rear item, or -1 if empty); ISFULL / ISEMPTY (output 1 or 0). Input: ops[i] is a command and (args[i][0], args[i][1]) are its two integer arguments (arguments a command does not use are 0). Model the system with proper classes (for example a base class or interface plus subclasses, or a class that hides its state) and have your function drive them. Print the output of the commands that produce output, in order.

Input Format:
- ops: an integer n, then n space-separated strings
- args: two integers r and c, then r lines of c space-separated integers

Output Format:
Print the integers on one line, separated by single spaces.

Example:
Input:
10
INIT ENQ ENQ ENQ REAR ISFULL DEQ ENQ REAR FRONT
10 2
2 0
1 0
2 0
3 0
0 0
0 0
0 0
3 0
0 0
0 0
Output:
1 1 0 2 1 1 1 3 2$q$,
  $q$def run_circular_queue(ops: List[str], args: List[List[int]]) -> List[int]$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef run_circular_queue(ops: List[str], args: List[List[int]]) -> List[int]:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    ops = [next(it) for _ in range(int(next(it)))]\n    rows, cols = int(next(it)), int(next(it))\n    args = [[int(next(it)) for _ in range(cols)] for _ in range(rows)]\n    result = run_circular_queue(ops, args)\n    print(' '.join(map(str, result)))\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction runCircularQueue(ops, args) {\n  // Write your solution here\n}\n\nconst ops = Array.from({ length: parseInt(next()) }, () => next());\nconst argsRows = parseInt(next());\nconst argsCols = parseInt(next());\nconst args = Array.from({ length: argsRows }, () => Array.from({ length: argsCols }, () => parseInt(next())));\nconst result = runCircularQueue(ops, args);\nconsole.log(result.join(' '));\n","java":"import java.util.*;\n\npublic class Main {\n    static int[] runCircularQueue(String[] ops, int[][] args) {\n        // Write your solution here\n        return new int[0];\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String[] ops = new String[scanner.nextInt()];\n        for (int i = 0; i < ops.length; i++) ops[i] = scanner.next();\n        int argsRows = scanner.nextInt(), argsCols = scanner.nextInt();\n        int[][] args = new int[argsRows][argsCols];\n        for (int i = 0; i < argsRows; i++)\n            for (int j = 0; j < argsCols; j++) args[i][j] = scanner.nextInt();\n        int[] result = runCircularQueue(ops, args);\n        StringBuilder sb = new StringBuilder();\n        for (int i = 0; i < result.length; i++) {\n            if (i > 0) sb.append(' ');\n            sb.append(result[i]);\n        }\n        System.out.println(sb);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nvector<int> runCircularQueue(vector<string> ops, vector<vector<int>> args) {\n    // Write your solution here\n    return {};\n}\n\nint main() {\n    int opsN;\n    cin >> opsN;\n    vector<string> ops(opsN);\n    for (string& x : ops) cin >> x;\n    int argsRows, argsCols;\n    cin >> argsRows >> argsCols;\n    vector<vector<int>> args(argsRows, vector<int>(argsCols));\n    for (auto& row : args) for (int& x : row) cin >> x;\n    auto result = runCircularQueue(ops, args);\n    for (size_t i = 0; i < result.size(); i++) {\n        if (i) cout << ' ';\n        cout << result[i];\n    }\n    cout << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"10\nINIT ENQ ENQ ENQ REAR ISFULL DEQ ENQ REAR FRONT\n10 2\n2 0\n1 0\n2 0\n3 0\n0 0\n0 0\n0 0\n3 0\n0 0\n0 0","expected":"1 1 0 2 1 1 1 3 2"},{"input":"3\nINIT ISEMPTY DEQ\n3 2\n1 0\n0 0\n0 0","expected":"1 0"},{"input":"2\nINIT FRONT\n2 2\n3 0\n0 0","expected":"-1"},{"input":"13\nINIT REAR FRONT REAR DEQ ISEMPTY ISFULL REAR DEQ ISFULL ISEMPTY ENQ ISEMPTY\n13 2\n2 0\n0 0\n0 0\n0 0\n0 0\n0 0\n0 0\n0 0\n0 0\n0 0\n0 0\n3 0\n0 0","expected":"-1 -1 -1 0 1 0 -1 0 0 1 1 0"},{"input":"16\nINIT DEQ ENQ ISFULL FRONT FRONT DEQ REAR REAR ISEMPTY FRONT FRONT ISEMPTY ISFULL ISFULL ISEMPTY\n16 2\n2 0\n0 0\n18 0\n0 0\n0 0\n0 0\n0 0\n0 0\n0 0\n0 0\n0 0\n0 0\n0 0\n0 0\n0 0\n0 0","expected":"0 1 0 18 18 1 -1 -1 1 -1 -1 1 0 0 1"},{"input":"16\nINIT ISEMPTY FRONT DEQ ENQ ENQ REAR REAR ENQ ISEMPTY ENQ ENQ ISEMPTY REAR ISEMPTY ISEMPTY\n16 2\n4 0\n0 0\n0 0\n0 0\n12 0\n5 0\n0 0\n0 0\n30 0\n0 0\n30 0\n15 0\n0 0\n0 0\n0 0\n0 0","expected":"1 -1 0 1 1 5 5 1 0 1 0 0 30 0 0"}]$j$::jsonb,
  $q$1 <= cap <= 1000$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','TCS','Accenture']::text[], ARRAY['data-structures','design','encapsulation']::text[]);

-- 12 | medium | Library Management
SELECT pg_temp.seed_coding($q$OOP Concepts$q$, 'medium', $q$Library Management$q$, $q$Model a Library that owns Books and serves Members. Every book has exactly one copy. Commands: ADD_BOOK b (register book b; no output, repeating it changes nothing); BORROW m b (output 1 if book b exists, is not currently borrowed and member m holds fewer than 2 books - the loan is then recorded - otherwise 0); RETURN m b (output 1 if member m currently holds book b, which is then returned, otherwise 0); AVAILABLE b (output 1 if book b exists and is not borrowed, else 0). Input: ops[i] is a command and (args[i][0], args[i][1]) are its two integer arguments (arguments a command does not use are 0). Model the system with proper classes (for example a base class or interface plus subclasses, or a class that hides its state) and have your function drive them. Print the output of the commands that produce output, in order.

Input Format:
- ops: an integer n, then n space-separated strings
- args: two integers r and c, then r lines of c space-separated integers

Output Format:
Print the integers on one line, separated by single spaces.

Example:
Input:
11
ADD_BOOK ADD_BOOK ADD_BOOK BORROW BORROW BORROW BORROW AVAILABLE RETURN AVAILABLE BORROW
11 2
1 0
2 0
3 0
7 1
8 1
7 2
7 3
1 0
7 1
1 0
7 3
Output:
1 0 1 0 0 1 1 1$q$,
  $q$def run_library(ops: List[str], args: List[List[int]]) -> List[int]$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef run_library(ops: List[str], args: List[List[int]]) -> List[int]:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    ops = [next(it) for _ in range(int(next(it)))]\n    rows, cols = int(next(it)), int(next(it))\n    args = [[int(next(it)) for _ in range(cols)] for _ in range(rows)]\n    result = run_library(ops, args)\n    print(' '.join(map(str, result)))\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction runLibrary(ops, args) {\n  // Write your solution here\n}\n\nconst ops = Array.from({ length: parseInt(next()) }, () => next());\nconst argsRows = parseInt(next());\nconst argsCols = parseInt(next());\nconst args = Array.from({ length: argsRows }, () => Array.from({ length: argsCols }, () => parseInt(next())));\nconst result = runLibrary(ops, args);\nconsole.log(result.join(' '));\n","java":"import java.util.*;\n\npublic class Main {\n    static int[] runLibrary(String[] ops, int[][] args) {\n        // Write your solution here\n        return new int[0];\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String[] ops = new String[scanner.nextInt()];\n        for (int i = 0; i < ops.length; i++) ops[i] = scanner.next();\n        int argsRows = scanner.nextInt(), argsCols = scanner.nextInt();\n        int[][] args = new int[argsRows][argsCols];\n        for (int i = 0; i < argsRows; i++)\n            for (int j = 0; j < argsCols; j++) args[i][j] = scanner.nextInt();\n        int[] result = runLibrary(ops, args);\n        StringBuilder sb = new StringBuilder();\n        for (int i = 0; i < result.length; i++) {\n            if (i > 0) sb.append(' ');\n            sb.append(result[i]);\n        }\n        System.out.println(sb);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nvector<int> runLibrary(vector<string> ops, vector<vector<int>> args) {\n    // Write your solution here\n    return {};\n}\n\nint main() {\n    int opsN;\n    cin >> opsN;\n    vector<string> ops(opsN);\n    for (string& x : ops) cin >> x;\n    int argsRows, argsCols;\n    cin >> argsRows >> argsCols;\n    vector<vector<int>> args(argsRows, vector<int>(argsCols));\n    for (auto& row : args) for (int& x : row) cin >> x;\n    auto result = runLibrary(ops, args);\n    for (size_t i = 0; i < result.size(); i++) {\n        if (i) cout << ' ';\n        cout << result[i];\n    }\n    cout << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"11\nADD_BOOK ADD_BOOK ADD_BOOK BORROW BORROW BORROW BORROW AVAILABLE RETURN AVAILABLE BORROW\n11 2\n1 0\n2 0\n3 0\n7 1\n8 1\n7 2\n7 3\n1 0\n7 1\n1 0\n7 3","expected":"1 0 1 0 0 1 1 1"},{"input":"1\nAVAILABLE\n1 2\n5 0","expected":"0"},{"input":"2\nADD_BOOK RETURN\n2 2\n1 0\n1 1","expected":"0"},{"input":"11\nBORROW RETURN RETURN BORROW AVAILABLE BORROW ADD_BOOK ADD_BOOK AVAILABLE BORROW AVAILABLE\n11 2\n1 2\n1 2\n2 3\n2 1\n3 0\n2 1\n2 0\n2 0\n3 0\n1 1\n1 0","expected":"0 0 0 0 0 0 0 0 0"},{"input":"13\nRETURN AVAILABLE RETURN RETURN BORROW RETURN BORROW ADD_BOOK BORROW AVAILABLE AVAILABLE RETURN AVAILABLE\n13 2\n1 1\n2 0\n2 3\n1 2\n2 2\n2 1\n1 3\n3 0\n1 2\n4 0\n2 0\n1 3\n1 0","expected":"0 0 0 0 0 0 0 0 0 0 0 0"},{"input":"16\nADD_BOOK AVAILABLE AVAILABLE AVAILABLE ADD_BOOK ADD_BOOK RETURN AVAILABLE ADD_BOOK AVAILABLE AVAILABLE ADD_BOOK RETURN AVAILABLE ADD_BOOK AVAILABLE\n16 2\n4 0\n4 0\n1 0\n1 0\n3 0\n2 0\n1 4\n2 0\n3 0\n1 0\n1 0\n3 0\n1 4\n2 0\n1 0\n1 0","expected":"1 0 0 0 1 0 0 0 1 1"}]$j$::jsonb,
  $q$1 <= n <= 10^4$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['composition','classes','association']::text[]);

-- 13 | medium | Parking Lot
SELECT pg_temp.seed_coding($q$OOP Concepts$q$, 'medium', $q$Parking Lot$q$, $q$A parking lot has a number of slots. A bike uses 1 slot, a car 2 and a truck 4 (slots need not be contiguous). Vehicle ids are unique while parked. Commands: INIT slots (always first, no output); PARK_BIKE id, PARK_CAR id, PARK_TRUCK id (output 1 if the vehicle fits and its id is not already parked, else 0); LEAVE id (output 1 and free its slots if it is parked, else 0); FREE (output the number of free slots). Input: ops[i] is a command and (args[i][0], args[i][1]) are its two integer arguments (arguments a command does not use are 0). Model the system with proper classes (for example a base class or interface plus subclasses, or a class that hides its state) and have your function drive them. Print the output of the commands that produce output, in order.

Input Format:
- ops: an integer n, then n space-separated strings
- args: two integers r and c, then r lines of c space-separated integers

Output Format:
Print the integers on one line, separated by single spaces.

Example:
Input:
9
INIT PARK_CAR PARK_TRUCK PARK_TRUCK FREE LEAVE PARK_TRUCK FREE PARK_BIKE
9 2
6 0
1 0
2 0
3 0
0 0
2 0
3 0
0 0
1 0
Output:
1 1 0 0 1 1 0 0$q$,
  $q$def run_parking_lot(ops: List[str], args: List[List[int]]) -> List[int]$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef run_parking_lot(ops: List[str], args: List[List[int]]) -> List[int]:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    ops = [next(it) for _ in range(int(next(it)))]\n    rows, cols = int(next(it)), int(next(it))\n    args = [[int(next(it)) for _ in range(cols)] for _ in range(rows)]\n    result = run_parking_lot(ops, args)\n    print(' '.join(map(str, result)))\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction runParkingLot(ops, args) {\n  // Write your solution here\n}\n\nconst ops = Array.from({ length: parseInt(next()) }, () => next());\nconst argsRows = parseInt(next());\nconst argsCols = parseInt(next());\nconst args = Array.from({ length: argsRows }, () => Array.from({ length: argsCols }, () => parseInt(next())));\nconst result = runParkingLot(ops, args);\nconsole.log(result.join(' '));\n","java":"import java.util.*;\n\npublic class Main {\n    static int[] runParkingLot(String[] ops, int[][] args) {\n        // Write your solution here\n        return new int[0];\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String[] ops = new String[scanner.nextInt()];\n        for (int i = 0; i < ops.length; i++) ops[i] = scanner.next();\n        int argsRows = scanner.nextInt(), argsCols = scanner.nextInt();\n        int[][] args = new int[argsRows][argsCols];\n        for (int i = 0; i < argsRows; i++)\n            for (int j = 0; j < argsCols; j++) args[i][j] = scanner.nextInt();\n        int[] result = runParkingLot(ops, args);\n        StringBuilder sb = new StringBuilder();\n        for (int i = 0; i < result.length; i++) {\n            if (i > 0) sb.append(' ');\n            sb.append(result[i]);\n        }\n        System.out.println(sb);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nvector<int> runParkingLot(vector<string> ops, vector<vector<int>> args) {\n    // Write your solution here\n    return {};\n}\n\nint main() {\n    int opsN;\n    cin >> opsN;\n    vector<string> ops(opsN);\n    for (string& x : ops) cin >> x;\n    int argsRows, argsCols;\n    cin >> argsRows >> argsCols;\n    vector<vector<int>> args(argsRows, vector<int>(argsCols));\n    for (auto& row : args) for (int& x : row) cin >> x;\n    auto result = runParkingLot(ops, args);\n    for (size_t i = 0; i < result.size(); i++) {\n        if (i) cout << ' ';\n        cout << result[i];\n    }\n    cout << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"9\nINIT PARK_CAR PARK_TRUCK PARK_TRUCK FREE LEAVE PARK_TRUCK FREE PARK_BIKE\n9 2\n6 0\n1 0\n2 0\n3 0\n0 0\n2 0\n3 0\n0 0\n1 0","expected":"1 1 0 0 1 1 0 0"},{"input":"2\nINIT LEAVE\n2 2\n1 0\n1 0","expected":"0"},{"input":"2\nINIT FREE\n2 2\n3 0\n0 0","expected":"3"},{"input":"13\nINIT PARK_TRUCK LEAVE PARK_TRUCK LEAVE PARK_CAR LEAVE FREE PARK_BIKE LEAVE FREE LEAVE FREE\n13 2\n8 0\n3 0\n5 0\n6 0\n1 0\n1 0\n2 0\n0 0\n6 0\n2 0\n0 0\n2 0\n0 0","expected":"1 0 1 0 0 0 0 0 0 0 0 0"},{"input":"12\nINIT PARK_CAR PARK_BIKE PARK_CAR PARK_TRUCK PARK_TRUCK FREE PARK_TRUCK LEAVE FREE PARK_CAR FREE\n12 2\n7 0\n4 0\n4 0\n3 0\n3 0\n6 0\n0 0\n5 0\n4 0\n0 0\n6 0\n0 0","expected":"1 0 1 0 0 3 0 1 5 1 3"},{"input":"12\nINIT PARK_BIKE PARK_BIKE PARK_BIKE LEAVE PARK_BIKE PARK_CAR PARK_TRUCK PARK_BIKE LEAVE PARK_CAR FREE\n12 2\n6 0\n2 0\n1 0\n1 0\n4 0\n5 0\n6 0\n2 0\n3 0\n3 0\n4 0\n0 0","expected":"1 1 0 0 1 1 0 1 1 0 1"}]$j$::jsonb,
  $q$1 <= slots <= 1000$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','TCS','Infosys','Accenture']::text[], ARRAY['polymorphism','design','inheritance']::text[]);

-- 14 | medium | Observer Pattern
SELECT pg_temp.seed_coding($q$OOP Concepts$q$, 'medium', $q$Observer Pattern$q$, $q$A Subject keeps a set of Observers (identified by id). Commands: SUBSCRIBE o (add observer o; subscribing twice changes nothing; no output); UNSUBSCRIBE o (remove it; no output); NOTIFY v (every CURRENT observer receives the value v and adds it to its running total; no output); RECEIVED o (output observer o's running total, 0 if it never subscribed). An observer keeps its total after unsubscribing and does not lose it on re-subscribing. Input: ops[i] is a command and (args[i][0], args[i][1]) are its two integer arguments (arguments a command does not use are 0). Model the system with proper classes (for example a base class or interface plus subclasses, or a class that hides its state) and have your function drive them. Print the output of the commands that produce output, in order.

Input Format:
- ops: an integer n, then n space-separated strings
- args: two integers r and c, then r lines of c space-separated integers

Output Format:
Print the integers on one line, separated by single spaces.

Example:
Input:
11
SUBSCRIBE NOTIFY SUBSCRIBE NOTIFY RECEIVED RECEIVED UNSUBSCRIBE NOTIFY RECEIVED RECEIVED RECEIVED
11 2
1 0
5 0
2 0
3 0
1 0
2 0
1 0
10 0
1 0
2 0
9 0
Output:
8 3 8 13 0$q$,
  $q$def run_observer(ops: List[str], args: List[List[int]]) -> List[int]$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef run_observer(ops: List[str], args: List[List[int]]) -> List[int]:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    ops = [next(it) for _ in range(int(next(it)))]\n    rows, cols = int(next(it)), int(next(it))\n    args = [[int(next(it)) for _ in range(cols)] for _ in range(rows)]\n    result = run_observer(ops, args)\n    print(' '.join(map(str, result)))\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction runObserver(ops, args) {\n  // Write your solution here\n}\n\nconst ops = Array.from({ length: parseInt(next()) }, () => next());\nconst argsRows = parseInt(next());\nconst argsCols = parseInt(next());\nconst args = Array.from({ length: argsRows }, () => Array.from({ length: argsCols }, () => parseInt(next())));\nconst result = runObserver(ops, args);\nconsole.log(result.join(' '));\n","java":"import java.util.*;\n\npublic class Main {\n    static int[] runObserver(String[] ops, int[][] args) {\n        // Write your solution here\n        return new int[0];\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String[] ops = new String[scanner.nextInt()];\n        for (int i = 0; i < ops.length; i++) ops[i] = scanner.next();\n        int argsRows = scanner.nextInt(), argsCols = scanner.nextInt();\n        int[][] args = new int[argsRows][argsCols];\n        for (int i = 0; i < argsRows; i++)\n            for (int j = 0; j < argsCols; j++) args[i][j] = scanner.nextInt();\n        int[] result = runObserver(ops, args);\n        StringBuilder sb = new StringBuilder();\n        for (int i = 0; i < result.length; i++) {\n            if (i > 0) sb.append(' ');\n            sb.append(result[i]);\n        }\n        System.out.println(sb);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nvector<int> runObserver(vector<string> ops, vector<vector<int>> args) {\n    // Write your solution here\n    return {};\n}\n\nint main() {\n    int opsN;\n    cin >> opsN;\n    vector<string> ops(opsN);\n    for (string& x : ops) cin >> x;\n    int argsRows, argsCols;\n    cin >> argsRows >> argsCols;\n    vector<vector<int>> args(argsRows, vector<int>(argsCols));\n    for (auto& row : args) for (int& x : row) cin >> x;\n    auto result = runObserver(ops, args);\n    for (size_t i = 0; i < result.size(); i++) {\n        if (i) cout << ' ';\n        cout << result[i];\n    }\n    cout << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"11\nSUBSCRIBE NOTIFY SUBSCRIBE NOTIFY RECEIVED RECEIVED UNSUBSCRIBE NOTIFY RECEIVED RECEIVED RECEIVED\n11 2\n1 0\n5 0\n2 0\n3 0\n1 0\n2 0\n1 0\n10 0\n1 0\n2 0\n9 0","expected":"8 3 8 13 0"},{"input":"1\nRECEIVED\n1 2\n4 0","expected":"0"},{"input":"4\nSUBSCRIBE SUBSCRIBE NOTIFY RECEIVED\n4 2\n1 0\n1 0\n2 0\n1 0","expected":"2"},{"input":"11\nNOTIFY RECEIVED SUBSCRIBE RECEIVED UNSUBSCRIBE NOTIFY NOTIFY SUBSCRIBE NOTIFY NOTIFY RECEIVED\n11 2\n4 0\n3 0\n3 0\n1 0\n3 0\n8 0\n7 0\n1 0\n6 0\n4 0\n1 0","expected":"0 0 10"},{"input":"11\nNOTIFY RECEIVED NOTIFY SUBSCRIBE UNSUBSCRIBE UNSUBSCRIBE SUBSCRIBE SUBSCRIBE NOTIFY UNSUBSCRIBE RECEIVED\n11 2\n6 0\n2 0\n1 0\n2 0\n2 0\n1 0\n3 0\n2 0\n9 0\n3 0\n1 0","expected":"0 0"},{"input":"9\nRECEIVED RECEIVED UNSUBSCRIBE NOTIFY NOTIFY UNSUBSCRIBE RECEIVED SUBSCRIBE RECEIVED\n9 2\n2 0\n1 0\n3 0\n4 0\n5 0\n3 0\n3 0\n3 0\n1 0","expected":"0 0 0 0"}]$j$::jsonb,
  $q$1 <= n <= 10^4$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Infosys','Accenture']::text[], ARRAY['observer-pattern','design']::text[]);

-- 15 | medium | Complex Number with Operator Overloading
SELECT pg_temp.seed_coding($q$OOP Concepts$q$, 'medium', $q$Complex Number with Operator Overloading$q$, $q$Implement a Complex class (real part a, imaginary part b) that overloads +, - and *, and keep one 'current' value that starts at 0 + 0i. Commands (a, b form the operand a + bi): SET a b (current = operand); ADD a b (current = current + operand); SUB a b (current = current - operand); MUL a b (current = current * operand); PRINT (output TWO numbers: the real part then the imaginary part of the current value). Input: ops[i] is a command and (args[i][0], args[i][1]) are its two integer arguments (arguments a command does not use are 0). Model the system with proper classes (for example a base class or interface plus subclasses, or a class that hides its state) and have your function drive them. Print the output of the commands that produce output, in order.

Input Format:
- ops: an integer n, then n space-separated strings
- args: two integers r and c, then r lines of c space-separated integers

Output Format:
Print the integers on one line, separated by single spaces.

Example:
Input:
3
SET MUL PRINT
3 2
1 2
3 4
0 0
Output:
-5 10$q$,
  $q$def run_complex(ops: List[str], args: List[List[int]]) -> List[int]$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef run_complex(ops: List[str], args: List[List[int]]) -> List[int]:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    ops = [next(it) for _ in range(int(next(it)))]\n    rows, cols = int(next(it)), int(next(it))\n    args = [[int(next(it)) for _ in range(cols)] for _ in range(rows)]\n    result = run_complex(ops, args)\n    print(' '.join(map(str, result)))\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction runComplex(ops, args) {\n  // Write your solution here\n}\n\nconst ops = Array.from({ length: parseInt(next()) }, () => next());\nconst argsRows = parseInt(next());\nconst argsCols = parseInt(next());\nconst args = Array.from({ length: argsRows }, () => Array.from({ length: argsCols }, () => parseInt(next())));\nconst result = runComplex(ops, args);\nconsole.log(result.join(' '));\n","java":"import java.util.*;\n\npublic class Main {\n    static int[] runComplex(String[] ops, int[][] args) {\n        // Write your solution here\n        return new int[0];\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String[] ops = new String[scanner.nextInt()];\n        for (int i = 0; i < ops.length; i++) ops[i] = scanner.next();\n        int argsRows = scanner.nextInt(), argsCols = scanner.nextInt();\n        int[][] args = new int[argsRows][argsCols];\n        for (int i = 0; i < argsRows; i++)\n            for (int j = 0; j < argsCols; j++) args[i][j] = scanner.nextInt();\n        int[] result = runComplex(ops, args);\n        StringBuilder sb = new StringBuilder();\n        for (int i = 0; i < result.length; i++) {\n            if (i > 0) sb.append(' ');\n            sb.append(result[i]);\n        }\n        System.out.println(sb);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nvector<int> runComplex(vector<string> ops, vector<vector<int>> args) {\n    // Write your solution here\n    return {};\n}\n\nint main() {\n    int opsN;\n    cin >> opsN;\n    vector<string> ops(opsN);\n    for (string& x : ops) cin >> x;\n    int argsRows, argsCols;\n    cin >> argsRows >> argsCols;\n    vector<vector<int>> args(argsRows, vector<int>(argsCols));\n    for (auto& row : args) for (int& x : row) cin >> x;\n    auto result = runComplex(ops, args);\n    for (size_t i = 0; i < result.size(); i++) {\n        if (i) cout << ' ';\n        cout << result[i];\n    }\n    cout << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"3\nSET MUL PRINT\n3 2\n1 2\n3 4\n0 0","expected":"-5 10"},{"input":"1\nPRINT\n1 2\n0 0","expected":"0 0"},{"input":"4\nSET ADD SUB PRINT\n4 2\n2 3\n1 1\n0 5\n0 0","expected":"3 -1"},{"input":"7\nADD SUB MUL SUB PRINT SUB PRINT\n7 2\n3 3\n2 -2\n-1 2\n-1 0\n0 0\n-4 -3\n0 0","expected":"-10 -3 -6 0"},{"input":"7\nPRINT PRINT PRINT ADD ADD SET PRINT\n7 2\n0 0\n0 0\n0 0\n-2 -4\n5 2\n-3 -4\n0 0","expected":"0 0 0 0 0 0 -3 -4"},{"input":"10\nSUB SET MUL SET SUB MUL ADD PRINT PRINT PRINT\n10 2\n4 -3\n-5 -5\n-2 0\n-2 0\n1 -5\n-1 2\n5 4\n0 0\n0 0\n0 0","expected":"-2 -7 -2 -7 -2 -7"}]$j$::jsonb,
  $q$1 <= n <= 10^4$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['operator-overloading','classes']::text[]);

-- 16 | medium | Fraction Class
SELECT pg_temp.seed_coding($q$OOP Concepts$q$, 'medium', $q$Fraction Class$q$, $q$Implement a Fraction class that always stays in lowest terms with a POSITIVE denominator (the sign lives on the numerator; zero is 0/1). Keep a current value starting at 0/1. Commands (operand n/d, d is never 0): SET n d; ADD n d (current = current + n/d); MUL n d (current = current * n/d); PRINT (output TWO numbers: numerator then denominator). Input: ops[i] is a command and (args[i][0], args[i][1]) are its two integer arguments (arguments a command does not use are 0). Model the system with proper classes (for example a base class or interface plus subclasses, or a class that hides its state) and have your function drive them. Print the output of the commands that produce output, in order.

Input Format:
- ops: an integer n, then n space-separated strings
- args: two integers r and c, then r lines of c space-separated integers

Output Format:
Print the integers on one line, separated by single spaces.

Example:
Input:
5
SET ADD PRINT MUL PRINT
5 2
1 2
1 3
0 0
3 5
0 0
Output:
5 6 1 2$q$,
  $q$def run_fraction(ops: List[str], args: List[List[int]]) -> List[int]$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef run_fraction(ops: List[str], args: List[List[int]]) -> List[int]:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    ops = [next(it) for _ in range(int(next(it)))]\n    rows, cols = int(next(it)), int(next(it))\n    args = [[int(next(it)) for _ in range(cols)] for _ in range(rows)]\n    result = run_fraction(ops, args)\n    print(' '.join(map(str, result)))\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction runFraction(ops, args) {\n  // Write your solution here\n}\n\nconst ops = Array.from({ length: parseInt(next()) }, () => next());\nconst argsRows = parseInt(next());\nconst argsCols = parseInt(next());\nconst args = Array.from({ length: argsRows }, () => Array.from({ length: argsCols }, () => parseInt(next())));\nconst result = runFraction(ops, args);\nconsole.log(result.join(' '));\n","java":"import java.util.*;\n\npublic class Main {\n    static int[] runFraction(String[] ops, int[][] args) {\n        // Write your solution here\n        return new int[0];\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String[] ops = new String[scanner.nextInt()];\n        for (int i = 0; i < ops.length; i++) ops[i] = scanner.next();\n        int argsRows = scanner.nextInt(), argsCols = scanner.nextInt();\n        int[][] args = new int[argsRows][argsCols];\n        for (int i = 0; i < argsRows; i++)\n            for (int j = 0; j < argsCols; j++) args[i][j] = scanner.nextInt();\n        int[] result = runFraction(ops, args);\n        StringBuilder sb = new StringBuilder();\n        for (int i = 0; i < result.length; i++) {\n            if (i > 0) sb.append(' ');\n            sb.append(result[i]);\n        }\n        System.out.println(sb);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nvector<int> runFraction(vector<string> ops, vector<vector<int>> args) {\n    // Write your solution here\n    return {};\n}\n\nint main() {\n    int opsN;\n    cin >> opsN;\n    vector<string> ops(opsN);\n    for (string& x : ops) cin >> x;\n    int argsRows, argsCols;\n    cin >> argsRows >> argsCols;\n    vector<vector<int>> args(argsRows, vector<int>(argsCols));\n    for (auto& row : args) for (int& x : row) cin >> x;\n    auto result = runFraction(ops, args);\n    for (size_t i = 0; i < result.size(); i++) {\n        if (i) cout << ' ';\n        cout << result[i];\n    }\n    cout << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"5\nSET ADD PRINT MUL PRINT\n5 2\n1 2\n1 3\n0 0\n3 5\n0 0","expected":"5 6 1 2"},{"input":"1\nPRINT\n1 2\n0 0","expected":"0 1"},{"input":"2\nSET PRINT\n2 2\n2 -4\n0 0","expected":"-1 2"},{"input":"9\nADD SET MUL PRINT MUL SET SET SET PRINT\n9 2\n-3 3\n1 6\n3 1\n0 0\n-2 2\n1 6\n-2 4\n-6 3\n0 0","expected":"1 2 -2 1"},{"input":"8\nSET SET PRINT SET ADD SET ADD PRINT\n8 2\n0 2\n1 -4\n0 0\n0 -4\n5 2\n-6 2\n-1 2\n0 0","expected":"-1 4 -7 2"},{"input":"9\nPRINT MUL SET ADD SET SET PRINT SET PRINT\n9 2\n0 0\n-1 1\n6 6\n3 3\n5 3\n-6 4\n0 0\n-5 -2\n0 0","expected":"0 1 -3 2 5 2"}]$j$::jsonb,
  $q$1 <= n <= 10^4$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Infosys','Accenture']::text[], ARRAY['operator-overloading','encapsulation']::text[]);

-- 17 | medium | Vending Machine
SELECT pg_temp.seed_coding($q$OOP Concepts$q$, 'medium', $q$Vending Machine$q$, $q$A vending machine sells one product at 50 per unit. It tracks its stock and the customer's credit (both start at 0). Commands: STOCK n (set the stock to n); INSERT x (credit += x); BUY (if stock > 0 and credit >= 50, dispense: stock -= 1, credit -= 50, output 1; otherwise output 0 and change nothing); REFUND (output the current credit and reset it to 0). STOCK and INSERT produce no output. Input: ops[i] is a command and (args[i][0], args[i][1]) are its two integer arguments (arguments a command does not use are 0). Model the system with proper classes (for example a base class or interface plus subclasses, or a class that hides its state) and have your function drive them. Print the output of the commands that produce output, in order.

Input Format:
- ops: an integer n, then n space-separated strings
- args: two integers r and c, then r lines of c space-separated integers

Output Format:
Print the integers on one line, separated by single spaces.

Example:
Input:
7
STOCK INSERT BUY INSERT BUY BUY REFUND
7 2
1 0
30 0
0 0
30 0
0 0
0 0
0 0
Output:
0 1 0 10$q$,
  $q$def run_vending(ops: List[str], args: List[List[int]]) -> List[int]$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef run_vending(ops: List[str], args: List[List[int]]) -> List[int]:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    ops = [next(it) for _ in range(int(next(it)))]\n    rows, cols = int(next(it)), int(next(it))\n    args = [[int(next(it)) for _ in range(cols)] for _ in range(rows)]\n    result = run_vending(ops, args)\n    print(' '.join(map(str, result)))\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction runVending(ops, args) {\n  // Write your solution here\n}\n\nconst ops = Array.from({ length: parseInt(next()) }, () => next());\nconst argsRows = parseInt(next());\nconst argsCols = parseInt(next());\nconst args = Array.from({ length: argsRows }, () => Array.from({ length: argsCols }, () => parseInt(next())));\nconst result = runVending(ops, args);\nconsole.log(result.join(' '));\n","java":"import java.util.*;\n\npublic class Main {\n    static int[] runVending(String[] ops, int[][] args) {\n        // Write your solution here\n        return new int[0];\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String[] ops = new String[scanner.nextInt()];\n        for (int i = 0; i < ops.length; i++) ops[i] = scanner.next();\n        int argsRows = scanner.nextInt(), argsCols = scanner.nextInt();\n        int[][] args = new int[argsRows][argsCols];\n        for (int i = 0; i < argsRows; i++)\n            for (int j = 0; j < argsCols; j++) args[i][j] = scanner.nextInt();\n        int[] result = runVending(ops, args);\n        StringBuilder sb = new StringBuilder();\n        for (int i = 0; i < result.length; i++) {\n            if (i > 0) sb.append(' ');\n            sb.append(result[i]);\n        }\n        System.out.println(sb);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nvector<int> runVending(vector<string> ops, vector<vector<int>> args) {\n    // Write your solution here\n    return {};\n}\n\nint main() {\n    int opsN;\n    cin >> opsN;\n    vector<string> ops(opsN);\n    for (string& x : ops) cin >> x;\n    int argsRows, argsCols;\n    cin >> argsRows >> argsCols;\n    vector<vector<int>> args(argsRows, vector<int>(argsCols));\n    for (auto& row : args) for (int& x : row) cin >> x;\n    auto result = runVending(ops, args);\n    for (size_t i = 0; i < result.size(); i++) {\n        if (i) cout << ' ';\n        cout << result[i];\n    }\n    cout << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"7\nSTOCK INSERT BUY INSERT BUY BUY REFUND\n7 2\n1 0\n30 0\n0 0\n30 0\n0 0\n0 0\n0 0","expected":"0 1 0 10"},{"input":"1\nREFUND\n1 2\n0 0","expected":"0"},{"input":"5\nSTOCK INSERT BUY BUY BUY\n5 2\n2 0\n100 0\n0 0\n0 0\n0 0","expected":"1 1 0"},{"input":"9\nINSERT REFUND INSERT STOCK BUY STOCK BUY BUY REFUND\n9 2\n50 0\n0 0\n50 0\n2 0\n0 0\n0 0\n0 0\n0 0\n0 0","expected":"50 1 0 0 0"},{"input":"12\nBUY REFUND INSERT REFUND STOCK INSERT REFUND INSERT STOCK BUY INSERT REFUND\n12 2\n0 0\n0 0\n10 0\n0 0\n1 0\n50 0\n0 0\n20 0\n2 0\n0 0\n50 0\n0 0","expected":"0 0 10 50 0 70"},{"input":"15\nINSERT INSERT REFUND INSERT INSERT INSERT BUY REFUND STOCK STOCK REFUND REFUND BUY BUY REFUND\n15 2\n20 0\n10 0\n0 0\n50 0\n20 0\n10 0\n0 0\n0 0\n0 0\n1 0\n0 0\n0 0\n0 0\n0 0\n0 0","expected":"30 0 80 0 0 0 0 0"}]$j$::jsonb,
  $q$1 <= n <= 10^4$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['state','encapsulation']::text[]);

-- 18 | medium | Rate Limiter
SELECT pg_temp.seed_coding($q$OOP Concepts$q$, 'medium', $q$Rate Limiter$q$, $q$Build a sliding-window rate limiter. INIT limit window (always first, no output). REQUEST t (timestamps never decrease): allow the request (output 1) if fewer than `limit` ALLOWED requests have timestamps strictly greater than t - window, otherwise deny it (output 0). Only allowed requests are counted. Input: ops[i] is a command and (args[i][0], args[i][1]) are its two integer arguments (arguments a command does not use are 0). Model the system with proper classes (for example a base class or interface plus subclasses, or a class that hides its state) and have your function drive them. Print the output of the commands that produce output, in order.

Input Format:
- ops: an integer n, then n space-separated strings
- args: two integers r and c, then r lines of c space-separated integers

Output Format:
Print the integers on one line, separated by single spaces.

Example:
Input:
7
INIT REQUEST REQUEST REQUEST REQUEST REQUEST REQUEST
7 2
2 10
1 0
2 0
3 0
11 0
12 0
12 0
Output:
1 1 0 1 1 0$q$,
  $q$def run_rate_limiter(ops: List[str], args: List[List[int]]) -> List[int]$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef run_rate_limiter(ops: List[str], args: List[List[int]]) -> List[int]:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    ops = [next(it) for _ in range(int(next(it)))]\n    rows, cols = int(next(it)), int(next(it))\n    args = [[int(next(it)) for _ in range(cols)] for _ in range(rows)]\n    result = run_rate_limiter(ops, args)\n    print(' '.join(map(str, result)))\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction runRateLimiter(ops, args) {\n  // Write your solution here\n}\n\nconst ops = Array.from({ length: parseInt(next()) }, () => next());\nconst argsRows = parseInt(next());\nconst argsCols = parseInt(next());\nconst args = Array.from({ length: argsRows }, () => Array.from({ length: argsCols }, () => parseInt(next())));\nconst result = runRateLimiter(ops, args);\nconsole.log(result.join(' '));\n","java":"import java.util.*;\n\npublic class Main {\n    static int[] runRateLimiter(String[] ops, int[][] args) {\n        // Write your solution here\n        return new int[0];\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String[] ops = new String[scanner.nextInt()];\n        for (int i = 0; i < ops.length; i++) ops[i] = scanner.next();\n        int argsRows = scanner.nextInt(), argsCols = scanner.nextInt();\n        int[][] args = new int[argsRows][argsCols];\n        for (int i = 0; i < argsRows; i++)\n            for (int j = 0; j < argsCols; j++) args[i][j] = scanner.nextInt();\n        int[] result = runRateLimiter(ops, args);\n        StringBuilder sb = new StringBuilder();\n        for (int i = 0; i < result.length; i++) {\n            if (i > 0) sb.append(' ');\n            sb.append(result[i]);\n        }\n        System.out.println(sb);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nvector<int> runRateLimiter(vector<string> ops, vector<vector<int>> args) {\n    // Write your solution here\n    return {};\n}\n\nint main() {\n    int opsN;\n    cin >> opsN;\n    vector<string> ops(opsN);\n    for (string& x : ops) cin >> x;\n    int argsRows, argsCols;\n    cin >> argsRows >> argsCols;\n    vector<vector<int>> args(argsRows, vector<int>(argsCols));\n    for (auto& row : args) for (int& x : row) cin >> x;\n    auto result = runRateLimiter(ops, args);\n    for (size_t i = 0; i < result.size(); i++) {\n        if (i) cout << ' ';\n        cout << result[i];\n    }\n    cout << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"7\nINIT REQUEST REQUEST REQUEST REQUEST REQUEST REQUEST\n7 2\n2 10\n1 0\n2 0\n3 0\n11 0\n12 0\n12 0","expected":"1 1 0 1 1 0"},{"input":"3\nINIT REQUEST REQUEST\n3 2\n1 5\n0 0\n5 0","expected":"1 1"},{"input":"2\nINIT REQUEST\n2 2\n3 1\n4 0","expected":"1"},{"input":"12\nINIT REQUEST REQUEST REQUEST REQUEST REQUEST REQUEST REQUEST REQUEST REQUEST REQUEST REQUEST\n12 2\n3 3\n3 0\n4 0\n8 0\n8 0\n12 0\n15 0\n15 0\n18 0\n21 0\n22 0\n25 0","expected":"1 1 1 1 1 1 1 1 1 1 1"},{"input":"13\nINIT REQUEST REQUEST REQUEST REQUEST REQUEST REQUEST REQUEST REQUEST REQUEST REQUEST REQUEST REQUEST\n13 2\n2 6\n2 0\n5 0\n6 0\n10 0\n12 0\n12 0\n16 0\n17 0\n20 0\n20 0\n24 0\n27 0","expected":"1 1 0 1 1 0 1 0 1 0 1 1"},{"input":"12\nINIT REQUEST REQUEST REQUEST REQUEST REQUEST REQUEST REQUEST REQUEST REQUEST REQUEST REQUEST\n12 2\n1 6\n2 0\n2 0\n5 0\n7 0\n10 0\n13 0\n16 0\n18 0\n21 0\n21 0\n22 0","expected":"1 0 0 0 1 0 1 0 0 0 1"}]$j$::jsonb,
  $q$1 <= limit <= 1000$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Infosys','Accenture']::text[], ARRAY['design','sliding-window','queue']::text[]);

-- 19 | medium | Priority Task Scheduler
SELECT pg_temp.seed_coding($q$OOP Concepts$q$, 'medium', $q$Priority Task Scheduler$q$, $q$Design a task scheduler. ADD id priority adds a task (no output; a LARGER priority number means more urgent). POP removes and outputs the id of the most urgent task, breaking ties in favour of the task that was added EARLIER (output -1 if there are no tasks). SIZE outputs the number of waiting tasks. Input: ops[i] is a command and (args[i][0], args[i][1]) are its two integer arguments (arguments a command does not use are 0). Model the system with proper classes (for example a base class or interface plus subclasses, or a class that hides its state) and have your function drive them. Print the output of the commands that produce output, in order.

Input Format:
- ops: an integer n, then n space-separated strings
- args: two integers r and c, then r lines of c space-separated integers

Output Format:
Print the integers on one line, separated by single spaces.

Example:
Input:
8
ADD ADD ADD POP POP SIZE POP POP
8 2
1 5
2 9
3 9
0 0
0 0
0 0
0 0
0 0
Output:
2 3 1 1 -1$q$,
  $q$def run_scheduler(ops: List[str], args: List[List[int]]) -> List[int]$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef run_scheduler(ops: List[str], args: List[List[int]]) -> List[int]:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    ops = [next(it) for _ in range(int(next(it)))]\n    rows, cols = int(next(it)), int(next(it))\n    args = [[int(next(it)) for _ in range(cols)] for _ in range(rows)]\n    result = run_scheduler(ops, args)\n    print(' '.join(map(str, result)))\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction runScheduler(ops, args) {\n  // Write your solution here\n}\n\nconst ops = Array.from({ length: parseInt(next()) }, () => next());\nconst argsRows = parseInt(next());\nconst argsCols = parseInt(next());\nconst args = Array.from({ length: argsRows }, () => Array.from({ length: argsCols }, () => parseInt(next())));\nconst result = runScheduler(ops, args);\nconsole.log(result.join(' '));\n","java":"import java.util.*;\n\npublic class Main {\n    static int[] runScheduler(String[] ops, int[][] args) {\n        // Write your solution here\n        return new int[0];\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String[] ops = new String[scanner.nextInt()];\n        for (int i = 0; i < ops.length; i++) ops[i] = scanner.next();\n        int argsRows = scanner.nextInt(), argsCols = scanner.nextInt();\n        int[][] args = new int[argsRows][argsCols];\n        for (int i = 0; i < argsRows; i++)\n            for (int j = 0; j < argsCols; j++) args[i][j] = scanner.nextInt();\n        int[] result = runScheduler(ops, args);\n        StringBuilder sb = new StringBuilder();\n        for (int i = 0; i < result.length; i++) {\n            if (i > 0) sb.append(' ');\n            sb.append(result[i]);\n        }\n        System.out.println(sb);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nvector<int> runScheduler(vector<string> ops, vector<vector<int>> args) {\n    // Write your solution here\n    return {};\n}\n\nint main() {\n    int opsN;\n    cin >> opsN;\n    vector<string> ops(opsN);\n    for (string& x : ops) cin >> x;\n    int argsRows, argsCols;\n    cin >> argsRows >> argsCols;\n    vector<vector<int>> args(argsRows, vector<int>(argsCols));\n    for (auto& row : args) for (int& x : row) cin >> x;\n    auto result = runScheduler(ops, args);\n    for (size_t i = 0; i < result.size(); i++) {\n        if (i) cout << ' ';\n        cout << result[i];\n    }\n    cout << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"8\nADD ADD ADD POP POP SIZE POP POP\n8 2\n1 5\n2 9\n3 9\n0 0\n0 0\n0 0\n0 0\n0 0","expected":"2 3 1 1 -1"},{"input":"1\nPOP\n1 2\n0 0","expected":"-1"},{"input":"2\nADD SIZE\n2 2\n7 1\n0 0","expected":"1"},{"input":"12\nADD ADD SIZE ADD SIZE ADD POP SIZE POP ADD SIZE POP\n12 2\n19 1\n1 1\n0 0\n10 2\n0 0\n9 1\n0 0\n0 0\n0 0\n3 2\n0 0\n0 0","expected":"2 3 10 3 19 3 3"},{"input":"13\nADD POP POP ADD POP SIZE ADD SIZE ADD ADD SIZE ADD POP\n13 2\n4 4\n0 0\n0 0\n3 1\n0 0\n0 0\n3 3\n0 0\n17 2\n18 3\n0 0\n2 4\n0 0","expected":"4 -1 3 0 1 3 2"},{"input":"15\nADD ADD SIZE ADD ADD ADD POP ADD POP SIZE ADD POP POP POP POP\n15 2\n5 1\n14 1\n0 0\n14 1\n14 2\n16 1\n0 0\n20 2\n0 0\n0 0\n16 3\n0 0\n0 0\n0 0\n0 0","expected":"2 14 20 4 16 5 14 14"}]$j$::jsonb,
  $q$1 <= n <= 10^4$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','TCS','Infosys','Accenture']::text[], ARRAY['design','priority-queue','heap']::text[]);

-- 20 | hard | Text Editor with Undo and Redo
SELECT pg_temp.seed_coding($q$OOP Concepts$q$, 'hard', $q$Text Editor with Undo and Redo$q$, $q$A document is a list of integers. Commands: ADD x (append x); DEL (remove the LAST element; if the document is empty it does nothing and is NOT recorded in the history); UNDO (reverse the most recent recorded ADD/DEL, no-op if there is nothing to undo); REDO (re-apply the most recently undone command, no-op if nothing is undone); SUM (output the sum of the document). Any new ADD or DEL clears the redo history. Only SUM produces output. Input: ops[i] is a command and (args[i][0], args[i][1]) are its two integer arguments (arguments a command does not use are 0). Model the system with proper classes (for example a base class or interface plus subclasses, or a class that hides its state) and have your function drive them. Print the output of the commands that produce output, in order.

Input Format:
- ops: an integer n, then n space-separated strings
- args: two integers r and c, then r lines of c space-separated integers

Output Format:
Print the integers on one line, separated by single spaces.

Example:
Input:
10
ADD ADD SUM UNDO SUM REDO SUM DEL UNDO SUM
10 2
5 0
7 0
0 0
0 0
0 0
0 0
0 0
0 0
0 0
0 0
Output:
12 5 12 12$q$,
  $q$def run_editor(ops: List[str], args: List[List[int]]) -> List[int]$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef run_editor(ops: List[str], args: List[List[int]]) -> List[int]:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    ops = [next(it) for _ in range(int(next(it)))]\n    rows, cols = int(next(it)), int(next(it))\n    args = [[int(next(it)) for _ in range(cols)] for _ in range(rows)]\n    result = run_editor(ops, args)\n    print(' '.join(map(str, result)))\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction runEditor(ops, args) {\n  // Write your solution here\n}\n\nconst ops = Array.from({ length: parseInt(next()) }, () => next());\nconst argsRows = parseInt(next());\nconst argsCols = parseInt(next());\nconst args = Array.from({ length: argsRows }, () => Array.from({ length: argsCols }, () => parseInt(next())));\nconst result = runEditor(ops, args);\nconsole.log(result.join(' '));\n","java":"import java.util.*;\n\npublic class Main {\n    static int[] runEditor(String[] ops, int[][] args) {\n        // Write your solution here\n        return new int[0];\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String[] ops = new String[scanner.nextInt()];\n        for (int i = 0; i < ops.length; i++) ops[i] = scanner.next();\n        int argsRows = scanner.nextInt(), argsCols = scanner.nextInt();\n        int[][] args = new int[argsRows][argsCols];\n        for (int i = 0; i < argsRows; i++)\n            for (int j = 0; j < argsCols; j++) args[i][j] = scanner.nextInt();\n        int[] result = runEditor(ops, args);\n        StringBuilder sb = new StringBuilder();\n        for (int i = 0; i < result.length; i++) {\n            if (i > 0) sb.append(' ');\n            sb.append(result[i]);\n        }\n        System.out.println(sb);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nvector<int> runEditor(vector<string> ops, vector<vector<int>> args) {\n    // Write your solution here\n    return {};\n}\n\nint main() {\n    int opsN;\n    cin >> opsN;\n    vector<string> ops(opsN);\n    for (string& x : ops) cin >> x;\n    int argsRows, argsCols;\n    cin >> argsRows >> argsCols;\n    vector<vector<int>> args(argsRows, vector<int>(argsCols));\n    for (auto& row : args) for (int& x : row) cin >> x;\n    auto result = runEditor(ops, args);\n    for (size_t i = 0; i < result.size(); i++) {\n        if (i) cout << ' ';\n        cout << result[i];\n    }\n    cout << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"10\nADD ADD SUM UNDO SUM REDO SUM DEL UNDO SUM\n10 2\n5 0\n7 0\n0 0\n0 0\n0 0\n0 0\n0 0\n0 0\n0 0\n0 0","expected":"12 5 12 12"},{"input":"1\nSUM\n1 2\n0 0","expected":"0"},{"input":"5\nADD UNDO ADD REDO SUM\n5 2\n1 0\n0 0\n2 0\n0 0\n0 0","expected":"2"},{"input":"14\nDEL SUM DEL DEL ADD DEL DEL DEL UNDO UNDO REDO SUM REDO SUM\n14 2\n0 0\n0 0\n0 0\n0 0\n7 0\n0 0\n0 0\n0 0\n0 0\n0 0\n0 0\n0 0\n0 0\n0 0","expected":"0 7 0"},{"input":"16\nREDO SUM ADD UNDO REDO ADD SUM ADD REDO DEL SUM REDO UNDO REDO ADD SUM\n16 2\n0 0\n0 0\n4 0\n0 0\n0 0\n9 0\n0 0\n8 0\n0 0\n0 0\n0 0\n0 0\n0 0\n0 0\n6 0\n0 0","expected":"0 13 13 19"},{"input":"11\nADD DEL DEL DEL ADD REDO UNDO SUM SUM REDO SUM\n11 2\n2 0\n0 0\n0 0\n0 0\n6 0\n0 0\n0 0\n0 0\n0 0\n0 0\n0 0","expected":"0 0 6"}]$j$::jsonb,
  $q$1 <= n <= 10^4$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Infosys','Accenture']::text[], ARRAY['command-pattern','design']::text[]);

-- 21 | hard | Tic-Tac-Toe Game
SELECT pg_temp.seed_coding($q$OOP Concepts$q$, 'hard', $q$Tic-Tac-Toe Game$q$, $q$Design a 3x3 Tic-Tac-Toe game. Players 1 and 2 alternate, player 1 starting. MOVE r c (0-based row and column) places the current player's mark. Output -1 (and do not change the turn) if the cell is outside the board, already taken, or the game is already over. Otherwise output 0 if the game goes on, or the player's id (1 or 2) if this move completes three in a row, column or diagonal - the game is then over and every later MOVE outputs -1. Input: ops[i] is a command and (args[i][0], args[i][1]) are its two integer arguments (arguments a command does not use are 0). Model the system with proper classes (for example a base class or interface plus subclasses, or a class that hides its state) and have your function drive them. Print the output of the commands that produce output, in order.

Input Format:
- ops: an integer n, then n space-separated strings
- args: two integers r and c, then r lines of c space-separated integers

Output Format:
Print the integers on one line, separated by single spaces.

Example:
Input:
6
MOVE MOVE MOVE MOVE MOVE MOVE
6 2
0 0
1 0
0 1
1 1
0 2
2 2
Output:
0 0 0 0 1 -1$q$,
  $q$def run_tic_tac_toe(ops: List[str], args: List[List[int]]) -> List[int]$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef run_tic_tac_toe(ops: List[str], args: List[List[int]]) -> List[int]:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    ops = [next(it) for _ in range(int(next(it)))]\n    rows, cols = int(next(it)), int(next(it))\n    args = [[int(next(it)) for _ in range(cols)] for _ in range(rows)]\n    result = run_tic_tac_toe(ops, args)\n    print(' '.join(map(str, result)))\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction runTicTacToe(ops, args) {\n  // Write your solution here\n}\n\nconst ops = Array.from({ length: parseInt(next()) }, () => next());\nconst argsRows = parseInt(next());\nconst argsCols = parseInt(next());\nconst args = Array.from({ length: argsRows }, () => Array.from({ length: argsCols }, () => parseInt(next())));\nconst result = runTicTacToe(ops, args);\nconsole.log(result.join(' '));\n","java":"import java.util.*;\n\npublic class Main {\n    static int[] runTicTacToe(String[] ops, int[][] args) {\n        // Write your solution here\n        return new int[0];\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String[] ops = new String[scanner.nextInt()];\n        for (int i = 0; i < ops.length; i++) ops[i] = scanner.next();\n        int argsRows = scanner.nextInt(), argsCols = scanner.nextInt();\n        int[][] args = new int[argsRows][argsCols];\n        for (int i = 0; i < argsRows; i++)\n            for (int j = 0; j < argsCols; j++) args[i][j] = scanner.nextInt();\n        int[] result = runTicTacToe(ops, args);\n        StringBuilder sb = new StringBuilder();\n        for (int i = 0; i < result.length; i++) {\n            if (i > 0) sb.append(' ');\n            sb.append(result[i]);\n        }\n        System.out.println(sb);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nvector<int> runTicTacToe(vector<string> ops, vector<vector<int>> args) {\n    // Write your solution here\n    return {};\n}\n\nint main() {\n    int opsN;\n    cin >> opsN;\n    vector<string> ops(opsN);\n    for (string& x : ops) cin >> x;\n    int argsRows, argsCols;\n    cin >> argsRows >> argsCols;\n    vector<vector<int>> args(argsRows, vector<int>(argsCols));\n    for (auto& row : args) for (int& x : row) cin >> x;\n    auto result = runTicTacToe(ops, args);\n    for (size_t i = 0; i < result.size(); i++) {\n        if (i) cout << ' ';\n        cout << result[i];\n    }\n    cout << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"6\nMOVE MOVE MOVE MOVE MOVE MOVE\n6 2\n0 0\n1 0\n0 1\n1 1\n0 2\n2 2","expected":"0 0 0 0 1 -1"},{"input":"3\nMOVE MOVE MOVE\n3 2\n3 0\n1 1\n1 1","expected":"-1 0 -1"},{"input":"5\nMOVE MOVE MOVE MOVE MOVE\n5 2\n0 0\n0 1\n1 1\n0 2\n2 2","expected":"0 0 0 0 1"},{"input":"6\nMOVE MOVE MOVE MOVE MOVE MOVE\n6 2\n0 1\n1 2\n0 1\n1 0\n1 0\n1 1","expected":"0 0 -1 0 -1 0"},{"input":"9\nMOVE MOVE MOVE MOVE MOVE MOVE MOVE MOVE MOVE\n9 2\n2 2\n0 0\n2 2\n2 0\n2 2\n2 1\n1 1\n2 0\n2 2","expected":"0 0 -1 0 -1 0 0 -1 -1"},{"input":"8\nMOVE MOVE MOVE MOVE MOVE MOVE MOVE MOVE\n8 2\n2 2\n1 1\n1 2\n2 1\n0 2\n1 2\n2 0\n2 0","expected":"0 0 0 0 1 -1 -1 -1"}]$j$::jsonb,
  $q$1 <= n <= 100$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','TCS','Infosys','Accenture']::text[], ARRAY['design','state','simulation']::text[]);

-- 22 | medium | Trie (Prefix Tree)
SELECT pg_temp.seed_coding($q$OOP Concepts$q$, 'medium', $q$Trie (Prefix Tree)$q$, $q$Implement a Trie. Input: ops[i] is a command and words[i] its string argument (lowercase letters). INSERT w adds a word (no output; inserting the same word twice counts once); SEARCH w outputs 1 if exactly w was inserted, else 0; PREFIX p outputs 1 if some inserted word starts with p, else 0; COUNT p outputs how many DISTINCT inserted words start with p (a word is a prefix of itself). Input: ops[i] is a command and (args[i][0], args[i][1]) are its two integer arguments (arguments a command does not use are 0). Model the system with proper classes (for example a base class or interface plus subclasses, or a class that hides its state) and have your function drive them. Print the output of the commands that produce output, in order.

Input Format:
- ops: an integer n, then n space-separated strings
- words: an integer n, then n space-separated strings

Output Format:
Print the integers on one line, separated by single spaces.

Example:
Input:
7
INSERT INSERT SEARCH SEARCH PREFIX COUNT COUNT
7
apple app app ap ap app b
Output:
1 0 1 2 0$q$,
  $q$def run_trie(ops: List[str], words: List[str]) -> List[int]$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef run_trie(ops: List[str], words: List[str]) -> List[int]:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    ops = [next(it) for _ in range(int(next(it)))]\n    words = [next(it) for _ in range(int(next(it)))]\n    result = run_trie(ops, words)\n    print(' '.join(map(str, result)))\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction runTrie(ops, words) {\n  // Write your solution here\n}\n\nconst ops = Array.from({ length: parseInt(next()) }, () => next());\nconst words = Array.from({ length: parseInt(next()) }, () => next());\nconst result = runTrie(ops, words);\nconsole.log(result.join(' '));\n","java":"import java.util.*;\n\npublic class Main {\n    static int[] runTrie(String[] ops, String[] words) {\n        // Write your solution here\n        return new int[0];\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String[] ops = new String[scanner.nextInt()];\n        for (int i = 0; i < ops.length; i++) ops[i] = scanner.next();\n        String[] words = new String[scanner.nextInt()];\n        for (int i = 0; i < words.length; i++) words[i] = scanner.next();\n        int[] result = runTrie(ops, words);\n        StringBuilder sb = new StringBuilder();\n        for (int i = 0; i < result.length; i++) {\n            if (i > 0) sb.append(' ');\n            sb.append(result[i]);\n        }\n        System.out.println(sb);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nvector<int> runTrie(vector<string> ops, vector<string> words) {\n    // Write your solution here\n    return {};\n}\n\nint main() {\n    int opsN;\n    cin >> opsN;\n    vector<string> ops(opsN);\n    for (string& x : ops) cin >> x;\n    int wordsN;\n    cin >> wordsN;\n    vector<string> words(wordsN);\n    for (string& x : words) cin >> x;\n    auto result = runTrie(ops, words);\n    for (size_t i = 0; i < result.size(); i++) {\n        if (i) cout << ' ';\n        cout << result[i];\n    }\n    cout << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"7\nINSERT INSERT SEARCH SEARCH PREFIX COUNT COUNT\n7\napple app app ap ap app b","expected":"1 0 1 2 0"},{"input":"1\nSEARCH\n1\na","expected":"0"},{"input":"3\nINSERT INSERT COUNT\n3\ngo go g","expected":"1"},{"input":"11\nINSERT SEARCH INSERT PREFIX INSERT INSERT SEARCH INSERT INSERT SEARCH COUNT\n11\nba c ab ab bab b ab ba c abc a","expected":"0 1 1 0 1"},{"input":"12\nINSERT INSERT COUNT INSERT COUNT INSERT COUNT INSERT SEARCH INSERT COUNT COUNT\n12\nab bab ba abc c abc ab abc ba b b a","expected":"1 0 2 0 2 2"},{"input":"12\nPREFIX INSERT INSERT COUNT SEARCH PREFIX INSERT INSERT COUNT INSERT COUNT COUNT\n12\nc b ba b abc b abc abc b abc ab a","expected":"0 2 0 1 2 1 1"}]$j$::jsonb,
  $q$1 <= n <= 10^4$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Infosys','Accenture']::text[], ARRAY['trie','design','strings']::text[]);


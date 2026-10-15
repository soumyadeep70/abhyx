-- 250_coding_dynamic_programming.sql
-- Topic: Dynamic Programming (coding) -- 22 questions.
-- Idempotent: re-running updates these rows in place (matched on topic + title).
-- Requires the helpers in 010_question_helpers.sql (run in the same session by `npm run seed`).

-- 01 | easy | Climbing Stairs
SELECT pg_temp.seed_coding($q$Dynamic Programming$q$, 'easy', $q$Climbing Stairs$q$, $q$You climb a staircase of n steps, taking 1 or 2 steps at a time. Print the number of distinct ways to reach the top.

Input Format:
- n: a single integer

Output Format:
Print a single integer.

Example:
Input:
5
Output:
8$q$,
  $q$def climb_stairs(n: int) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef climb_stairs(n: int) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    n = int(next(it))\n    result = climb_stairs(n)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction climbStairs(n) {\n  // Write your solution here\n}\n\nconst n = parseInt(next());\nconst result = climbStairs(n);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int climbStairs(int n) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int n = scanner.nextInt();\n        int result = climbStairs(n);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint climbStairs(int n) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int n;\n    cin >> n;\n    auto result = climbStairs(n);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"5","expected":"8"},{"input":"1","expected":"1"},{"input":"30","expected":"1346269"},{"input":"15","expected":"987"},{"input":"39","expected":"102334155"},{"input":"27","expected":"317811"}]$j$::jsonb,
  $q$1 <= n <= 40$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','TCS','Infosys','Wipro','Accenture']::text[], ARRAY['dp','fibonacci']::text[]);

-- 02 | easy | House Robber
SELECT pg_temp.seed_coding($q$Dynamic Programming$q$, 'easy', $q$House Robber$q$, $q$Each house holds some money, but robbing two adjacent houses triggers an alarm. Print the maximum amount you can rob in one night.

Input Format:
- nums: an integer n, then a line of n space-separated integers

Output Format:
Print a single integer.

Example:
Input:
5
2 7 9 3 1
Output:
12$q$,
  $q$def rob(nums: List[int]) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef rob(nums: List[int]) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    nums = [int(next(it)) for _ in range(int(next(it)))]\n    result = rob(nums)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction rob(nums) {\n  // Write your solution here\n}\n\nconst nums = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst result = rob(nums);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int rob(int[] nums) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int[] nums = new int[scanner.nextInt()];\n        for (int i = 0; i < nums.length; i++) nums[i] = scanner.nextInt();\n        int result = rob(nums);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint rob(vector<int> nums) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int numsN;\n    cin >> numsN;\n    vector<int> nums(numsN);\n    for (int& x : nums) cin >> x;\n    auto result = rob(nums);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"5\n2 7 9 3 1","expected":"12"},{"input":"4\n1 2 3 1","expected":"4"},{"input":"1\n5","expected":"5"},{"input":"8\n4 1 8 1 16 13 6 13","expected":"41"},{"input":"8\n3 11 12 4 10 13 11 11","expected":"39"},{"input":"6\n10 8 20 15 16 5","expected":"46"}]$j$::jsonb,
  $q$1 <= n <= 100; 0 <= nums[i] <= 400$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','TCS','Accenture']::text[], ARRAY['dp']::text[]);

-- 03 | medium | Coin Change
SELECT pg_temp.seed_coding($q$Dynamic Programming$q$, 'medium', $q$Coin Change$q$, $q$Print the fewest coins needed to make up amount using unlimited coins of each denomination, or -1 if it can't be done.

Input Format:
- coins: an integer n, then a line of n space-separated integers
- amount: a single integer

Output Format:
Print a single integer.

Example:
Input:
3
1 2 5
11
Output:
3$q$,
  $q$def coin_change(coins: List[int], amount: int) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef coin_change(coins: List[int], amount: int) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    coins = [int(next(it)) for _ in range(int(next(it)))]\n    amount = int(next(it))\n    result = coin_change(coins, amount)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction coinChange(coins, amount) {\n  // Write your solution here\n}\n\nconst coins = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst amount = parseInt(next());\nconst result = coinChange(coins, amount);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int coinChange(int[] coins, int amount) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int[] coins = new int[scanner.nextInt()];\n        for (int i = 0; i < coins.length; i++) coins[i] = scanner.nextInt();\n        int amount = scanner.nextInt();\n        int result = coinChange(coins, amount);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint coinChange(vector<int> coins, int amount) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int coinsN;\n    cin >> coinsN;\n    vector<int> coins(coinsN);\n    for (int& x : coins) cin >> x;\n    int amount;\n    cin >> amount;\n    auto result = coinChange(coins, amount);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"3\n1 2 5\n11","expected":"3"},{"input":"1\n2\n3","expected":"-1"},{"input":"1\n1\n0","expected":"0"},{"input":"4\n1 2 7 8\n39","expected":"5"},{"input":"3\n4 7 9\n29","expected":"4"},{"input":"3\n3 7 9\n35","expected":"5"}]$j$::jsonb,
  $q$1 <= n <= 12; 0 <= amount <= 10^4$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','TCS','Accenture']::text[], ARRAY['dp','unbounded-knapsack']::text[]);

-- 04 | medium | Coin Change II
SELECT pg_temp.seed_coding($q$Dynamic Programming$q$, 'medium', $q$Coin Change II$q$, $q$Print the number of different COMBINATIONS (order does not matter) of the coins that sum to amount. You have an unlimited supply of each coin. Print 0 if it is impossible. The answer fits in a 32-bit integer.

Input Format:
- amount: a single integer
- coins: an integer n, then a line of n space-separated integers

Output Format:
Print a single integer.

Example:
Input:
5
3
1 2 5
Output:
4$q$,
  $q$def change_ways(amount: int, coins: List[int]) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef change_ways(amount: int, coins: List[int]) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    amount = int(next(it))\n    coins = [int(next(it)) for _ in range(int(next(it)))]\n    result = change_ways(amount, coins)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction changeWays(amount, coins) {\n  // Write your solution here\n}\n\nconst amount = parseInt(next());\nconst coins = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst result = changeWays(amount, coins);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int changeWays(int amount, int[] coins) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int amount = scanner.nextInt();\n        int[] coins = new int[scanner.nextInt()];\n        for (int i = 0; i < coins.length; i++) coins[i] = scanner.nextInt();\n        int result = changeWays(amount, coins);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint changeWays(int amount, vector<int> coins) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int amount;\n    cin >> amount;\n    int coinsN;\n    cin >> coinsN;\n    vector<int> coins(coinsN);\n    for (int& x : coins) cin >> x;\n    auto result = changeWays(amount, coins);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"5\n3\n1 2 5","expected":"4"},{"input":"3\n1\n2","expected":"0"},{"input":"10\n1\n10","expected":"1"},{"input":"24\n3\n4 5 6","expected":"5"},{"input":"14\n4\n1 5 8 9","expected":"7"},{"input":"8\n2\n1 6","expected":"2"}]$j$::jsonb,
  $q$1 <= n <= 300; 0 <= amount <= 5000$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Accenture']::text[], ARRAY['dp','unbounded-knapsack']::text[]);

-- 05 | hard | Longest Increasing Subsequence
SELECT pg_temp.seed_coding($q$Dynamic Programming$q$, 'hard', $q$Longest Increasing Subsequence$q$, $q$Given an integer array nums, print the length of the longest strictly increasing subsequence. A subsequence keeps the original order but may skip elements.

Input Format:
- nums: an integer n, then a line of n space-separated integers

Output Format:
Print a single integer.

Example:
Input:
8
10 9 2 5 3 7 101 18
Output:
4$q$,
  $q$def length_of_lis(nums: List[int]) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef length_of_lis(nums: List[int]) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    nums = [int(next(it)) for _ in range(int(next(it)))]\n    result = length_of_lis(nums)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction lengthOfLis(nums) {\n  // Write your solution here\n}\n\nconst nums = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst result = lengthOfLis(nums);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int lengthOfLis(int[] nums) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int[] nums = new int[scanner.nextInt()];\n        for (int i = 0; i < nums.length; i++) nums[i] = scanner.nextInt();\n        int result = lengthOfLis(nums);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint lengthOfLis(vector<int> nums) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int numsN;\n    cin >> numsN;\n    vector<int> nums(numsN);\n    for (int& x : nums) cin >> x;\n    auto result = lengthOfLis(nums);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"8\n10 9 2 5 3 7 101 18","expected":"4"},{"input":"6\n0 1 0 3 2 3","expected":"4"},{"input":"4\n7 7 7 7","expected":"1"},{"input":"7\n2 5 16 0 1 9 3","expected":"3"},{"input":"10\n7 8 8 19 0 9 10 2 17 15","expected":"5"},{"input":"8\n1 14 14 2 15 4 20 11","expected":"4"}]$j$::jsonb,
  $q$1 <= n <= 2500$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Accenture']::text[], ARRAY['dp','binary-search']::text[]);

-- 06 | medium | Longest Common Subsequence
SELECT pg_temp.seed_coding($q$Dynamic Programming$q$, 'medium', $q$Longest Common Subsequence$q$, $q$Print the length of the longest subsequence that appears in both strings (a subsequence keeps order but may skip characters).

Input Format:
- text1: a single string (no spaces)
- text2: a single string (no spaces)

Output Format:
Print a single integer.

Example:
Input:
abcde
ace
Output:
3$q$,
  $q$def longest_common_subsequence(text1: str, text2: str) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef longest_common_subsequence(text1: str, text2: str) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    text1 = next(it)\n    text2 = next(it)\n    result = longest_common_subsequence(text1, text2)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction longestCommonSubsequence(text1, text2) {\n  // Write your solution here\n}\n\nconst text1 = next();\nconst text2 = next();\nconst result = longestCommonSubsequence(text1, text2);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int longestCommonSubsequence(String text1, String text2) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String text1 = scanner.next();\n        String text2 = scanner.next();\n        int result = longestCommonSubsequence(text1, text2);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint longestCommonSubsequence(string text1, string text2) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    string text1;\n    cin >> text1;\n    string text2;\n    cin >> text2;\n    auto result = longestCommonSubsequence(text1, text2);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"abcde\nace","expected":"3"},{"input":"abc\nabc","expected":"3"},{"input":"abc\ndef","expected":"0"},{"input":"acbac\nabbcb","expected":"3"},{"input":"abaca\nacaccbc","expected":"3"},{"input":"bacbba\ncaaaccacaa","expected":"3"}]$j$::jsonb,
  $q$1 <= length <= 1000$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','TCS','Accenture']::text[], ARRAY['dp','strings']::text[]);

-- 07 | hard | Edit Distance
SELECT pg_temp.seed_coding($q$Dynamic Programming$q$, 'hard', $q$Edit Distance$q$, $q$Print the minimum number of single-character operations (insert, delete or replace) needed to convert word1 into word2.

Input Format:
- word1: a single string (no spaces)
- word2: a single string (no spaces)

Output Format:
Print a single integer.

Example:
Input:
horse
ros
Output:
3$q$,
  $q$def min_distance(word1: str, word2: str) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef min_distance(word1: str, word2: str) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    word1 = next(it)\n    word2 = next(it)\n    result = min_distance(word1, word2)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction minDistance(word1, word2) {\n  // Write your solution here\n}\n\nconst word1 = next();\nconst word2 = next();\nconst result = minDistance(word1, word2);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int minDistance(String word1, String word2) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String word1 = scanner.next();\n        String word2 = scanner.next();\n        int result = minDistance(word1, word2);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint minDistance(string word1, string word2) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    string word1;\n    cin >> word1;\n    string word2;\n    cin >> word2;\n    auto result = minDistance(word1, word2);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"horse\nros","expected":"3"},{"input":"intention\nexecution","expected":"5"},{"input":"a\na","expected":"0"},{"input":"bbcbcccb\ncabacaa","expected":"6"},{"input":"ccbbbc\ncbaaa","expected":"4"},{"input":"ababcc\nccbababa","expected":"5"}]$j$::jsonb,
  $q$1 <= length <= 500$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Accenture']::text[], ARRAY['dp','strings']::text[]);

-- 08 | medium | 0/1 Knapsack
SELECT pg_temp.seed_coding($q$Dynamic Programming$q$, 'medium', $q$0/1 Knapsack$q$, $q$Item i has weight weights[i] and value values[i]; each item can be taken at most once. Print the maximum total value that fits in a knapsack of the given capacity.

Input Format:
- weights: an integer n, then a line of n space-separated integers
- values: an integer n, then a line of n space-separated integers
- capacity: a single integer

Output Format:
Print a single integer.

Example:
Input:
4
1 3 4 5
4
1 4 5 7
7
Output:
9$q$,
  $q$def knapsack(weights: List[int], values: List[int], capacity: int) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef knapsack(weights: List[int], values: List[int], capacity: int) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    weights = [int(next(it)) for _ in range(int(next(it)))]\n    values = [int(next(it)) for _ in range(int(next(it)))]\n    capacity = int(next(it))\n    result = knapsack(weights, values, capacity)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction knapsack(weights, values, capacity) {\n  // Write your solution here\n}\n\nconst weights = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst values = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst capacity = parseInt(next());\nconst result = knapsack(weights, values, capacity);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int knapsack(int[] weights, int[] values, int capacity) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int[] weights = new int[scanner.nextInt()];\n        for (int i = 0; i < weights.length; i++) weights[i] = scanner.nextInt();\n        int[] values = new int[scanner.nextInt()];\n        for (int i = 0; i < values.length; i++) values[i] = scanner.nextInt();\n        int capacity = scanner.nextInt();\n        int result = knapsack(weights, values, capacity);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint knapsack(vector<int> weights, vector<int> values, int capacity) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int weightsN;\n    cin >> weightsN;\n    vector<int> weights(weightsN);\n    for (int& x : weights) cin >> x;\n    int valuesN;\n    cin >> valuesN;\n    vector<int> values(valuesN);\n    for (int& x : values) cin >> x;\n    int capacity;\n    cin >> capacity;\n    auto result = knapsack(weights, values, capacity);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"4\n1 3 4 5\n4\n1 4 5 7\n7","expected":"9"},{"input":"1\n5\n1\n10\n4","expected":"0"},{"input":"3\n2 3 4\n3\n3 4 5\n5","expected":"7"},{"input":"5\n7 6 7 1 3\n5\n6 2 10 20 20\n8","expected":"40"},{"input":"5\n9 7 1 9 5\n5\n12 20 19 18 15\n11","expected":"39"},{"input":"7\n5 6 6 4 4 2 1\n7\n17 1 4 20 14 17 2\n12","expected":"56"}]$j$::jsonb,
  $q$1 <= n <= 100; 1 <= capacity <= 10^4$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','TCS','Infosys','Accenture']::text[], ARRAY['dp','knapsack']::text[]);

-- 09 | medium | Partition Equal Subset Sum
SELECT pg_temp.seed_coding($q$Dynamic Programming$q$, 'medium', $q$Partition Equal Subset Sum$q$, $q$Print true if the array can be split into two subsets with equal sums.

Input Format:
- nums: an integer n, then a line of n space-separated integers

Output Format:
Print true or false (lowercase).

Example:
Input:
4
1 5 11 5
Output:
true$q$,
  $q$def can_partition(nums: List[int]) -> bool$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef can_partition(nums: List[int]) -> bool:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    nums = [int(next(it)) for _ in range(int(next(it)))]\n    result = can_partition(nums)\n    print('true' if result else 'false')\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction canPartition(nums) {\n  // Write your solution here\n}\n\nconst nums = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst result = canPartition(nums);\nconsole.log(result ? 'true' : 'false');\n","java":"import java.util.*;\n\npublic class Main {\n    static boolean canPartition(int[] nums) {\n        // Write your solution here\n        return false;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int[] nums = new int[scanner.nextInt()];\n        for (int i = 0; i < nums.length; i++) nums[i] = scanner.nextInt();\n        boolean result = canPartition(nums);\n        System.out.println(result ? \"true\" : \"false\");\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nbool canPartition(vector<int> nums) {\n    // Write your solution here\n    return false;\n}\n\nint main() {\n    int numsN;\n    cin >> numsN;\n    vector<int> nums(numsN);\n    for (int& x : nums) cin >> x;\n    auto result = canPartition(nums);\n    cout << (result ? \"true\" : \"false\") << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"4\n1 5 11 5","expected":"true"},{"input":"4\n1 2 3 5","expected":"false"},{"input":"2\n2 2","expected":"true"},{"input":"6\n3 1 3 6 1 6","expected":"true"},{"input":"8\n6 5 8 3 8 1 8 7","expected":"true"},{"input":"7\n8 1 9 6 7 2 4","expected":"false"}]$j$::jsonb,
  $q$1 <= n <= 200; 1 <= nums[i] <= 100$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Accenture']::text[], ARRAY['dp','subset-sum']::text[]);

-- 10 | easy | Unique Paths
SELECT pg_temp.seed_coding($q$Dynamic Programming$q$, 'easy', $q$Unique Paths$q$, $q$A robot starts at the top-left of an m x n grid and may only move right or down. Print the number of distinct paths to the bottom-right corner. The answer fits in a 32-bit integer.

Input Format:
- m: a single integer
- n: a single integer

Output Format:
Print a single integer.

Example:
Input:
3
7
Output:
28$q$,
  $q$def unique_paths(m: int, n: int) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef unique_paths(m: int, n: int) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    m = int(next(it))\n    n = int(next(it))\n    result = unique_paths(m, n)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction uniquePaths(m, n) {\n  // Write your solution here\n}\n\nconst m = parseInt(next());\nconst n = parseInt(next());\nconst result = uniquePaths(m, n);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int uniquePaths(int m, int n) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int m = scanner.nextInt();\n        int n = scanner.nextInt();\n        int result = uniquePaths(m, n);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint uniquePaths(int m, int n) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int m;\n    cin >> m;\n    int n;\n    cin >> n;\n    auto result = uniquePaths(m, n);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"3\n7","expected":"28"},{"input":"3\n2","expected":"3"},{"input":"1\n1","expected":"1"},{"input":"8\n9","expected":"6435"},{"input":"8\n6","expected":"792"},{"input":"3\n12","expected":"78"}]$j$::jsonb,
  $q$1 <= m, n <= 100$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','TCS','Infosys','Accenture']::text[], ARRAY['dp','grid','combinatorics']::text[]);

-- 11 | medium | Unique Paths with Obstacles
SELECT pg_temp.seed_coding($q$Dynamic Programming$q$, 'medium', $q$Unique Paths with Obstacles$q$, $q$Same as Unique Paths, but some cells are obstacles (1) that cannot be entered. Print the number of paths from the top-left to the bottom-right, moving only right or down. Cells with 0 are free.

Input Format:
- grid: two integers r and c, then r lines of c space-separated integers

Output Format:
Print a single integer.

Example:
Input:
3 3
0 0 0
0 1 0
0 0 0
Output:
2$q$,
  $q$def unique_paths_obstacles(grid: List[List[int]]) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef unique_paths_obstacles(grid: List[List[int]]) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    rows, cols = int(next(it)), int(next(it))\n    grid = [[int(next(it)) for _ in range(cols)] for _ in range(rows)]\n    result = unique_paths_obstacles(grid)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction uniquePathsObstacles(grid) {\n  // Write your solution here\n}\n\nconst gridRows = parseInt(next());\nconst gridCols = parseInt(next());\nconst grid = Array.from({ length: gridRows }, () => Array.from({ length: gridCols }, () => parseInt(next())));\nconst result = uniquePathsObstacles(grid);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int uniquePathsObstacles(int[][] grid) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int gridRows = scanner.nextInt(), gridCols = scanner.nextInt();\n        int[][] grid = new int[gridRows][gridCols];\n        for (int i = 0; i < gridRows; i++)\n            for (int j = 0; j < gridCols; j++) grid[i][j] = scanner.nextInt();\n        int result = uniquePathsObstacles(grid);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint uniquePathsObstacles(vector<vector<int>> grid) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int gridRows, gridCols;\n    cin >> gridRows >> gridCols;\n    vector<vector<int>> grid(gridRows, vector<int>(gridCols));\n    for (auto& row : grid) for (int& x : row) cin >> x;\n    auto result = uniquePathsObstacles(grid);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"3 3\n0 0 0\n0 1 0\n0 0 0","expected":"2"},{"input":"2 2\n0 1\n0 0","expected":"1"},{"input":"1 2\n1 0","expected":"0"},{"input":"4 4\n0 0 0 1\n1 0 0 0\n1 1 0 0\n0 0 0 0","expected":"6"},{"input":"4 4\n0 0 0 1\n1 0 0 0\n0 1 0 0\n1 0 0 0","expected":"6"},{"input":"4 4\n0 0 0 1\n1 0 1 0\n0 0 0 0\n1 0 0 0","expected":"3"}]$j$::jsonb,
  $q$1 <= rows, cols <= 100$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Accenture']::text[], ARRAY['dp','grid']::text[]);

-- 12 | medium | Minimum Path Sum
SELECT pg_temp.seed_coding($q$Dynamic Programming$q$, 'medium', $q$Minimum Path Sum$q$, $q$Print the minimum sum of the numbers along a path from the top-left to the bottom-right of the grid, moving only right or down.

Input Format:
- grid: two integers r and c, then r lines of c space-separated integers

Output Format:
Print a single integer.

Example:
Input:
3 3
1 3 1
1 5 1
4 2 1
Output:
7$q$,
  $q$def min_path_sum(grid: List[List[int]]) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef min_path_sum(grid: List[List[int]]) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    rows, cols = int(next(it)), int(next(it))\n    grid = [[int(next(it)) for _ in range(cols)] for _ in range(rows)]\n    result = min_path_sum(grid)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction minPathSum(grid) {\n  // Write your solution here\n}\n\nconst gridRows = parseInt(next());\nconst gridCols = parseInt(next());\nconst grid = Array.from({ length: gridRows }, () => Array.from({ length: gridCols }, () => parseInt(next())));\nconst result = minPathSum(grid);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int minPathSum(int[][] grid) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int gridRows = scanner.nextInt(), gridCols = scanner.nextInt();\n        int[][] grid = new int[gridRows][gridCols];\n        for (int i = 0; i < gridRows; i++)\n            for (int j = 0; j < gridCols; j++) grid[i][j] = scanner.nextInt();\n        int result = minPathSum(grid);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint minPathSum(vector<vector<int>> grid) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int gridRows, gridCols;\n    cin >> gridRows >> gridCols;\n    vector<vector<int>> grid(gridRows, vector<int>(gridCols));\n    for (auto& row : grid) for (int& x : row) cin >> x;\n    auto result = minPathSum(grid);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"3 3\n1 3 1\n1 5 1\n4 2 1","expected":"7"},{"input":"2 3\n1 2 3\n4 5 6","expected":"12"},{"input":"1 1\n7","expected":"7"},{"input":"3 3\n4 2 5\n0 4 1\n4 3 5","expected":"14"},{"input":"3 3\n9 3 3\n7 8 2\n4 4 6","expected":"23"},{"input":"4 4\n8 2 4 6\n9 2 0 3\n7 6 1 4\n5 8 7 7","expected":"24"}]$j$::jsonb,
  $q$1 <= rows, cols <= 200$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','TCS','Infosys','Accenture']::text[], ARRAY['dp','grid']::text[]);

-- 13 | medium | Decode Ways
SELECT pg_temp.seed_coding($q$Dynamic Programming$q$, 'medium', $q$Decode Ways$q$, $q$A message of letters is encoded by A=1, B=2, ..., Z=26. Given a string of digits, print the number of ways to decode it. Leading zeros are not allowed within a code (so '06' is invalid); print 0 if the string cannot be decoded.

Input Format:
- s: a single string (no spaces)

Output Format:
Print a single integer.

Example:
Input:
226
Output:
3$q$,
  $q$def num_decodings(s: str) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef num_decodings(s: str) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    s = next(it)\n    result = num_decodings(s)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction numDecodings(s) {\n  // Write your solution here\n}\n\nconst s = next();\nconst result = numDecodings(s);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int numDecodings(String s) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String s = scanner.next();\n        int result = numDecodings(s);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint numDecodings(string s) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    string s;\n    cin >> s;\n    auto result = numDecodings(s);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"226","expected":"3"},{"input":"12","expected":"2"},{"input":"06","expected":"0"},{"input":"10","expected":"1"},{"input":"6621","expected":"2"},{"input":"5250511","expected":"0"},{"input":"30015","expected":"0"}]$j$::jsonb,
  $q$1 <= length <= 100$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Accenture']::text[], ARRAY['dp','strings']::text[]);

-- 14 | medium | Word Break
SELECT pg_temp.seed_coding($q$Dynamic Programming$q$, 'medium', $q$Word Break$q$, $q$Print true if s can be split into a sequence of one or more words from the dictionary. Dictionary words may be reused.

Input Format:
- s: a single string (no spaces)
- word_dict: an integer n, then n space-separated strings

Output Format:
Print true or false (lowercase).

Example:
Input:
leetcode
2
leet code
Output:
true$q$,
  $q$def word_break(s: str, word_dict: List[str]) -> bool$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef word_break(s: str, word_dict: List[str]) -> bool:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    s = next(it)\n    word_dict = [next(it) for _ in range(int(next(it)))]\n    result = word_break(s, word_dict)\n    print('true' if result else 'false')\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction wordBreak(s, word_dict) {\n  // Write your solution here\n}\n\nconst s = next();\nconst word_dict = Array.from({ length: parseInt(next()) }, () => next());\nconst result = wordBreak(s, word_dict);\nconsole.log(result ? 'true' : 'false');\n","java":"import java.util.*;\n\npublic class Main {\n    static boolean wordBreak(String s, String[] word_dict) {\n        // Write your solution here\n        return false;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String s = scanner.next();\n        String[] word_dict = new String[scanner.nextInt()];\n        for (int i = 0; i < word_dict.length; i++) word_dict[i] = scanner.next();\n        boolean result = wordBreak(s, word_dict);\n        System.out.println(result ? \"true\" : \"false\");\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nbool wordBreak(string s, vector<string> word_dict) {\n    // Write your solution here\n    return false;\n}\n\nint main() {\n    string s;\n    cin >> s;\n    int word_dictN;\n    cin >> word_dictN;\n    vector<string> word_dict(word_dictN);\n    for (string& x : word_dict) cin >> x;\n    auto result = wordBreak(s, word_dict);\n    cout << (result ? \"true\" : \"false\") << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"leetcode\n2\nleet code","expected":"true"},{"input":"applepenapple\n2\napple pen","expected":"true"},{"input":"catsandog\n5\ncats dog sand and cat","expected":"false"},{"input":"aabbbabbb\n2\nbb bbb","expected":"false"},{"input":"aaabb\n4\nba a bb b","expected":"true"},{"input":"bbbaab\n3\nb a a","expected":"true"}]$j$::jsonb,
  $q$1 <= length <= 300$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Accenture']::text[], ARRAY['dp','strings']::text[]);

-- 15 | medium | Jump Game II
SELECT pg_temp.seed_coding($q$Dynamic Programming$q$, 'medium', $q$Jump Game II$q$, $q$nums[i] is the maximum jump length from index i. Starting at index 0, print the minimum number of jumps to reach the last index. The last index is always reachable.

Input Format:
- nums: an integer n, then a line of n space-separated integers

Output Format:
Print a single integer.

Example:
Input:
5
2 3 1 1 4
Output:
2$q$,
  $q$def min_jumps(nums: List[int]) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef min_jumps(nums: List[int]) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    nums = [int(next(it)) for _ in range(int(next(it)))]\n    result = min_jumps(nums)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction minJumps(nums) {\n  // Write your solution here\n}\n\nconst nums = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst result = minJumps(nums);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int minJumps(int[] nums) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int[] nums = new int[scanner.nextInt()];\n        for (int i = 0; i < nums.length; i++) nums[i] = scanner.nextInt();\n        int result = minJumps(nums);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint minJumps(vector<int> nums) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int numsN;\n    cin >> numsN;\n    vector<int> nums(numsN);\n    for (int& x : nums) cin >> x;\n    auto result = minJumps(nums);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"5\n2 3 1 1 4","expected":"2"},{"input":"5\n2 3 0 1 4","expected":"2"},{"input":"1\n0","expected":"0"},{"input":"6\n4 4 3 4 2 3","expected":"2"},{"input":"6\n4 2 4 1 4 4","expected":"2"},{"input":"6\n3 4 3 2 3 4","expected":"2"}]$j$::jsonb,
  $q$1 <= n <= 10^4; the last index is reachable$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Accenture']::text[], ARRAY['greedy','dp']::text[]);

-- 16 | medium | Longest Palindromic Subsequence
SELECT pg_temp.seed_coding($q$Dynamic Programming$q$, 'medium', $q$Longest Palindromic Subsequence$q$, $q$Print the length of the longest palindromic SUBSEQUENCE of s (characters need not be contiguous).

Input Format:
- s: a single string (no spaces)

Output Format:
Print a single integer.

Example:
Input:
bbbab
Output:
4$q$,
  $q$def longest_palindrome_subseq(s: str) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef longest_palindrome_subseq(s: str) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    s = next(it)\n    result = longest_palindrome_subseq(s)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction longestPalindromeSubseq(s) {\n  // Write your solution here\n}\n\nconst s = next();\nconst result = longestPalindromeSubseq(s);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int longestPalindromeSubseq(String s) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String s = scanner.next();\n        int result = longestPalindromeSubseq(s);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint longestPalindromeSubseq(string s) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    string s;\n    cin >> s;\n    auto result = longestPalindromeSubseq(s);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"bbbab","expected":"4"},{"input":"cbbd","expected":"2"},{"input":"abcde","expected":"1"},{"input":"bbccabc","expected":"4"},{"input":"bacabbccac","expected":"6"},{"input":"bbbaaabccc","expected":"5"}]$j$::jsonb,
  $q$1 <= length <= 1000$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Accenture']::text[], ARRAY['dp','strings']::text[]);

-- 17 | medium | Target Sum
SELECT pg_temp.seed_coding($q$Dynamic Programming$q$, 'medium', $q$Target Sum$q$, $q$Put a '+' or '-' in front of every number and count the ways the resulting expression equals target. Print 0 if there are none.

Input Format:
- nums: an integer n, then a line of n space-separated integers
- target: a single integer

Output Format:
Print a single integer.

Example:
Input:
5
1 1 1 1 1
3
Output:
5$q$,
  $q$def find_target_sum_ways(nums: List[int], target: int) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef find_target_sum_ways(nums: List[int], target: int) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    nums = [int(next(it)) for _ in range(int(next(it)))]\n    target = int(next(it))\n    result = find_target_sum_ways(nums, target)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction findTargetSumWays(nums, target) {\n  // Write your solution here\n}\n\nconst nums = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst target = parseInt(next());\nconst result = findTargetSumWays(nums, target);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int findTargetSumWays(int[] nums, int target) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int[] nums = new int[scanner.nextInt()];\n        for (int i = 0; i < nums.length; i++) nums[i] = scanner.nextInt();\n        int target = scanner.nextInt();\n        int result = findTargetSumWays(nums, target);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint findTargetSumWays(vector<int> nums, int target) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int numsN;\n    cin >> numsN;\n    vector<int> nums(numsN);\n    for (int& x : nums) cin >> x;\n    int target;\n    cin >> target;\n    auto result = findTargetSumWays(nums, target);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"5\n1 1 1 1 1\n3","expected":"5"},{"input":"1\n1\n1","expected":"1"},{"input":"2\n1 2\n7","expected":"0"},{"input":"8\n1 3 2 4 0 5 5 2\n0","expected":"20"},{"input":"5\n2 5 4 2 2\n3","expected":"4"},{"input":"8\n1 1 1 2 4 2 4 1\n4","expected":"24"}]$j$::jsonb,
  $q$1 <= n <= 20; 0 <= nums[i] <= 1000$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Accenture']::text[], ARRAY['dp','subset-sum']::text[]);

-- 18 | medium | Best Time to Buy and Sell Stock with Cooldown
SELECT pg_temp.seed_coding($q$Dynamic Programming$q$, 'medium', $q$Best Time to Buy and Sell Stock with Cooldown$q$, $q$You may complete as many transactions as you like (buy then sell, holding one share at a time), but after selling you must wait one day before buying again. Print the maximum profit.

Input Format:
- prices: an integer n, then a line of n space-separated integers

Output Format:
Print a single integer.

Example:
Input:
5
1 2 3 0 2
Output:
3$q$,
  $q$def max_profit_cooldown(prices: List[int]) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef max_profit_cooldown(prices: List[int]) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    prices = [int(next(it)) for _ in range(int(next(it)))]\n    result = max_profit_cooldown(prices)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction maxProfitCooldown(prices) {\n  // Write your solution here\n}\n\nconst prices = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst result = maxProfitCooldown(prices);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int maxProfitCooldown(int[] prices) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int[] prices = new int[scanner.nextInt()];\n        for (int i = 0; i < prices.length; i++) prices[i] = scanner.nextInt();\n        int result = maxProfitCooldown(prices);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint maxProfitCooldown(vector<int> prices) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int pricesN;\n    cin >> pricesN;\n    vector<int> prices(pricesN);\n    for (int& x : prices) cin >> x;\n    auto result = maxProfitCooldown(prices);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"5\n1 2 3 0 2","expected":"3"},{"input":"1\n1","expected":"0"},{"input":"6\n6 1 3 2 4 7","expected":"6"},{"input":"6\n3 4 3 11 11 9","expected":"8"},{"input":"9\n4 1 2 1 12 9 10 2 9","expected":"18"},{"input":"5\n8 4 7 5 7","expected":"3"}]$j$::jsonb,
  $q$1 <= n <= 5000$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon']::text[], ARRAY['dp','state-machine']::text[]);

-- 19 | medium | Maximal Square
SELECT pg_temp.seed_coding($q$Dynamic Programming$q$, 'medium', $q$Maximal Square$q$, $q$In a grid of 0s and 1s, find the largest square containing only 1s and print its AREA (0 if there is no 1).

Input Format:
- matrix: two integers r and c, then r lines of c space-separated integers

Output Format:
Print a single integer.

Example:
Input:
4 5
1 0 1 0 0
1 0 1 1 1
1 1 1 1 1
1 0 0 1 0
Output:
4$q$,
  $q$def maximal_square(matrix: List[List[int]]) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef maximal_square(matrix: List[List[int]]) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    rows, cols = int(next(it)), int(next(it))\n    matrix = [[int(next(it)) for _ in range(cols)] for _ in range(rows)]\n    result = maximal_square(matrix)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction maximalSquare(matrix) {\n  // Write your solution here\n}\n\nconst matrixRows = parseInt(next());\nconst matrixCols = parseInt(next());\nconst matrix = Array.from({ length: matrixRows }, () => Array.from({ length: matrixCols }, () => parseInt(next())));\nconst result = maximalSquare(matrix);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int maximalSquare(int[][] matrix) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int matrixRows = scanner.nextInt(), matrixCols = scanner.nextInt();\n        int[][] matrix = new int[matrixRows][matrixCols];\n        for (int i = 0; i < matrixRows; i++)\n            for (int j = 0; j < matrixCols; j++) matrix[i][j] = scanner.nextInt();\n        int result = maximalSquare(matrix);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint maximalSquare(vector<vector<int>> matrix) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int matrixRows, matrixCols;\n    cin >> matrixRows >> matrixCols;\n    vector<vector<int>> matrix(matrixRows, vector<int>(matrixCols));\n    for (auto& row : matrix) for (int& x : row) cin >> x;\n    auto result = maximalSquare(matrix);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"4 5\n1 0 1 0 0\n1 0 1 1 1\n1 1 1 1 1\n1 0 0 1 0","expected":"4"},{"input":"2 2\n0 1\n1 0","expected":"1"},{"input":"1 1\n0","expected":"0"},{"input":"5 5\n0 0 0 1 0\n0 0 1 0 1\n1 0 0 0 0\n0 1 1 0 0\n1 1 0 0 0","expected":"1"},{"input":"5 4\n0 1 1 1\n1 1 1 0\n0 0 0 1\n1 1 1 1\n0 0 0 1","expected":"4"},{"input":"5 5\n0 1 1 1 1\n1 1 0 0 0\n0 1 1 0 0\n1 0 0 1 0\n1 1 0 1 0","expected":"1"}]$j$::jsonb,
  $q$1 <= rows, cols <= 300$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Accenture']::text[], ARRAY['dp','matrix']::text[]);

-- 20 | hard | Burst Balloons
SELECT pg_temp.seed_coding($q$Dynamic Programming$q$, 'hard', $q$Burst Balloons$q$, $q$Balloon i has number nums[i]. Bursting balloon i earns nums[i-1] * nums[i] * nums[i+1] coins, where a neighbour that is out of range counts as 1. Print the maximum coins you can collect by bursting all balloons in the best order.

Input Format:
- nums: an integer n, then a line of n space-separated integers

Output Format:
Print a single integer.

Example:
Input:
4
3 1 5 8
Output:
167$q$,
  $q$def max_coins(nums: List[int]) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef max_coins(nums: List[int]) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    nums = [int(next(it)) for _ in range(int(next(it)))]\n    result = max_coins(nums)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction maxCoins(nums) {\n  // Write your solution here\n}\n\nconst nums = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst result = maxCoins(nums);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int maxCoins(int[] nums) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int[] nums = new int[scanner.nextInt()];\n        for (int i = 0; i < nums.length; i++) nums[i] = scanner.nextInt();\n        int result = maxCoins(nums);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint maxCoins(vector<int> nums) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int numsN;\n    cin >> numsN;\n    vector<int> nums(numsN);\n    for (int& x : nums) cin >> x;\n    auto result = maxCoins(nums);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"4\n3 1 5 8","expected":"167"},{"input":"2\n1 5","expected":"10"},{"input":"1\n7","expected":"7"},{"input":"4\n2 3 3 2","expected":"36"},{"input":"4\n7 6 5 3","expected":"343"},{"input":"7\n1 9 7 2 1 6 6","expected":"870"}]$j$::jsonb,
  $q$1 <= n <= 300; 0 <= nums[i] <= 100$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon']::text[], ARRAY['dp','interval-dp']::text[]);

-- 21 | hard | Longest Valid Parentheses
SELECT pg_temp.seed_coding($q$Dynamic Programming$q$, 'hard', $q$Longest Valid Parentheses$q$, $q$The string contains only '(' and ')'. Print the length of the longest contiguous substring that is a valid (well-formed) parentheses string.

Input Format:
- s: a single string (no spaces)

Output Format:
Print a single integer.

Example:
Input:
(()
Output:
2$q$,
  $q$def longest_valid_parentheses(s: str) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef longest_valid_parentheses(s: str) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    s = next(it)\n    result = longest_valid_parentheses(s)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction longestValidParentheses(s) {\n  // Write your solution here\n}\n\nconst s = next();\nconst result = longestValidParentheses(s);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int longestValidParentheses(String s) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String s = scanner.next();\n        int result = longestValidParentheses(s);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint longestValidParentheses(string s) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    string s;\n    cin >> s;\n    auto result = longestValidParentheses(s);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"(()","expected":"2"},{"input":")()())","expected":"4"},{"input":"))((","expected":"0"},{"input":"()))))((()","expected":"2"},{"input":")))()(())))","expected":"6"},{"input":"()((((())()","expected":"6"}]$j$::jsonb,
  $q$1 <= length <= 3 * 10^4$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon']::text[], ARRAY['dp','stack']::text[]);

-- 22 | hard | Distinct Subsequences
SELECT pg_temp.seed_coding($q$Dynamic Programming$q$, 'hard', $q$Distinct Subsequences$q$, $q$Print the number of distinct subsequences of s that equal t. (Two subsequences differ when they use different index sets.) The answer fits in a 32-bit integer.

Input Format:
- s: a single string (no spaces)
- t: a single string (no spaces)

Output Format:
Print a single integer.

Example:
Input:
rabbbit
rabbit
Output:
3$q$,
  $q$def num_distinct(s: str, t: str) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef num_distinct(s: str, t: str) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    s = next(it)\n    t = next(it)\n    result = num_distinct(s, t)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction numDistinct(s, t) {\n  // Write your solution here\n}\n\nconst s = next();\nconst t = next();\nconst result = numDistinct(s, t);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int numDistinct(String s, String t) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String s = scanner.next();\n        String t = scanner.next();\n        int result = numDistinct(s, t);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint numDistinct(string s, string t) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    string s;\n    cin >> s;\n    string t;\n    cin >> t;\n    auto result = numDistinct(s, t);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"rabbbit\nrabbit","expected":"3"},{"input":"babgbag\nbag","expected":"5"},{"input":"abc\nd","expected":"0"},{"input":"bbabaaa\nbb","expected":"3"},{"input":"aaaaaaab\nabb","expected":"0"},{"input":"abbabaab\naba","expected":"10"}]$j$::jsonb,
  $q$1 <= length <= 1000$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon']::text[], ARRAY['dp','strings']::text[]);


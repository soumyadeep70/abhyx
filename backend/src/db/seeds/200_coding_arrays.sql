-- 200_coding_arrays.sql
-- Topic: Arrays (coding) -- 23 questions.
-- Idempotent: re-running updates these rows in place (matched on topic + title).
-- Requires the helpers in 010_question_helpers.sql (run in the same session by `npm run seed`).

-- 01 | easy | Two Sum
SELECT pg_temp.seed_coding($q$Arrays$q$, 'easy', $q$Two Sum$q$, $q$Given an array of integers nums and an integer target, find the two numbers that add up to target. Exactly one pair of indices (i, j) with i < j satisfies this, and you may not use the same element twice. Print the two indices in ascending order (0-based).

Input Format:
- nums: an integer n, then a line of n space-separated integers
- target: a single integer

Output Format:
Print the integers on one line, separated by single spaces.

Example:
Input:
4
2 7 11 15
9
Output:
0 1$q$,
  $q$def two_sum(nums: List[int], target: int) -> List[int]$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef two_sum(nums: List[int], target: int) -> List[int]:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    nums = [int(next(it)) for _ in range(int(next(it)))]\n    target = int(next(it))\n    result = two_sum(nums, target)\n    print(' '.join(map(str, result)))\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction twoSum(nums, target) {\n  // Write your solution here\n}\n\nconst nums = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst target = parseInt(next());\nconst result = twoSum(nums, target);\nconsole.log(result.join(' '));\n","java":"import java.util.*;\n\npublic class Main {\n    static int[] twoSum(int[] nums, int target) {\n        // Write your solution here\n        return new int[0];\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int[] nums = new int[scanner.nextInt()];\n        for (int i = 0; i < nums.length; i++) nums[i] = scanner.nextInt();\n        int target = scanner.nextInt();\n        int[] result = twoSum(nums, target);\n        StringBuilder sb = new StringBuilder();\n        for (int i = 0; i < result.length; i++) {\n            if (i > 0) sb.append(' ');\n            sb.append(result[i]);\n        }\n        System.out.println(sb);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nvector<int> twoSum(vector<int> nums, int target) {\n    // Write your solution here\n    return {};\n}\n\nint main() {\n    int numsN;\n    cin >> numsN;\n    vector<int> nums(numsN);\n    for (int& x : nums) cin >> x;\n    int target;\n    cin >> target;\n    auto result = twoSum(nums, target);\n    for (size_t i = 0; i < result.size(); i++) {\n        if (i) cout << ' ';\n        cout << result[i];\n    }\n    cout << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"4\n2 7 11 15\n9","expected":"0 1"},{"input":"3\n3 2 4\n6","expected":"1 2"},{"input":"2\n3 3\n6","expected":"0 1"},{"input":"5\n-2 37 12 -13 30\n49","expected":"1 2"},{"input":"5\n31 -12 8 -4 39\n70","expected":"0 4"},{"input":"8\n8 -19 -18 16 14 1 -8 -20\n-7","expected":"5 6"}]$j$::jsonb,
  $q$2 <= n <= 10^4; exactly one valid pair exists$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','TCS','Infosys']::text[], ARRAY['hashing']::text[]);

-- 02 | easy | Best Time to Buy and Sell Stock
SELECT pg_temp.seed_coding($q$Arrays$q$, 'easy', $q$Best Time to Buy and Sell Stock$q$, $q$prices[i] is the price of a stock on day i. You may buy on one day and sell on a LATER day, once. Print the maximum profit you can make, or 0 if no profit is possible.

Input Format:
- prices: an integer n, then a line of n space-separated integers

Output Format:
Print a single integer.

Example:
Input:
6
7 1 5 3 6 4
Output:
5$q$,
  $q$def max_profit(prices: List[int]) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef max_profit(prices: List[int]) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    prices = [int(next(it)) for _ in range(int(next(it)))]\n    result = max_profit(prices)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction maxProfit(prices) {\n  // Write your solution here\n}\n\nconst prices = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst result = maxProfit(prices);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int maxProfit(int[] prices) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int[] prices = new int[scanner.nextInt()];\n        for (int i = 0; i < prices.length; i++) prices[i] = scanner.nextInt();\n        int result = maxProfit(prices);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint maxProfit(vector<int> prices) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int pricesN;\n    cin >> pricesN;\n    vector<int> prices(pricesN);\n    for (int& x : prices) cin >> x;\n    auto result = maxProfit(prices);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"6\n7 1 5 3 6 4","expected":"5"},{"input":"5\n7 6 4 3 1","expected":"0"},{"input":"1\n5","expected":"0"},{"input":"5\n21 29 0 24 7","expected":"24"},{"input":"9\n12 24 28 11 13 25 9 28 10","expected":"19"},{"input":"6\n28 21 7 16 5 19","expected":"14"}]$j$::jsonb,
  $q$1 <= n <= 10^5; 0 <= prices[i] <= 10^4$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','TCS','Accenture']::text[], ARRAY['greedy']::text[]);

-- 03 | easy | Move Zeroes
SELECT pg_temp.seed_coding($q$Arrays$q$, 'easy', $q$Move Zeroes$q$, $q$Move all 0s in the array to the end while keeping the relative order of the non-zero elements. Print the resulting array.

Input Format:
- nums: an integer n, then a line of n space-separated integers

Output Format:
Print the integers on one line, separated by single spaces.

Example:
Input:
5
0 1 0 3 12
Output:
1 3 12 0 0$q$,
  $q$def move_zeroes(nums: List[int]) -> List[int]$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef move_zeroes(nums: List[int]) -> List[int]:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    nums = [int(next(it)) for _ in range(int(next(it)))]\n    result = move_zeroes(nums)\n    print(' '.join(map(str, result)))\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction moveZeroes(nums) {\n  // Write your solution here\n}\n\nconst nums = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst result = moveZeroes(nums);\nconsole.log(result.join(' '));\n","java":"import java.util.*;\n\npublic class Main {\n    static int[] moveZeroes(int[] nums) {\n        // Write your solution here\n        return new int[0];\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int[] nums = new int[scanner.nextInt()];\n        for (int i = 0; i < nums.length; i++) nums[i] = scanner.nextInt();\n        int[] result = moveZeroes(nums);\n        StringBuilder sb = new StringBuilder();\n        for (int i = 0; i < result.length; i++) {\n            if (i > 0) sb.append(' ');\n            sb.append(result[i]);\n        }\n        System.out.println(sb);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nvector<int> moveZeroes(vector<int> nums) {\n    // Write your solution here\n    return {};\n}\n\nint main() {\n    int numsN;\n    cin >> numsN;\n    vector<int> nums(numsN);\n    for (int& x : nums) cin >> x;\n    auto result = moveZeroes(nums);\n    for (size_t i = 0; i < result.size(); i++) {\n        if (i) cout << ' ';\n        cout << result[i];\n    }\n    cout << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"5\n0 1 0 3 12","expected":"1 3 12 0 0"},{"input":"3\n0 0 1","expected":"1 0 0"},{"input":"3\n4 5 6","expected":"4 5 6"},{"input":"6\n2 1 3 1 1 -2","expected":"2 1 3 1 1 -2"},{"input":"7\n-2 0 -1 -1 -2 -2 -1","expected":"-2 -1 -1 -2 -2 -1 0"},{"input":"8\n2 2 2 3 -1 1 0 0","expected":"2 2 2 3 -1 1 0 0"}]$j$::jsonb,
  $q$1 <= n <= 10^4$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Wipro','Infosys']::text[], ARRAY['two-pointers']::text[]);

-- 04 | easy | Missing Number
SELECT pg_temp.seed_coding($q$Arrays$q$, 'easy', $q$Missing Number$q$, $q$The array contains n distinct numbers taken from the range 0..n, so exactly one number in that range is missing. Print the missing number.

Input Format:
- nums: an integer n, then a line of n space-separated integers

Output Format:
Print a single integer.

Example:
Input:
3
3 0 1
Output:
2$q$,
  $q$def missing_number(nums: List[int]) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef missing_number(nums: List[int]) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    nums = [int(next(it)) for _ in range(int(next(it)))]\n    result = missing_number(nums)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction missingNumber(nums) {\n  // Write your solution here\n}\n\nconst nums = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst result = missingNumber(nums);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int missingNumber(int[] nums) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int[] nums = new int[scanner.nextInt()];\n        for (int i = 0; i < nums.length; i++) nums[i] = scanner.nextInt();\n        int result = missingNumber(nums);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint missingNumber(vector<int> nums) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int numsN;\n    cin >> numsN;\n    vector<int> nums(numsN);\n    for (int& x : nums) cin >> x;\n    auto result = missingNumber(nums);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"3\n3 0 1","expected":"2"},{"input":"2\n0 1","expected":"2"},{"input":"9\n9 6 4 2 3 5 7 0 1","expected":"8"},{"input":"3\n2 1 0","expected":"3"},{"input":"7\n2 3 6 7 5 1 0","expected":"4"},{"input":"8\n2 6 8 5 3 4 1 7","expected":"0"}]$j$::jsonb,
  $q$1 <= n <= 10^4; values are distinct$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Infosys','Wipro']::text[], ARRAY['math','xor']::text[]);

-- 05 | easy | Majority Element
SELECT pg_temp.seed_coding($q$Arrays$q$, 'easy', $q$Majority Element$q$, $q$A majority element appears MORE than n/2 times in the array. One is guaranteed to exist. Print it.

Input Format:
- nums: an integer n, then a line of n space-separated integers

Output Format:
Print a single integer.

Example:
Input:
3
3 2 3
Output:
3$q$,
  $q$def majority_element(nums: List[int]) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef majority_element(nums: List[int]) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    nums = [int(next(it)) for _ in range(int(next(it)))]\n    result = majority_element(nums)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction majorityElement(nums) {\n  // Write your solution here\n}\n\nconst nums = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst result = majorityElement(nums);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int majorityElement(int[] nums) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int[] nums = new int[scanner.nextInt()];\n        for (int i = 0; i < nums.length; i++) nums[i] = scanner.nextInt();\n        int result = majorityElement(nums);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint majorityElement(vector<int> nums) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int numsN;\n    cin >> numsN;\n    vector<int> nums(numsN);\n    for (int& x : nums) cin >> x;\n    auto result = majorityElement(nums);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"3\n3 2 3","expected":"3"},{"input":"7\n2 2 1 1 1 2 2","expected":"2"},{"input":"1\n7","expected":"7"},{"input":"10\n3 -3 -5 -3 -3 5 -3 -3 -1 -3","expected":"-3"},{"input":"9\n4 3 -5 3 3 3 3 -1 2","expected":"3"},{"input":"6\n1 -4 -4 -4 -4 -4","expected":"-4"}]$j$::jsonb,
  $q$1 <= n <= 5 * 10^4; a majority element always exists$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','TCS','Accenture']::text[], ARRAY['boyer-moore','hashing']::text[]);

-- 06 | easy | Sort Colors
SELECT pg_temp.seed_coding($q$Arrays$q$, 'easy', $q$Sort Colors$q$, $q$The array contains only 0, 1 and 2 (red, white, blue). Sort it so equal colours are adjacent in the order 0, 1, 2, ideally in a single pass without a library sort. Print the sorted array.

Input Format:
- nums: an integer n, then a line of n space-separated integers

Output Format:
Print the integers on one line, separated by single spaces.

Example:
Input:
6
2 0 2 1 1 0
Output:
0 0 1 1 2 2$q$,
  $q$def sort_colors(nums: List[int]) -> List[int]$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef sort_colors(nums: List[int]) -> List[int]:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    nums = [int(next(it)) for _ in range(int(next(it)))]\n    result = sort_colors(nums)\n    print(' '.join(map(str, result)))\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction sortColors(nums) {\n  // Write your solution here\n}\n\nconst nums = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst result = sortColors(nums);\nconsole.log(result.join(' '));\n","java":"import java.util.*;\n\npublic class Main {\n    static int[] sortColors(int[] nums) {\n        // Write your solution here\n        return new int[0];\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int[] nums = new int[scanner.nextInt()];\n        for (int i = 0; i < nums.length; i++) nums[i] = scanner.nextInt();\n        int[] result = sortColors(nums);\n        StringBuilder sb = new StringBuilder();\n        for (int i = 0; i < result.length; i++) {\n            if (i > 0) sb.append(' ');\n            sb.append(result[i]);\n        }\n        System.out.println(sb);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nvector<int> sortColors(vector<int> nums) {\n    // Write your solution here\n    return {};\n}\n\nint main() {\n    int numsN;\n    cin >> numsN;\n    vector<int> nums(numsN);\n    for (int& x : nums) cin >> x;\n    auto result = sortColors(nums);\n    for (size_t i = 0; i < result.size(); i++) {\n        if (i) cout << ' ';\n        cout << result[i];\n    }\n    cout << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"6\n2 0 2 1 1 0","expected":"0 0 1 1 2 2"},{"input":"3\n2 0 1","expected":"0 1 2"},{"input":"3\n1 1 1","expected":"1 1 1"},{"input":"11\n0 1 2 1 2 2 1 1 0 0 1","expected":"0 0 0 1 1 1 1 1 2 2 2"},{"input":"12\n1 0 2 2 0 0 2 2 1 2 1 2","expected":"0 0 0 1 1 1 2 2 2 2 2 2"},{"input":"11\n2 1 2 1 2 2 0 2 2 1 0","expected":"0 0 1 1 1 2 2 2 2 2 2"}]$j$::jsonb,
  $q$1 <= n <= 300; nums[i] in {0, 1, 2}$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Infosys','Wipro']::text[], ARRAY['two-pointers','dutch-flag']::text[]);

-- 07 | easy | Maximum Sum of Subarray of Size K
SELECT pg_temp.seed_coding($q$Arrays$q$, 'easy', $q$Maximum Sum of Subarray of Size K$q$, $q$Given an array and an integer k, print the maximum sum of any contiguous subarray of exactly k elements.

Input Format:
- nums: an integer n, then a line of n space-separated integers
- k: a single integer

Output Format:
Print a single integer.

Example:
Input:
6
2 1 5 1 3 2
3
Output:
9$q$,
  $q$def max_sum_k(nums: List[int], k: int) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef max_sum_k(nums: List[int], k: int) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    nums = [int(next(it)) for _ in range(int(next(it)))]\n    k = int(next(it))\n    result = max_sum_k(nums, k)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction maxSumK(nums, k) {\n  // Write your solution here\n}\n\nconst nums = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst k = parseInt(next());\nconst result = maxSumK(nums, k);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int maxSumK(int[] nums, int k) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int[] nums = new int[scanner.nextInt()];\n        for (int i = 0; i < nums.length; i++) nums[i] = scanner.nextInt();\n        int k = scanner.nextInt();\n        int result = maxSumK(nums, k);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint maxSumK(vector<int> nums, int k) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int numsN;\n    cin >> numsN;\n    vector<int> nums(numsN);\n    for (int& x : nums) cin >> x;\n    int k;\n    cin >> k;\n    auto result = maxSumK(nums, k);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"6\n2 1 5 1 3 2\n3","expected":"9"},{"input":"4\n-1 -2 -3 -4\n2","expected":"-3"},{"input":"1\n4\n1","expected":"4"},{"input":"9\n-6 -7 -2 0 5 1 3 5 -2\n3","expected":"9"},{"input":"12\n-1 -1 6 0 -5 -8 1 3 5 1 8 0\n3","expected":"14"},{"input":"6\n5 -2 1 0 -3 -4\n3","expected":"4"}]$j$::jsonb,
  $q$1 <= k <= n <= 10^5$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Infosys','Accenture']::text[], ARRAY['sliding-window']::text[]);

-- 08 | medium | Maximum Subarray
SELECT pg_temp.seed_coding($q$Arrays$q$, 'medium', $q$Maximum Subarray$q$, $q$Find the contiguous, non-empty subarray with the largest sum and print that sum.

Input Format:
- nums: an integer n, then a line of n space-separated integers

Output Format:
Print a single integer.

Example:
Input:
9
-2 1 -3 4 -1 2 1 -5 4
Output:
6$q$,
  $q$def max_subarray(nums: List[int]) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef max_subarray(nums: List[int]) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    nums = [int(next(it)) for _ in range(int(next(it)))]\n    result = max_subarray(nums)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction maxSubarray(nums) {\n  // Write your solution here\n}\n\nconst nums = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst result = maxSubarray(nums);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int maxSubarray(int[] nums) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int[] nums = new int[scanner.nextInt()];\n        for (int i = 0; i < nums.length; i++) nums[i] = scanner.nextInt();\n        int result = maxSubarray(nums);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint maxSubarray(vector<int> nums) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int numsN;\n    cin >> numsN;\n    vector<int> nums(numsN);\n    for (int& x : nums) cin >> x;\n    auto result = maxSubarray(nums);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"9\n-2 1 -3 4 -1 2 1 -5 4","expected":"6"},{"input":"1\n1","expected":"1"},{"input":"3\n-3 -1 -2","expected":"-1"},{"input":"7\n9 -9 -4 -9 -5 0 -1","expected":"9"},{"input":"11\n-2 -9 10 10 -3 -7 -3 5 2 -9 -4","expected":"20"},{"input":"5\n-4 -2 -10 10 -2","expected":"10"}]$j$::jsonb,
  $q$1 <= n <= 10^5$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','TCS','Accenture']::text[], ARRAY['kadane','dp']::text[]);

-- 09 | medium | Rotate Array
SELECT pg_temp.seed_coding($q$Arrays$q$, 'medium', $q$Rotate Array$q$, $q$Rotate the array to the right by k steps (k may be larger than n). Print the rotated array.

Input Format:
- nums: an integer n, then a line of n space-separated integers
- k: a single integer

Output Format:
Print the integers on one line, separated by single spaces.

Example:
Input:
7
1 2 3 4 5 6 7
3
Output:
5 6 7 1 2 3 4$q$,
  $q$def rotate_array(nums: List[int], k: int) -> List[int]$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef rotate_array(nums: List[int], k: int) -> List[int]:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    nums = [int(next(it)) for _ in range(int(next(it)))]\n    k = int(next(it))\n    result = rotate_array(nums, k)\n    print(' '.join(map(str, result)))\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction rotateArray(nums, k) {\n  // Write your solution here\n}\n\nconst nums = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst k = parseInt(next());\nconst result = rotateArray(nums, k);\nconsole.log(result.join(' '));\n","java":"import java.util.*;\n\npublic class Main {\n    static int[] rotateArray(int[] nums, int k) {\n        // Write your solution here\n        return new int[0];\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int[] nums = new int[scanner.nextInt()];\n        for (int i = 0; i < nums.length; i++) nums[i] = scanner.nextInt();\n        int k = scanner.nextInt();\n        int[] result = rotateArray(nums, k);\n        StringBuilder sb = new StringBuilder();\n        for (int i = 0; i < result.length; i++) {\n            if (i > 0) sb.append(' ');\n            sb.append(result[i]);\n        }\n        System.out.println(sb);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nvector<int> rotateArray(vector<int> nums, int k) {\n    // Write your solution here\n    return {};\n}\n\nint main() {\n    int numsN;\n    cin >> numsN;\n    vector<int> nums(numsN);\n    for (int& x : nums) cin >> x;\n    int k;\n    cin >> k;\n    auto result = rotateArray(nums, k);\n    for (size_t i = 0; i < result.size(); i++) {\n        if (i) cout << ' ';\n        cout << result[i];\n    }\n    cout << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"7\n1 2 3 4 5 6 7\n3","expected":"5 6 7 1 2 3 4"},{"input":"4\n-1 -100 3 99\n2","expected":"3 99 -1 -100"},{"input":"2\n1 2\n5","expected":"2 1"},{"input":"9\n0 1 0 1 -7 1 -5 6 4\n3","expected":"-5 6 4 0 1 0 1 -7 1"},{"input":"8\n9 -8 -2 1 -3 -5 -1 9\n0","expected":"9 -8 -2 1 -3 -5 -1 9"},{"input":"8\n-6 -5 9 -4 3 4 9 -6\n7","expected":"-5 9 -4 3 4 9 -6 -6"}]$j$::jsonb,
  $q$1 <= n <= 10^5; 0 <= k <= 10^9$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Wipro','Infosys']::text[], ARRAY['reversal']::text[]);

-- 10 | medium | Product of Array Except Self
SELECT pg_temp.seed_coding($q$Arrays$q$, 'medium', $q$Product of Array Except Self$q$, $q$Print an array where element i is the product of every element of nums except nums[i]. Do it without using division. All products fit in a 32-bit integer.

Input Format:
- nums: an integer n, then a line of n space-separated integers

Output Format:
Print the integers on one line, separated by single spaces.

Example:
Input:
4
1 2 3 4
Output:
24 12 8 6$q$,
  $q$def product_except_self(nums: List[int]) -> List[int]$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef product_except_self(nums: List[int]) -> List[int]:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    nums = [int(next(it)) for _ in range(int(next(it)))]\n    result = product_except_self(nums)\n    print(' '.join(map(str, result)))\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction productExceptSelf(nums) {\n  // Write your solution here\n}\n\nconst nums = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst result = productExceptSelf(nums);\nconsole.log(result.join(' '));\n","java":"import java.util.*;\n\npublic class Main {\n    static int[] productExceptSelf(int[] nums) {\n        // Write your solution here\n        return new int[0];\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int[] nums = new int[scanner.nextInt()];\n        for (int i = 0; i < nums.length; i++) nums[i] = scanner.nextInt();\n        int[] result = productExceptSelf(nums);\n        StringBuilder sb = new StringBuilder();\n        for (int i = 0; i < result.length; i++) {\n            if (i > 0) sb.append(' ');\n            sb.append(result[i]);\n        }\n        System.out.println(sb);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nvector<int> productExceptSelf(vector<int> nums) {\n    // Write your solution here\n    return {};\n}\n\nint main() {\n    int numsN;\n    cin >> numsN;\n    vector<int> nums(numsN);\n    for (int& x : nums) cin >> x;\n    auto result = productExceptSelf(nums);\n    for (size_t i = 0; i < result.size(); i++) {\n        if (i) cout << ' ';\n        cout << result[i];\n    }\n    cout << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"4\n1 2 3 4","expected":"24 12 8 6"},{"input":"5\n-1 1 0 -3 3","expected":"0 0 9 0 0"},{"input":"2\n2 5","expected":"5 2"},{"input":"7\n0 4 -2 2 3 -1 0","expected":"0 0 0 0 0 0 0"},{"input":"6\n0 4 0 -4 4 -3","expected":"0 0 0 0 0 0"},{"input":"6\n-4 1 -3 -2 -1 4","expected":"-24 96 -32 -48 -96 24"}]$j$::jsonb,
  $q$2 <= n <= 10^5; products fit in a 32-bit integer$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Accenture']::text[], ARRAY['prefix-suffix']::text[]);

-- 11 | medium | Find the Duplicate Number
SELECT pg_temp.seed_coding($q$Arrays$q$, 'medium', $q$Find the Duplicate Number$q$, $q$The array holds n + 1 integers, each between 1 and n inclusive, and exactly one value is repeated (it may appear more than twice). Print the repeated value.

Input Format:
- nums: an integer n, then a line of n space-separated integers

Output Format:
Print a single integer.

Example:
Input:
5
1 3 4 2 2
Output:
2$q$,
  $q$def find_duplicate(nums: List[int]) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef find_duplicate(nums: List[int]) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    nums = [int(next(it)) for _ in range(int(next(it)))]\n    result = find_duplicate(nums)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction findDuplicate(nums) {\n  // Write your solution here\n}\n\nconst nums = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst result = findDuplicate(nums);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int findDuplicate(int[] nums) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int[] nums = new int[scanner.nextInt()];\n        for (int i = 0; i < nums.length; i++) nums[i] = scanner.nextInt();\n        int result = findDuplicate(nums);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint findDuplicate(vector<int> nums) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int numsN;\n    cin >> numsN;\n    vector<int> nums(numsN);\n    for (int& x : nums) cin >> x;\n    auto result = findDuplicate(nums);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"5\n1 3 4 2 2","expected":"2"},{"input":"5\n3 1 3 4 2","expected":"3"},{"input":"5\n2 2 2 2 2","expected":"2"},{"input":"10\n3 8 7 8 2 4 5 6 9 1","expected":"8"},{"input":"4\n3 2 2 1","expected":"2"},{"input":"11\n9 7 1 4 3 5 2 6 8 2 10","expected":"2"}]$j$::jsonb,
  $q$1 <= n <= 10^5; nums.length = n + 1$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Infosys']::text[], ARRAY['floyd-cycle','hashing']::text[]);

-- 12 | medium | Merge Intervals
SELECT pg_temp.seed_coding($q$Arrays$q$, 'medium', $q$Merge Intervals$q$, $q$Given a list of intervals [start, end], merge all overlapping intervals (intervals that touch, such as [1,4] and [4,5], also merge). Print the merged intervals sorted by start, one per line.

Input Format:
- intervals: two integers r and c, then r lines of c space-separated integers

Output Format:
Print each row on its own line, values separated by single spaces.

Example:
Input:
4 2
1 3
2 6
8 10
15 18
Output:
1 6
8 10
15 18$q$,
  $q$def merge_intervals(intervals: List[List[int]]) -> List[List[int]]$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef merge_intervals(intervals: List[List[int]]) -> List[List[int]]:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    rows, cols = int(next(it)), int(next(it))\n    intervals = [[int(next(it)) for _ in range(cols)] for _ in range(rows)]\n    result = merge_intervals(intervals)\n    print('\\n'.join(' '.join(map(str, row)) for row in result))\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction mergeIntervals(intervals) {\n  // Write your solution here\n}\n\nconst intervalsRows = parseInt(next());\nconst intervalsCols = parseInt(next());\nconst intervals = Array.from({ length: intervalsRows }, () => Array.from({ length: intervalsCols }, () => parseInt(next())));\nconst result = mergeIntervals(intervals);\nconsole.log(result.map((row) => row.join(' ')).join('\\n'));\n","java":"import java.util.*;\n\npublic class Main {\n    static int[][] mergeIntervals(int[][] intervals) {\n        // Write your solution here\n        return new int[0][];\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int intervalsRows = scanner.nextInt(), intervalsCols = scanner.nextInt();\n        int[][] intervals = new int[intervalsRows][intervalsCols];\n        for (int i = 0; i < intervalsRows; i++)\n            for (int j = 0; j < intervalsCols; j++) intervals[i][j] = scanner.nextInt();\n        int[][] result = mergeIntervals(intervals);\n        StringBuilder sb = new StringBuilder();\n        for (int[] row : result) {\n            for (int j = 0; j < row.length; j++) {\n                if (j > 0) sb.append(' ');\n                sb.append(row[j]);\n            }\n            sb.append('\\n');\n        }\n        System.out.print(sb);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nvector<vector<int>> mergeIntervals(vector<vector<int>> intervals) {\n    // Write your solution here\n    return {};\n}\n\nint main() {\n    int intervalsRows, intervalsCols;\n    cin >> intervalsRows >> intervalsCols;\n    vector<vector<int>> intervals(intervalsRows, vector<int>(intervalsCols));\n    for (auto& row : intervals) for (int& x : row) cin >> x;\n    auto result = mergeIntervals(intervals);\n    for (auto& row : result) {\n        for (size_t j = 0; j < row.size(); j++) {\n            if (j) cout << ' ';\n            cout << row[j];\n        }\n        cout << '\\n';\n    }\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"4 2\n1 3\n2 6\n8 10\n15 18","expected":"1 6\n8 10\n15 18"},{"input":"2 2\n1 4\n4 5","expected":"1 5"},{"input":"2 2\n5 7\n1 2","expected":"1 2\n5 7"},{"input":"6 2\n13 18\n5 10\n14 15\n11 12\n6 8\n2 6","expected":"2 10\n11 12\n13 18"},{"input":"6 2\n0 1\n19 24\n17 22\n13 15\n4 5\n8 10","expected":"0 1\n4 5\n8 10\n13 15\n17 24"},{"input":"4 2\n8 12\n16 17\n15 17\n10 12","expected":"8 12\n15 17"}]$j$::jsonb,
  $q$1 <= n <= 10^4; 0 <= start <= end <= 10^4$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Accenture']::text[], ARRAY['sorting','intervals']::text[]);

-- 13 | medium | Container With Most Water
SELECT pg_temp.seed_coding($q$Arrays$q$, 'medium', $q$Container With Most Water$q$, $q$height[i] is the height of a vertical line at x = i. Choose two lines that, together with the x-axis, hold the most water. Print the maximum area (width x the shorter height).

Input Format:
- height: an integer n, then a line of n space-separated integers

Output Format:
Print a single integer.

Example:
Input:
9
1 8 6 2 5 4 8 3 7
Output:
49$q$,
  $q$def max_area(height: List[int]) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef max_area(height: List[int]) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    height = [int(next(it)) for _ in range(int(next(it)))]\n    result = max_area(height)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction maxArea(height) {\n  // Write your solution here\n}\n\nconst height = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst result = maxArea(height);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int maxArea(int[] height) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int[] height = new int[scanner.nextInt()];\n        for (int i = 0; i < height.length; i++) height[i] = scanner.nextInt();\n        int result = maxArea(height);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint maxArea(vector<int> height) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int heightN;\n    cin >> heightN;\n    vector<int> height(heightN);\n    for (int& x : height) cin >> x;\n    auto result = maxArea(height);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"9\n1 8 6 2 5 4 8 3 7","expected":"49"},{"input":"2\n1 1","expected":"1"},{"input":"5\n4 3 2 1 4","expected":"16"},{"input":"8\n9 0 5 5 11 1 3 12","expected":"63"},{"input":"8\n7 6 8 9 1 4 1 11","expected":"49"},{"input":"4\n3 12 3 3","expected":"9"}]$j$::jsonb,
  $q$2 <= n <= 10^5; 0 <= height[i] <= 10^4$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Accenture']::text[], ARRAY['two-pointers','greedy']::text[]);

-- 14 | medium | 3Sum
SELECT pg_temp.seed_coding($q$Arrays$q$, 'medium', $q$3Sum$q$, $q$Find all UNIQUE triplets (a, b, c) of values in the array with a + b + c = 0. Each triplet is printed in non-decreasing order on its own line, and the lines are sorted lexicographically. At least one triplet exists in every test.

Input Format:
- nums: an integer n, then a line of n space-separated integers

Output Format:
Print each row on its own line, values separated by single spaces.

Example:
Input:
6
-1 0 1 2 -1 -4
Output:
-1 -1 2
-1 0 1$q$,
  $q$def three_sum(nums: List[int]) -> List[List[int]]$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef three_sum(nums: List[int]) -> List[List[int]]:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    nums = [int(next(it)) for _ in range(int(next(it)))]\n    result = three_sum(nums)\n    print('\\n'.join(' '.join(map(str, row)) for row in result))\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction threeSum(nums) {\n  // Write your solution here\n}\n\nconst nums = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst result = threeSum(nums);\nconsole.log(result.map((row) => row.join(' ')).join('\\n'));\n","java":"import java.util.*;\n\npublic class Main {\n    static int[][] threeSum(int[] nums) {\n        // Write your solution here\n        return new int[0][];\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int[] nums = new int[scanner.nextInt()];\n        for (int i = 0; i < nums.length; i++) nums[i] = scanner.nextInt();\n        int[][] result = threeSum(nums);\n        StringBuilder sb = new StringBuilder();\n        for (int[] row : result) {\n            for (int j = 0; j < row.length; j++) {\n                if (j > 0) sb.append(' ');\n                sb.append(row[j]);\n            }\n            sb.append('\\n');\n        }\n        System.out.print(sb);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nvector<vector<int>> threeSum(vector<int> nums) {\n    // Write your solution here\n    return {};\n}\n\nint main() {\n    int numsN;\n    cin >> numsN;\n    vector<int> nums(numsN);\n    for (int& x : nums) cin >> x;\n    auto result = threeSum(nums);\n    for (auto& row : result) {\n        for (size_t j = 0; j < row.size(); j++) {\n            if (j) cout << ' ';\n            cout << row[j];\n        }\n        cout << '\\n';\n    }\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"6\n-1 0 1 2 -1 -4","expected":"-1 -1 2\n-1 0 1"},{"input":"4\n0 0 0 0","expected":"0 0 0"},{"input":"5\n-2 0 1 1 2","expected":"-2 0 2\n-2 1 1"},{"input":"7\n1 5 -2 -1 -1 6 -3","expected":"-3 -2 5"},{"input":"9\n-3 5 -6 1 -4 -3 3 2 -4","expected":"-6 1 5\n-4 1 3\n-3 1 2"},{"input":"8\n1 -2 -4 2 -2 4 4 4","expected":"-2 -2 4"}]$j$::jsonb,
  $q$3 <= n <= 3000$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Accenture']::text[], ARRAY['two-pointers','sorting']::text[]);

-- 15 | medium | Subarray Sum Equals K
SELECT pg_temp.seed_coding($q$Arrays$q$, 'medium', $q$Subarray Sum Equals K$q$, $q$Count the contiguous subarrays whose elements sum to k. The array may contain negative numbers.

Input Format:
- nums: an integer n, then a line of n space-separated integers
- k: a single integer

Output Format:
Print a single integer.

Example:
Input:
3
1 1 1
2
Output:
2$q$,
  $q$def subarray_sum(nums: List[int], k: int) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef subarray_sum(nums: List[int], k: int) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    nums = [int(next(it)) for _ in range(int(next(it)))]\n    k = int(next(it))\n    result = subarray_sum(nums, k)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction subarraySum(nums, k) {\n  // Write your solution here\n}\n\nconst nums = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst k = parseInt(next());\nconst result = subarraySum(nums, k);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int subarraySum(int[] nums, int k) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int[] nums = new int[scanner.nextInt()];\n        for (int i = 0; i < nums.length; i++) nums[i] = scanner.nextInt();\n        int k = scanner.nextInt();\n        int result = subarraySum(nums, k);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint subarraySum(vector<int> nums, int k) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int numsN;\n    cin >> numsN;\n    vector<int> nums(numsN);\n    for (int& x : nums) cin >> x;\n    int k;\n    cin >> k;\n    auto result = subarraySum(nums, k);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"3\n1 1 1\n2","expected":"2"},{"input":"3\n1 2 3\n3","expected":"2"},{"input":"3\n1 -1 0\n0","expected":"3"},{"input":"6\n-2 2 0 -3 1 -1\n5","expected":"0"},{"input":"7\n4 -1 -1 3 2 -1 2\n3","expected":"5"},{"input":"12\n3 3 3 -1 -2 1 -1 -3 -1 -3 2 2\n1","expected":"4"}]$j$::jsonb,
  $q$1 <= n <= 2 * 10^4$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Infosys']::text[], ARRAY['prefix-sum','hashing']::text[]);

-- 16 | medium | Longest Consecutive Sequence
SELECT pg_temp.seed_coding($q$Arrays$q$, 'medium', $q$Longest Consecutive Sequence$q$, $q$Print the length of the longest sequence of consecutive integers (such as 3, 4, 5, 6) that can be formed from the array elements, in any order. Aim for O(n) time.

Input Format:
- nums: an integer n, then a line of n space-separated integers

Output Format:
Print a single integer.

Example:
Input:
6
100 4 200 1 3 2
Output:
4$q$,
  $q$def longest_consecutive(nums: List[int]) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef longest_consecutive(nums: List[int]) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    nums = [int(next(it)) for _ in range(int(next(it)))]\n    result = longest_consecutive(nums)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction longestConsecutive(nums) {\n  // Write your solution here\n}\n\nconst nums = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst result = longestConsecutive(nums);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int longestConsecutive(int[] nums) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int[] nums = new int[scanner.nextInt()];\n        for (int i = 0; i < nums.length; i++) nums[i] = scanner.nextInt();\n        int result = longestConsecutive(nums);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint longestConsecutive(vector<int> nums) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int numsN;\n    cin >> numsN;\n    vector<int> nums(numsN);\n    for (int& x : nums) cin >> x;\n    auto result = longestConsecutive(nums);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"6\n100 4 200 1 3 2","expected":"4"},{"input":"10\n0 3 7 2 5 8 4 6 0 1","expected":"9"},{"input":"1\n9","expected":"1"},{"input":"12\n8 11 14 4 2 2 11 7 14 11 6 7","expected":"3"},{"input":"9\n15 13 10 13 12 2 6 14 15","expected":"4"},{"input":"8\n3 13 14 13 3 12 0 13","expected":"3"}]$j$::jsonb,
  $q$1 <= n <= 10^5$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Accenture']::text[], ARRAY['hashing']::text[]);

-- 17 | medium | Spiral Matrix
SELECT pg_temp.seed_coding($q$Arrays$q$, 'medium', $q$Spiral Matrix$q$, $q$Print all elements of an m x n matrix in clockwise spiral order, starting from the top-left cell.

Input Format:
- matrix: two integers r and c, then r lines of c space-separated integers

Output Format:
Print the integers on one line, separated by single spaces.

Example:
Input:
3 3
1 2 3
4 5 6
7 8 9
Output:
1 2 3 6 9 8 7 4 5$q$,
  $q$def spiral_order(matrix: List[List[int]]) -> List[int]$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef spiral_order(matrix: List[List[int]]) -> List[int]:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    rows, cols = int(next(it)), int(next(it))\n    matrix = [[int(next(it)) for _ in range(cols)] for _ in range(rows)]\n    result = spiral_order(matrix)\n    print(' '.join(map(str, result)))\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction spiralOrder(matrix) {\n  // Write your solution here\n}\n\nconst matrixRows = parseInt(next());\nconst matrixCols = parseInt(next());\nconst matrix = Array.from({ length: matrixRows }, () => Array.from({ length: matrixCols }, () => parseInt(next())));\nconst result = spiralOrder(matrix);\nconsole.log(result.join(' '));\n","java":"import java.util.*;\n\npublic class Main {\n    static int[] spiralOrder(int[][] matrix) {\n        // Write your solution here\n        return new int[0];\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int matrixRows = scanner.nextInt(), matrixCols = scanner.nextInt();\n        int[][] matrix = new int[matrixRows][matrixCols];\n        for (int i = 0; i < matrixRows; i++)\n            for (int j = 0; j < matrixCols; j++) matrix[i][j] = scanner.nextInt();\n        int[] result = spiralOrder(matrix);\n        StringBuilder sb = new StringBuilder();\n        for (int i = 0; i < result.length; i++) {\n            if (i > 0) sb.append(' ');\n            sb.append(result[i]);\n        }\n        System.out.println(sb);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nvector<int> spiralOrder(vector<vector<int>> matrix) {\n    // Write your solution here\n    return {};\n}\n\nint main() {\n    int matrixRows, matrixCols;\n    cin >> matrixRows >> matrixCols;\n    vector<vector<int>> matrix(matrixRows, vector<int>(matrixCols));\n    for (auto& row : matrix) for (int& x : row) cin >> x;\n    auto result = spiralOrder(matrix);\n    for (size_t i = 0; i < result.size(); i++) {\n        if (i) cout << ' ';\n        cout << result[i];\n    }\n    cout << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"3 3\n1 2 3\n4 5 6\n7 8 9","expected":"1 2 3 6 9 8 7 4 5"},{"input":"3 4\n1 2 3 4\n5 6 7 8\n9 10 11 12","expected":"1 2 3 4 8 12 11 10 9 5 6 7"},{"input":"3 1\n7\n9\n6","expected":"7 9 6"},{"input":"4 5\n9 6 7 1 2\n2 5 5 1 6\n1 3 9 3 2\n4 1 1 2 3","expected":"9 6 7 1 2 6 2 3 2 1 1 4 1 2 5 5 1 3 9 3"},{"input":"5 3\n4 4 7\n6 9 8\n5 7 8\n7 7 3\n8 1 5","expected":"4 4 7 8 8 3 5 1 8 7 5 6 9 7 7"},{"input":"3 4\n5 7 3 3\n1 6 2 4\n8 2 1 3","expected":"5 7 3 3 4 3 1 2 8 1 6 2"}]$j$::jsonb,
  $q$1 <= m, n <= 10$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','TCS','Accenture']::text[], ARRAY['matrix','simulation']::text[]);

-- 18 | medium | Rotate Image
SELECT pg_temp.seed_coding($q$Arrays$q$, 'medium', $q$Rotate Image$q$, $q$Rotate an n x n matrix by 90 degrees clockwise and print the result, one row per line.

Input Format:
- matrix: two integers r and c, then r lines of c space-separated integers

Output Format:
Print each row on its own line, values separated by single spaces.

Example:
Input:
3 3
1 2 3
4 5 6
7 8 9
Output:
7 4 1
8 5 2
9 6 3$q$,
  $q$def rotate_image(matrix: List[List[int]]) -> List[List[int]]$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef rotate_image(matrix: List[List[int]]) -> List[List[int]]:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    rows, cols = int(next(it)), int(next(it))\n    matrix = [[int(next(it)) for _ in range(cols)] for _ in range(rows)]\n    result = rotate_image(matrix)\n    print('\\n'.join(' '.join(map(str, row)) for row in result))\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction rotateImage(matrix) {\n  // Write your solution here\n}\n\nconst matrixRows = parseInt(next());\nconst matrixCols = parseInt(next());\nconst matrix = Array.from({ length: matrixRows }, () => Array.from({ length: matrixCols }, () => parseInt(next())));\nconst result = rotateImage(matrix);\nconsole.log(result.map((row) => row.join(' ')).join('\\n'));\n","java":"import java.util.*;\n\npublic class Main {\n    static int[][] rotateImage(int[][] matrix) {\n        // Write your solution here\n        return new int[0][];\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int matrixRows = scanner.nextInt(), matrixCols = scanner.nextInt();\n        int[][] matrix = new int[matrixRows][matrixCols];\n        for (int i = 0; i < matrixRows; i++)\n            for (int j = 0; j < matrixCols; j++) matrix[i][j] = scanner.nextInt();\n        int[][] result = rotateImage(matrix);\n        StringBuilder sb = new StringBuilder();\n        for (int[] row : result) {\n            for (int j = 0; j < row.length; j++) {\n                if (j > 0) sb.append(' ');\n                sb.append(row[j]);\n            }\n            sb.append('\\n');\n        }\n        System.out.print(sb);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nvector<vector<int>> rotateImage(vector<vector<int>> matrix) {\n    // Write your solution here\n    return {};\n}\n\nint main() {\n    int matrixRows, matrixCols;\n    cin >> matrixRows >> matrixCols;\n    vector<vector<int>> matrix(matrixRows, vector<int>(matrixCols));\n    for (auto& row : matrix) for (int& x : row) cin >> x;\n    auto result = rotateImage(matrix);\n    for (auto& row : result) {\n        for (size_t j = 0; j < row.size(); j++) {\n            if (j) cout << ' ';\n            cout << row[j];\n        }\n        cout << '\\n';\n    }\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"3 3\n1 2 3\n4 5 6\n7 8 9","expected":"7 4 1\n8 5 2\n9 6 3"},{"input":"4 4\n5 1 9 11\n2 4 8 10\n13 3 6 7\n15 14 12 16","expected":"15 13 2 5\n14 3 4 1\n12 6 8 9\n16 7 10 11"},{"input":"1 1\n1","expected":"1"},{"input":"5 5\n3 3 1 0 7\n1 8 1 5 7\n5 8 9 6 1\n7 0 5 0 9\n1 3 7 0 6","expected":"1 7 5 1 3\n3 0 8 8 3\n7 5 9 1 1\n0 0 6 5 0\n6 9 1 7 7"},{"input":"2 2\n8 8\n7 8","expected":"7 8\n8 8"},{"input":"3 3\n4 3 1\n3 7 0\n1 3 8","expected":"1 3 4\n3 7 3\n8 0 1"}]$j$::jsonb,
  $q$1 <= n <= 20$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Accenture']::text[], ARRAY['matrix']::text[]);

-- 19 | medium | Next Permutation
SELECT pg_temp.seed_coding($q$Arrays$q$, 'medium', $q$Next Permutation$q$, $q$Rearrange the numbers into the lexicographically next greater permutation. If no such permutation exists (the array is in descending order), rearrange it into the lowest possible order (ascending). Print the result.

Input Format:
- nums: an integer n, then a line of n space-separated integers

Output Format:
Print the integers on one line, separated by single spaces.

Example:
Input:
3
1 2 3
Output:
1 3 2$q$,
  $q$def next_permutation(nums: List[int]) -> List[int]$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef next_permutation(nums: List[int]) -> List[int]:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    nums = [int(next(it)) for _ in range(int(next(it)))]\n    result = next_permutation(nums)\n    print(' '.join(map(str, result)))\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction nextPermutation(nums) {\n  // Write your solution here\n}\n\nconst nums = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst result = nextPermutation(nums);\nconsole.log(result.join(' '));\n","java":"import java.util.*;\n\npublic class Main {\n    static int[] nextPermutation(int[] nums) {\n        // Write your solution here\n        return new int[0];\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int[] nums = new int[scanner.nextInt()];\n        for (int i = 0; i < nums.length; i++) nums[i] = scanner.nextInt();\n        int[] result = nextPermutation(nums);\n        StringBuilder sb = new StringBuilder();\n        for (int i = 0; i < result.length; i++) {\n            if (i > 0) sb.append(' ');\n            sb.append(result[i]);\n        }\n        System.out.println(sb);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nvector<int> nextPermutation(vector<int> nums) {\n    // Write your solution here\n    return {};\n}\n\nint main() {\n    int numsN;\n    cin >> numsN;\n    vector<int> nums(numsN);\n    for (int& x : nums) cin >> x;\n    auto result = nextPermutation(nums);\n    for (size_t i = 0; i < result.size(); i++) {\n        if (i) cout << ' ';\n        cout << result[i];\n    }\n    cout << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"3\n1 2 3","expected":"1 3 2"},{"input":"3\n3 2 1","expected":"1 2 3"},{"input":"3\n1 1 5","expected":"1 5 1"},{"input":"7\n2 1 5 1 0 2 2","expected":"2 1 5 1 2 0 2"},{"input":"5\n3 1 0 2 4","expected":"3 1 0 4 2"},{"input":"4\n2 1 0 2","expected":"2 1 2 0"}]$j$::jsonb,
  $q$1 <= n <= 100$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Accenture']::text[], ARRAY['permutation','two-pointers']::text[]);

-- 20 | medium | Maximum Product Subarray
SELECT pg_temp.seed_coding($q$Arrays$q$, 'medium', $q$Maximum Product Subarray$q$, $q$Find the contiguous, non-empty subarray with the largest PRODUCT and print that product. The result fits in a 32-bit integer.

Input Format:
- nums: an integer n, then a line of n space-separated integers

Output Format:
Print a single integer.

Example:
Input:
4
2 3 -2 4
Output:
6$q$,
  $q$def max_product(nums: List[int]) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef max_product(nums: List[int]) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    nums = [int(next(it)) for _ in range(int(next(it)))]\n    result = max_product(nums)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction maxProduct(nums) {\n  // Write your solution here\n}\n\nconst nums = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst result = maxProduct(nums);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int maxProduct(int[] nums) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int[] nums = new int[scanner.nextInt()];\n        for (int i = 0; i < nums.length; i++) nums[i] = scanner.nextInt();\n        int result = maxProduct(nums);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint maxProduct(vector<int> nums) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int numsN;\n    cin >> numsN;\n    vector<int> nums(numsN);\n    for (int& x : nums) cin >> x;\n    auto result = maxProduct(nums);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"4\n2 3 -2 4","expected":"6"},{"input":"3\n-2 0 -1","expected":"0"},{"input":"3\n-2 3 -4","expected":"24"},{"input":"8\n-1 -1 3 2 1 3 -1 1","expected":"18"},{"input":"7\n0 -2 -2 -1 2 -2 -3","expected":"24"},{"input":"8\n-2 -3 1 -3 -2 2 1 -2","expected":"72"}]$j$::jsonb,
  $q$1 <= n <= 2 * 10^4$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Accenture']::text[], ARRAY['dp']::text[]);

-- 21 | medium | Minimum Size Subarray Sum
SELECT pg_temp.seed_coding($q$Arrays$q$, 'medium', $q$Minimum Size Subarray Sum$q$, $q$Given an array of POSITIVE integers and a target, print the minimal length of a contiguous subarray whose sum is at least target. Print 0 if no such subarray exists.

Input Format:
- target: a single integer
- nums: an integer n, then a line of n space-separated integers

Output Format:
Print a single integer.

Example:
Input:
7
6
2 3 1 2 4 3
Output:
2$q$,
  $q$def min_subarray_len(target: int, nums: List[int]) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef min_subarray_len(target: int, nums: List[int]) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    target = int(next(it))\n    nums = [int(next(it)) for _ in range(int(next(it)))]\n    result = min_subarray_len(target, nums)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction minSubarrayLen(target, nums) {\n  // Write your solution here\n}\n\nconst target = parseInt(next());\nconst nums = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst result = minSubarrayLen(target, nums);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int minSubarrayLen(int target, int[] nums) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int target = scanner.nextInt();\n        int[] nums = new int[scanner.nextInt()];\n        for (int i = 0; i < nums.length; i++) nums[i] = scanner.nextInt();\n        int result = minSubarrayLen(target, nums);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint minSubarrayLen(int target, vector<int> nums) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int target;\n    cin >> target;\n    int numsN;\n    cin >> numsN;\n    vector<int> nums(numsN);\n    for (int& x : nums) cin >> x;\n    auto result = minSubarrayLen(target, nums);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"7\n6\n2 3 1 2 4 3","expected":"2"},{"input":"4\n3\n1 4 4","expected":"1"},{"input":"11\n5\n1 1 1 1 1","expected":"0"},{"input":"6\n5\n1 3 4 1 3","expected":"2"},{"input":"6\n7\n2 1 6 6 4 2 2","expected":"1"},{"input":"12\n9\n4 4 5 6 3 1 5 5 1","expected":"3"}]$j$::jsonb,
  $q$1 <= n <= 10^5; 1 <= nums[i] <= 10^4$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Infosys']::text[], ARRAY['sliding-window']::text[]);

-- 22 | hard | Trapping Rain Water
SELECT pg_temp.seed_coding($q$Arrays$q$, 'hard', $q$Trapping Rain Water$q$, $q$Each element is the height of a bar of width 1. After it rains, how many units of water are trapped between the bars? Print the total.

Input Format:
- height: an integer n, then a line of n space-separated integers

Output Format:
Print a single integer.

Example:
Input:
12
0 1 0 2 1 0 1 3 2 1 2 1
Output:
6$q$,
  $q$def trap_water(height: List[int]) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef trap_water(height: List[int]) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    height = [int(next(it)) for _ in range(int(next(it)))]\n    result = trap_water(height)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction trapWater(height) {\n  // Write your solution here\n}\n\nconst height = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst result = trapWater(height);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int trapWater(int[] height) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int[] height = new int[scanner.nextInt()];\n        for (int i = 0; i < height.length; i++) height[i] = scanner.nextInt();\n        int result = trapWater(height);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint trapWater(vector<int> height) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int heightN;\n    cin >> heightN;\n    vector<int> height(heightN);\n    for (int& x : height) cin >> x;\n    auto result = trapWater(height);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"12\n0 1 0 2 1 0 1 3 2 1 2 1","expected":"6"},{"input":"6\n4 2 0 3 2 5","expected":"9"},{"input":"3\n1 2 3","expected":"0"},{"input":"9\n4 4 1 6 3 2 5 6 4","expected":"11"},{"input":"9\n6 4 0 5 2 1 1 3 2","expected":"11"},{"input":"10\n4 6 2 3 6 5 4 4 2 5","expected":"12"}]$j$::jsonb,
  $q$1 <= n <= 2 * 10^4$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Accenture']::text[], ARRAY['two-pointers','stack']::text[]);

-- 23 | hard | First Missing Positive
SELECT pg_temp.seed_coding($q$Arrays$q$, 'hard', $q$First Missing Positive$q$, $q$Print the smallest positive integer (1, 2, 3, ...) that does not appear in the array. A solution using O(n) time and O(1) extra space is the goal.

Input Format:
- nums: an integer n, then a line of n space-separated integers

Output Format:
Print a single integer.

Example:
Input:
4
3 4 -1 1
Output:
2$q$,
  $q$def first_missing_positive(nums: List[int]) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef first_missing_positive(nums: List[int]) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    nums = [int(next(it)) for _ in range(int(next(it)))]\n    result = first_missing_positive(nums)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction firstMissingPositive(nums) {\n  // Write your solution here\n}\n\nconst nums = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst result = firstMissingPositive(nums);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int firstMissingPositive(int[] nums) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int[] nums = new int[scanner.nextInt()];\n        for (int i = 0; i < nums.length; i++) nums[i] = scanner.nextInt();\n        int result = firstMissingPositive(nums);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint firstMissingPositive(vector<int> nums) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int numsN;\n    cin >> numsN;\n    vector<int> nums(numsN);\n    for (int& x : nums) cin >> x;\n    auto result = firstMissingPositive(nums);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"4\n3 4 -1 1","expected":"2"},{"input":"3\n1 2 0","expected":"3"},{"input":"5\n7 8 9 11 12","expected":"1"},{"input":"7\n7 8 -2 6 1 7 0","expected":"2"},{"input":"7\n8 -2 8 0 3 -1 1","expected":"2"},{"input":"5\n3 1 8 5 3","expected":"2"}]$j$::jsonb,
  $q$1 <= n <= 10^5$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon']::text[], ARRAY['cyclic-sort','hashing']::text[]);


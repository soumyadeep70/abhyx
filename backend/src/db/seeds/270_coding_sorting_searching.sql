-- 270_coding_sorting_searching.sql
-- Topic: Sorting & Searching (coding) -- 23 questions.
-- Idempotent: re-running updates these rows in place (matched on topic + title).
-- Requires the helpers in 010_question_helpers.sql (run in the same session by `npm run seed`).

-- 01 | easy | Binary Search
SELECT pg_temp.seed_coding($q$Sorting & Searching$q$, 'easy', $q$Binary Search$q$, $q$The array is sorted in ascending order with distinct values. Print the index of target, or -1 if it is not present. Aim for O(log n).

Input Format:
- nums: an integer n, then a line of n space-separated integers
- target: a single integer

Output Format:
Print a single integer.

Example:
Input:
6
-1 0 3 5 9 12
9
Output:
4$q$,
  $q$def binary_search(nums: List[int], target: int) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef binary_search(nums: List[int], target: int) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    nums = [int(next(it)) for _ in range(int(next(it)))]\n    target = int(next(it))\n    result = binary_search(nums, target)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction binarySearch(nums, target) {\n  // Write your solution here\n}\n\nconst nums = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst target = parseInt(next());\nconst result = binarySearch(nums, target);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int binarySearch(int[] nums, int target) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int[] nums = new int[scanner.nextInt()];\n        for (int i = 0; i < nums.length; i++) nums[i] = scanner.nextInt();\n        int target = scanner.nextInt();\n        int result = binarySearch(nums, target);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint binarySearch(vector<int> nums, int target) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int numsN;\n    cin >> numsN;\n    vector<int> nums(numsN);\n    for (int& x : nums) cin >> x;\n    int target;\n    cin >> target;\n    auto result = binarySearch(nums, target);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"6\n-1 0 3 5 9 12\n9","expected":"4"},{"input":"6\n-1 0 3 5 9 12\n2","expected":"-1"},{"input":"1\n5\n5","expected":"0"},{"input":"5\n-13 -6 29 32 39\n29","expected":"2"},{"input":"9\n-20 -18 -14 0 6 10 19 21 28\n6","expected":"4"},{"input":"7\n-20 -10 -2 5 7 13 36\n-10","expected":"1"}]$j$::jsonb,
  $q$1 <= n <= 10^4$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['binary-search']::text[]);

-- 02 | easy | Search Insert Position
SELECT pg_temp.seed_coding($q$Sorting & Searching$q$, 'easy', $q$Search Insert Position$q$, $q$The array is sorted with distinct values. Print the index of target if it is present, otherwise the index where it would be inserted to keep the array sorted.

Input Format:
- nums: an integer n, then a line of n space-separated integers
- target: a single integer

Output Format:
Print a single integer.

Example:
Input:
4
1 3 5 6
5
Output:
2$q$,
  $q$def search_insert(nums: List[int], target: int) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef search_insert(nums: List[int], target: int) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    nums = [int(next(it)) for _ in range(int(next(it)))]\n    target = int(next(it))\n    result = search_insert(nums, target)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction searchInsert(nums, target) {\n  // Write your solution here\n}\n\nconst nums = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst target = parseInt(next());\nconst result = searchInsert(nums, target);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int searchInsert(int[] nums, int target) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int[] nums = new int[scanner.nextInt()];\n        for (int i = 0; i < nums.length; i++) nums[i] = scanner.nextInt();\n        int target = scanner.nextInt();\n        int result = searchInsert(nums, target);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint searchInsert(vector<int> nums, int target) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int numsN;\n    cin >> numsN;\n    vector<int> nums(numsN);\n    for (int& x : nums) cin >> x;\n    int target;\n    cin >> target;\n    auto result = searchInsert(nums, target);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"4\n1 3 5 6\n5","expected":"2"},{"input":"4\n1 3 5 6\n2","expected":"1"},{"input":"4\n1 3 5 6\n7","expected":"4"},{"input":"4\n1 3 5 6\n0","expected":"0"},{"input":"8\n-14 -4 -3 3 5 14 22 30\n-7","expected":"1"},{"input":"9\n-18 -14 -1 0 7 11 15 30 36\n20","expected":"7"},{"input":"8\n-5 1 3 4 9 24 25 33\n20","expected":"5"}]$j$::jsonb,
  $q$1 <= n <= 10^4$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Infosys','Wipro']::text[], ARRAY['binary-search']::text[]);

-- 03 | easy | Peak Index in a Mountain Array
SELECT pg_temp.seed_coding($q$Sorting & Searching$q$, 'easy', $q$Peak Index in a Mountain Array$q$, $q$The array strictly increases up to a single peak and then strictly decreases. Print the index of the peak. Aim for O(log n).

Input Format:
- arr: an integer n, then a line of n space-separated integers

Output Format:
Print a single integer.

Example:
Input:
4
0 2 1 0
Output:
1$q$,
  $q$def peak_index(arr: List[int]) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef peak_index(arr: List[int]) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    arr = [int(next(it)) for _ in range(int(next(it)))]\n    result = peak_index(arr)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction peakIndex(arr) {\n  // Write your solution here\n}\n\nconst arr = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst result = peakIndex(arr);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int peakIndex(int[] arr) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int[] arr = new int[scanner.nextInt()];\n        for (int i = 0; i < arr.length; i++) arr[i] = scanner.nextInt();\n        int result = peakIndex(arr);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint peakIndex(vector<int> arr) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int arrN;\n    cin >> arrN;\n    vector<int> arr(arrN);\n    for (int& x : arr) cin >> x;\n    auto result = peakIndex(arr);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"4\n0 2 1 0","expected":"1"},{"input":"4\n0 10 5 2","expected":"1"},{"input":"5\n3 5 3 2 0","expected":"1"},{"input":"7\n8 13 19 22 26 27 16","expected":"5"},{"input":"8\n18 25 26 22 19 13 11 1","expected":"2"},{"input":"7\n10 11 25 26 29 28 25","expected":"4"}]$j$::jsonb,
  $q$3 <= n <= 10^5$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Infosys','Accenture']::text[], ARRAY['binary-search']::text[]);

-- 04 | easy | Integer Square Root
SELECT pg_temp.seed_coding($q$Sorting & Searching$q$, 'easy', $q$Integer Square Root$q$, $q$Print the square root of x rounded DOWN to the nearest integer, without using a built-in power or sqrt function.

Input Format:
- x: a single integer

Output Format:
Print a single integer.

Example:
Input:
8
Output:
2$q$,
  $q$def int_sqrt(x: int) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef int_sqrt(x: int) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    x = int(next(it))\n    result = int_sqrt(x)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction intSqrt(x) {\n  // Write your solution here\n}\n\nconst x = parseInt(next());\nconst result = intSqrt(x);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int intSqrt(int x) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int x = scanner.nextInt();\n        int result = intSqrt(x);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint intSqrt(int x) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int x;\n    cin >> x;\n    auto result = intSqrt(x);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"8","expected":"2"},{"input":"4","expected":"2"},{"input":"0","expected":"0"},{"input":"2147395599","expected":"46339"},{"input":"353909","expected":"594"},{"input":"254406","expected":"504"},{"input":"13138","expected":"114"}]$j$::jsonb,
  $q$0 <= x <= 2^31 - 1$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['binary-search','math']::text[]);

-- 05 | easy | Sort an Array
SELECT pg_temp.seed_coding($q$Sorting & Searching$q$, 'easy', $q$Sort an Array$q$, $q$Sort the array in ascending order and print it. Try implementing merge sort or quick sort yourself rather than calling a library sort.

Input Format:
- nums: an integer n, then a line of n space-separated integers

Output Format:
Print the integers on one line, separated by single spaces.

Example:
Input:
4
5 2 3 1
Output:
1 2 3 5$q$,
  $q$def sort_array(nums: List[int]) -> List[int]$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef sort_array(nums: List[int]) -> List[int]:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    nums = [int(next(it)) for _ in range(int(next(it)))]\n    result = sort_array(nums)\n    print(' '.join(map(str, result)))\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction sortArray(nums) {\n  // Write your solution here\n}\n\nconst nums = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst result = sortArray(nums);\nconsole.log(result.join(' '));\n","java":"import java.util.*;\n\npublic class Main {\n    static int[] sortArray(int[] nums) {\n        // Write your solution here\n        return new int[0];\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int[] nums = new int[scanner.nextInt()];\n        for (int i = 0; i < nums.length; i++) nums[i] = scanner.nextInt();\n        int[] result = sortArray(nums);\n        StringBuilder sb = new StringBuilder();\n        for (int i = 0; i < result.length; i++) {\n            if (i > 0) sb.append(' ');\n            sb.append(result[i]);\n        }\n        System.out.println(sb);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nvector<int> sortArray(vector<int> nums) {\n    // Write your solution here\n    return {};\n}\n\nint main() {\n    int numsN;\n    cin >> numsN;\n    vector<int> nums(numsN);\n    for (int& x : nums) cin >> x;\n    auto result = sortArray(nums);\n    for (size_t i = 0; i < result.size(); i++) {\n        if (i) cout << ' ';\n        cout << result[i];\n    }\n    cout << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"4\n5 2 3 1","expected":"1 2 3 5"},{"input":"6\n5 1 1 2 0 0","expected":"0 0 1 1 2 5"},{"input":"1\n7","expected":"7"},{"input":"10\n4 -5 -4 5 6 8 1 -1 7 -3","expected":"-5 -4 -3 -1 1 4 5 6 7 8"},{"input":"6\n2 1 -8 9 0 6","expected":"-8 0 1 2 6 9"},{"input":"6\n-2 -7 -3 -1 6 2","expected":"-7 -3 -2 -1 2 6"}]$j$::jsonb,
  $q$1 <= n <= 5 * 10^4$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['merge-sort','sorting']::text[]);

-- 06 | easy | Merge Two Sorted Arrays
SELECT pg_temp.seed_coding($q$Sorting & Searching$q$, 'easy', $q$Merge Two Sorted Arrays$q$, $q$Both arrays are sorted in non-decreasing order. Print all their elements merged into one sorted array in O(m + n) time.

Input Format:
- a: an integer n, then a line of n space-separated integers
- b: an integer n, then a line of n space-separated integers

Output Format:
Print the integers on one line, separated by single spaces.

Example:
Input:
3
1 2 3
3
2 5 6
Output:
1 2 2 3 5 6$q$,
  $q$def merge_sorted(a: List[int], b: List[int]) -> List[int]$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef merge_sorted(a: List[int], b: List[int]) -> List[int]:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    a = [int(next(it)) for _ in range(int(next(it)))]\n    b = [int(next(it)) for _ in range(int(next(it)))]\n    result = merge_sorted(a, b)\n    print(' '.join(map(str, result)))\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction mergeSorted(a, b) {\n  // Write your solution here\n}\n\nconst a = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst b = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst result = mergeSorted(a, b);\nconsole.log(result.join(' '));\n","java":"import java.util.*;\n\npublic class Main {\n    static int[] mergeSorted(int[] a, int[] b) {\n        // Write your solution here\n        return new int[0];\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int[] a = new int[scanner.nextInt()];\n        for (int i = 0; i < a.length; i++) a[i] = scanner.nextInt();\n        int[] b = new int[scanner.nextInt()];\n        for (int i = 0; i < b.length; i++) b[i] = scanner.nextInt();\n        int[] result = mergeSorted(a, b);\n        StringBuilder sb = new StringBuilder();\n        for (int i = 0; i < result.length; i++) {\n            if (i > 0) sb.append(' ');\n            sb.append(result[i]);\n        }\n        System.out.println(sb);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nvector<int> mergeSorted(vector<int> a, vector<int> b) {\n    // Write your solution here\n    return {};\n}\n\nint main() {\n    int aN;\n    cin >> aN;\n    vector<int> a(aN);\n    for (int& x : a) cin >> x;\n    int bN;\n    cin >> bN;\n    vector<int> b(bN);\n    for (int& x : b) cin >> x;\n    auto result = mergeSorted(a, b);\n    for (size_t i = 0; i < result.size(); i++) {\n        if (i) cout << ' ';\n        cout << result[i];\n    }\n    cout << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"3\n1 2 3\n3\n2 5 6","expected":"1 2 2 3 5 6"},{"input":"1\n1\n1\n0","expected":"0 1"},{"input":"2\n4 4\n1\n4","expected":"4 4 4"},{"input":"6\n1 3 5 6 7 13\n5\n2 10 10 10 14","expected":"1 2 3 5 6 7 10 10 10 13 14"},{"input":"5\n3 4 6 7 9\n3\n0 5 8","expected":"0 3 4 5 6 7 8 9"},{"input":"5\n1 3 11 12 13\n5\n7 10 11 13 15","expected":"1 3 7 10 11 11 12 13 13 15"}]$j$::jsonb,
  $q$1 <= m, n <= 10^4$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['two-pointers','merge']::text[]);

-- 07 | easy | Sort Array by Increasing Frequency
SELECT pg_temp.seed_coding($q$Sorting & Searching$q$, 'easy', $q$Sort Array by Increasing Frequency$q$, $q$Sort the values by increasing frequency. Values with the same frequency are sorted in DECREASING order. Print the sorted array.

Input Format:
- nums: an integer n, then a line of n space-separated integers

Output Format:
Print the integers on one line, separated by single spaces.

Example:
Input:
6
1 1 2 2 2 3
Output:
3 1 1 2 2 2$q$,
  $q$def frequency_sort(nums: List[int]) -> List[int]$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef frequency_sort(nums: List[int]) -> List[int]:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    nums = [int(next(it)) for _ in range(int(next(it)))]\n    result = frequency_sort(nums)\n    print(' '.join(map(str, result)))\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction frequencySort(nums) {\n  // Write your solution here\n}\n\nconst nums = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst result = frequencySort(nums);\nconsole.log(result.join(' '));\n","java":"import java.util.*;\n\npublic class Main {\n    static int[] frequencySort(int[] nums) {\n        // Write your solution here\n        return new int[0];\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int[] nums = new int[scanner.nextInt()];\n        for (int i = 0; i < nums.length; i++) nums[i] = scanner.nextInt();\n        int[] result = frequencySort(nums);\n        StringBuilder sb = new StringBuilder();\n        for (int i = 0; i < result.length; i++) {\n            if (i > 0) sb.append(' ');\n            sb.append(result[i]);\n        }\n        System.out.println(sb);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nvector<int> frequencySort(vector<int> nums) {\n    // Write your solution here\n    return {};\n}\n\nint main() {\n    int numsN;\n    cin >> numsN;\n    vector<int> nums(numsN);\n    for (int& x : nums) cin >> x;\n    auto result = frequencySort(nums);\n    for (size_t i = 0; i < result.size(); i++) {\n        if (i) cout << ' ';\n        cout << result[i];\n    }\n    cout << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"6\n1 1 2 2 2 3","expected":"3 1 1 2 2 2"},{"input":"5\n2 3 1 3 2","expected":"1 3 3 2 2"},{"input":"9\n-1 1 -6 4 5 -6 1 4 1","expected":"5 -1 4 4 -6 -6 1 1 1"},{"input":"7\n-1 -1 1 -3 1 0 3","expected":"3 0 -3 1 1 -1 -1"},{"input":"8\n0 3 1 2 3 0 -3 3","expected":"2 1 -3 0 0 3 3 3"},{"input":"9\n2 -2 2 3 0 -3 -2 -3 -2","expected":"3 0 2 2 -3 -3 -2 -2 -2"}]$j$::jsonb,
  $q$1 <= n <= 100$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Accenture']::text[], ARRAY['sorting','hashing']::text[]);

-- 08 | medium | First and Last Position of Element
SELECT pg_temp.seed_coding($q$Sorting & Searching$q$, 'medium', $q$First and Last Position of Element$q$, $q$The array is sorted in non-decreasing order. Print the first and last index of target separated by a space, or '-1 -1' if it is absent. Aim for O(log n).

Input Format:
- nums: an integer n, then a line of n space-separated integers
- target: a single integer

Output Format:
Print the integers on one line, separated by single spaces.

Example:
Input:
6
5 7 7 8 8 10
8
Output:
3 4$q$,
  $q$def search_range(nums: List[int], target: int) -> List[int]$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef search_range(nums: List[int], target: int) -> List[int]:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    nums = [int(next(it)) for _ in range(int(next(it)))]\n    target = int(next(it))\n    result = search_range(nums, target)\n    print(' '.join(map(str, result)))\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction searchRange(nums, target) {\n  // Write your solution here\n}\n\nconst nums = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst target = parseInt(next());\nconst result = searchRange(nums, target);\nconsole.log(result.join(' '));\n","java":"import java.util.*;\n\npublic class Main {\n    static int[] searchRange(int[] nums, int target) {\n        // Write your solution here\n        return new int[0];\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int[] nums = new int[scanner.nextInt()];\n        for (int i = 0; i < nums.length; i++) nums[i] = scanner.nextInt();\n        int target = scanner.nextInt();\n        int[] result = searchRange(nums, target);\n        StringBuilder sb = new StringBuilder();\n        for (int i = 0; i < result.length; i++) {\n            if (i > 0) sb.append(' ');\n            sb.append(result[i]);\n        }\n        System.out.println(sb);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nvector<int> searchRange(vector<int> nums, int target) {\n    // Write your solution here\n    return {};\n}\n\nint main() {\n    int numsN;\n    cin >> numsN;\n    vector<int> nums(numsN);\n    for (int& x : nums) cin >> x;\n    int target;\n    cin >> target;\n    auto result = searchRange(nums, target);\n    for (size_t i = 0; i < result.size(); i++) {\n        if (i) cout << ' ';\n        cout << result[i];\n    }\n    cout << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"6\n5 7 7 8 8 10\n8","expected":"3 4"},{"input":"6\n5 7 7 8 8 10\n6","expected":"-1 -1"},{"input":"1\n1\n1","expected":"0 0"},{"input":"11\n0 0 1 2 2 3 3 3 5 6 6\n0","expected":"0 1"},{"input":"10\n1 1 1 3 5 5 5 5 6 6\n3","expected":"3 3"},{"input":"9\n1 1 1 1 2 2 3 4 5\n1","expected":"0 3"}]$j$::jsonb,
  $q$0 <= n <= 10^5$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Accenture']::text[], ARRAY['binary-search']::text[]);

-- 09 | medium | Search in Rotated Sorted Array
SELECT pg_temp.seed_coding($q$Sorting & Searching$q$, 'medium', $q$Search in Rotated Sorted Array$q$, $q$A sorted array of DISTINCT values was rotated at an unknown pivot (for example [0,1,2,4,5,6,7] became [4,5,6,7,0,1,2]). Print the index of target, or -1 if it is absent, in O(log n).

Input Format:
- nums: an integer n, then a line of n space-separated integers
- target: a single integer

Output Format:
Print a single integer.

Example:
Input:
7
4 5 6 7 0 1 2
0
Output:
4$q$,
  $q$def search_rotated(nums: List[int], target: int) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef search_rotated(nums: List[int], target: int) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    nums = [int(next(it)) for _ in range(int(next(it)))]\n    target = int(next(it))\n    result = search_rotated(nums, target)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction searchRotated(nums, target) {\n  // Write your solution here\n}\n\nconst nums = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst target = parseInt(next());\nconst result = searchRotated(nums, target);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int searchRotated(int[] nums, int target) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int[] nums = new int[scanner.nextInt()];\n        for (int i = 0; i < nums.length; i++) nums[i] = scanner.nextInt();\n        int target = scanner.nextInt();\n        int result = searchRotated(nums, target);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint searchRotated(vector<int> nums, int target) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int numsN;\n    cin >> numsN;\n    vector<int> nums(numsN);\n    for (int& x : nums) cin >> x;\n    int target;\n    cin >> target;\n    auto result = searchRotated(nums, target);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"7\n4 5 6 7 0 1 2\n0","expected":"4"},{"input":"7\n4 5 6 7 0 1 2\n3","expected":"-1"},{"input":"1\n1\n0","expected":"-1"},{"input":"8\n7 9 10 15 19 38 -16 -15\n-16","expected":"6"},{"input":"7\n38 -3 11 12 18 20 36\n-3","expected":"1"},{"input":"6\n-6 5 6 10 32 -9\n32","expected":"4"}]$j$::jsonb,
  $q$1 <= n <= 5000$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Accenture','Infosys']::text[], ARRAY['binary-search']::text[]);

-- 10 | medium | Find Minimum in Rotated Sorted Array
SELECT pg_temp.seed_coding($q$Sorting & Searching$q$, 'medium', $q$Find Minimum in Rotated Sorted Array$q$, $q$A sorted array of DISTINCT values was rotated at an unknown pivot. Print its minimum element in O(log n).

Input Format:
- nums: an integer n, then a line of n space-separated integers

Output Format:
Print a single integer.

Example:
Input:
5
3 4 5 1 2
Output:
1$q$,
  $q$def find_min(nums: List[int]) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef find_min(nums: List[int]) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    nums = [int(next(it)) for _ in range(int(next(it)))]\n    result = find_min(nums)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction findMin(nums) {\n  // Write your solution here\n}\n\nconst nums = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst result = findMin(nums);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int findMin(int[] nums) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int[] nums = new int[scanner.nextInt()];\n        for (int i = 0; i < nums.length; i++) nums[i] = scanner.nextInt();\n        int result = findMin(nums);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint findMin(vector<int> nums) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int numsN;\n    cin >> numsN;\n    vector<int> nums(numsN);\n    for (int& x : nums) cin >> x;\n    auto result = findMin(nums);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"5\n3 4 5 1 2","expected":"1"},{"input":"7\n4 5 6 7 0 1 2","expected":"0"},{"input":"4\n11 13 15 17","expected":"11"},{"input":"7\n16 21 27 -13 -6 -1 6","expected":"-13"},{"input":"8\n21 22 27 29 -15 -10 7 9","expected":"-15"},{"input":"5\n17 21 -14 -5 3","expected":"-14"}]$j$::jsonb,
  $q$1 <= n <= 5000$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Accenture','Infosys']::text[], ARRAY['binary-search']::text[]);

-- 11 | medium | Kth Largest Element in an Array
SELECT pg_temp.seed_coding($q$Sorting & Searching$q$, 'medium', $q$Kth Largest Element in an Array$q$, $q$Print the k-th largest element of the array in sorted order (duplicates count separately, so [3,3,1] has 2nd largest 3).

Input Format:
- nums: an integer n, then a line of n space-separated integers
- k: a single integer

Output Format:
Print a single integer.

Example:
Input:
6
3 2 1 5 6 4
2
Output:
5$q$,
  $q$def find_kth_largest(nums: List[int], k: int) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef find_kth_largest(nums: List[int], k: int) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    nums = [int(next(it)) for _ in range(int(next(it)))]\n    k = int(next(it))\n    result = find_kth_largest(nums, k)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction findKthLargest(nums, k) {\n  // Write your solution here\n}\n\nconst nums = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst k = parseInt(next());\nconst result = findKthLargest(nums, k);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int findKthLargest(int[] nums, int k) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int[] nums = new int[scanner.nextInt()];\n        for (int i = 0; i < nums.length; i++) nums[i] = scanner.nextInt();\n        int k = scanner.nextInt();\n        int result = findKthLargest(nums, k);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint findKthLargest(vector<int> nums, int k) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int numsN;\n    cin >> numsN;\n    vector<int> nums(numsN);\n    for (int& x : nums) cin >> x;\n    int k;\n    cin >> k;\n    auto result = findKthLargest(nums, k);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"6\n3 2 1 5 6 4\n2","expected":"5"},{"input":"9\n3 2 3 1 2 4 5 5 6\n4","expected":"4"},{"input":"1\n1\n1","expected":"1"},{"input":"10\n-8 -9 1 6 4 -2 -5 9 8 0\n4","expected":"4"},{"input":"9\n9 -6 1 9 5 6 -2 -9 7\n2","expected":"9"},{"input":"6\n8 3 -7 1 2 0\n2","expected":"3"}]$j$::jsonb,
  $q$1 <= k <= n <= 10^5$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Accenture','Infosys']::text[], ARRAY['heap','quickselect']::text[]);

-- 12 | medium | Count Inversions
SELECT pg_temp.seed_coding($q$Sorting & Searching$q$, 'medium', $q$Count Inversions$q$, $q$An inversion is a pair of indices i < j with nums[i] > nums[j]. Print the number of inversions. An O(n log n) merge-sort solution is expected.

Input Format:
- nums: an integer n, then a line of n space-separated integers

Output Format:
Print a single integer.

Example:
Input:
5
2 4 1 3 5
Output:
3$q$,
  $q$def count_inversions(nums: List[int]) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef count_inversions(nums: List[int]) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    nums = [int(next(it)) for _ in range(int(next(it)))]\n    result = count_inversions(nums)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction countInversions(nums) {\n  // Write your solution here\n}\n\nconst nums = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst result = countInversions(nums);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int countInversions(int[] nums) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int[] nums = new int[scanner.nextInt()];\n        for (int i = 0; i < nums.length; i++) nums[i] = scanner.nextInt();\n        int result = countInversions(nums);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint countInversions(vector<int> nums) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int numsN;\n    cin >> numsN;\n    vector<int> nums(numsN);\n    for (int& x : nums) cin >> x;\n    auto result = countInversions(nums);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"5\n2 4 1 3 5","expected":"3"},{"input":"5\n5 4 3 2 1","expected":"10"},{"input":"3\n1 2 3","expected":"0"},{"input":"5\n-7 9 8 -3 2","expected":"5"},{"input":"5\n-6 8 -5 -5 -6","expected":"5"},{"input":"5\n6 5 4 -3 3","expected":"9"}]$j$::jsonb,
  $q$1 <= n <= 10^5$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Accenture','Infosys']::text[], ARRAY['merge-sort','divide-and-conquer']::text[]);

-- 13 | medium | Largest Number
SELECT pg_temp.seed_coding($q$Sorting & Searching$q$, 'medium', $q$Largest Number$q$, $q$Arrange the non-negative integers so their concatenation forms the largest possible number, and print it as a string (print 0 if every number is 0).

Input Format:
- nums: an integer n, then a line of n space-separated integers

Output Format:
Print the resulting string.

Example:
Input:
2
10 2
Output:
210$q$,
  $q$def largest_number(nums: List[int]) -> str$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef largest_number(nums: List[int]) -> str:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    nums = [int(next(it)) for _ in range(int(next(it)))]\n    result = largest_number(nums)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction largestNumber(nums) {\n  // Write your solution here\n}\n\nconst nums = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst result = largestNumber(nums);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static String largestNumber(int[] nums) {\n        // Write your solution here\n        return \"\";\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int[] nums = new int[scanner.nextInt()];\n        for (int i = 0; i < nums.length; i++) nums[i] = scanner.nextInt();\n        String result = largestNumber(nums);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nstring largestNumber(vector<int> nums) {\n    // Write your solution here\n    return \"\";\n}\n\nint main() {\n    int numsN;\n    cin >> numsN;\n    vector<int> nums(numsN);\n    for (int& x : nums) cin >> x;\n    auto result = largestNumber(nums);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"2\n10 2","expected":"210"},{"input":"5\n3 30 34 5 9","expected":"9534330"},{"input":"2\n0 0","expected":"0"},{"input":"4\n38 98 30 47","expected":"98473830"},{"input":"5\n94 33 6 7 46","expected":"94764633"},{"input":"5\n31 12 16 30 25","expected":"3130251612"}]$j$::jsonb,
  $q$1 <= n <= 100$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Accenture']::text[], ARRAY['sorting','custom-comparator']::text[]);

-- 14 | medium | Meeting Rooms II
SELECT pg_temp.seed_coding($q$Sorting & Searching$q$, 'medium', $q$Meeting Rooms II$q$, $q$meetings[i] = [start, end). Print the minimum number of rooms needed so no two overlapping meetings share a room (a meeting ending at time t does not clash with one starting at t).

Input Format:
- meetings: two integers r and c, then r lines of c space-separated integers

Output Format:
Print a single integer.

Example:
Input:
3 2
0 30
5 10
15 20
Output:
2$q$,
  $q$def min_meeting_rooms(meetings: List[List[int]]) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef min_meeting_rooms(meetings: List[List[int]]) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    rows, cols = int(next(it)), int(next(it))\n    meetings = [[int(next(it)) for _ in range(cols)] for _ in range(rows)]\n    result = min_meeting_rooms(meetings)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction minMeetingRooms(meetings) {\n  // Write your solution here\n}\n\nconst meetingsRows = parseInt(next());\nconst meetingsCols = parseInt(next());\nconst meetings = Array.from({ length: meetingsRows }, () => Array.from({ length: meetingsCols }, () => parseInt(next())));\nconst result = minMeetingRooms(meetings);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int minMeetingRooms(int[][] meetings) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int meetingsRows = scanner.nextInt(), meetingsCols = scanner.nextInt();\n        int[][] meetings = new int[meetingsRows][meetingsCols];\n        for (int i = 0; i < meetingsRows; i++)\n            for (int j = 0; j < meetingsCols; j++) meetings[i][j] = scanner.nextInt();\n        int result = minMeetingRooms(meetings);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint minMeetingRooms(vector<vector<int>> meetings) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int meetingsRows, meetingsCols;\n    cin >> meetingsRows >> meetingsCols;\n    vector<vector<int>> meetings(meetingsRows, vector<int>(meetingsCols));\n    for (auto& row : meetings) for (int& x : row) cin >> x;\n    auto result = minMeetingRooms(meetings);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"3 2\n0 30\n5 10\n15 20","expected":"2"},{"input":"2 2\n7 10\n2 4","expected":"1"},{"input":"2 2\n1 5\n5 9","expected":"1"},{"input":"5 2\n14 16\n7 8\n3 6\n14 19\n14 20","expected":"3"},{"input":"8 2\n13 18\n14 22\n14 19\n4 10\n7 9\n3 5\n1 8\n3 8","expected":"4"},{"input":"7 2\n12 17\n6 11\n8 10\n11 16\n0 5\n8 12\n0 5","expected":"3"}]$j$::jsonb,
  $q$1 <= n <= 10^4$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Accenture']::text[], ARRAY['intervals','sorting','sweep-line']::text[]);

-- 15 | medium | Non-overlapping Intervals
SELECT pg_temp.seed_coding($q$Sorting & Searching$q$, 'medium', $q$Non-overlapping Intervals$q$, $q$Print the minimum number of intervals to remove so that the remaining intervals do not overlap (touching endpoints is fine).

Input Format:
- intervals: two integers r and c, then r lines of c space-separated integers

Output Format:
Print a single integer.

Example:
Input:
4 2
1 2
2 3
3 4
1 3
Output:
1$q$,
  $q$def erase_overlap_intervals(intervals: List[List[int]]) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef erase_overlap_intervals(intervals: List[List[int]]) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    rows, cols = int(next(it)), int(next(it))\n    intervals = [[int(next(it)) for _ in range(cols)] for _ in range(rows)]\n    result = erase_overlap_intervals(intervals)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction eraseOverlapIntervals(intervals) {\n  // Write your solution here\n}\n\nconst intervalsRows = parseInt(next());\nconst intervalsCols = parseInt(next());\nconst intervals = Array.from({ length: intervalsRows }, () => Array.from({ length: intervalsCols }, () => parseInt(next())));\nconst result = eraseOverlapIntervals(intervals);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int eraseOverlapIntervals(int[][] intervals) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int intervalsRows = scanner.nextInt(), intervalsCols = scanner.nextInt();\n        int[][] intervals = new int[intervalsRows][intervalsCols];\n        for (int i = 0; i < intervalsRows; i++)\n            for (int j = 0; j < intervalsCols; j++) intervals[i][j] = scanner.nextInt();\n        int result = eraseOverlapIntervals(intervals);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint eraseOverlapIntervals(vector<vector<int>> intervals) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int intervalsRows, intervalsCols;\n    cin >> intervalsRows >> intervalsCols;\n    vector<vector<int>> intervals(intervalsRows, vector<int>(intervalsCols));\n    for (auto& row : intervals) for (int& x : row) cin >> x;\n    auto result = eraseOverlapIntervals(intervals);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"4 2\n1 2\n2 3\n3 4\n1 3","expected":"1"},{"input":"3 2\n1 2\n1 2\n1 2","expected":"2"},{"input":"2 2\n1 2\n2 3","expected":"0"},{"input":"7 2\n1 7\n8 12\n7 9\n1 7\n8 16\n4 10\n6 13","expected":"5"},{"input":"5 2\n7 11\n11 18\n1 5\n5 10\n2 7","expected":"2"},{"input":"5 2\n11 18\n3 4\n5 8\n0 5\n9 16","expected":"2"}]$j$::jsonb,
  $q$1 <= n <= 10^5$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Accenture']::text[], ARRAY['intervals','greedy']::text[]);

-- 16 | medium | Top K Frequent Elements
SELECT pg_temp.seed_coding($q$Sorting & Searching$q$, 'medium', $q$Top K Frequent Elements$q$, $q$Print the k most frequent values. Order them by frequency (highest first); break ties by smaller value first. k is never larger than the number of distinct values.

Input Format:
- nums: an integer n, then a line of n space-separated integers
- k: a single integer

Output Format:
Print the integers on one line, separated by single spaces.

Example:
Input:
6
1 1 1 2 2 3
2
Output:
1 2$q$,
  $q$def top_k_frequent(nums: List[int], k: int) -> List[int]$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef top_k_frequent(nums: List[int], k: int) -> List[int]:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    nums = [int(next(it)) for _ in range(int(next(it)))]\n    k = int(next(it))\n    result = top_k_frequent(nums, k)\n    print(' '.join(map(str, result)))\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction topKFrequent(nums, k) {\n  // Write your solution here\n}\n\nconst nums = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst k = parseInt(next());\nconst result = topKFrequent(nums, k);\nconsole.log(result.join(' '));\n","java":"import java.util.*;\n\npublic class Main {\n    static int[] topKFrequent(int[] nums, int k) {\n        // Write your solution here\n        return new int[0];\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int[] nums = new int[scanner.nextInt()];\n        for (int i = 0; i < nums.length; i++) nums[i] = scanner.nextInt();\n        int k = scanner.nextInt();\n        int[] result = topKFrequent(nums, k);\n        StringBuilder sb = new StringBuilder();\n        for (int i = 0; i < result.length; i++) {\n            if (i > 0) sb.append(' ');\n            sb.append(result[i]);\n        }\n        System.out.println(sb);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nvector<int> topKFrequent(vector<int> nums, int k) {\n    // Write your solution here\n    return {};\n}\n\nint main() {\n    int numsN;\n    cin >> numsN;\n    vector<int> nums(numsN);\n    for (int& x : nums) cin >> x;\n    int k;\n    cin >> k;\n    auto result = topKFrequent(nums, k);\n    for (size_t i = 0; i < result.size(); i++) {\n        if (i) cout << ' ';\n        cout << result[i];\n    }\n    cout << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"6\n1 1 1 2 2 3\n2","expected":"1 2"},{"input":"1\n1\n1","expected":"1"},{"input":"5\n4 4 5 5 6\n3","expected":"4 5 6"},{"input":"11\n4 3 1 0 1 1 5 0 1 3 0\n3","expected":"1 0 3"},{"input":"12\n5 0 1 1 0 2 3 4 1 5 3 2\n1","expected":"1"},{"input":"10\n1 4 5 2 1 2 0 0 2 5\n5","expected":"2 0 1 5 4"}]$j$::jsonb,
  $q$1 <= n <= 10^5$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Accenture','Infosys']::text[], ARRAY['hashing','heap','sorting']::text[]);

-- 17 | medium | Search a 2D Matrix
SELECT pg_temp.seed_coding($q$Sorting & Searching$q$, 'medium', $q$Search a 2D Matrix$q$, $q$Each row of the matrix is sorted ascending and the first value of each row is greater than the last value of the previous row. Print true if target is in the matrix, in O(log(m*n)).

Input Format:
- matrix: two integers r and c, then r lines of c space-separated integers
- target: a single integer

Output Format:
Print true or false (lowercase).

Example:
Input:
3 4
1 3 5 7
10 11 16 20
23 30 34 60
3
Output:
true$q$,
  $q$def search_matrix(matrix: List[List[int]], target: int) -> bool$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef search_matrix(matrix: List[List[int]], target: int) -> bool:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    rows, cols = int(next(it)), int(next(it))\n    matrix = [[int(next(it)) for _ in range(cols)] for _ in range(rows)]\n    target = int(next(it))\n    result = search_matrix(matrix, target)\n    print('true' if result else 'false')\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction searchMatrix(matrix, target) {\n  // Write your solution here\n}\n\nconst matrixRows = parseInt(next());\nconst matrixCols = parseInt(next());\nconst matrix = Array.from({ length: matrixRows }, () => Array.from({ length: matrixCols }, () => parseInt(next())));\nconst target = parseInt(next());\nconst result = searchMatrix(matrix, target);\nconsole.log(result ? 'true' : 'false');\n","java":"import java.util.*;\n\npublic class Main {\n    static boolean searchMatrix(int[][] matrix, int target) {\n        // Write your solution here\n        return false;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int matrixRows = scanner.nextInt(), matrixCols = scanner.nextInt();\n        int[][] matrix = new int[matrixRows][matrixCols];\n        for (int i = 0; i < matrixRows; i++)\n            for (int j = 0; j < matrixCols; j++) matrix[i][j] = scanner.nextInt();\n        int target = scanner.nextInt();\n        boolean result = searchMatrix(matrix, target);\n        System.out.println(result ? \"true\" : \"false\");\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nbool searchMatrix(vector<vector<int>> matrix, int target) {\n    // Write your solution here\n    return false;\n}\n\nint main() {\n    int matrixRows, matrixCols;\n    cin >> matrixRows >> matrixCols;\n    vector<vector<int>> matrix(matrixRows, vector<int>(matrixCols));\n    for (auto& row : matrix) for (int& x : row) cin >> x;\n    int target;\n    cin >> target;\n    auto result = searchMatrix(matrix, target);\n    cout << (result ? \"true\" : \"false\") << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"3 4\n1 3 5 7\n10 11 16 20\n23 30 34 60\n3","expected":"true"},{"input":"3 4\n1 3 5 7\n10 11 16 20\n23 30 34 60\n13","expected":"false"},{"input":"1 1\n1\n1","expected":"true"},{"input":"3 4\n1 2 19 23\n26 28 35 36\n42 46 51 59\n16","expected":"false"},{"input":"3 4\n7 18 23 26\n29 31 32 43\n55 56 57 58\n56","expected":"true"},{"input":"3 4\n3 6 20 22\n38 39 40 46\n47 50 54 59\n27","expected":"false"}]$j$::jsonb,
  $q$1 <= m, n <= 100$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Accenture']::text[], ARRAY['binary-search','matrix']::text[]);

-- 18 | medium | Koko Eating Bananas
SELECT pg_temp.seed_coding($q$Sorting & Searching$q$, 'medium', $q$Koko Eating Bananas$q$, $q$Koko eats at a speed of k bananas per hour: each hour she picks one pile and eats up to k bananas from it (finishing the pile early wastes the rest of that hour). Print the minimum integer speed k that lets her finish all piles within h hours. h is at least the number of piles.

Input Format:
- piles: an integer n, then a line of n space-separated integers
- h: a single integer

Output Format:
Print a single integer.

Example:
Input:
4
3 6 7 11
8
Output:
4$q$,
  $q$def min_eating_speed(piles: List[int], h: int) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef min_eating_speed(piles: List[int], h: int) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    piles = [int(next(it)) for _ in range(int(next(it)))]\n    h = int(next(it))\n    result = min_eating_speed(piles, h)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction minEatingSpeed(piles, h) {\n  // Write your solution here\n}\n\nconst piles = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst h = parseInt(next());\nconst result = minEatingSpeed(piles, h);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int minEatingSpeed(int[] piles, int h) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int[] piles = new int[scanner.nextInt()];\n        for (int i = 0; i < piles.length; i++) piles[i] = scanner.nextInt();\n        int h = scanner.nextInt();\n        int result = minEatingSpeed(piles, h);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint minEatingSpeed(vector<int> piles, int h) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int pilesN;\n    cin >> pilesN;\n    vector<int> piles(pilesN);\n    for (int& x : piles) cin >> x;\n    int h;\n    cin >> h;\n    auto result = minEatingSpeed(piles, h);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"4\n3 6 7 11\n8","expected":"4"},{"input":"5\n30 11 23 4 20\n5","expected":"30"},{"input":"5\n30 11 23 4 20\n6","expected":"23"},{"input":"5\n23 2 16 6 7\n12","expected":"6"},{"input":"6\n10 12 3 5 28 15\n8","expected":"14"},{"input":"6\n13 7 22 16 5 25\n7","expected":"22"}]$j$::jsonb,
  $q$1 <= n <= 10^4; n <= h <= 10^9$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Accenture']::text[], ARRAY['binary-search-on-answer']::text[]);

-- 19 | medium | Capacity to Ship Packages Within D Days
SELECT pg_temp.seed_coding($q$Sorting & Searching$q$, 'medium', $q$Capacity to Ship Packages Within D Days$q$, $q$Packages must be shipped in the given ORDER, a ship carrying consecutive packages each day up to its capacity. Print the least ship capacity that delivers all packages within the given number of days.

Input Format:
- weights: an integer n, then a line of n space-separated integers
- days: a single integer

Output Format:
Print a single integer.

Example:
Input:
10
1 2 3 4 5 6 7 8 9 10
5
Output:
15$q$,
  $q$def ship_within_days(weights: List[int], days: int) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef ship_within_days(weights: List[int], days: int) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    weights = [int(next(it)) for _ in range(int(next(it)))]\n    days = int(next(it))\n    result = ship_within_days(weights, days)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction shipWithinDays(weights, days) {\n  // Write your solution here\n}\n\nconst weights = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst days = parseInt(next());\nconst result = shipWithinDays(weights, days);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int shipWithinDays(int[] weights, int days) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int[] weights = new int[scanner.nextInt()];\n        for (int i = 0; i < weights.length; i++) weights[i] = scanner.nextInt();\n        int days = scanner.nextInt();\n        int result = shipWithinDays(weights, days);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint shipWithinDays(vector<int> weights, int days) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int weightsN;\n    cin >> weightsN;\n    vector<int> weights(weightsN);\n    for (int& x : weights) cin >> x;\n    int days;\n    cin >> days;\n    auto result = shipWithinDays(weights, days);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"10\n1 2 3 4 5 6 7 8 9 10\n5","expected":"15"},{"input":"6\n3 2 2 4 1 4\n3","expected":"6"},{"input":"5\n1 2 3 1 1\n4","expected":"3"},{"input":"5\n16 19 3 3 8\n3","expected":"19"},{"input":"5\n3 15 20 5 14\n5","expected":"20"},{"input":"5\n17 4 4 18 3\n5","expected":"18"}]$j$::jsonb,
  $q$1 <= days <= n <= 5 * 10^4$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Accenture']::text[], ARRAY['binary-search-on-answer']::text[]);

-- 20 | medium | Kth Smallest Element in a Sorted Matrix
SELECT pg_temp.seed_coding($q$Sorting & Searching$q$, 'medium', $q$Kth Smallest Element in a Sorted Matrix$q$, $q$Every row and every column of the n x n matrix is sorted in ascending order. Print the k-th smallest element of the whole matrix (duplicates count separately).

Input Format:
- matrix: two integers r and c, then r lines of c space-separated integers
- k: a single integer

Output Format:
Print a single integer.

Example:
Input:
3 3
1 5 9
10 11 13
12 13 15
8
Output:
13$q$,
  $q$def kth_smallest(matrix: List[List[int]], k: int) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef kth_smallest(matrix: List[List[int]], k: int) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    rows, cols = int(next(it)), int(next(it))\n    matrix = [[int(next(it)) for _ in range(cols)] for _ in range(rows)]\n    k = int(next(it))\n    result = kth_smallest(matrix, k)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction kthSmallest(matrix, k) {\n  // Write your solution here\n}\n\nconst matrixRows = parseInt(next());\nconst matrixCols = parseInt(next());\nconst matrix = Array.from({ length: matrixRows }, () => Array.from({ length: matrixCols }, () => parseInt(next())));\nconst k = parseInt(next());\nconst result = kthSmallest(matrix, k);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int kthSmallest(int[][] matrix, int k) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int matrixRows = scanner.nextInt(), matrixCols = scanner.nextInt();\n        int[][] matrix = new int[matrixRows][matrixCols];\n        for (int i = 0; i < matrixRows; i++)\n            for (int j = 0; j < matrixCols; j++) matrix[i][j] = scanner.nextInt();\n        int k = scanner.nextInt();\n        int result = kthSmallest(matrix, k);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint kthSmallest(vector<vector<int>> matrix, int k) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int matrixRows, matrixCols;\n    cin >> matrixRows >> matrixCols;\n    vector<vector<int>> matrix(matrixRows, vector<int>(matrixCols));\n    for (auto& row : matrix) for (int& x : row) cin >> x;\n    int k;\n    cin >> k;\n    auto result = kthSmallest(matrix, k);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"3 3\n1 5 9\n10 11 13\n12 13 15\n8","expected":"13"},{"input":"1 1\n-5\n1","expected":"-5"},{"input":"2 2\n1 2\n1 3\n2","expected":"1"},{"input":"3 3\n3 5 9\n7 8 13\n10 11 15\n7","expected":"11"},{"input":"3 3\n4 6 7\n6 10 11\n9 12 15\n5","expected":"9"},{"input":"3 3\n3 7 9\n5 11 15\n8 13 19\n6","expected":"11"}]$j$::jsonb,
  $q$1 <= n <= 300$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Accenture']::text[], ARRAY['binary-search','heap']::text[]);

-- 21 | hard | Median of Two Sorted Arrays
SELECT pg_temp.seed_coding($q$Sorting & Searching$q$, 'hard', $q$Median of Two Sorted Arrays$q$, $q$Print the median of the two sorted arrays combined. If the median is a whole number print it without a decimal point (for example 2); otherwise print it with exactly one decimal digit (for example 2.5). O(log(m + n)) is the goal.

Input Format:
- nums1: an integer n, then a line of n space-separated integers
- nums2: an integer n, then a line of n space-separated integers

Output Format:
Print the resulting string.

Example:
Input:
2
1 3
1
2
Output:
2$q$,
  $q$def find_median(nums1: List[int], nums2: List[int]) -> str$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef find_median(nums1: List[int], nums2: List[int]) -> str:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    nums1 = [int(next(it)) for _ in range(int(next(it)))]\n    nums2 = [int(next(it)) for _ in range(int(next(it)))]\n    result = find_median(nums1, nums2)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction findMedian(nums1, nums2) {\n  // Write your solution here\n}\n\nconst nums1 = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst nums2 = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst result = findMedian(nums1, nums2);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static String findMedian(int[] nums1, int[] nums2) {\n        // Write your solution here\n        return \"\";\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int[] nums1 = new int[scanner.nextInt()];\n        for (int i = 0; i < nums1.length; i++) nums1[i] = scanner.nextInt();\n        int[] nums2 = new int[scanner.nextInt()];\n        for (int i = 0; i < nums2.length; i++) nums2[i] = scanner.nextInt();\n        String result = findMedian(nums1, nums2);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nstring findMedian(vector<int> nums1, vector<int> nums2) {\n    // Write your solution here\n    return \"\";\n}\n\nint main() {\n    int nums1N;\n    cin >> nums1N;\n    vector<int> nums1(nums1N);\n    for (int& x : nums1) cin >> x;\n    int nums2N;\n    cin >> nums2N;\n    vector<int> nums2(nums2N);\n    for (int& x : nums2) cin >> x;\n    auto result = findMedian(nums1, nums2);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"2\n1 3\n1\n2","expected":"2"},{"input":"2\n1 2\n2\n3 4","expected":"2.5"},{"input":"2\n0 0\n2\n0 0","expected":"0"},{"input":"1\n2\n0\n","expected":"2"},{"input":"4\n5 7 8 12\n4\n3 6 8 15","expected":"7.5"},{"input":"2\n5 9\n6\n2 7 7 14 15 17","expected":"8"},{"input":"4\n2 14 14 18\n6\n6 9 15 15 18 19","expected":"14.5"}]$j$::jsonb,
  $q$0 <= m, n <= 1000; m + n >= 1$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon']::text[], ARRAY['binary-search','divide-and-conquer']::text[]);

-- 22 | hard | Split Array Largest Sum
SELECT pg_temp.seed_coding($q$Sorting & Searching$q$, 'hard', $q$Split Array Largest Sum$q$, $q$Split the array into k non-empty CONTIGUOUS subarrays so that the largest subarray sum is as small as possible. Print that minimum possible largest sum.

Input Format:
- nums: an integer n, then a line of n space-separated integers
- k: a single integer

Output Format:
Print a single integer.

Example:
Input:
5
7 2 5 10 8
2
Output:
18$q$,
  $q$def split_array(nums: List[int], k: int) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef split_array(nums: List[int], k: int) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    nums = [int(next(it)) for _ in range(int(next(it)))]\n    k = int(next(it))\n    result = split_array(nums, k)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction splitArray(nums, k) {\n  // Write your solution here\n}\n\nconst nums = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst k = parseInt(next());\nconst result = splitArray(nums, k);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int splitArray(int[] nums, int k) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int[] nums = new int[scanner.nextInt()];\n        for (int i = 0; i < nums.length; i++) nums[i] = scanner.nextInt();\n        int k = scanner.nextInt();\n        int result = splitArray(nums, k);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint splitArray(vector<int> nums, int k) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int numsN;\n    cin >> numsN;\n    vector<int> nums(numsN);\n    for (int& x : nums) cin >> x;\n    int k;\n    cin >> k;\n    auto result = splitArray(nums, k);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"5\n7 2 5 10 8\n2","expected":"18"},{"input":"5\n1 2 3 4 5\n2","expected":"9"},{"input":"3\n1 4 4\n3","expected":"4"},{"input":"6\n14 13 10 1 5 2\n3","expected":"18"},{"input":"9\n6 12 2 10 6 10 19 16 5\n5","expected":"21"},{"input":"9\n6 0 5 13 6 11 6 20 4\n2","expected":"41"}]$j$::jsonb,
  $q$1 <= k <= n <= 1000$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon']::text[], ARRAY['binary-search-on-answer','dp']::text[]);

-- 23 | hard | Aggressive Cows
SELECT pg_temp.seed_coding($q$Sorting & Searching$q$, 'hard', $q$Aggressive Cows$q$, $q$Place c cows in stalls at the given positions so that the MINIMUM distance between any two cows is as large as possible. Print that largest minimum distance.

Input Format:
- stalls: an integer n, then a line of n space-separated integers
- cows: a single integer

Output Format:
Print a single integer.

Example:
Input:
5
1 2 4 8 9
3
Output:
3$q$,
  $q$def aggressive_cows(stalls: List[int], cows: int) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef aggressive_cows(stalls: List[int], cows: int) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    stalls = [int(next(it)) for _ in range(int(next(it)))]\n    cows = int(next(it))\n    result = aggressive_cows(stalls, cows)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction aggressiveCows(stalls, cows) {\n  // Write your solution here\n}\n\nconst stalls = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst cows = parseInt(next());\nconst result = aggressiveCows(stalls, cows);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int aggressiveCows(int[] stalls, int cows) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int[] stalls = new int[scanner.nextInt()];\n        for (int i = 0; i < stalls.length; i++) stalls[i] = scanner.nextInt();\n        int cows = scanner.nextInt();\n        int result = aggressiveCows(stalls, cows);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint aggressiveCows(vector<int> stalls, int cows) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int stallsN;\n    cin >> stallsN;\n    vector<int> stalls(stallsN);\n    for (int& x : stalls) cin >> x;\n    int cows;\n    cin >> cows;\n    auto result = aggressiveCows(stalls, cows);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"5\n1 2 4 8 9\n3","expected":"3"},{"input":"3\n1 2 3\n2","expected":"2"},{"input":"4\n5 17 100 11\n2","expected":"95"},{"input":"7\n56 33 30 40 39 34 25\n2","expected":"31"},{"input":"8\n22 14 11 55 1 49 27 48\n2","expected":"54"},{"input":"8\n3 42 52 37 32 11 41 47\n8","expected":"1"}]$j$::jsonb,
  $q$2 <= cows <= n <= 10^5$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon']::text[], ARRAY['binary-search-on-answer','greedy']::text[]);


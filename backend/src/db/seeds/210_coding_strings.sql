-- 210_coding_strings.sql
-- Topic: Strings (coding) -- 22 questions.
-- Idempotent: re-running updates these rows in place (matched on topic + title).
-- Requires the helpers in 010_question_helpers.sql (run in the same session by `npm run seed`).

-- 01 | easy | Valid Palindrome
SELECT pg_temp.seed_coding($q$Strings$q$, 'easy', $q$Valid Palindrome$q$, $q$A string is a palindrome if, after ignoring every character that is not a letter or digit and ignoring letter case, it reads the same forwards and backwards. Decide whether the given string is a palindrome. (The string contains no spaces; punctuation such as '-' or ',' may appear and must be ignored.)

Input Format:
- s: a single string (no spaces)

Output Format:
Print true or false (lowercase).

Example:
Input:
A-man,-a-plan,-a-canal:-Panama
Output:
true$q$,
  $q$def is_palindrome(s: str) -> bool$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef is_palindrome(s: str) -> bool:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    s = next(it)\n    result = is_palindrome(s)\n    print('true' if result else 'false')\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction isPalindrome(s) {\n  // Write your solution here\n}\n\nconst s = next();\nconst result = isPalindrome(s);\nconsole.log(result ? 'true' : 'false');\n","java":"import java.util.*;\n\npublic class Main {\n    static boolean isPalindrome(String s) {\n        // Write your solution here\n        return false;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String s = scanner.next();\n        boolean result = isPalindrome(s);\n        System.out.println(result ? \"true\" : \"false\");\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nbool isPalindrome(string s) {\n    // Write your solution here\n    return false;\n}\n\nint main() {\n    string s;\n    cin >> s;\n    auto result = isPalindrome(s);\n    cout << (result ? \"true\" : \"false\") << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"A-man,-a-plan,-a-canal:-Panama","expected":"true"},{"input":"race-a-car","expected":"false"},{"input":"-,-","expected":"true"},{"input":"cab-,cd,d","expected":"false"},{"input":"dccb-bccd","expected":"true"},{"input":"ccddcc","expected":"true"}]$j$::jsonb,
  $q$1 <= length <= 2 * 10^5$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['two-pointers']::text[]);

-- 02 | medium | Longest Substring Without Repeating Characters
SELECT pg_temp.seed_coding($q$Strings$q$, 'medium', $q$Longest Substring Without Repeating Characters$q$, $q$Given a string s, find the length of the longest substring without repeating characters.

Input Format:
- s: a single string (no spaces)

Output Format:
Print a single integer.

Example:
Input:
abcabcbb
Output:
3$q$,
  $q$def length_of_longest_substring(s: str) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef length_of_longest_substring(s: str) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    s = next(it)\n    result = length_of_longest_substring(s)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction lengthOfLongestSubstring(s) {\n  // Write your solution here\n}\n\nconst s = next();\nconst result = lengthOfLongestSubstring(s);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int lengthOfLongestSubstring(String s) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String s = scanner.next();\n        int result = lengthOfLongestSubstring(s);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint lengthOfLongestSubstring(string s) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    string s;\n    cin >> s;\n    auto result = lengthOfLongestSubstring(s);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"abcabcbb","expected":"3"},{"input":"bbbbb","expected":"1"},{"input":"pwwkew","expected":"3"},{"input":"becbdcebae","expected":"5"},{"input":"eecede","expected":"3"},{"input":"acbdadaabdb","expected":"4"}]$j$::jsonb,
  $q$1 <= length <= 5 * 10^4$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','TCS','Accenture']::text[], ARRAY['sliding-window','hashing']::text[]);

-- 03 | easy | Valid Anagram
SELECT pg_temp.seed_coding($q$Strings$q$, 'easy', $q$Valid Anagram$q$, $q$Print true if t is an anagram of s (same letters with the same counts, in any order), otherwise false.

Input Format:
- s: a single string (no spaces)
- t: a single string (no spaces)

Output Format:
Print true or false (lowercase).

Example:
Input:
anagram
nagaram
Output:
true$q$,
  $q$def is_anagram(s: str, t: str) -> bool$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef is_anagram(s: str, t: str) -> bool:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    s = next(it)\n    t = next(it)\n    result = is_anagram(s, t)\n    print('true' if result else 'false')\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction isAnagram(s, t) {\n  // Write your solution here\n}\n\nconst s = next();\nconst t = next();\nconst result = isAnagram(s, t);\nconsole.log(result ? 'true' : 'false');\n","java":"import java.util.*;\n\npublic class Main {\n    static boolean isAnagram(String s, String t) {\n        // Write your solution here\n        return false;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String s = scanner.next();\n        String t = scanner.next();\n        boolean result = isAnagram(s, t);\n        System.out.println(result ? \"true\" : \"false\");\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nbool isAnagram(string s, string t) {\n    // Write your solution here\n    return false;\n}\n\nint main() {\n    string s;\n    cin >> s;\n    string t;\n    cin >> t;\n    auto result = isAnagram(s, t);\n    cout << (result ? \"true\" : \"false\") << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"anagram\nnagaram","expected":"true"},{"input":"rat\ncar","expected":"false"},{"input":"a\nab","expected":"false"},{"input":"bbcbcb\nbbcbbc","expected":"true"},{"input":"cabb\nccab","expected":"false"},{"input":"abbcbb\nacacca","expected":"false"}]$j$::jsonb,
  $q$1 <= length <= 5 * 10^4; lowercase letters$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Infosys','Wipro']::text[], ARRAY['hashing','sorting']::text[]);

-- 04 | easy | Reverse Vowels of a String
SELECT pg_temp.seed_coding($q$Strings$q$, 'easy', $q$Reverse Vowels of a String$q$, $q$Reverse only the vowels (a, e, i, o, u in either case) of the string; all other characters stay where they are. Print the result.

Input Format:
- s: a single string (no spaces)

Output Format:
Print the resulting string.

Example:
Input:
hello
Output:
holle$q$,
  $q$def reverse_vowels(s: str) -> str$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef reverse_vowels(s: str) -> str:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    s = next(it)\n    result = reverse_vowels(s)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction reverseVowels(s) {\n  // Write your solution here\n}\n\nconst s = next();\nconst result = reverseVowels(s);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static String reverseVowels(String s) {\n        // Write your solution here\n        return \"\";\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String s = scanner.next();\n        String result = reverseVowels(s);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nstring reverseVowels(string s) {\n    // Write your solution here\n    return \"\";\n}\n\nint main() {\n    string s;\n    cin >> s;\n    auto result = reverseVowels(s);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"hello","expected":"holle"},{"input":"leetcode","expected":"leotcede"},{"input":"rhythm","expected":"rhythm"},{"input":"ziabbuia","expected":"zaibbuai"},{"input":"ieeeyaxaix","expected":"iaaeyexeix"},{"input":"xxaiboiz","expected":"xxiobiaz"}]$j$::jsonb,
  $q$1 <= length <= 3 * 10^5$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Wipro','Accenture']::text[], ARRAY['two-pointers']::text[]);

-- 05 | easy | First Unique Character
SELECT pg_temp.seed_coding($q$Strings$q$, 'easy', $q$First Unique Character$q$, $q$Print the 0-based index of the first character that appears exactly once in the string, or -1 if every character repeats.

Input Format:
- s: a single string (no spaces)

Output Format:
Print a single integer.

Example:
Input:
leetcode
Output:
0$q$,
  $q$def first_unique_char(s: str) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef first_unique_char(s: str) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    s = next(it)\n    result = first_unique_char(s)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction firstUniqueChar(s) {\n  // Write your solution here\n}\n\nconst s = next();\nconst result = firstUniqueChar(s);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int firstUniqueChar(String s) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String s = scanner.next();\n        int result = firstUniqueChar(s);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint firstUniqueChar(string s) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    string s;\n    cin >> s;\n    auto result = firstUniqueChar(s);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"leetcode","expected":"0"},{"input":"loveleetcode","expected":"2"},{"input":"aabb","expected":"-1"},{"input":"acddddc","expected":"0"},{"input":"cbca","expected":"1"},{"input":"daac","expected":"0"}]$j$::jsonb,
  $q$1 <= length <= 10^5$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['hashing']::text[]);

-- 06 | easy | Longest Common Prefix
SELECT pg_temp.seed_coding($q$Strings$q$, 'easy', $q$Longest Common Prefix$q$, $q$Find the longest prefix shared by all the strings. Print -1 if there is no common prefix.

Input Format:
- strs: an integer n, then n space-separated strings

Output Format:
Print the resulting string.

Example:
Input:
3
flower flow flight
Output:
fl$q$,
  $q$def longest_common_prefix(strs: List[str]) -> str$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef longest_common_prefix(strs: List[str]) -> str:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    strs = [next(it) for _ in range(int(next(it)))]\n    result = longest_common_prefix(strs)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction longestCommonPrefix(strs) {\n  // Write your solution here\n}\n\nconst strs = Array.from({ length: parseInt(next()) }, () => next());\nconst result = longestCommonPrefix(strs);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static String longestCommonPrefix(String[] strs) {\n        // Write your solution here\n        return \"\";\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String[] strs = new String[scanner.nextInt()];\n        for (int i = 0; i < strs.length; i++) strs[i] = scanner.next();\n        String result = longestCommonPrefix(strs);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nstring longestCommonPrefix(vector<string> strs) {\n    // Write your solution here\n    return \"\";\n}\n\nint main() {\n    int strsN;\n    cin >> strsN;\n    vector<string> strs(strsN);\n    for (string& x : strs) cin >> x;\n    auto result = longestCommonPrefix(strs);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"3\nflower flow flight","expected":"fl"},{"input":"3\ndog racecar car","expected":"-1"},{"input":"3\ninterview internet internal","expected":"inter"},{"input":"4\na ab aabb aa","expected":"a"},{"input":"2\nabccb abc","expected":"abc"},{"input":"2\nabaaa abaacc","expected":"abaa"}]$j$::jsonb,
  $q$1 <= n <= 200; lowercase letters$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['strings']::text[]);

-- 07 | easy | Isomorphic Strings
SELECT pg_temp.seed_coding($q$Strings$q$, 'easy', $q$Isomorphic Strings$q$, $q$Two strings of equal length are isomorphic if the characters of s can be replaced (consistently, one-to-one) to get t. No two different characters may map to the same character, but a character may map to itself.

Input Format:
- s: a single string (no spaces)
- t: a single string (no spaces)

Output Format:
Print true or false (lowercase).

Example:
Input:
egg
add
Output:
true$q$,
  $q$def is_isomorphic(s: str, t: str) -> bool$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef is_isomorphic(s: str, t: str) -> bool:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    s = next(it)\n    t = next(it)\n    result = is_isomorphic(s, t)\n    print('true' if result else 'false')\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction isIsomorphic(s, t) {\n  // Write your solution here\n}\n\nconst s = next();\nconst t = next();\nconst result = isIsomorphic(s, t);\nconsole.log(result ? 'true' : 'false');\n","java":"import java.util.*;\n\npublic class Main {\n    static boolean isIsomorphic(String s, String t) {\n        // Write your solution here\n        return false;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String s = scanner.next();\n        String t = scanner.next();\n        boolean result = isIsomorphic(s, t);\n        System.out.println(result ? \"true\" : \"false\");\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nbool isIsomorphic(string s, string t) {\n    // Write your solution here\n    return false;\n}\n\nint main() {\n    string s;\n    cin >> s;\n    string t;\n    cin >> t;\n    auto result = isIsomorphic(s, t);\n    cout << (result ? \"true\" : \"false\") << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"egg\nadd","expected":"true"},{"input":"foo\nbar","expected":"false"},{"input":"paper\ntitle","expected":"true"},{"input":"badc\nbaba","expected":"false"},{"input":"abbcbc\nxzxzyy","expected":"false"},{"input":"bbc\nzzy","expected":"true"},{"input":"bbbac\nyzxzy","expected":"false"}]$j$::jsonb,
  $q$1 <= length <= 5 * 10^4; equal lengths$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Infosys','Accenture']::text[], ARRAY['hashing']::text[]);

-- 08 | easy | Valid Parentheses
SELECT pg_temp.seed_coding($q$Strings$q$, 'easy', $q$Valid Parentheses$q$, $q$The string contains only the characters ( ) [ ] { }. It is valid when every bracket is closed by the same type of bracket and brackets close in the correct order. Print true or false.

Input Format:
- s: a single string (no spaces)

Output Format:
Print true or false (lowercase).

Example:
Input:
()[]{}
Output:
true$q$,
  $q$def is_valid(s: str) -> bool$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef is_valid(s: str) -> bool:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    s = next(it)\n    result = is_valid(s)\n    print('true' if result else 'false')\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction isValid(s) {\n  // Write your solution here\n}\n\nconst s = next();\nconst result = isValid(s);\nconsole.log(result ? 'true' : 'false');\n","java":"import java.util.*;\n\npublic class Main {\n    static boolean isValid(String s) {\n        // Write your solution here\n        return false;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String s = scanner.next();\n        boolean result = isValid(s);\n        System.out.println(result ? \"true\" : \"false\");\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nbool isValid(string s) {\n    // Write your solution here\n    return false;\n}\n\nint main() {\n    string s;\n    cin >> s;\n    auto result = isValid(s);\n    cout << (result ? \"true\" : \"false\") << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"()[]{}","expected":"true"},{"input":"(]","expected":"false"},{"input":"([{}])","expected":"true"},{"input":"((","expected":"false"},{"input":"(){}","expected":"true"},{"input":"}){]","expected":"false"},{"input":"(({}{})[(){}])","expected":"true"}]$j$::jsonb,
  $q$1 <= length <= 10^4$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','TCS','Infosys','Accenture']::text[], ARRAY['stack']::text[]);

-- 09 | easy | Run-Length Encoding
SELECT pg_temp.seed_coding($q$Strings$q$, 'easy', $q$Run-Length Encoding$q$, $q$Compress the string by replacing each run of identical characters with the character followed by the run length (always include the count, even when it is 1). For example, aab becomes a2b1.

Input Format:
- s: a single string (no spaces)

Output Format:
Print the resulting string.

Example:
Input:
aabcccccaaa
Output:
a2b1c5a3$q$,
  $q$def run_length_encode(s: str) -> str$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef run_length_encode(s: str) -> str:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    s = next(it)\n    result = run_length_encode(s)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction runLengthEncode(s) {\n  // Write your solution here\n}\n\nconst s = next();\nconst result = runLengthEncode(s);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static String runLengthEncode(String s) {\n        // Write your solution here\n        return \"\";\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String s = scanner.next();\n        String result = runLengthEncode(s);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nstring runLengthEncode(string s) {\n    // Write your solution here\n    return \"\";\n}\n\nint main() {\n    string s;\n    cin >> s;\n    auto result = runLengthEncode(s);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"aabcccccaaa","expected":"a2b1c5a3"},{"input":"abc","expected":"a1b1c1"},{"input":"zzzzzzzzzzzz","expected":"z12"},{"input":"aabbaaaaa","expected":"a2b2a5"},{"input":"babaabab","expected":"b1a1b1a2b1a1b1"},{"input":"aabaabaaab","expected":"a2b1a2b1a3b1"}]$j$::jsonb,
  $q$1 <= length <= 10^4$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Wipro','Accenture']::text[], ARRAY['strings']::text[]);

-- 10 | easy | Roman to Integer
SELECT pg_temp.seed_coding($q$Strings$q$, 'easy', $q$Roman to Integer$q$, $q$Convert a Roman numeral to an integer. Symbols: I=1, V=5, X=10, L=50, C=100, D=500, M=1000. A smaller symbol placed before a larger one is subtracted (IV = 4, IX = 9, XL = 40, XC = 90, CD = 400, CM = 900).

Input Format:
- s: a single string (no spaces)

Output Format:
Print a single integer.

Example:
Input:
III
Output:
3$q$,
  $q$def roman_to_int(s: str) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef roman_to_int(s: str) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    s = next(it)\n    result = roman_to_int(s)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction romanToInt(s) {\n  // Write your solution here\n}\n\nconst s = next();\nconst result = romanToInt(s);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int romanToInt(String s) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String s = scanner.next();\n        int result = romanToInt(s);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint romanToInt(string s) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    string s;\n    cin >> s;\n    auto result = romanToInt(s);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"III","expected":"3"},{"input":"LVIII","expected":"58"},{"input":"MCMXCIV","expected":"1994"},{"input":"MMCD","expected":"2400"},{"input":"MDLVIII","expected":"1558"},{"input":"MCII","expected":"1102"}]$j$::jsonb,
  $q$1 <= value <= 3999$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Infosys','Wipro']::text[], ARRAY['strings','math']::text[]);

-- 11 | medium | String to Integer (atoi)
SELECT pg_temp.seed_coding($q$Strings$q$, 'medium', $q$String to Integer (atoi)$q$, $q$Implement atoi. Read an optional '+' or '-' sign, then read digits until the first non-digit character. If no digits are read, the result is 0. Clamp the result to the signed 32-bit range [-2147483648, 2147483647].

Input Format:
- s: a single string (no spaces)

Output Format:
Print a single integer.

Example:
Input:
42
Output:
42$q$,
  $q$def my_atoi(s: str) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef my_atoi(s: str) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    s = next(it)\n    result = my_atoi(s)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction myAtoi(s) {\n  // Write your solution here\n}\n\nconst s = next();\nconst result = myAtoi(s);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int myAtoi(String s) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String s = scanner.next();\n        int result = myAtoi(s);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint myAtoi(string s) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    string s;\n    cin >> s;\n    auto result = myAtoi(s);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"42","expected":"42"},{"input":"-91283472332","expected":"-2147483648"},{"input":"4193with-words","expected":"4193"},{"input":"words987","expected":"0"},{"input":"+7","expected":"7"},{"input":"5795ab","expected":"5795"},{"input":"-1","expected":"-1"},{"input":"6074312839ab","expected":"2147483647"}]$j$::jsonb,
  $q$1 <= length <= 200; no spaces$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Accenture','Infosys']::text[], ARRAY['strings','parsing']::text[]);

-- 12 | medium | Longest Palindromic Substring Length
SELECT pg_temp.seed_coding($q$Strings$q$, 'medium', $q$Longest Palindromic Substring Length$q$, $q$Print the length of the longest palindromic substring of s.

Input Format:
- s: a single string (no spaces)

Output Format:
Print a single integer.

Example:
Input:
babad
Output:
3$q$,
  $q$def longest_palindrome_length(s: str) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef longest_palindrome_length(s: str) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    s = next(it)\n    result = longest_palindrome_length(s)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction longestPalindromeLength(s) {\n  // Write your solution here\n}\n\nconst s = next();\nconst result = longestPalindromeLength(s);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int longestPalindromeLength(String s) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String s = scanner.next();\n        int result = longestPalindromeLength(s);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint longestPalindromeLength(string s) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    string s;\n    cin >> s;\n    auto result = longestPalindromeLength(s);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"babad","expected":"3"},{"input":"cbbd","expected":"2"},{"input":"a","expected":"1"},{"input":"abccbbbcac","expected":"5"},{"input":"bbcaba","expected":"3"},{"input":"accaab","expected":"4"}]$j$::jsonb,
  $q$1 <= length <= 1000$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Accenture']::text[], ARRAY['expand-around-center','dp']::text[]);

-- 13 | medium | Group Anagrams
SELECT pg_temp.seed_coding($q$Strings$q$, 'medium', $q$Group Anagrams$q$, $q$Group the words so that words that are anagrams of each other end up together. Print the NUMBER of groups.

Input Format:
- words: an integer n, then n space-separated strings

Output Format:
Print a single integer.

Example:
Input:
6
eat tea tan ate nat bat
Output:
3$q$,
  $q$def count_anagram_groups(words: List[str]) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef count_anagram_groups(words: List[str]) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    words = [next(it) for _ in range(int(next(it)))]\n    result = count_anagram_groups(words)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction countAnagramGroups(words) {\n  // Write your solution here\n}\n\nconst words = Array.from({ length: parseInt(next()) }, () => next());\nconst result = countAnagramGroups(words);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int countAnagramGroups(String[] words) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String[] words = new String[scanner.nextInt()];\n        for (int i = 0; i < words.length; i++) words[i] = scanner.next();\n        int result = countAnagramGroups(words);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint countAnagramGroups(vector<string> words) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int wordsN;\n    cin >> wordsN;\n    vector<string> words(wordsN);\n    for (string& x : words) cin >> x;\n    auto result = countAnagramGroups(words);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"6\neat tea tan ate nat bat","expected":"3"},{"input":"1\na","expected":"1"},{"input":"6\nab ba abc cab bca x","expected":"3"},{"input":"4\naa cbc ba ba","expected":"3"},{"input":"6\ncbc aca aaa ca aba aab","expected":"5"},{"input":"8\nba bbc aa bb aa cb ca bb","expected":"6"}]$j$::jsonb,
  $q$1 <= n <= 10^4; lowercase letters$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Accenture']::text[], ARRAY['hashing','sorting']::text[]);

-- 14 | medium | Longest Repeating Character Replacement
SELECT pg_temp.seed_coding($q$Strings$q$, 'medium', $q$Longest Repeating Character Replacement$q$, $q$You may change at most k characters of the string to any uppercase letter. Print the length of the longest substring that can be made of one repeated letter.

Input Format:
- s: a single string (no spaces)
- k: a single integer

Output Format:
Print a single integer.

Example:
Input:
AABABBA
1
Output:
4$q$,
  $q$def character_replacement(s: str, k: int) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef character_replacement(s: str, k: int) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    s = next(it)\n    k = int(next(it))\n    result = character_replacement(s, k)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction characterReplacement(s, k) {\n  // Write your solution here\n}\n\nconst s = next();\nconst k = parseInt(next());\nconst result = characterReplacement(s, k);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int characterReplacement(String s, int k) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String s = scanner.next();\n        int k = scanner.nextInt();\n        int result = characterReplacement(s, k);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint characterReplacement(string s, int k) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    string s;\n    cin >> s;\n    int k;\n    cin >> k;\n    auto result = characterReplacement(s, k);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"AABABBA\n1","expected":"4"},{"input":"ABAB\n2","expected":"4"},{"input":"AAAA\n0","expected":"4"},{"input":"CAACABABCB\n3","expected":"7"},{"input":"BCAACBCC\n3","expected":"7"},{"input":"BABCBAB\n3","expected":"7"}]$j$::jsonb,
  $q$1 <= length <= 10^5; 0 <= k <= length$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon']::text[], ARRAY['sliding-window']::text[]);

-- 15 | medium | Palindromic Substrings
SELECT pg_temp.seed_coding($q$Strings$q$, 'medium', $q$Palindromic Substrings$q$, $q$Count how many substrings of s are palindromes. Substrings at different positions count separately, even if their text is identical.

Input Format:
- s: a single string (no spaces)

Output Format:
Print a single integer.

Example:
Input:
abc
Output:
3$q$,
  $q$def count_substrings(s: str) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef count_substrings(s: str) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    s = next(it)\n    result = count_substrings(s)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction countSubstrings(s) {\n  // Write your solution here\n}\n\nconst s = next();\nconst result = countSubstrings(s);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int countSubstrings(String s) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String s = scanner.next();\n        int result = countSubstrings(s);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint countSubstrings(string s) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    string s;\n    cin >> s;\n    auto result = countSubstrings(s);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"abc","expected":"3"},{"input":"aaa","expected":"6"},{"input":"abba","expected":"6"},{"input":"bbbabba","expected":"14"},{"input":"abbbaaabbba","expected":"26"},{"input":"bbaaababab","expected":"21"}]$j$::jsonb,
  $q$1 <= length <= 1000$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Accenture']::text[], ARRAY['expand-around-center']::text[]);

-- 16 | easy | Add Binary
SELECT pg_temp.seed_coding($q$Strings$q$, 'easy', $q$Add Binary$q$, $q$Add two binary numbers given as strings and print their sum as a binary string (no leading zeros except for the value 0).

Input Format:
- a: a single string (no spaces)
- b: a single string (no spaces)

Output Format:
Print the resulting string.

Example:
Input:
11
1
Output:
100$q$,
  $q$def add_binary(a: str, b: str) -> str$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef add_binary(a: str, b: str) -> str:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    a = next(it)\n    b = next(it)\n    result = add_binary(a, b)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction addBinary(a, b) {\n  // Write your solution here\n}\n\nconst a = next();\nconst b = next();\nconst result = addBinary(a, b);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static String addBinary(String a, String b) {\n        // Write your solution here\n        return \"\";\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String a = scanner.next();\n        String b = scanner.next();\n        String result = addBinary(a, b);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nstring addBinary(string a, string b) {\n    // Write your solution here\n    return \"\";\n}\n\nint main() {\n    string a;\n    cin >> a;\n    string b;\n    cin >> b;\n    auto result = addBinary(a, b);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"11\n1","expected":"100"},{"input":"1010\n1011","expected":"10101"},{"input":"0\n0","expected":"0"},{"input":"10010001\n1010001","expected":"11100010"},{"input":"101\n110110","expected":"111011"},{"input":"11010110\n10011","expected":"11101001"}]$j$::jsonb,
  $q$1 <= length <= 10^4$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Infosys','Wipro']::text[], ARRAY['math','strings']::text[]);

-- 17 | medium | Multiply Strings
SELECT pg_temp.seed_coding($q$Strings$q$, 'medium', $q$Multiply Strings$q$, $q$Multiply two non-negative integers given as decimal strings and print the product as a string. The values can be too large for built-in integer types, so simulate grade-school multiplication.

Input Format:
- num1: a single string (no spaces)
- num2: a single string (no spaces)

Output Format:
Print the resulting string.

Example:
Input:
123
456
Output:
56088$q$,
  $q$def multiply(num1: str, num2: str) -> str$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef multiply(num1: str, num2: str) -> str:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    num1 = next(it)\n    num2 = next(it)\n    result = multiply(num1, num2)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction multiply(num1, num2) {\n  // Write your solution here\n}\n\nconst num1 = next();\nconst num2 = next();\nconst result = multiply(num1, num2);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static String multiply(String num1, String num2) {\n        // Write your solution here\n        return \"\";\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String num1 = scanner.next();\n        String num2 = scanner.next();\n        String result = multiply(num1, num2);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nstring multiply(string num1, string num2) {\n    // Write your solution here\n    return \"\";\n}\n\nint main() {\n    string num1;\n    cin >> num1;\n    string num2;\n    cin >> num2;\n    auto result = multiply(num1, num2);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"123\n456","expected":"56088"},{"input":"2\n3","expected":"6"},{"input":"999999999999\n999999999999","expected":"999999999998000000000001"},{"input":"0\n12345","expected":"0"},{"input":"488037049683223\n527347112076","expected":"257364928736538979677900948"},{"input":"913181879660798\n565235630656","expected":"516162935653702656890223488"},{"input":"246516324480957\n765611321242","expected":"188735688893587078638588594"}]$j$::jsonb,
  $q$1 <= length <= 200; no leading zeros except for 0 itself$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Accenture']::text[], ARRAY['math','strings']::text[]);

-- 18 | easy | String Rotation Check
SELECT pg_temp.seed_coding($q$Strings$q$, 'easy', $q$String Rotation Check$q$, $q$Print true if string b can be obtained by rotating string a by some number of positions (for example, 'erbottlewat' is a rotation of 'waterbottle').

Input Format:
- a: a single string (no spaces)
- b: a single string (no spaces)

Output Format:
Print true or false (lowercase).

Example:
Input:
waterbottle
erbottlewat
Output:
true$q$,
  $q$def is_rotation(a: str, b: str) -> bool$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef is_rotation(a: str, b: str) -> bool:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    a = next(it)\n    b = next(it)\n    result = is_rotation(a, b)\n    print('true' if result else 'false')\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction isRotation(a, b) {\n  // Write your solution here\n}\n\nconst a = next();\nconst b = next();\nconst result = isRotation(a, b);\nconsole.log(result ? 'true' : 'false');\n","java":"import java.util.*;\n\npublic class Main {\n    static boolean isRotation(String a, String b) {\n        // Write your solution here\n        return false;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String a = scanner.next();\n        String b = scanner.next();\n        boolean result = isRotation(a, b);\n        System.out.println(result ? \"true\" : \"false\");\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nbool isRotation(string a, string b) {\n    // Write your solution here\n    return false;\n}\n\nint main() {\n    string a;\n    cin >> a;\n    string b;\n    cin >> b;\n    auto result = isRotation(a, b);\n    cout << (result ? \"true\" : \"false\") << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"waterbottle\nerbottlewat","expected":"true"},{"input":"abcd\nacbd","expected":"false"},{"input":"abc\nabcd","expected":"false"},{"input":"cbccca\ncabcba","expected":"false"},{"input":"cacc\nbbba","expected":"false"},{"input":"cacccca\nccccaca","expected":"true"}]$j$::jsonb,
  $q$1 <= length <= 10^5$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['strings']::text[]);

-- 19 | medium | Find All Anagrams in a String
SELECT pg_temp.seed_coding($q$Strings$q$, 'medium', $q$Find All Anagrams in a String$q$, $q$Print every starting index (0-based, ascending) of a substring of s that is an anagram of p. Print -1 if there is none.

Input Format:
- s: a single string (no spaces)
- p: a single string (no spaces)

Output Format:
Print the integers on one line, separated by single spaces.

Example:
Input:
cbaebabacd
abc
Output:
0 6$q$,
  $q$def find_anagrams(s: str, p: str) -> List[int]$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef find_anagrams(s: str, p: str) -> List[int]:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    s = next(it)\n    p = next(it)\n    result = find_anagrams(s, p)\n    print(' '.join(map(str, result)))\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction findAnagrams(s, p) {\n  // Write your solution here\n}\n\nconst s = next();\nconst p = next();\nconst result = findAnagrams(s, p);\nconsole.log(result.join(' '));\n","java":"import java.util.*;\n\npublic class Main {\n    static int[] findAnagrams(String s, String p) {\n        // Write your solution here\n        return new int[0];\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String s = scanner.next();\n        String p = scanner.next();\n        int[] result = findAnagrams(s, p);\n        StringBuilder sb = new StringBuilder();\n        for (int i = 0; i < result.length; i++) {\n            if (i > 0) sb.append(' ');\n            sb.append(result[i]);\n        }\n        System.out.println(sb);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nvector<int> findAnagrams(string s, string p) {\n    // Write your solution here\n    return {};\n}\n\nint main() {\n    string s;\n    cin >> s;\n    string p;\n    cin >> p;\n    auto result = findAnagrams(s, p);\n    for (size_t i = 0; i < result.size(); i++) {\n        if (i) cout << ' ';\n        cout << result[i];\n    }\n    cout << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"cbaebabacd\nabc","expected":"0 6"},{"input":"abab\nab","expected":"0 1 2"},{"input":"xyz\nab","expected":"-1"},{"input":"bcaabbbacabcc\naa","expected":"2"},{"input":"cabcbcbcbab\nbca","expected":"0 1 7"},{"input":"bbabbbbababc\naba","expected":"7"}]$j$::jsonb,
  $q$1 <= length <= 3 * 10^4$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Accenture']::text[], ARRAY['sliding-window','hashing']::text[]);

-- 20 | medium | Remove All Adjacent Duplicates
SELECT pg_temp.seed_coding($q$Strings$q$, 'medium', $q$Remove All Adjacent Duplicates$q$, $q$Repeatedly remove two equal adjacent characters until no such pair remains, then print the final string (print EMPTY if nothing is left). The result is unique regardless of removal order.

Input Format:
- s: a single string (no spaces)

Output Format:
Print the resulting string.

Example:
Input:
abbaca
Output:
ca$q$,
  $q$def remove_duplicates(s: str) -> str$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef remove_duplicates(s: str) -> str:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    s = next(it)\n    result = remove_duplicates(s)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction removeDuplicates(s) {\n  // Write your solution here\n}\n\nconst s = next();\nconst result = removeDuplicates(s);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static String removeDuplicates(String s) {\n        // Write your solution here\n        return \"\";\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String s = scanner.next();\n        String result = removeDuplicates(s);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nstring removeDuplicates(string s) {\n    // Write your solution here\n    return \"\";\n}\n\nint main() {\n    string s;\n    cin >> s;\n    auto result = removeDuplicates(s);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"abbaca","expected":"ca"},{"input":"azxxzy","expected":"ay"},{"input":"aabb","expected":"EMPTY"},{"input":"aaccbbccaa","expected":"EMPTY"},{"input":"abcaabbccca","expected":"aba"},{"input":"bcacacacba","expected":"bcacacacba"}]$j$::jsonb,
  $q$1 <= length <= 10^5$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Infosys','Accenture']::text[], ARRAY['stack']::text[]);

-- 21 | easy | Caesar Cipher
SELECT pg_temp.seed_coding($q$Strings$q$, 'easy', $q$Caesar Cipher$q$, $q$Shift every letter k positions forward in the alphabet, wrapping from z to a (and Z to A) and preserving case. Non-letter characters are unchanged.

Input Format:
- s: a single string (no spaces)
- k: a single integer

Output Format:
Print the resulting string.

Example:
Input:
Hello-World!
3
Output:
Khoor-Zruog!$q$,
  $q$def caesar_cipher(s: str, k: int) -> str$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef caesar_cipher(s: str, k: int) -> str:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    s = next(it)\n    k = int(next(it))\n    result = caesar_cipher(s, k)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction caesarCipher(s, k) {\n  // Write your solution here\n}\n\nconst s = next();\nconst k = parseInt(next());\nconst result = caesarCipher(s, k);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static String caesarCipher(String s, int k) {\n        // Write your solution here\n        return \"\";\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String s = scanner.next();\n        int k = scanner.nextInt();\n        String result = caesarCipher(s, k);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nstring caesarCipher(string s, int k) {\n    // Write your solution here\n    return \"\";\n}\n\nint main() {\n    string s;\n    cin >> s;\n    int k;\n    cin >> k;\n    auto result = caesarCipher(s, k);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"Hello-World!\n3","expected":"Khoor-Zruog!"},{"input":"xyz\n2","expected":"zab"},{"input":"Abc-123\n26","expected":"Abc-123"},{"input":"cYXcY9X9Zb\n4","expected":"gCBgC9B9Df"},{"input":"cbcaaaYYb9\n71","expected":"vuvtttRRu9"},{"input":"bX9caYaaY\n97","expected":"uQ9vtRttR"}]$j$::jsonb,
  $q$1 <= length <= 10^4; 0 <= k <= 10^6$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['strings','simulation']::text[]);

-- 22 | hard | Minimum Window Substring
SELECT pg_temp.seed_coding($q$Strings$q$, 'hard', $q$Minimum Window Substring$q$, $q$Find the shortest substring of s that contains every character of t (including duplicates). If several windows have the same minimum length, print the leftmost. Print -1 if no window exists.

Input Format:
- s: a single string (no spaces)
- t: a single string (no spaces)

Output Format:
Print the resulting string.

Example:
Input:
ADOBECODEBANC
ABC
Output:
BANC$q$,
  $q$def min_window(s: str, t: str) -> str$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef min_window(s: str, t: str) -> str:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    s = next(it)\n    t = next(it)\n    result = min_window(s, t)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction minWindow(s, t) {\n  // Write your solution here\n}\n\nconst s = next();\nconst t = next();\nconst result = minWindow(s, t);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static String minWindow(String s, String t) {\n        // Write your solution here\n        return \"\";\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String s = scanner.next();\n        String t = scanner.next();\n        String result = minWindow(s, t);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nstring minWindow(string s, string t) {\n    // Write your solution here\n    return \"\";\n}\n\nint main() {\n    string s;\n    cin >> s;\n    string t;\n    cin >> t;\n    auto result = minWindow(s, t);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"ADOBECODEBANC\nABC","expected":"BANC"},{"input":"a\na","expected":"a"},{"input":"a\naa","expected":"-1"},{"input":"aaflslflsldkalskaaa\naaa","expected":"aaa"},{"input":"CAACBACC\nAB","expected":"BA"},{"input":"ACACBBABBB\nCCA","expected":"CAC"},{"input":"CBBBCBABAAAC\nAAC","expected":"AAC"}]$j$::jsonb,
  $q$1 <= length <= 10^5; letters only$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon']::text[], ARRAY['sliding-window','hashing']::text[]);


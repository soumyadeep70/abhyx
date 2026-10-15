-- 290_coding_operating_systems.sql
-- Topic: Operating Systems (coding) -- 23 questions.
-- Idempotent: re-running updates these rows in place (matched on topic + title).
-- Requires the helpers in 010_question_helpers.sql (run in the same session by `npm run seed`).

-- 01 | easy | FCFS Scheduling: Waiting Times
SELECT pg_temp.seed_coding($q$Operating Systems$q$, 'easy', $q$FCFS Scheduling: Waiting Times$q$, $q$Simulate First-Come-First-Served (non-preemptive) CPU scheduling and print each process's waiting time in input order. Processes are numbered 0..n-1 in input order. Whenever the CPU is free and a choice must be made, ties are broken by earlier arrival time and then by lower process index. If no process has arrived, the CPU idles until the next arrival. Waiting time = turnaround time - burst time = completion time - arrival time - burst time.

Input Format:
- arrival: an integer n, then a line of n space-separated integers
- burst: an integer n, then a line of n space-separated integers

Output Format:
Print the integers on one line, separated by single spaces.

Example:
Input:
3
0 1 2
3
5 3 8
Output:
0 4 6$q$,
  $q$def fcfs_waiting_times(arrival: List[int], burst: List[int]) -> List[int]$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef fcfs_waiting_times(arrival: List[int], burst: List[int]) -> List[int]:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    arrival = [int(next(it)) for _ in range(int(next(it)))]\n    burst = [int(next(it)) for _ in range(int(next(it)))]\n    result = fcfs_waiting_times(arrival, burst)\n    print(' '.join(map(str, result)))\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction fcfsWaitingTimes(arrival, burst) {\n  // Write your solution here\n}\n\nconst arrival = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst burst = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst result = fcfsWaitingTimes(arrival, burst);\nconsole.log(result.join(' '));\n","java":"import java.util.*;\n\npublic class Main {\n    static int[] fcfsWaitingTimes(int[] arrival, int[] burst) {\n        // Write your solution here\n        return new int[0];\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int[] arrival = new int[scanner.nextInt()];\n        for (int i = 0; i < arrival.length; i++) arrival[i] = scanner.nextInt();\n        int[] burst = new int[scanner.nextInt()];\n        for (int i = 0; i < burst.length; i++) burst[i] = scanner.nextInt();\n        int[] result = fcfsWaitingTimes(arrival, burst);\n        StringBuilder sb = new StringBuilder();\n        for (int i = 0; i < result.length; i++) {\n            if (i > 0) sb.append(' ');\n            sb.append(result[i]);\n        }\n        System.out.println(sb);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nvector<int> fcfsWaitingTimes(vector<int> arrival, vector<int> burst) {\n    // Write your solution here\n    return {};\n}\n\nint main() {\n    int arrivalN;\n    cin >> arrivalN;\n    vector<int> arrival(arrivalN);\n    for (int& x : arrival) cin >> x;\n    int burstN;\n    cin >> burstN;\n    vector<int> burst(burstN);\n    for (int& x : burst) cin >> x;\n    auto result = fcfsWaitingTimes(arrival, burst);\n    for (size_t i = 0; i < result.size(); i++) {\n        if (i) cout << ' ';\n        cout << result[i];\n    }\n    cout << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"3\n0 1 2\n3\n5 3 8","expected":"0 4 6"},{"input":"3\n0 0 0\n3\n24 3 3","expected":"0 24 27"},{"input":"2\n5 0\n2\n2 4","expected":"0 0"},{"input":"5\n6 6 6 0 7\n5\n9 2 5 6 1","expected":"0 9 11 0 15"},{"input":"5\n0 2 7 3 0\n5\n4 4 4 8 9","expected":"0 11 18 14 4"},{"input":"3\n3 6 0\n3\n4 5 8","expected":"5 6 0"}]$j$::jsonb,
  $q$1 <= n <= 100$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['cpu-scheduling','fcfs']::text[]);

-- 02 | medium | SJF (Non-Preemptive) Scheduling: Waiting Times
SELECT pg_temp.seed_coding($q$Operating Systems$q$, 'medium', $q$SJF (Non-Preemptive) Scheduling: Waiting Times$q$, $q$Simulate non-preemptive Shortest-Job-First scheduling: whenever the CPU is free, run the arrived process with the smallest burst time to completion. Print every process's waiting time in input order. Processes are numbered 0..n-1 in input order. Whenever the CPU is free and a choice must be made, ties are broken by earlier arrival time and then by lower process index. If no process has arrived, the CPU idles until the next arrival. Waiting time = turnaround time - burst time = completion time - arrival time - burst time.

Input Format:
- arrival: an integer n, then a line of n space-separated integers
- burst: an integer n, then a line of n space-separated integers

Output Format:
Print the integers on one line, separated by single spaces.

Example:
Input:
4
0 1 2 3
4
7 4 1 4
Output:
0 7 5 9$q$,
  $q$def sjf_waiting_times(arrival: List[int], burst: List[int]) -> List[int]$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef sjf_waiting_times(arrival: List[int], burst: List[int]) -> List[int]:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    arrival = [int(next(it)) for _ in range(int(next(it)))]\n    burst = [int(next(it)) for _ in range(int(next(it)))]\n    result = sjf_waiting_times(arrival, burst)\n    print(' '.join(map(str, result)))\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction sjfWaitingTimes(arrival, burst) {\n  // Write your solution here\n}\n\nconst arrival = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst burst = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst result = sjfWaitingTimes(arrival, burst);\nconsole.log(result.join(' '));\n","java":"import java.util.*;\n\npublic class Main {\n    static int[] sjfWaitingTimes(int[] arrival, int[] burst) {\n        // Write your solution here\n        return new int[0];\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int[] arrival = new int[scanner.nextInt()];\n        for (int i = 0; i < arrival.length; i++) arrival[i] = scanner.nextInt();\n        int[] burst = new int[scanner.nextInt()];\n        for (int i = 0; i < burst.length; i++) burst[i] = scanner.nextInt();\n        int[] result = sjfWaitingTimes(arrival, burst);\n        StringBuilder sb = new StringBuilder();\n        for (int i = 0; i < result.length; i++) {\n            if (i > 0) sb.append(' ');\n            sb.append(result[i]);\n        }\n        System.out.println(sb);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nvector<int> sjfWaitingTimes(vector<int> arrival, vector<int> burst) {\n    // Write your solution here\n    return {};\n}\n\nint main() {\n    int arrivalN;\n    cin >> arrivalN;\n    vector<int> arrival(arrivalN);\n    for (int& x : arrival) cin >> x;\n    int burstN;\n    cin >> burstN;\n    vector<int> burst(burstN);\n    for (int& x : burst) cin >> x;\n    auto result = sjfWaitingTimes(arrival, burst);\n    for (size_t i = 0; i < result.size(); i++) {\n        if (i) cout << ' ';\n        cout << result[i];\n    }\n    cout << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"4\n0 1 2 3\n4\n7 4 1 4","expected":"0 7 5 9"},{"input":"3\n0 0 0\n3\n6 8 7","expected":"0 13 6"},{"input":"2\n3 0\n2\n2 9","expected":"6 0"},{"input":"6\n2 2 2 8 3 4\n6\n5 1 8 4 6 3","expected":"1 0 19 3 12 4"},{"input":"5\n4 0 1 6 6\n5\n2 7 8 6 6","expected":"3 0 20 3 9"},{"input":"4\n4 4 2 1\n4\n7 3 8 8","expected":"8 5 17 0"}]$j$::jsonb,
  $q$1 <= n <= 100$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['cpu-scheduling','sjf']::text[]);

-- 03 | medium | Priority Scheduling: Waiting Times
SELECT pg_temp.seed_coding($q$Operating Systems$q$, 'medium', $q$Priority Scheduling: Waiting Times$q$, $q$Simulate NON-preemptive priority scheduling where a SMALLER number means a HIGHER priority: when the CPU is free, run the arrived process with the best priority to completion. Print each process's waiting time in input order. Processes are numbered 0..n-1 in input order. Whenever the CPU is free and a choice must be made, ties are broken by earlier arrival time and then by lower process index. If no process has arrived, the CPU idles until the next arrival. Waiting time = turnaround time - burst time = completion time - arrival time - burst time.

Input Format:
- arrival: an integer n, then a line of n space-separated integers
- burst: an integer n, then a line of n space-separated integers
- priority: an integer n, then a line of n space-separated integers

Output Format:
Print the integers on one line, separated by single spaces.

Example:
Input:
5
0 0 0 0 0
5
10 1 2 1 5
5
3 1 4 5 2
Output:
6 0 16 18 1$q$,
  $q$def priority_waiting_times(arrival: List[int], burst: List[int], priority: List[int]) -> List[int]$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef priority_waiting_times(arrival: List[int], burst: List[int], priority: List[int]) -> List[int]:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    arrival = [int(next(it)) for _ in range(int(next(it)))]\n    burst = [int(next(it)) for _ in range(int(next(it)))]\n    priority = [int(next(it)) for _ in range(int(next(it)))]\n    result = priority_waiting_times(arrival, burst, priority)\n    print(' '.join(map(str, result)))\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction priorityWaitingTimes(arrival, burst, priority) {\n  // Write your solution here\n}\n\nconst arrival = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst burst = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst priority = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst result = priorityWaitingTimes(arrival, burst, priority);\nconsole.log(result.join(' '));\n","java":"import java.util.*;\n\npublic class Main {\n    static int[] priorityWaitingTimes(int[] arrival, int[] burst, int[] priority) {\n        // Write your solution here\n        return new int[0];\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int[] arrival = new int[scanner.nextInt()];\n        for (int i = 0; i < arrival.length; i++) arrival[i] = scanner.nextInt();\n        int[] burst = new int[scanner.nextInt()];\n        for (int i = 0; i < burst.length; i++) burst[i] = scanner.nextInt();\n        int[] priority = new int[scanner.nextInt()];\n        for (int i = 0; i < priority.length; i++) priority[i] = scanner.nextInt();\n        int[] result = priorityWaitingTimes(arrival, burst, priority);\n        StringBuilder sb = new StringBuilder();\n        for (int i = 0; i < result.length; i++) {\n            if (i > 0) sb.append(' ');\n            sb.append(result[i]);\n        }\n        System.out.println(sb);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nvector<int> priorityWaitingTimes(vector<int> arrival, vector<int> burst, vector<int> priority) {\n    // Write your solution here\n    return {};\n}\n\nint main() {\n    int arrivalN;\n    cin >> arrivalN;\n    vector<int> arrival(arrivalN);\n    for (int& x : arrival) cin >> x;\n    int burstN;\n    cin >> burstN;\n    vector<int> burst(burstN);\n    for (int& x : burst) cin >> x;\n    int priorityN;\n    cin >> priorityN;\n    vector<int> priority(priorityN);\n    for (int& x : priority) cin >> x;\n    auto result = priorityWaitingTimes(arrival, burst, priority);\n    for (size_t i = 0; i < result.size(); i++) {\n        if (i) cout << ' ';\n        cout << result[i];\n    }\n    cout << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"5\n0 0 0 0 0\n5\n10 1 2 1 5\n5\n3 1 4 5 2","expected":"6 0 16 18 1"},{"input":"2\n0 2\n2\n4 3\n2\n2 1","expected":"0 2"},{"input":"1\n1\n1\n5\n1\n1","expected":"0"},{"input":"4\n4 2 2 3\n4\n1 5 8 6\n4\n1 4 1 5","expected":"6 9 0 13"},{"input":"4\n5 4 0 0\n4\n9 6 6 7\n4\n1 1 4 4","expected":"7 2 0 21"},{"input":"3\n8 0 7\n3\n6 8 2\n3\n2 5 4","expected":"0 0 7"}]$j$::jsonb,
  $q$1 <= n <= 100$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['cpu-scheduling','priority']::text[]);

-- 04 | hard | SRTF (Preemptive SJF) Scheduling: Waiting Times
SELECT pg_temp.seed_coding($q$Operating Systems$q$, 'hard', $q$SRTF (Preemptive SJF) Scheduling: Waiting Times$q$, $q$Simulate Shortest-Remaining-Time-First: at every time unit, run the arrived process with the smallest REMAINING burst time (a newly arrived shorter job preempts the running one). Print each process's waiting time in input order. Processes are numbered 0..n-1 in input order. Whenever the CPU is free and a choice must be made, ties are broken by earlier arrival time and then by lower process index. If no process has arrived, the CPU idles until the next arrival. Waiting time = turnaround time - burst time = completion time - arrival time - burst time.

Input Format:
- arrival: an integer n, then a line of n space-separated integers
- burst: an integer n, then a line of n space-separated integers

Output Format:
Print the integers on one line, separated by single spaces.

Example:
Input:
4
0 1 2 3
4
8 4 9 5
Output:
9 0 15 2$q$,
  $q$def srtf_waiting_times(arrival: List[int], burst: List[int]) -> List[int]$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef srtf_waiting_times(arrival: List[int], burst: List[int]) -> List[int]:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    arrival = [int(next(it)) for _ in range(int(next(it)))]\n    burst = [int(next(it)) for _ in range(int(next(it)))]\n    result = srtf_waiting_times(arrival, burst)\n    print(' '.join(map(str, result)))\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction srtfWaitingTimes(arrival, burst) {\n  // Write your solution here\n}\n\nconst arrival = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst burst = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst result = srtfWaitingTimes(arrival, burst);\nconsole.log(result.join(' '));\n","java":"import java.util.*;\n\npublic class Main {\n    static int[] srtfWaitingTimes(int[] arrival, int[] burst) {\n        // Write your solution here\n        return new int[0];\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int[] arrival = new int[scanner.nextInt()];\n        for (int i = 0; i < arrival.length; i++) arrival[i] = scanner.nextInt();\n        int[] burst = new int[scanner.nextInt()];\n        for (int i = 0; i < burst.length; i++) burst[i] = scanner.nextInt();\n        int[] result = srtfWaitingTimes(arrival, burst);\n        StringBuilder sb = new StringBuilder();\n        for (int i = 0; i < result.length; i++) {\n            if (i > 0) sb.append(' ');\n            sb.append(result[i]);\n        }\n        System.out.println(sb);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nvector<int> srtfWaitingTimes(vector<int> arrival, vector<int> burst) {\n    // Write your solution here\n    return {};\n}\n\nint main() {\n    int arrivalN;\n    cin >> arrivalN;\n    vector<int> arrival(arrivalN);\n    for (int& x : arrival) cin >> x;\n    int burstN;\n    cin >> burstN;\n    vector<int> burst(burstN);\n    for (int& x : burst) cin >> x;\n    auto result = srtfWaitingTimes(arrival, burst);\n    for (size_t i = 0; i < result.size(); i++) {\n        if (i) cout << ' ';\n        cout << result[i];\n    }\n    cout << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"4\n0 1 2 3\n4\n8 4 9 5","expected":"9 0 15 2"},{"input":"3\n0 2 4\n3\n7 4 1","expected":"5 1 0"},{"input":"1\n2\n1\n3","expected":"0"},{"input":"5\n0 7 2 6 7\n5\n8 1 8 7 6","expected":"0 1 20 9 2"},{"input":"3\n4 0 5\n3\n6 4 7","expected":"0 0 5"},{"input":"3\n4 6 2\n3\n6 4 4","expected":"6 0 0"}]$j$::jsonb,
  $q$1 <= n <= 100$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Infosys','Accenture']::text[], ARRAY['cpu-scheduling','srtf','preemptive']::text[]);

-- 05 | hard | Round Robin Scheduling: Waiting Times
SELECT pg_temp.seed_coding($q$Operating Systems$q$, 'hard', $q$Round Robin Scheduling: Waiting Times$q$, $q$Simulate Round Robin with the given time quantum. The ready queue is FIFO. A process that arrives while another is running (or exactly when its slice ends) joins the queue BEFORE the preempted process is put back at the tail. Print every process's waiting time in input order. Processes are numbered 0..n-1 in input order. Whenever the CPU is free and a choice must be made, ties are broken by earlier arrival time and then by lower process index. If no process has arrived, the CPU idles until the next arrival. Waiting time = turnaround time - burst time = completion time - arrival time - burst time.

Input Format:
- quantum: a single integer
- arrival: an integer n, then a line of n space-separated integers
- burst: an integer n, then a line of n space-separated integers

Output Format:
Print the integers on one line, separated by single spaces.

Example:
Input:
4
3
0 0 0
3
24 3 3
Output:
6 4 7$q$,
  $q$def round_robin_waiting_times(quantum: int, arrival: List[int], burst: List[int]) -> List[int]$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef round_robin_waiting_times(quantum: int, arrival: List[int], burst: List[int]) -> List[int]:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    quantum = int(next(it))\n    arrival = [int(next(it)) for _ in range(int(next(it)))]\n    burst = [int(next(it)) for _ in range(int(next(it)))]\n    result = round_robin_waiting_times(quantum, arrival, burst)\n    print(' '.join(map(str, result)))\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction roundRobinWaitingTimes(quantum, arrival, burst) {\n  // Write your solution here\n}\n\nconst quantum = parseInt(next());\nconst arrival = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst burst = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst result = roundRobinWaitingTimes(quantum, arrival, burst);\nconsole.log(result.join(' '));\n","java":"import java.util.*;\n\npublic class Main {\n    static int[] roundRobinWaitingTimes(int quantum, int[] arrival, int[] burst) {\n        // Write your solution here\n        return new int[0];\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int quantum = scanner.nextInt();\n        int[] arrival = new int[scanner.nextInt()];\n        for (int i = 0; i < arrival.length; i++) arrival[i] = scanner.nextInt();\n        int[] burst = new int[scanner.nextInt()];\n        for (int i = 0; i < burst.length; i++) burst[i] = scanner.nextInt();\n        int[] result = roundRobinWaitingTimes(quantum, arrival, burst);\n        StringBuilder sb = new StringBuilder();\n        for (int i = 0; i < result.length; i++) {\n            if (i > 0) sb.append(' ');\n            sb.append(result[i]);\n        }\n        System.out.println(sb);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nvector<int> roundRobinWaitingTimes(int quantum, vector<int> arrival, vector<int> burst) {\n    // Write your solution here\n    return {};\n}\n\nint main() {\n    int quantum;\n    cin >> quantum;\n    int arrivalN;\n    cin >> arrivalN;\n    vector<int> arrival(arrivalN);\n    for (int& x : arrival) cin >> x;\n    int burstN;\n    cin >> burstN;\n    vector<int> burst(burstN);\n    for (int& x : burst) cin >> x;\n    auto result = roundRobinWaitingTimes(quantum, arrival, burst);\n    for (size_t i = 0; i < result.size(); i++) {\n        if (i) cout << ' ';\n        cout << result[i];\n    }\n    cout << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"4\n3\n0 0 0\n3\n24 3 3","expected":"6 4 7"},{"input":"2\n4\n0 1 2 3\n4\n5 3 1 2","expected":"6 6 2 4"},{"input":"3\n1\n0\n1\n7","expected":"0"},{"input":"2\n4\n3 2 8 2\n4\n5 5 3 3","expected":"10 9 6 6"},{"input":"1\n6\n0 2 4 2 4 4\n6\n8 2 4 3 6 4","expected":"18 2 13 10 17 15"},{"input":"2\n5\n2 0 6 4 8\n5\n7 9 2 3 1","expected":"12 13 4 9 6"}]$j$::jsonb,
  $q$1 <= quantum <= 100; 1 <= n <= 100$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['cpu-scheduling','round-robin','queue']::text[]);

-- 06 | easy | FIFO Page Replacement: Page Faults
SELECT pg_temp.seed_coding($q$Operating Systems$q$, 'easy', $q$FIFO Page Replacement: Page Faults$q$, $q$Memory has the given number of frames, initially empty. Process the page reference string with FIFO replacement (evict the page that has been in memory the longest) and print the number of page faults.

Input Format:
- frames: a single integer
- pages: an integer n, then a line of n space-separated integers

Output Format:
Print a single integer.

Example:
Input:
3
20
7 0 1 2 0 3 0 4 2 3 0 3 2 1 2 0 1 7 0 1
Output:
15$q$,
  $q$def fifo_page_faults(frames: int, pages: List[int]) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef fifo_page_faults(frames: int, pages: List[int]) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    frames = int(next(it))\n    pages = [int(next(it)) for _ in range(int(next(it)))]\n    result = fifo_page_faults(frames, pages)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction fifoPageFaults(frames, pages) {\n  // Write your solution here\n}\n\nconst frames = parseInt(next());\nconst pages = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst result = fifoPageFaults(frames, pages);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int fifoPageFaults(int frames, int[] pages) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int frames = scanner.nextInt();\n        int[] pages = new int[scanner.nextInt()];\n        for (int i = 0; i < pages.length; i++) pages[i] = scanner.nextInt();\n        int result = fifoPageFaults(frames, pages);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint fifoPageFaults(int frames, vector<int> pages) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int frames;\n    cin >> frames;\n    int pagesN;\n    cin >> pagesN;\n    vector<int> pages(pagesN);\n    for (int& x : pages) cin >> x;\n    auto result = fifoPageFaults(frames, pages);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"3\n20\n7 0 1 2 0 3 0 4 2 3 0 3 2 1 2 0 1 7 0 1","expected":"15"},{"input":"3\n12\n1 2 3 4 1 2 5 1 2 3 4 5","expected":"9"},{"input":"4\n12\n1 2 3 4 1 2 5 1 2 3 4 5","expected":"10"},{"input":"2\n13\n0 6 0 0 3 4 3 1 2 1 2 4 6","expected":"8"},{"input":"2\n14\n4 5 1 0 0 6 2 3 1 5 1 6 2 2","expected":"11"},{"input":"2\n14\n0 3 4 3 2 0 1 3 2 6 3 6 5 1","expected":"12"}]$j$::jsonb,
  $q$1 <= frames <= 10; 1 <= n <= 1000$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['page-replacement','fifo']::text[]);

-- 07 | medium | LRU Page Replacement: Page Faults
SELECT pg_temp.seed_coding($q$Operating Systems$q$, 'medium', $q$LRU Page Replacement: Page Faults$q$, $q$Same setup as FIFO page replacement but evict the LEAST RECENTLY USED page. Print the number of page faults.

Input Format:
- frames: a single integer
- pages: an integer n, then a line of n space-separated integers

Output Format:
Print a single integer.

Example:
Input:
3
20
7 0 1 2 0 3 0 4 2 3 0 3 2 1 2 0 1 7 0 1
Output:
12$q$,
  $q$def lru_page_faults(frames: int, pages: List[int]) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef lru_page_faults(frames: int, pages: List[int]) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    frames = int(next(it))\n    pages = [int(next(it)) for _ in range(int(next(it)))]\n    result = lru_page_faults(frames, pages)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction lruPageFaults(frames, pages) {\n  // Write your solution here\n}\n\nconst frames = parseInt(next());\nconst pages = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst result = lruPageFaults(frames, pages);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int lruPageFaults(int frames, int[] pages) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int frames = scanner.nextInt();\n        int[] pages = new int[scanner.nextInt()];\n        for (int i = 0; i < pages.length; i++) pages[i] = scanner.nextInt();\n        int result = lruPageFaults(frames, pages);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint lruPageFaults(int frames, vector<int> pages) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int frames;\n    cin >> frames;\n    int pagesN;\n    cin >> pagesN;\n    vector<int> pages(pagesN);\n    for (int& x : pages) cin >> x;\n    auto result = lruPageFaults(frames, pages);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"3\n20\n7 0 1 2 0 3 0 4 2 3 0 3 2 1 2 0 1 7 0 1","expected":"12"},{"input":"4\n12\n1 2 3 4 1 2 5 1 2 3 4 5","expected":"8"},{"input":"1\n3\n1 1 2","expected":"2"},{"input":"2\n12\n2 0 1 1 6 1 1 0 0 3 1 1","expected":"7"},{"input":"4\n15\n2 6 5 5 3 3 5 4 1 1 4 2 0 1 3","expected":"9"},{"input":"2\n13\n0 2 0 0 1 5 2 3 3 3 1 6 3","expected":"9"}]$j$::jsonb,
  $q$1 <= frames <= 10; 1 <= n <= 1000$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['page-replacement','lru']::text[]);

-- 08 | medium | Optimal Page Replacement: Page Faults
SELECT pg_temp.seed_coding($q$Operating Systems$q$, 'medium', $q$Optimal Page Replacement: Page Faults$q$, $q$Simulate the OPTIMAL (Belady's MIN) policy: on a fault with full memory, evict the page whose next use lies farthest in the future (or never occurs again). Print the number of page faults.

Input Format:
- frames: a single integer
- pages: an integer n, then a line of n space-separated integers

Output Format:
Print a single integer.

Example:
Input:
3
20
7 0 1 2 0 3 0 4 2 3 0 3 2 1 2 0 1 7 0 1
Output:
9$q$,
  $q$def optimal_page_faults(frames: int, pages: List[int]) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef optimal_page_faults(frames: int, pages: List[int]) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    frames = int(next(it))\n    pages = [int(next(it)) for _ in range(int(next(it)))]\n    result = optimal_page_faults(frames, pages)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction optimalPageFaults(frames, pages) {\n  // Write your solution here\n}\n\nconst frames = parseInt(next());\nconst pages = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst result = optimalPageFaults(frames, pages);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int optimalPageFaults(int frames, int[] pages) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int frames = scanner.nextInt();\n        int[] pages = new int[scanner.nextInt()];\n        for (int i = 0; i < pages.length; i++) pages[i] = scanner.nextInt();\n        int result = optimalPageFaults(frames, pages);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint optimalPageFaults(int frames, vector<int> pages) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int frames;\n    cin >> frames;\n    int pagesN;\n    cin >> pagesN;\n    vector<int> pages(pagesN);\n    for (int& x : pages) cin >> x;\n    auto result = optimalPageFaults(frames, pages);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"3\n20\n7 0 1 2 0 3 0 4 2 3 0 3 2 1 2 0 1 7 0 1","expected":"9"},{"input":"4\n12\n1 2 3 4 1 2 5 1 2 3 4 5","expected":"6"},{"input":"2\n4\n1 2 1 2","expected":"2"},{"input":"2\n11\n6 1 3 0 6 1 5 3 4 0 1","expected":"9"},{"input":"3\n11\n1 5 4 3 0 1 1 6 6 2 1","expected":"7"},{"input":"2\n11\n3 3 6 6 5 2 0 0 0 0 1","expected":"6"}]$j$::jsonb,
  $q$1 <= frames <= 10; 1 <= n <= 1000$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Infosys','Accenture']::text[], ARRAY['page-replacement','optimal']::text[]);

-- 09 | medium | Detect Belady's Anomaly
SELECT pg_temp.seed_coding($q$Operating Systems$q$, 'medium', $q$Detect Belady's Anomaly$q$, $q$Under FIFO replacement, giving a process MORE frames can sometimes cause MORE page faults (Belady's anomaly). For frame counts 1, 2, ..., maxFrames, compute the FIFO fault count of the reference string; print true if the fault count for some f + 1 frames is strictly greater than for f frames (with f + 1 <= maxFrames), otherwise false.

Input Format:
- pages: an integer n, then a line of n space-separated integers
- max_frames: a single integer

Output Format:
Print true or false (lowercase).

Example:
Input:
12
1 2 3 4 1 2 5 1 2 3 4 5
4
Output:
true$q$,
  $q$def has_beladys_anomaly(pages: List[int], max_frames: int) -> bool$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef has_beladys_anomaly(pages: List[int], max_frames: int) -> bool:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    pages = [int(next(it)) for _ in range(int(next(it)))]\n    max_frames = int(next(it))\n    result = has_beladys_anomaly(pages, max_frames)\n    print('true' if result else 'false')\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction hasBeladysAnomaly(pages, max_frames) {\n  // Write your solution here\n}\n\nconst pages = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst max_frames = parseInt(next());\nconst result = hasBeladysAnomaly(pages, max_frames);\nconsole.log(result ? 'true' : 'false');\n","java":"import java.util.*;\n\npublic class Main {\n    static boolean hasBeladysAnomaly(int[] pages, int max_frames) {\n        // Write your solution here\n        return false;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int[] pages = new int[scanner.nextInt()];\n        for (int i = 0; i < pages.length; i++) pages[i] = scanner.nextInt();\n        int max_frames = scanner.nextInt();\n        boolean result = hasBeladysAnomaly(pages, max_frames);\n        System.out.println(result ? \"true\" : \"false\");\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nbool hasBeladysAnomaly(vector<int> pages, int max_frames) {\n    // Write your solution here\n    return false;\n}\n\nint main() {\n    int pagesN;\n    cin >> pagesN;\n    vector<int> pages(pagesN);\n    for (int& x : pages) cin >> x;\n    int max_frames;\n    cin >> max_frames;\n    auto result = hasBeladysAnomaly(pages, max_frames);\n    cout << (result ? \"true\" : \"false\") << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"12\n1 2 3 4 1 2 5 1 2 3 4 5\n4","expected":"true"},{"input":"12\n1 2 3 4 1 2 5 1 2 3 4 5\n3","expected":"false"},{"input":"8\n7 0 1 2 0 3 0 4\n4","expected":"false"},{"input":"14\n2 5 2 0 3 0 3 4 2 0 4 4 3 1\n4","expected":"false"},{"input":"12\n3 5 4 1 1 4 3 0 4 4 3 4\n3","expected":"false"},{"input":"14\n2 0 4 5 4 1 3 2 1 5 0 1 5 4\n4","expected":"false"}]$j$::jsonb,
  $q$1 <= maxFrames <= 10; 1 <= n <= 1000$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Infosys','Accenture']::text[], ARRAY['page-replacement','fifo','belady']::text[]);

-- 10 | hard | Banker's Algorithm: Safe Sequence
SELECT pg_temp.seed_coding($q$Operating Systems$q$, 'hard', $q$Banker's Algorithm: Safe Sequence$q$, $q$Given the available vector, the current Allocation matrix and the Max matrix (n processes x m resource types), decide whether the system is in a safe state. Build the safe sequence by repeatedly choosing the SMALLEST-INDEX unfinished process whose remaining Need (Max - Allocation) is <= Work, then adding its Allocation back to Work. Print the sequence of process indices, or -1 if the system is unsafe.

Input Format:
- available: an integer n, then a line of n space-separated integers
- allocation: two integers r and c, then r lines of c space-separated integers
- max_need: two integers r and c, then r lines of c space-separated integers

Output Format:
Print the integers on one line, separated by single spaces.

Example:
Input:
3
3 3 2
5 3
0 1 0
2 0 0
3 0 2
2 1 1
0 0 2
5 3
7 5 3
3 2 2
9 0 2
2 2 2
4 3 3
Output:
1 3 0 2 4$q$,
  $q$def safe_sequence(available: List[int], allocation: List[List[int]], max_need: List[List[int]]) -> List[int]$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef safe_sequence(available: List[int], allocation: List[List[int]], max_need: List[List[int]]) -> List[int]:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    available = [int(next(it)) for _ in range(int(next(it)))]\n    rows, cols = int(next(it)), int(next(it))\n    allocation = [[int(next(it)) for _ in range(cols)] for _ in range(rows)]\n    rows, cols = int(next(it)), int(next(it))\n    max_need = [[int(next(it)) for _ in range(cols)] for _ in range(rows)]\n    result = safe_sequence(available, allocation, max_need)\n    print(' '.join(map(str, result)))\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction safeSequence(available, allocation, max_need) {\n  // Write your solution here\n}\n\nconst available = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst allocationRows = parseInt(next());\nconst allocationCols = parseInt(next());\nconst allocation = Array.from({ length: allocationRows }, () => Array.from({ length: allocationCols }, () => parseInt(next())));\nconst max_needRows = parseInt(next());\nconst max_needCols = parseInt(next());\nconst max_need = Array.from({ length: max_needRows }, () => Array.from({ length: max_needCols }, () => parseInt(next())));\nconst result = safeSequence(available, allocation, max_need);\nconsole.log(result.join(' '));\n","java":"import java.util.*;\n\npublic class Main {\n    static int[] safeSequence(int[] available, int[][] allocation, int[][] max_need) {\n        // Write your solution here\n        return new int[0];\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int[] available = new int[scanner.nextInt()];\n        for (int i = 0; i < available.length; i++) available[i] = scanner.nextInt();\n        int allocationRows = scanner.nextInt(), allocationCols = scanner.nextInt();\n        int[][] allocation = new int[allocationRows][allocationCols];\n        for (int i = 0; i < allocationRows; i++)\n            for (int j = 0; j < allocationCols; j++) allocation[i][j] = scanner.nextInt();\n        int max_needRows = scanner.nextInt(), max_needCols = scanner.nextInt();\n        int[][] max_need = new int[max_needRows][max_needCols];\n        for (int i = 0; i < max_needRows; i++)\n            for (int j = 0; j < max_needCols; j++) max_need[i][j] = scanner.nextInt();\n        int[] result = safeSequence(available, allocation, max_need);\n        StringBuilder sb = new StringBuilder();\n        for (int i = 0; i < result.length; i++) {\n            if (i > 0) sb.append(' ');\n            sb.append(result[i]);\n        }\n        System.out.println(sb);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nvector<int> safeSequence(vector<int> available, vector<vector<int>> allocation, vector<vector<int>> max_need) {\n    // Write your solution here\n    return {};\n}\n\nint main() {\n    int availableN;\n    cin >> availableN;\n    vector<int> available(availableN);\n    for (int& x : available) cin >> x;\n    int allocationRows, allocationCols;\n    cin >> allocationRows >> allocationCols;\n    vector<vector<int>> allocation(allocationRows, vector<int>(allocationCols));\n    for (auto& row : allocation) for (int& x : row) cin >> x;\n    int max_needRows, max_needCols;\n    cin >> max_needRows >> max_needCols;\n    vector<vector<int>> max_need(max_needRows, vector<int>(max_needCols));\n    for (auto& row : max_need) for (int& x : row) cin >> x;\n    auto result = safeSequence(available, allocation, max_need);\n    for (size_t i = 0; i < result.size(); i++) {\n        if (i) cout << ' ';\n        cout << result[i];\n    }\n    cout << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"3\n3 3 2\n5 3\n0 1 0\n2 0 0\n3 0 2\n2 1 1\n0 0 2\n5 3\n7 5 3\n3 2 2\n9 0 2\n2 2 2\n4 3 3","expected":"1 3 0 2 4"},{"input":"3\n0 0 0\n2 3\n1 0 0\n0 1 0\n2 3\n2 0 0\n0 2 0","expected":"-1"},{"input":"1\n1\n2 1\n1\n1\n2 1\n1\n2","expected":"0 1"},{"input":"3\n1 0 0\n3 3\n0 3 3\n2 1 2\n0 2 3\n3 3\n3 5 5\n4 5 4\n3 2 4","expected":"-1"},{"input":"3\n2 3 2\n3 3\n0 1 3\n3 3 0\n0 1 2\n3 3\n2 2 4\n4 3 4\n1 4 5","expected":"0 1 2"},{"input":"3\n2 4 3\n4 3\n2 3 2\n3 0 1\n0 1 1\n2 2 1\n4 3\n3 4 4\n5 0 4\n2 5 4\n2 2 1","expected":"0 1 2 3"}]$j$::jsonb,
  $q$1 <= n <= 100; 1 <= m <= 20$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Infosys','Accenture']::text[], ARRAY['deadlock','bankers-algorithm']::text[]);

-- 11 | medium | Deadlock Detection (Wait-For Graph)
SELECT pg_temp.seed_coding($q$Operating Systems$q$, 'medium', $q$Deadlock Detection (Wait-For Graph)$q$, $q$With single-instance resources, a deadlock exists exactly when the wait-for graph has a cycle. There are n processes (0..n-1) and each row [a, b] means process a is waiting for a resource held by process b. Print true if the system is deadlocked.

Input Format:
- n: a single integer
- waits: two integers r and c, then r lines of c space-separated integers

Output Format:
Print true or false (lowercase).

Example:
Input:
3
3 2
0 1
1 2
2 0
Output:
true$q$,
  $q$def has_deadlock(n: int, waits: List[List[int]]) -> bool$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef has_deadlock(n: int, waits: List[List[int]]) -> bool:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    n = int(next(it))\n    rows, cols = int(next(it)), int(next(it))\n    waits = [[int(next(it)) for _ in range(cols)] for _ in range(rows)]\n    result = has_deadlock(n, waits)\n    print('true' if result else 'false')\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction hasDeadlock(n, waits) {\n  // Write your solution here\n}\n\nconst n = parseInt(next());\nconst waitsRows = parseInt(next());\nconst waitsCols = parseInt(next());\nconst waits = Array.from({ length: waitsRows }, () => Array.from({ length: waitsCols }, () => parseInt(next())));\nconst result = hasDeadlock(n, waits);\nconsole.log(result ? 'true' : 'false');\n","java":"import java.util.*;\n\npublic class Main {\n    static boolean hasDeadlock(int n, int[][] waits) {\n        // Write your solution here\n        return false;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int n = scanner.nextInt();\n        int waitsRows = scanner.nextInt(), waitsCols = scanner.nextInt();\n        int[][] waits = new int[waitsRows][waitsCols];\n        for (int i = 0; i < waitsRows; i++)\n            for (int j = 0; j < waitsCols; j++) waits[i][j] = scanner.nextInt();\n        boolean result = hasDeadlock(n, waits);\n        System.out.println(result ? \"true\" : \"false\");\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nbool hasDeadlock(int n, vector<vector<int>> waits) {\n    // Write your solution here\n    return false;\n}\n\nint main() {\n    int n;\n    cin >> n;\n    int waitsRows, waitsCols;\n    cin >> waitsRows >> waitsCols;\n    vector<vector<int>> waits(waitsRows, vector<int>(waitsCols));\n    for (auto& row : waits) for (int& x : row) cin >> x;\n    auto result = hasDeadlock(n, waits);\n    cout << (result ? \"true\" : \"false\") << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"3\n3 2\n0 1\n1 2\n2 0","expected":"true"},{"input":"3\n2 2\n0 1\n1 2","expected":"false"},{"input":"2\n1 2\n0 0","expected":"true"},{"input":"6\n3 2\n3 1\n4 3\n1 0","expected":"false"},{"input":"6\n3 2\n5 1\n4 0\n3 0","expected":"false"},{"input":"5\n5 2\n2 3\n4 2\n2 4\n3 4\n3 1","expected":"true"}]$j$::jsonb,
  $q$1 <= n <= 1000$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['deadlock','graph','cycle-detection']::text[]);

-- 12 | easy | First Fit Memory Allocation
SELECT pg_temp.seed_coding($q$Operating Systems$q$, 'easy', $q$First Fit Memory Allocation$q$, $q$Memory is split into variable partitions (blocks) with the given sizes. Each process, in order, is placed in the FIRST block (lowest index) that is large enough, and that block shrinks by the process size. Print the block index chosen for every process, or -1 if no block fits.

Input Format:
- blocks: an integer n, then a line of n space-separated integers
- processes: an integer n, then a line of n space-separated integers

Output Format:
Print the integers on one line, separated by single spaces.

Example:
Input:
5
100 500 200 300 600
4
212 417 112 426
Output:
1 4 1 -1$q$,
  $q$def first_fit(blocks: List[int], processes: List[int]) -> List[int]$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef first_fit(blocks: List[int], processes: List[int]) -> List[int]:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    blocks = [int(next(it)) for _ in range(int(next(it)))]\n    processes = [int(next(it)) for _ in range(int(next(it)))]\n    result = first_fit(blocks, processes)\n    print(' '.join(map(str, result)))\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction firstFit(blocks, processes) {\n  // Write your solution here\n}\n\nconst blocks = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst processes = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst result = firstFit(blocks, processes);\nconsole.log(result.join(' '));\n","java":"import java.util.*;\n\npublic class Main {\n    static int[] firstFit(int[] blocks, int[] processes) {\n        // Write your solution here\n        return new int[0];\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int[] blocks = new int[scanner.nextInt()];\n        for (int i = 0; i < blocks.length; i++) blocks[i] = scanner.nextInt();\n        int[] processes = new int[scanner.nextInt()];\n        for (int i = 0; i < processes.length; i++) processes[i] = scanner.nextInt();\n        int[] result = firstFit(blocks, processes);\n        StringBuilder sb = new StringBuilder();\n        for (int i = 0; i < result.length; i++) {\n            if (i > 0) sb.append(' ');\n            sb.append(result[i]);\n        }\n        System.out.println(sb);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nvector<int> firstFit(vector<int> blocks, vector<int> processes) {\n    // Write your solution here\n    return {};\n}\n\nint main() {\n    int blocksN;\n    cin >> blocksN;\n    vector<int> blocks(blocksN);\n    for (int& x : blocks) cin >> x;\n    int processesN;\n    cin >> processesN;\n    vector<int> processes(processesN);\n    for (int& x : processes) cin >> x;\n    auto result = firstFit(blocks, processes);\n    for (size_t i = 0; i < result.size(); i++) {\n        if (i) cout << ' ';\n        cout << result[i];\n    }\n    cout << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"5\n100 500 200 300 600\n4\n212 417 112 426","expected":"1 4 1 -1"},{"input":"1\n10\n1\n20","expected":"-1"},{"input":"2\n50 50\n3\n30 30 30","expected":"0 1 -1"},{"input":"4\n550 400 350 300\n4\n160 120 120 80","expected":"0 0 0 0"},{"input":"4\n400 550 300 50\n4\n320 320 80 40","expected":"0 1 0 1"},{"input":"4\n200 350 350 400\n4\n120 280 320 160","expected":"0 1 2 3"}]$j$::jsonb,
  $q$1 <= n, m <= 100$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['memory-management','first-fit']::text[]);

-- 13 | medium | Best Fit Memory Allocation
SELECT pg_temp.seed_coding($q$Operating Systems$q$, 'medium', $q$Best Fit Memory Allocation$q$, $q$As in First Fit, but each process goes to the block that leaves the SMALLEST leftover space (the smallest block that still fits; lowest index on ties). Print the block index chosen for every process, or -1 if none fits.

Input Format:
- blocks: an integer n, then a line of n space-separated integers
- processes: an integer n, then a line of n space-separated integers

Output Format:
Print the integers on one line, separated by single spaces.

Example:
Input:
5
100 500 200 300 600
4
212 417 112 426
Output:
3 1 2 4$q$,
  $q$def best_fit(blocks: List[int], processes: List[int]) -> List[int]$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef best_fit(blocks: List[int], processes: List[int]) -> List[int]:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    blocks = [int(next(it)) for _ in range(int(next(it)))]\n    processes = [int(next(it)) for _ in range(int(next(it)))]\n    result = best_fit(blocks, processes)\n    print(' '.join(map(str, result)))\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction bestFit(blocks, processes) {\n  // Write your solution here\n}\n\nconst blocks = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst processes = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst result = bestFit(blocks, processes);\nconsole.log(result.join(' '));\n","java":"import java.util.*;\n\npublic class Main {\n    static int[] bestFit(int[] blocks, int[] processes) {\n        // Write your solution here\n        return new int[0];\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int[] blocks = new int[scanner.nextInt()];\n        for (int i = 0; i < blocks.length; i++) blocks[i] = scanner.nextInt();\n        int[] processes = new int[scanner.nextInt()];\n        for (int i = 0; i < processes.length; i++) processes[i] = scanner.nextInt();\n        int[] result = bestFit(blocks, processes);\n        StringBuilder sb = new StringBuilder();\n        for (int i = 0; i < result.length; i++) {\n            if (i > 0) sb.append(' ');\n            sb.append(result[i]);\n        }\n        System.out.println(sb);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nvector<int> bestFit(vector<int> blocks, vector<int> processes) {\n    // Write your solution here\n    return {};\n}\n\nint main() {\n    int blocksN;\n    cin >> blocksN;\n    vector<int> blocks(blocksN);\n    for (int& x : blocks) cin >> x;\n    int processesN;\n    cin >> processesN;\n    vector<int> processes(processesN);\n    for (int& x : processes) cin >> x;\n    auto result = bestFit(blocks, processes);\n    for (size_t i = 0; i < result.size(); i++) {\n        if (i) cout << ' ';\n        cout << result[i];\n    }\n    cout << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"5\n100 500 200 300 600\n4\n212 417 112 426","expected":"3 1 2 4"},{"input":"1\n10\n1\n20","expected":"-1"},{"input":"2\n50 50\n3\n30 30 30","expected":"0 1 -1"},{"input":"6\n350 200 250 500 500 150\n5\n120 160 120 80 320","expected":"5 1 2 2 0"},{"input":"6\n250 350 100 200 600 300\n5\n240 120 40 280 200","expected":"0 3 3 5 1"},{"input":"5\n450 350 450 300 450\n3\n160 80 80","expected":"3 3 1"}]$j$::jsonb,
  $q$1 <= n, m <= 100$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['memory-management','best-fit']::text[]);

-- 14 | medium | Worst Fit Memory Allocation
SELECT pg_temp.seed_coding($q$Operating Systems$q$, 'medium', $q$Worst Fit Memory Allocation$q$, $q$As in First Fit, but each process goes to the LARGEST block that still fits it (lowest index on ties). Print the block index chosen for every process, or -1 if none fits.

Input Format:
- blocks: an integer n, then a line of n space-separated integers
- processes: an integer n, then a line of n space-separated integers

Output Format:
Print the integers on one line, separated by single spaces.

Example:
Input:
5
100 500 200 300 600
4
212 417 112 426
Output:
4 1 4 -1$q$,
  $q$def worst_fit(blocks: List[int], processes: List[int]) -> List[int]$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef worst_fit(blocks: List[int], processes: List[int]) -> List[int]:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    blocks = [int(next(it)) for _ in range(int(next(it)))]\n    processes = [int(next(it)) for _ in range(int(next(it)))]\n    result = worst_fit(blocks, processes)\n    print(' '.join(map(str, result)))\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction worstFit(blocks, processes) {\n  // Write your solution here\n}\n\nconst blocks = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst processes = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst result = worstFit(blocks, processes);\nconsole.log(result.join(' '));\n","java":"import java.util.*;\n\npublic class Main {\n    static int[] worstFit(int[] blocks, int[] processes) {\n        // Write your solution here\n        return new int[0];\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int[] blocks = new int[scanner.nextInt()];\n        for (int i = 0; i < blocks.length; i++) blocks[i] = scanner.nextInt();\n        int[] processes = new int[scanner.nextInt()];\n        for (int i = 0; i < processes.length; i++) processes[i] = scanner.nextInt();\n        int[] result = worstFit(blocks, processes);\n        StringBuilder sb = new StringBuilder();\n        for (int i = 0; i < result.length; i++) {\n            if (i > 0) sb.append(' ');\n            sb.append(result[i]);\n        }\n        System.out.println(sb);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nvector<int> worstFit(vector<int> blocks, vector<int> processes) {\n    // Write your solution here\n    return {};\n}\n\nint main() {\n    int blocksN;\n    cin >> blocksN;\n    vector<int> blocks(blocksN);\n    for (int& x : blocks) cin >> x;\n    int processesN;\n    cin >> processesN;\n    vector<int> processes(processesN);\n    for (int& x : processes) cin >> x;\n    auto result = worstFit(blocks, processes);\n    for (size_t i = 0; i < result.size(); i++) {\n        if (i) cout << ' ';\n        cout << result[i];\n    }\n    cout << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"5\n100 500 200 300 600\n4\n212 417 112 426","expected":"4 1 4 -1"},{"input":"1\n10\n1\n20","expected":"-1"},{"input":"2\n50 50\n3\n30 30 30","expected":"0 1 -1"},{"input":"4\n200 200 100 250\n5\n120 200 120 160 120","expected":"3 0 1 -1 3"},{"input":"4\n400 400 350 450\n5\n120 280 160 160 280","expected":"3 0 1 2 3"},{"input":"6\n250 450 50 150 50 550\n5\n280 40 200 160 80","expected":"5 1 1 5 0"}]$j$::jsonb,
  $q$1 <= n, m <= 100$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['memory-management','worst-fit']::text[]);

-- 15 | easy | Paging: Logical to Physical Address
SELECT pg_temp.seed_coding($q$Operating Systems$q$, 'easy', $q$Paging: Logical to Physical Address$q$, $q$page_table[p] is the frame that holds logical page p, or -1 if the page is not in memory. For each logical address print the physical address (frame * pageSize + offset), or -1 if the page is not resident or the page number is outside the table.

Input Format:
- page_size: a single integer
- page_table: an integer n, then a line of n space-separated integers
- addresses: an integer n, then a line of n space-separated integers

Output Format:
Print the integers on one line, separated by single spaces.

Example:
Input:
100
3
5 2 7
3
250 120 20
Output:
750 220 520$q$,
  $q$def translate_addresses(page_size: int, page_table: List[int], addresses: List[int]) -> List[int]$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef translate_addresses(page_size: int, page_table: List[int], addresses: List[int]) -> List[int]:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    page_size = int(next(it))\n    page_table = [int(next(it)) for _ in range(int(next(it)))]\n    addresses = [int(next(it)) for _ in range(int(next(it)))]\n    result = translate_addresses(page_size, page_table, addresses)\n    print(' '.join(map(str, result)))\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction translateAddresses(page_size, page_table, addresses) {\n  // Write your solution here\n}\n\nconst page_size = parseInt(next());\nconst page_table = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst addresses = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst result = translateAddresses(page_size, page_table, addresses);\nconsole.log(result.join(' '));\n","java":"import java.util.*;\n\npublic class Main {\n    static int[] translateAddresses(int page_size, int[] page_table, int[] addresses) {\n        // Write your solution here\n        return new int[0];\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int page_size = scanner.nextInt();\n        int[] page_table = new int[scanner.nextInt()];\n        for (int i = 0; i < page_table.length; i++) page_table[i] = scanner.nextInt();\n        int[] addresses = new int[scanner.nextInt()];\n        for (int i = 0; i < addresses.length; i++) addresses[i] = scanner.nextInt();\n        int[] result = translateAddresses(page_size, page_table, addresses);\n        StringBuilder sb = new StringBuilder();\n        for (int i = 0; i < result.length; i++) {\n            if (i > 0) sb.append(' ');\n            sb.append(result[i]);\n        }\n        System.out.println(sb);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nvector<int> translateAddresses(int page_size, vector<int> page_table, vector<int> addresses) {\n    // Write your solution here\n    return {};\n}\n\nint main() {\n    int page_size;\n    cin >> page_size;\n    int page_tableN;\n    cin >> page_tableN;\n    vector<int> page_table(page_tableN);\n    for (int& x : page_table) cin >> x;\n    int addressesN;\n    cin >> addressesN;\n    vector<int> addresses(addressesN);\n    for (int& x : addresses) cin >> x;\n    auto result = translateAddresses(page_size, page_table, addresses);\n    for (size_t i = 0; i < result.size(); i++) {\n        if (i) cout << ' ';\n        cout << result[i];\n    }\n    cout << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"100\n3\n5 2 7\n3\n250 120 20","expected":"750 220 520"},{"input":"64\n2\n3 -1\n3\n70 10 200","expected":"-1 202 -1"},{"input":"16\n1\n0\n1\n0","expected":"0"},{"input":"256\n4\n-1 1 6 9\n4\n932 1231 543 703","expected":"2468 -1 1567 1727"},{"input":"32\n3\n3 -1 1\n4\n76 73 134 178","expected":"44 41 -1 -1"},{"input":"16\n4\n9 -1 -1 -1\n4\n10 1 36 88","expected":"154 145 -1 -1"}]$j$::jsonb,
  $q$1 <= pageSize <= 10^4$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['paging','address-translation']::text[]);

-- 16 | easy | Single-Level Page Table Size
SELECT pg_temp.seed_coding($q$Operating Systems$q$, 'easy', $q$Single-Level Page Table Size$q$, $q$A system has a virtual address of the given number of bits, a page size in bytes (always a power of two) and a page-table entry of pteBytes bytes. Print the size in BYTES of a single-level page table that has one entry for every virtual page.

Input Format:
- address_bits: a single integer
- page_size: a single integer
- pte_bytes: a single integer

Output Format:
Print a single integer.

Example:
Input:
32
4096
4
Output:
4194304$q$,
  $q$def page_table_bytes(address_bits: int, page_size: int, pte_bytes: int) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef page_table_bytes(address_bits: int, page_size: int, pte_bytes: int) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    address_bits = int(next(it))\n    page_size = int(next(it))\n    pte_bytes = int(next(it))\n    result = page_table_bytes(address_bits, page_size, pte_bytes)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction pageTableBytes(address_bits, page_size, pte_bytes) {\n  // Write your solution here\n}\n\nconst address_bits = parseInt(next());\nconst page_size = parseInt(next());\nconst pte_bytes = parseInt(next());\nconst result = pageTableBytes(address_bits, page_size, pte_bytes);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int pageTableBytes(int address_bits, int page_size, int pte_bytes) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int address_bits = scanner.nextInt();\n        int page_size = scanner.nextInt();\n        int pte_bytes = scanner.nextInt();\n        int result = pageTableBytes(address_bits, page_size, pte_bytes);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint pageTableBytes(int address_bits, int page_size, int pte_bytes) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int address_bits;\n    cin >> address_bits;\n    int page_size;\n    cin >> page_size;\n    int pte_bytes;\n    cin >> pte_bytes;\n    auto result = pageTableBytes(address_bits, page_size, pte_bytes);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"32\n4096\n4","expected":"4194304"},{"input":"16\n1024\n2","expected":"128"},{"input":"24\n256\n4","expected":"262144"},{"input":"22\n4096\n8","expected":"8192"},{"input":"27\n16384\n8","expected":"65536"},{"input":"22\n8192\n4","expected":"2048"}]$j$::jsonb,
  $q$pageSize <= 2^addressBits; the result fits in 32 bits$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['paging','virtual-memory']::text[]);

-- 17 | easy | Effective Memory Access Time with a TLB
SELECT pg_temp.seed_coding($q$Operating Systems$q$, 'easy', $q$Effective Memory Access Time with a TLB$q$, $q$A single-level page table is cached in a TLB. A TLB hit costs tlb + mem nanoseconds; a miss costs tlb + 2 * mem (one extra memory access for the page table). Given the TLB hit ratio as a percentage, print the effective memory access time in nanoseconds. All test values give a whole number.

Input Format:
- hit_percent: a single integer
- tlb_ns: a single integer
- mem_ns: a single integer

Output Format:
Print a single integer.

Example:
Input:
80
20
100
Output:
140$q$,
  $q$def effective_access_time(hit_percent: int, tlb_ns: int, mem_ns: int) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef effective_access_time(hit_percent: int, tlb_ns: int, mem_ns: int) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    hit_percent = int(next(it))\n    tlb_ns = int(next(it))\n    mem_ns = int(next(it))\n    result = effective_access_time(hit_percent, tlb_ns, mem_ns)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction effectiveAccessTime(hit_percent, tlb_ns, mem_ns) {\n  // Write your solution here\n}\n\nconst hit_percent = parseInt(next());\nconst tlb_ns = parseInt(next());\nconst mem_ns = parseInt(next());\nconst result = effectiveAccessTime(hit_percent, tlb_ns, mem_ns);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int effectiveAccessTime(int hit_percent, int tlb_ns, int mem_ns) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int hit_percent = scanner.nextInt();\n        int tlb_ns = scanner.nextInt();\n        int mem_ns = scanner.nextInt();\n        int result = effectiveAccessTime(hit_percent, tlb_ns, mem_ns);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint effectiveAccessTime(int hit_percent, int tlb_ns, int mem_ns) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int hit_percent;\n    cin >> hit_percent;\n    int tlb_ns;\n    cin >> tlb_ns;\n    int mem_ns;\n    cin >> mem_ns;\n    auto result = effectiveAccessTime(hit_percent, tlb_ns, mem_ns);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"80\n20\n100","expected":"140"},{"input":"100\n10\n50","expected":"60"},{"input":"50\n0\n200","expected":"300"},{"input":"60\n50\n200","expected":"330"},{"input":"50\n50\n120","expected":"230"},{"input":"80\n10\n100","expected":"130"}]$j$::jsonb,
  $q$0 <= hitPercent <= 100$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['paging','tlb']::text[]);

-- 18 | medium | Direct-Mapped Cache Simulation
SELECT pg_temp.seed_coding($q$Operating Systems$q$, 'medium', $q$Direct-Mapped Cache Simulation$q$, $q$A direct-mapped cache has numLines lines, each holding one block of blockSize bytes; the cache starts empty. Block number = address / blockSize (integer division), line = block mod numLines, tag = block / numLines. A request hits when its line holds the same tag; otherwise the block replaces the line. Print the number of hits for the sequence of byte addresses.

Input Format:
- num_lines: a single integer
- block_size: a single integer
- addresses: an integer n, then a line of n space-separated integers

Output Format:
Print a single integer.

Example:
Input:
4
4
8
0 4 8 12 0 4 16 0
Output:
2$q$,
  $q$def cache_hits(num_lines: int, block_size: int, addresses: List[int]) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef cache_hits(num_lines: int, block_size: int, addresses: List[int]) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    num_lines = int(next(it))\n    block_size = int(next(it))\n    addresses = [int(next(it)) for _ in range(int(next(it)))]\n    result = cache_hits(num_lines, block_size, addresses)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction cacheHits(num_lines, block_size, addresses) {\n  // Write your solution here\n}\n\nconst num_lines = parseInt(next());\nconst block_size = parseInt(next());\nconst addresses = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst result = cacheHits(num_lines, block_size, addresses);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int cacheHits(int num_lines, int block_size, int[] addresses) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int num_lines = scanner.nextInt();\n        int block_size = scanner.nextInt();\n        int[] addresses = new int[scanner.nextInt()];\n        for (int i = 0; i < addresses.length; i++) addresses[i] = scanner.nextInt();\n        int result = cacheHits(num_lines, block_size, addresses);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint cacheHits(int num_lines, int block_size, vector<int> addresses) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int num_lines;\n    cin >> num_lines;\n    int block_size;\n    cin >> block_size;\n    int addressesN;\n    cin >> addressesN;\n    vector<int> addresses(addressesN);\n    for (int& x : addresses) cin >> x;\n    auto result = cacheHits(num_lines, block_size, addresses);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"4\n4\n8\n0 4 8 12 0 4 16 0","expected":"2"},{"input":"2\n8\n4\n0 1 2 3","expected":"3"},{"input":"1\n1\n4\n5 5 6 6","expected":"2"},{"input":"4\n2\n14\n40 23 52 24 13 24 6 46 44 0 29 35 49 41","expected":"1"},{"input":"8\n4\n14\n10 33 57 37 24 22 33 8 56 24 19 46 60 8","expected":"3"},{"input":"8\n4\n9\n25 31 60 47 62 22 28 53 3","expected":"1"}]$j$::jsonb,
  $q$1 <= n <= 10^5$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Infosys','Accenture']::text[], ARRAY['cache','computer-organization']::text[]);

-- 19 | easy | Disk Scheduling: FCFS Head Movement
SELECT pg_temp.seed_coding($q$Operating Systems$q$, 'easy', $q$Disk Scheduling: FCFS Head Movement$q$, $q$The disk head starts at the given track. Serve the requests in arrival order (FCFS) and print the total head movement (sum of absolute track differences).

Input Format:
- head: a single integer
- requests: an integer n, then a line of n space-separated integers

Output Format:
Print a single integer.

Example:
Input:
53
8
98 183 37 122 14 124 65 67
Output:
640$q$,
  $q$def fcfs_head_movement(head: int, requests: List[int]) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef fcfs_head_movement(head: int, requests: List[int]) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    head = int(next(it))\n    requests = [int(next(it)) for _ in range(int(next(it)))]\n    result = fcfs_head_movement(head, requests)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction fcfsHeadMovement(head, requests) {\n  // Write your solution here\n}\n\nconst head = parseInt(next());\nconst requests = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst result = fcfsHeadMovement(head, requests);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int fcfsHeadMovement(int head, int[] requests) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int head = scanner.nextInt();\n        int[] requests = new int[scanner.nextInt()];\n        for (int i = 0; i < requests.length; i++) requests[i] = scanner.nextInt();\n        int result = fcfsHeadMovement(head, requests);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint fcfsHeadMovement(int head, vector<int> requests) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int head;\n    cin >> head;\n    int requestsN;\n    cin >> requestsN;\n    vector<int> requests(requestsN);\n    for (int& x : requests) cin >> x;\n    auto result = fcfsHeadMovement(head, requests);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"53\n8\n98 183 37 122 14 124 65 67","expected":"640"},{"input":"0\n1\n10","expected":"10"},{"input":"50\n2\n50 50","expected":"0"},{"input":"54\n5\n58 185 186 58 97","expected":"299"},{"input":"35\n7\n110 97 115 154 149 199 192","expected":"207"},{"input":"93\n7\n12 156 153 30 112 72 143","expected":"544"}]$j$::jsonb,
  $q$1 <= n <= 1000; tracks are non-negative$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['disk-scheduling','fcfs']::text[]);

-- 20 | medium | Disk Scheduling: SSTF Head Movement
SELECT pg_temp.seed_coding($q$Operating Systems$q$, 'medium', $q$Disk Scheduling: SSTF Head Movement$q$, $q$Shortest-Seek-Time-First: from the current head position always serve the pending request with the smallest seek distance (on a tie choose the lower track). Print the total head movement.

Input Format:
- head: a single integer
- requests: an integer n, then a line of n space-separated integers

Output Format:
Print a single integer.

Example:
Input:
53
8
98 183 37 122 14 124 65 67
Output:
236$q$,
  $q$def sstf_head_movement(head: int, requests: List[int]) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef sstf_head_movement(head: int, requests: List[int]) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    head = int(next(it))\n    requests = [int(next(it)) for _ in range(int(next(it)))]\n    result = sstf_head_movement(head, requests)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction sstfHeadMovement(head, requests) {\n  // Write your solution here\n}\n\nconst head = parseInt(next());\nconst requests = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst result = sstfHeadMovement(head, requests);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int sstfHeadMovement(int head, int[] requests) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int head = scanner.nextInt();\n        int[] requests = new int[scanner.nextInt()];\n        for (int i = 0; i < requests.length; i++) requests[i] = scanner.nextInt();\n        int result = sstfHeadMovement(head, requests);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint sstfHeadMovement(int head, vector<int> requests) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int head;\n    cin >> head;\n    int requestsN;\n    cin >> requestsN;\n    vector<int> requests(requestsN);\n    for (int& x : requests) cin >> x;\n    auto result = sstfHeadMovement(head, requests);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"53\n8\n98 183 37 122 14 124 65 67","expected":"236"},{"input":"10\n2\n8 12","expected":"6"},{"input":"0\n1\n5","expected":"5"},{"input":"65\n4\n104 150 65 156","expected":"91"},{"input":"76\n8\n136 117 78 90 15 120 74 137","expected":"187"},{"input":"6\n4\n94 106 32 104","expected":"100"}]$j$::jsonb,
  $q$1 <= n <= 1000$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['disk-scheduling','sstf']::text[]);

-- 21 | medium | Disk Scheduling: SCAN Head Movement
SELECT pg_temp.seed_coding($q$Operating Systems$q$, 'medium', $q$Disk Scheduling: SCAN Head Movement$q$, $q$SCAN (elevator): the head moves in its initial direction (1 = towards higher tracks, 0 = towards lower tracks) serving requests on the way, travels ALL the way to the end of the disk (track diskSize - 1 or track 0), then reverses and serves the remaining requests, stopping at the last request. Print the total head movement.

Input Format:
- head: a single integer
- requests: an integer n, then a line of n space-separated integers
- disk_size: a single integer
- direction: a single integer

Output Format:
Print a single integer.

Example:
Input:
53
8
98 183 37 122 14 124 65 67
200
0
Output:
236$q$,
  $q$def scan_head_movement(head: int, requests: List[int], disk_size: int, direction: int) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef scan_head_movement(head: int, requests: List[int], disk_size: int, direction: int) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    head = int(next(it))\n    requests = [int(next(it)) for _ in range(int(next(it)))]\n    disk_size = int(next(it))\n    direction = int(next(it))\n    result = scan_head_movement(head, requests, disk_size, direction)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction scanHeadMovement(head, requests, disk_size, direction) {\n  // Write your solution here\n}\n\nconst head = parseInt(next());\nconst requests = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst disk_size = parseInt(next());\nconst direction = parseInt(next());\nconst result = scanHeadMovement(head, requests, disk_size, direction);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int scanHeadMovement(int head, int[] requests, int disk_size, int direction) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int head = scanner.nextInt();\n        int[] requests = new int[scanner.nextInt()];\n        for (int i = 0; i < requests.length; i++) requests[i] = scanner.nextInt();\n        int disk_size = scanner.nextInt();\n        int direction = scanner.nextInt();\n        int result = scanHeadMovement(head, requests, disk_size, direction);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint scanHeadMovement(int head, vector<int> requests, int disk_size, int direction) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int head;\n    cin >> head;\n    int requestsN;\n    cin >> requestsN;\n    vector<int> requests(requestsN);\n    for (int& x : requests) cin >> x;\n    int disk_size;\n    cin >> disk_size;\n    int direction;\n    cin >> direction;\n    auto result = scanHeadMovement(head, requests, disk_size, direction);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"53\n8\n98 183 37 122 14 124 65 67\n200\n0","expected":"236"},{"input":"53\n8\n98 183 37 122 14 124 65 67\n200\n1","expected":"331"},{"input":"10\n1\n5\n50\n1","expected":"83"},{"input":"36\n6\n84 42 59 178 114 194\n200\n0","expected":"230"},{"input":"80\n6\n2 108 38 47 146 85\n200\n1","expected":"316"},{"input":"61\n5\n116 27 3 161 82\n200\n0","expected":"222"}]$j$::jsonb,
  $q$1 <= n <= 1000; 0 <= track < diskSize$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Infosys','Accenture']::text[], ARRAY['disk-scheduling','scan','elevator']::text[]);

-- 22 | medium | Disk Scheduling: LOOK Head Movement
SELECT pg_temp.seed_coding($q$Operating Systems$q$, 'medium', $q$Disk Scheduling: LOOK Head Movement$q$, $q$LOOK is SCAN without the trip to the disk edge: the head serves requests in its initial direction (1 = up, 0 = down) as far as the last request in that direction, then reverses and serves the rest. Print the total head movement.

Input Format:
- head: a single integer
- requests: an integer n, then a line of n space-separated integers
- direction: a single integer

Output Format:
Print a single integer.

Example:
Input:
53
8
98 183 37 122 14 124 65 67
0
Output:
208$q$,
  $q$def look_head_movement(head: int, requests: List[int], direction: int) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef look_head_movement(head: int, requests: List[int], direction: int) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    head = int(next(it))\n    requests = [int(next(it)) for _ in range(int(next(it)))]\n    direction = int(next(it))\n    result = look_head_movement(head, requests, direction)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction lookHeadMovement(head, requests, direction) {\n  // Write your solution here\n}\n\nconst head = parseInt(next());\nconst requests = Array.from({ length: parseInt(next()) }, () => parseInt(next()));\nconst direction = parseInt(next());\nconst result = lookHeadMovement(head, requests, direction);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int lookHeadMovement(int head, int[] requests, int direction) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int head = scanner.nextInt();\n        int[] requests = new int[scanner.nextInt()];\n        for (int i = 0; i < requests.length; i++) requests[i] = scanner.nextInt();\n        int direction = scanner.nextInt();\n        int result = lookHeadMovement(head, requests, direction);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint lookHeadMovement(int head, vector<int> requests, int direction) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int head;\n    cin >> head;\n    int requestsN;\n    cin >> requestsN;\n    vector<int> requests(requestsN);\n    for (int& x : requests) cin >> x;\n    int direction;\n    cin >> direction;\n    auto result = lookHeadMovement(head, requests, direction);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"53\n8\n98 183 37 122 14 124 65 67\n0","expected":"208"},{"input":"53\n8\n98 183 37 122 14 124 65 67\n1","expected":"299"},{"input":"10\n1\n5\n1","expected":"5"},{"input":"62\n6\n53 36 102 3 36 43\n1","expected":"139"},{"input":"9\n5\n33 134 180 95 67\n0","expected":"171"},{"input":"78\n6\n2 35 19 145 19 108\n1","expected":"210"}]$j$::jsonb,
  $q$1 <= n <= 1000$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Infosys','Accenture']::text[], ARRAY['disk-scheduling','look']::text[]);

-- 23 | easy | Bounded Buffer (Producer-Consumer)
SELECT pg_temp.seed_coding($q$Operating Systems$q$, 'easy', $q$Bounded Buffer (Producer-Consumer)$q$, $q$A bounded buffer holds at most capacity items. Each operation is P (a producer tries to add an item) or C (a consumer tries to remove one). A P on a full buffer and a C on an empty buffer are REJECTED (they change nothing and count as failed). Print the final number of items and the number of failed operations.

Input Format:
- capacity: a single integer
- ops: an integer n, then n space-separated strings

Output Format:
Print the integers on one line, separated by single spaces.

Example:
Input:
2
6
P P P C C C
Output:
0 2$q$,
  $q$def bounded_buffer(capacity: int, ops: List[str]) -> List[int]$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef bounded_buffer(capacity: int, ops: List[str]) -> List[int]:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    capacity = int(next(it))\n    ops = [next(it) for _ in range(int(next(it)))]\n    result = bounded_buffer(capacity, ops)\n    print(' '.join(map(str, result)))\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction boundedBuffer(capacity, ops) {\n  // Write your solution here\n}\n\nconst capacity = parseInt(next());\nconst ops = Array.from({ length: parseInt(next()) }, () => next());\nconst result = boundedBuffer(capacity, ops);\nconsole.log(result.join(' '));\n","java":"import java.util.*;\n\npublic class Main {\n    static int[] boundedBuffer(int capacity, String[] ops) {\n        // Write your solution here\n        return new int[0];\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int capacity = scanner.nextInt();\n        String[] ops = new String[scanner.nextInt()];\n        for (int i = 0; i < ops.length; i++) ops[i] = scanner.next();\n        int[] result = boundedBuffer(capacity, ops);\n        StringBuilder sb = new StringBuilder();\n        for (int i = 0; i < result.length; i++) {\n            if (i > 0) sb.append(' ');\n            sb.append(result[i]);\n        }\n        System.out.println(sb);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nvector<int> boundedBuffer(int capacity, vector<string> ops) {\n    // Write your solution here\n    return {};\n}\n\nint main() {\n    int capacity;\n    cin >> capacity;\n    int opsN;\n    cin >> opsN;\n    vector<string> ops(opsN);\n    for (string& x : ops) cin >> x;\n    auto result = boundedBuffer(capacity, ops);\n    for (size_t i = 0; i < result.size(); i++) {\n        if (i) cout << ' ';\n        cout << result[i];\n    }\n    cout << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"2\n6\nP P P C C C","expected":"0 2"},{"input":"1\n4\nC P P C","expected":"0 2"},{"input":"3\n1\nP","expected":"1 0"},{"input":"1\n7\nC P C C C P P","expected":"1 4"},{"input":"3\n11\nC C P C C P P C P C C","expected":"0 3"},{"input":"2\n8\nC C P C P P C P","expected":"2 2"}]$j$::jsonb,
  $q$1 <= capacity <= 100; ops are P or C$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['synchronization','producer-consumer']::text[]);


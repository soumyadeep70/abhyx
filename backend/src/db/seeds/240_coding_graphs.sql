-- 240_coding_graphs.sql
-- Topic: Graphs (coding) -- 23 questions.
-- Idempotent: re-running updates these rows in place (matched on topic + title).
-- Requires the helpers in 010_question_helpers.sql (run in the same session by `npm run seed`).

-- 01 | easy | Flood Fill
SELECT pg_temp.seed_coding($q$Graphs$q$, 'easy', $q$Flood Fill$q$, $q$Starting at cell (sr, sc), replace the colour of that cell and of every cell connected to it 4-directionally with the same original colour by newColor. Print the final grid.

Input Format:
- image: two integers r and c, then r lines of c space-separated integers
- sr: a single integer
- sc: a single integer
- new_color: a single integer

Output Format:
Print each row on its own line, values separated by single spaces.

Example:
Input:
3 3
1 1 1
1 1 0
1 0 1
1
1
2
Output:
2 2 2
2 2 0
2 0 1$q$,
  $q$def flood_fill(image: List[List[int]], sr: int, sc: int, new_color: int) -> List[List[int]]$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef flood_fill(image: List[List[int]], sr: int, sc: int, new_color: int) -> List[List[int]]:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    rows, cols = int(next(it)), int(next(it))\n    image = [[int(next(it)) for _ in range(cols)] for _ in range(rows)]\n    sr = int(next(it))\n    sc = int(next(it))\n    new_color = int(next(it))\n    result = flood_fill(image, sr, sc, new_color)\n    print('\\n'.join(' '.join(map(str, row)) for row in result))\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction floodFill(image, sr, sc, new_color) {\n  // Write your solution here\n}\n\nconst imageRows = parseInt(next());\nconst imageCols = parseInt(next());\nconst image = Array.from({ length: imageRows }, () => Array.from({ length: imageCols }, () => parseInt(next())));\nconst sr = parseInt(next());\nconst sc = parseInt(next());\nconst new_color = parseInt(next());\nconst result = floodFill(image, sr, sc, new_color);\nconsole.log(result.map((row) => row.join(' ')).join('\\n'));\n","java":"import java.util.*;\n\npublic class Main {\n    static int[][] floodFill(int[][] image, int sr, int sc, int new_color) {\n        // Write your solution here\n        return new int[0][];\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int imageRows = scanner.nextInt(), imageCols = scanner.nextInt();\n        int[][] image = new int[imageRows][imageCols];\n        for (int i = 0; i < imageRows; i++)\n            for (int j = 0; j < imageCols; j++) image[i][j] = scanner.nextInt();\n        int sr = scanner.nextInt();\n        int sc = scanner.nextInt();\n        int new_color = scanner.nextInt();\n        int[][] result = floodFill(image, sr, sc, new_color);\n        StringBuilder sb = new StringBuilder();\n        for (int[] row : result) {\n            for (int j = 0; j < row.length; j++) {\n                if (j > 0) sb.append(' ');\n                sb.append(row[j]);\n            }\n            sb.append('\\n');\n        }\n        System.out.print(sb);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nvector<vector<int>> floodFill(vector<vector<int>> image, int sr, int sc, int new_color) {\n    // Write your solution here\n    return {};\n}\n\nint main() {\n    int imageRows, imageCols;\n    cin >> imageRows >> imageCols;\n    vector<vector<int>> image(imageRows, vector<int>(imageCols));\n    for (auto& row : image) for (int& x : row) cin >> x;\n    int sr;\n    cin >> sr;\n    int sc;\n    cin >> sc;\n    int new_color;\n    cin >> new_color;\n    auto result = floodFill(image, sr, sc, new_color);\n    for (auto& row : result) {\n        for (size_t j = 0; j < row.size(); j++) {\n            if (j) cout << ' ';\n            cout << row[j];\n        }\n        cout << '\\n';\n    }\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"3 3\n1 1 1\n1 1 0\n1 0 1\n1\n1\n2","expected":"2 2 2\n2 2 0\n2 0 1"},{"input":"2 3\n0 0 0\n0 0 0\n0\n0\n0","expected":"0 0 0\n0 0 0"},{"input":"2 2\n1 2\n2 1\n0\n1\n5","expected":"1 5\n2 1"},{"input":"3 4\n2 1 2 0\n2 0 2 1\n0 2 0 0\n1\n0\n3","expected":"3 1 2 0\n3 0 2 1\n0 2 0 0"},{"input":"3 4\n2 0 1 2\n2 2 1 2\n1 2 1 2\n1\n1\n3","expected":"3 0 1 2\n3 3 1 2\n1 3 1 2"},{"input":"3 4\n0 0 2 1\n0 0 0 1\n1 0 1 2\n0\n2\n4","expected":"0 0 4 1\n0 0 0 1\n1 0 1 2"}]$j$::jsonb,
  $q$1 <= rows, cols <= 50$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Infosys','Wipro','Accenture']::text[], ARRAY['dfs','grid']::text[]);

-- 02 | easy | Find if Path Exists in Graph
SELECT pg_temp.seed_coding($q$Graphs$q$, 'easy', $q$Find if Path Exists in Graph$q$, $q$An undirected graph has n vertices numbered 0..n-1 and the given edges. Print true if there is a path from source to destination.

Input Format:
- n: a single integer
- edges: two integers r and c, then r lines of c space-separated integers
- source: a single integer
- destination: a single integer

Output Format:
Print true or false (lowercase).

Example:
Input:
3
3 2
0 1
1 2
2 0
0
2
Output:
true$q$,
  $q$def valid_path(n: int, edges: List[List[int]], source: int, destination: int) -> bool$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef valid_path(n: int, edges: List[List[int]], source: int, destination: int) -> bool:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    n = int(next(it))\n    rows, cols = int(next(it)), int(next(it))\n    edges = [[int(next(it)) for _ in range(cols)] for _ in range(rows)]\n    source = int(next(it))\n    destination = int(next(it))\n    result = valid_path(n, edges, source, destination)\n    print('true' if result else 'false')\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction validPath(n, edges, source, destination) {\n  // Write your solution here\n}\n\nconst n = parseInt(next());\nconst edgesRows = parseInt(next());\nconst edgesCols = parseInt(next());\nconst edges = Array.from({ length: edgesRows }, () => Array.from({ length: edgesCols }, () => parseInt(next())));\nconst source = parseInt(next());\nconst destination = parseInt(next());\nconst result = validPath(n, edges, source, destination);\nconsole.log(result ? 'true' : 'false');\n","java":"import java.util.*;\n\npublic class Main {\n    static boolean validPath(int n, int[][] edges, int source, int destination) {\n        // Write your solution here\n        return false;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int n = scanner.nextInt();\n        int edgesRows = scanner.nextInt(), edgesCols = scanner.nextInt();\n        int[][] edges = new int[edgesRows][edgesCols];\n        for (int i = 0; i < edgesRows; i++)\n            for (int j = 0; j < edgesCols; j++) edges[i][j] = scanner.nextInt();\n        int source = scanner.nextInt();\n        int destination = scanner.nextInt();\n        boolean result = validPath(n, edges, source, destination);\n        System.out.println(result ? \"true\" : \"false\");\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nbool validPath(int n, vector<vector<int>> edges, int source, int destination) {\n    // Write your solution here\n    return false;\n}\n\nint main() {\n    int n;\n    cin >> n;\n    int edgesRows, edgesCols;\n    cin >> edgesRows >> edgesCols;\n    vector<vector<int>> edges(edgesRows, vector<int>(edgesCols));\n    for (auto& row : edges) for (int& x : row) cin >> x;\n    int source;\n    cin >> source;\n    int destination;\n    cin >> destination;\n    auto result = validPath(n, edges, source, destination);\n    cout << (result ? \"true\" : \"false\") << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"3\n3 2\n0 1\n1 2\n2 0\n0\n2","expected":"true"},{"input":"6\n5 2\n0 1\n0 2\n3 5\n5 4\n4 3\n0\n5","expected":"false"},{"input":"2\n1 2\n0 1\n1\n1","expected":"true"},{"input":"5\n3 2\n0 3\n1 4\n0 1\n0\n4","expected":"true"},{"input":"6\n2 2\n2 3\n4 5\n0\n5","expected":"false"},{"input":"5\n5 2\n0 1\n2 4\n1 3\n1 2\n2 3\n0\n4","expected":"true"}]$j$::jsonb,
  $q$1 <= n <= 2 * 10^5$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Infosys','Accenture']::text[], ARRAY['dfs','bfs','union-find']::text[]);

-- 03 | easy | Find the Town Judge
SELECT pg_temp.seed_coding($q$Graphs$q$, 'easy', $q$Find the Town Judge$q$, $q$In a town of n people labelled 1..n, the judge (if one exists) trusts nobody, and everybody else trusts the judge. trust[i] = [a, b] means a trusts b. Print the judge's label, or -1 if there is no judge.

Input Format:
- n: a single integer
- trust: two integers r and c, then r lines of c space-separated integers

Output Format:
Print a single integer.

Example:
Input:
2
1 2
1 2
Output:
2$q$,
  $q$def find_judge(n: int, trust: List[List[int]]) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef find_judge(n: int, trust: List[List[int]]) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    n = int(next(it))\n    rows, cols = int(next(it)), int(next(it))\n    trust = [[int(next(it)) for _ in range(cols)] for _ in range(rows)]\n    result = find_judge(n, trust)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction findJudge(n, trust) {\n  // Write your solution here\n}\n\nconst n = parseInt(next());\nconst trustRows = parseInt(next());\nconst trustCols = parseInt(next());\nconst trust = Array.from({ length: trustRows }, () => Array.from({ length: trustCols }, () => parseInt(next())));\nconst result = findJudge(n, trust);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int findJudge(int n, int[][] trust) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int n = scanner.nextInt();\n        int trustRows = scanner.nextInt(), trustCols = scanner.nextInt();\n        int[][] trust = new int[trustRows][trustCols];\n        for (int i = 0; i < trustRows; i++)\n            for (int j = 0; j < trustCols; j++) trust[i][j] = scanner.nextInt();\n        int result = findJudge(n, trust);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint findJudge(int n, vector<vector<int>> trust) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int n;\n    cin >> n;\n    int trustRows, trustCols;\n    cin >> trustRows >> trustCols;\n    vector<vector<int>> trust(trustRows, vector<int>(trustCols));\n    for (auto& row : trust) for (int& x : row) cin >> x;\n    auto result = findJudge(n, trust);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"2\n1 2\n1 2","expected":"2"},{"input":"3\n3 2\n1 3\n2 3\n3 1","expected":"-1"},{"input":"3\n2 2\n1 3\n2 3","expected":"3"},{"input":"4\n1 2\n4 2","expected":"-1"},{"input":"3\n2 2\n2 1\n3 1","expected":"1"},{"input":"5\n4 2\n2 1\n3 1\n4 1\n5 1","expected":"1"}]$j$::jsonb,
  $q$1 <= n <= 1000$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Infosys','Wipro']::text[], ARRAY['graph','degree']::text[]);

-- 04 | easy | Vertices with Zero In-Degree
SELECT pg_temp.seed_coding($q$Graphs$q$, 'easy', $q$Vertices with Zero In-Degree$q$, $q$A directed acyclic graph has n vertices (0..n-1). Print, in ascending order, the vertices that have no incoming edge - the smallest set from which every vertex can be reached.

Input Format:
- n: a single integer
- edges: two integers r and c, then r lines of c space-separated integers

Output Format:
Print the integers on one line, separated by single spaces.

Example:
Input:
6
5 2
0 1
0 2
2 5
3 4
4 2
Output:
0 3$q$,
  $q$def zero_indegree(n: int, edges: List[List[int]]) -> List[int]$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef zero_indegree(n: int, edges: List[List[int]]) -> List[int]:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    n = int(next(it))\n    rows, cols = int(next(it)), int(next(it))\n    edges = [[int(next(it)) for _ in range(cols)] for _ in range(rows)]\n    result = zero_indegree(n, edges)\n    print(' '.join(map(str, result)))\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction zeroIndegree(n, edges) {\n  // Write your solution here\n}\n\nconst n = parseInt(next());\nconst edgesRows = parseInt(next());\nconst edgesCols = parseInt(next());\nconst edges = Array.from({ length: edgesRows }, () => Array.from({ length: edgesCols }, () => parseInt(next())));\nconst result = zeroIndegree(n, edges);\nconsole.log(result.join(' '));\n","java":"import java.util.*;\n\npublic class Main {\n    static int[] zeroIndegree(int n, int[][] edges) {\n        // Write your solution here\n        return new int[0];\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int n = scanner.nextInt();\n        int edgesRows = scanner.nextInt(), edgesCols = scanner.nextInt();\n        int[][] edges = new int[edgesRows][edgesCols];\n        for (int i = 0; i < edgesRows; i++)\n            for (int j = 0; j < edgesCols; j++) edges[i][j] = scanner.nextInt();\n        int[] result = zeroIndegree(n, edges);\n        StringBuilder sb = new StringBuilder();\n        for (int i = 0; i < result.length; i++) {\n            if (i > 0) sb.append(' ');\n            sb.append(result[i]);\n        }\n        System.out.println(sb);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nvector<int> zeroIndegree(int n, vector<vector<int>> edges) {\n    // Write your solution here\n    return {};\n}\n\nint main() {\n    int n;\n    cin >> n;\n    int edgesRows, edgesCols;\n    cin >> edgesRows >> edgesCols;\n    vector<vector<int>> edges(edgesRows, vector<int>(edgesCols));\n    for (auto& row : edges) for (int& x : row) cin >> x;\n    auto result = zeroIndegree(n, edges);\n    for (size_t i = 0; i < result.size(); i++) {\n        if (i) cout << ' ';\n        cout << result[i];\n    }\n    cout << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"6\n5 2\n0 1\n0 2\n2 5\n3 4\n4 2","expected":"0 3"},{"input":"5\n4 2\n0 1\n2 1\n3 1\n1 4","expected":"0 2 3"},{"input":"3\n2 2\n0 1\n1 2","expected":"0"},{"input":"6\n7 2\n4 5\n1 5\n1 2\n0 5\n1 3\n2 3\n0 1","expected":"0 4"},{"input":"5\n5 2\n0 2\n0 4\n2 3\n1 2\n2 4","expected":"0 1"},{"input":"6\n6 2\n1 4\n0 2\n2 5\n2 3\n0 3\n3 5","expected":"0 1"}]$j$::jsonb,
  $q$2 <= n <= 10^5$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Accenture']::text[], ARRAY['graph','degree']::text[]);

-- 05 | easy | Island Perimeter
SELECT pg_temp.seed_coding($q$Graphs$q$, 'easy', $q$Island Perimeter$q$, $q$The grid has exactly one island (cells with 1 connected 4-directionally, with no lakes). Print the island's perimeter. Each cell is a unit square.

Input Format:
- grid: two integers r and c, then r lines of c space-separated integers

Output Format:
Print a single integer.

Example:
Input:
4 4
0 1 0 0
1 1 1 0
0 1 0 0
1 1 0 0
Output:
16$q$,
  $q$def island_perimeter(grid: List[List[int]]) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef island_perimeter(grid: List[List[int]]) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    rows, cols = int(next(it)), int(next(it))\n    grid = [[int(next(it)) for _ in range(cols)] for _ in range(rows)]\n    result = island_perimeter(grid)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction islandPerimeter(grid) {\n  // Write your solution here\n}\n\nconst gridRows = parseInt(next());\nconst gridCols = parseInt(next());\nconst grid = Array.from({ length: gridRows }, () => Array.from({ length: gridCols }, () => parseInt(next())));\nconst result = islandPerimeter(grid);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int islandPerimeter(int[][] grid) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int gridRows = scanner.nextInt(), gridCols = scanner.nextInt();\n        int[][] grid = new int[gridRows][gridCols];\n        for (int i = 0; i < gridRows; i++)\n            for (int j = 0; j < gridCols; j++) grid[i][j] = scanner.nextInt();\n        int result = islandPerimeter(grid);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint islandPerimeter(vector<vector<int>> grid) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int gridRows, gridCols;\n    cin >> gridRows >> gridCols;\n    vector<vector<int>> grid(gridRows, vector<int>(gridCols));\n    for (auto& row : grid) for (int& x : row) cin >> x;\n    auto result = islandPerimeter(grid);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"4 4\n0 1 0 0\n1 1 1 0\n0 1 0 0\n1 1 0 0","expected":"16"},{"input":"1 1\n1","expected":"4"},{"input":"1 2\n1 0","expected":"4"},{"input":"4 5\n1 1 1 1 1\n0 0 0 0 0\n0 0 0 0 0\n0 0 0 0 0","expected":"12"},{"input":"4 5\n1 0 0 0 0\n1 0 0 0 0\n1 0 0 0 0\n1 0 0 0 0","expected":"10"},{"input":"4 5\n1 1 0 0 0\n1 1 0 0 0\n1 1 0 0 0\n0 0 0 0 0","expected":"10"}]$j$::jsonb,
  $q$1 <= rows, cols <= 100$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['TCS','Wipro','Accenture']::text[], ARRAY['grid']::text[]);

-- 06 | medium | Number of Islands
SELECT pg_temp.seed_coding($q$Graphs$q$, 'medium', $q$Number of Islands$q$, $q$Count the islands in a grid of 1 (land) and 0 (water). An island is a group of land cells connected horizontally or vertically.

Input Format:
- grid: two integers r and c, then r lines of c space-separated integers

Output Format:
Print a single integer.

Example:
Input:
4 5
1 1 0 0 0
1 1 0 0 0
0 0 1 0 0
0 0 0 1 1
Output:
3$q$,
  $q$def num_islands(grid: List[List[int]]) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef num_islands(grid: List[List[int]]) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    rows, cols = int(next(it)), int(next(it))\n    grid = [[int(next(it)) for _ in range(cols)] for _ in range(rows)]\n    result = num_islands(grid)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction numIslands(grid) {\n  // Write your solution here\n}\n\nconst gridRows = parseInt(next());\nconst gridCols = parseInt(next());\nconst grid = Array.from({ length: gridRows }, () => Array.from({ length: gridCols }, () => parseInt(next())));\nconst result = numIslands(grid);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int numIslands(int[][] grid) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int gridRows = scanner.nextInt(), gridCols = scanner.nextInt();\n        int[][] grid = new int[gridRows][gridCols];\n        for (int i = 0; i < gridRows; i++)\n            for (int j = 0; j < gridCols; j++) grid[i][j] = scanner.nextInt();\n        int result = numIslands(grid);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint numIslands(vector<vector<int>> grid) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int gridRows, gridCols;\n    cin >> gridRows >> gridCols;\n    vector<vector<int>> grid(gridRows, vector<int>(gridCols));\n    for (auto& row : grid) for (int& x : row) cin >> x;\n    auto result = numIslands(grid);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"4 5\n1 1 0 0 0\n1 1 0 0 0\n0 0 1 0 0\n0 0 0 1 1","expected":"3"},{"input":"3 3\n1 0 1\n0 1 0\n1 0 1","expected":"5"},{"input":"1 1\n0","expected":"0"},{"input":"5 6\n1 0 0 0 1 1\n0 1 0 1 0 0\n0 1 0 1 1 0\n1 1 0 1 1 1\n0 0 1 1 1 0","expected":"4"},{"input":"6 4\n1 1 0 0\n0 0 0 0\n0 0 0 1\n0 0 1 1\n1 1 1 1\n0 0 0 1","expected":"2"},{"input":"3 4\n0 0 0 1\n0 1 0 1\n0 1 1 1","expected":"1"}]$j$::jsonb,
  $q$1 <= rows, cols <= 300$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','TCS','Accenture']::text[], ARRAY['dfs','bfs','grid']::text[]);

-- 07 | medium | Max Area of Island
SELECT pg_temp.seed_coding($q$Graphs$q$, 'medium', $q$Max Area of Island$q$, $q$Print the area (number of cells) of the largest island in the grid, or 0 if there is none.

Input Format:
- grid: two integers r and c, then r lines of c space-separated integers

Output Format:
Print a single integer.

Example:
Input:
3 3
0 1 1
0 1 0
1 0 1
Output:
3$q$,
  $q$def max_area_of_island(grid: List[List[int]]) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef max_area_of_island(grid: List[List[int]]) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    rows, cols = int(next(it)), int(next(it))\n    grid = [[int(next(it)) for _ in range(cols)] for _ in range(rows)]\n    result = max_area_of_island(grid)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction maxAreaOfIsland(grid) {\n  // Write your solution here\n}\n\nconst gridRows = parseInt(next());\nconst gridCols = parseInt(next());\nconst grid = Array.from({ length: gridRows }, () => Array.from({ length: gridCols }, () => parseInt(next())));\nconst result = maxAreaOfIsland(grid);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int maxAreaOfIsland(int[][] grid) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int gridRows = scanner.nextInt(), gridCols = scanner.nextInt();\n        int[][] grid = new int[gridRows][gridCols];\n        for (int i = 0; i < gridRows; i++)\n            for (int j = 0; j < gridCols; j++) grid[i][j] = scanner.nextInt();\n        int result = maxAreaOfIsland(grid);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint maxAreaOfIsland(vector<vector<int>> grid) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int gridRows, gridCols;\n    cin >> gridRows >> gridCols;\n    vector<vector<int>> grid(gridRows, vector<int>(gridCols));\n    for (auto& row : grid) for (int& x : row) cin >> x;\n    auto result = maxAreaOfIsland(grid);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"3 3\n0 1 1\n0 1 0\n1 0 1","expected":"3"},{"input":"1 2\n0 0","expected":"0"},{"input":"2 2\n1 1\n1 1","expected":"4"},{"input":"4 6\n1 0 1 1 1 1\n1 1 0 1 0 1\n1 1 0 1 1 0\n1 1 1 0 1 0","expected":"9"},{"input":"3 3\n1 0 1\n1 0 0\n1 0 1","expected":"3"},{"input":"3 4\n1 1 1 0\n0 1 1 0\n1 0 1 1","expected":"7"}]$j$::jsonb,
  $q$1 <= rows, cols <= 50$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Accenture']::text[], ARRAY['dfs','grid']::text[]);

-- 08 | medium | Number of Provinces
SELECT pg_temp.seed_coding($q$Graphs$q$, 'medium', $q$Number of Provinces$q$, $q$There are n cities (0..n-1) and some direct roads between pairs of cities. A province is a group of cities connected directly or indirectly. Print the number of provinces.

Input Format:
- n: a single integer
- roads: two integers r and c, then r lines of c space-separated integers

Output Format:
Print a single integer.

Example:
Input:
3
1 2
0 1
Output:
2$q$,
  $q$def count_provinces(n: int, roads: List[List[int]]) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef count_provinces(n: int, roads: List[List[int]]) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    n = int(next(it))\n    rows, cols = int(next(it)), int(next(it))\n    roads = [[int(next(it)) for _ in range(cols)] for _ in range(rows)]\n    result = count_provinces(n, roads)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction countProvinces(n, roads) {\n  // Write your solution here\n}\n\nconst n = parseInt(next());\nconst roadsRows = parseInt(next());\nconst roadsCols = parseInt(next());\nconst roads = Array.from({ length: roadsRows }, () => Array.from({ length: roadsCols }, () => parseInt(next())));\nconst result = countProvinces(n, roads);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int countProvinces(int n, int[][] roads) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int n = scanner.nextInt();\n        int roadsRows = scanner.nextInt(), roadsCols = scanner.nextInt();\n        int[][] roads = new int[roadsRows][roadsCols];\n        for (int i = 0; i < roadsRows; i++)\n            for (int j = 0; j < roadsCols; j++) roads[i][j] = scanner.nextInt();\n        int result = countProvinces(n, roads);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint countProvinces(int n, vector<vector<int>> roads) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int n;\n    cin >> n;\n    int roadsRows, roadsCols;\n    cin >> roadsRows >> roadsCols;\n    vector<vector<int>> roads(roadsRows, vector<int>(roadsCols));\n    for (auto& row : roads) for (int& x : row) cin >> x;\n    auto result = countProvinces(n, roads);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"3\n1 2\n0 1","expected":"2"},{"input":"3\n0 2","expected":"3"},{"input":"5\n3 2\n0 1\n1 2\n3 4","expected":"2"},{"input":"9\n3 2\n0 1\n0 5\n6 8","expected":"6"},{"input":"7\n3 2\n4 6\n0 6\n2 6","expected":"4"},{"input":"8\n3 2\n2 5\n0 7\n2 4","expected":"5"}]$j$::jsonb,
  $q$1 <= n <= 200$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','TCS','Infosys','Accenture']::text[], ARRAY['union-find','dfs']::text[]);

-- 09 | medium | Course Schedule
SELECT pg_temp.seed_coding($q$Graphs$q$, 'medium', $q$Course Schedule$q$, $q$There are n courses (0..n-1). prerequisites[i] = [a, b] means you must take course b before course a. Print true if all courses can be finished (the graph has no cycle).

Input Format:
- num_courses: a single integer
- prerequisites: two integers r and c, then r lines of c space-separated integers

Output Format:
Print true or false (lowercase).

Example:
Input:
2
1 2
1 0
Output:
true$q$,
  $q$def can_finish(num_courses: int, prerequisites: List[List[int]]) -> bool$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef can_finish(num_courses: int, prerequisites: List[List[int]]) -> bool:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    num_courses = int(next(it))\n    rows, cols = int(next(it)), int(next(it))\n    prerequisites = [[int(next(it)) for _ in range(cols)] for _ in range(rows)]\n    result = can_finish(num_courses, prerequisites)\n    print('true' if result else 'false')\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction canFinish(num_courses, prerequisites) {\n  // Write your solution here\n}\n\nconst num_courses = parseInt(next());\nconst prerequisitesRows = parseInt(next());\nconst prerequisitesCols = parseInt(next());\nconst prerequisites = Array.from({ length: prerequisitesRows }, () => Array.from({ length: prerequisitesCols }, () => parseInt(next())));\nconst result = canFinish(num_courses, prerequisites);\nconsole.log(result ? 'true' : 'false');\n","java":"import java.util.*;\n\npublic class Main {\n    static boolean canFinish(int num_courses, int[][] prerequisites) {\n        // Write your solution here\n        return false;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int num_courses = scanner.nextInt();\n        int prerequisitesRows = scanner.nextInt(), prerequisitesCols = scanner.nextInt();\n        int[][] prerequisites = new int[prerequisitesRows][prerequisitesCols];\n        for (int i = 0; i < prerequisitesRows; i++)\n            for (int j = 0; j < prerequisitesCols; j++) prerequisites[i][j] = scanner.nextInt();\n        boolean result = canFinish(num_courses, prerequisites);\n        System.out.println(result ? \"true\" : \"false\");\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nbool canFinish(int num_courses, vector<vector<int>> prerequisites) {\n    // Write your solution here\n    return false;\n}\n\nint main() {\n    int num_courses;\n    cin >> num_courses;\n    int prerequisitesRows, prerequisitesCols;\n    cin >> prerequisitesRows >> prerequisitesCols;\n    vector<vector<int>> prerequisites(prerequisitesRows, vector<int>(prerequisitesCols));\n    for (auto& row : prerequisites) for (int& x : row) cin >> x;\n    auto result = canFinish(num_courses, prerequisites);\n    cout << (result ? \"true\" : \"false\") << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"2\n1 2\n1 0","expected":"true"},{"input":"2\n2 2\n1 0\n0 1","expected":"false"},{"input":"4\n3 2\n1 0\n2 1\n3 2","expected":"true"},{"input":"4\n3 2\n2 3\n1 3\n0 2","expected":"true"},{"input":"4\n5 2\n3 2\n1 2\n0 3\n2 3\n1 3","expected":"false"},{"input":"6\n3 2\n3 1\n3 5\n5 2","expected":"true"}]$j$::jsonb,
  $q$1 <= n <= 2000$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Accenture']::text[], ARRAY['topological-sort','cycle-detection']::text[]);

-- 10 | medium | Course Schedule II
SELECT pg_temp.seed_coding($q$Graphs$q$, 'medium', $q$Course Schedule II$q$, $q$Same setup as Course Schedule, but print an ORDER in which the courses can be taken. Many orders can be valid, so print the lexicographically smallest one (always take the smallest-numbered available course next). Print -1 if it is impossible.

Input Format:
- num_courses: a single integer
- prerequisites: two integers r and c, then r lines of c space-separated integers

Output Format:
Print the integers on one line, separated by single spaces.

Example:
Input:
4
4 2
1 0
2 0
3 1
3 2
Output:
0 1 2 3$q$,
  $q$def find_order(num_courses: int, prerequisites: List[List[int]]) -> List[int]$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef find_order(num_courses: int, prerequisites: List[List[int]]) -> List[int]:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    num_courses = int(next(it))\n    rows, cols = int(next(it)), int(next(it))\n    prerequisites = [[int(next(it)) for _ in range(cols)] for _ in range(rows)]\n    result = find_order(num_courses, prerequisites)\n    print(' '.join(map(str, result)))\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction findOrder(num_courses, prerequisites) {\n  // Write your solution here\n}\n\nconst num_courses = parseInt(next());\nconst prerequisitesRows = parseInt(next());\nconst prerequisitesCols = parseInt(next());\nconst prerequisites = Array.from({ length: prerequisitesRows }, () => Array.from({ length: prerequisitesCols }, () => parseInt(next())));\nconst result = findOrder(num_courses, prerequisites);\nconsole.log(result.join(' '));\n","java":"import java.util.*;\n\npublic class Main {\n    static int[] findOrder(int num_courses, int[][] prerequisites) {\n        // Write your solution here\n        return new int[0];\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int num_courses = scanner.nextInt();\n        int prerequisitesRows = scanner.nextInt(), prerequisitesCols = scanner.nextInt();\n        int[][] prerequisites = new int[prerequisitesRows][prerequisitesCols];\n        for (int i = 0; i < prerequisitesRows; i++)\n            for (int j = 0; j < prerequisitesCols; j++) prerequisites[i][j] = scanner.nextInt();\n        int[] result = findOrder(num_courses, prerequisites);\n        StringBuilder sb = new StringBuilder();\n        for (int i = 0; i < result.length; i++) {\n            if (i > 0) sb.append(' ');\n            sb.append(result[i]);\n        }\n        System.out.println(sb);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nvector<int> findOrder(int num_courses, vector<vector<int>> prerequisites) {\n    // Write your solution here\n    return {};\n}\n\nint main() {\n    int num_courses;\n    cin >> num_courses;\n    int prerequisitesRows, prerequisitesCols;\n    cin >> prerequisitesRows >> prerequisitesCols;\n    vector<vector<int>> prerequisites(prerequisitesRows, vector<int>(prerequisitesCols));\n    for (auto& row : prerequisites) for (int& x : row) cin >> x;\n    auto result = findOrder(num_courses, prerequisites);\n    for (size_t i = 0; i < result.size(); i++) {\n        if (i) cout << ' ';\n        cout << result[i];\n    }\n    cout << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"4\n4 2\n1 0\n2 0\n3 1\n3 2","expected":"0 1 2 3"},{"input":"2\n2 2\n1 0\n0 1","expected":"-1"},{"input":"3\n0 2","expected":"0 1 2"},{"input":"4\n6 2\n2 0\n2 1\n3 2\n1 0\n0 1\n2 3","expected":"-1"},{"input":"5\n2 2\n0 1\n4 3","expected":"1 0 2 3 4"},{"input":"6\n3 2\n3 2\n3 5\n1 0","expected":"0 1 2 4 5 3"}]$j$::jsonb,
  $q$1 <= n <= 2000$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Accenture']::text[], ARRAY['topological-sort','heap']::text[]);

-- 11 | medium | Shortest Path in Binary Matrix
SELECT pg_temp.seed_coding($q$Graphs$q$, 'medium', $q$Shortest Path in Binary Matrix$q$, $q$In an n x n grid of 0 (open) and 1 (blocked), find the length of the shortest path from the top-left to the bottom-right cell moving in any of the 8 directions through open cells only. The length counts cells, including both ends. Print -1 if no path exists.

Input Format:
- grid: two integers r and c, then r lines of c space-separated integers

Output Format:
Print a single integer.

Example:
Input:
3 3
0 0 0
1 1 0
1 1 0
Output:
4$q$,
  $q$def shortest_path_binary_matrix(grid: List[List[int]]) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef shortest_path_binary_matrix(grid: List[List[int]]) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    rows, cols = int(next(it)), int(next(it))\n    grid = [[int(next(it)) for _ in range(cols)] for _ in range(rows)]\n    result = shortest_path_binary_matrix(grid)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction shortestPathBinaryMatrix(grid) {\n  // Write your solution here\n}\n\nconst gridRows = parseInt(next());\nconst gridCols = parseInt(next());\nconst grid = Array.from({ length: gridRows }, () => Array.from({ length: gridCols }, () => parseInt(next())));\nconst result = shortestPathBinaryMatrix(grid);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int shortestPathBinaryMatrix(int[][] grid) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int gridRows = scanner.nextInt(), gridCols = scanner.nextInt();\n        int[][] grid = new int[gridRows][gridCols];\n        for (int i = 0; i < gridRows; i++)\n            for (int j = 0; j < gridCols; j++) grid[i][j] = scanner.nextInt();\n        int result = shortestPathBinaryMatrix(grid);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint shortestPathBinaryMatrix(vector<vector<int>> grid) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int gridRows, gridCols;\n    cin >> gridRows >> gridCols;\n    vector<vector<int>> grid(gridRows, vector<int>(gridCols));\n    for (auto& row : grid) for (int& x : row) cin >> x;\n    auto result = shortestPathBinaryMatrix(grid);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"3 3\n0 0 0\n1 1 0\n1 1 0","expected":"4"},{"input":"2 2\n0 1\n1 0","expected":"2"},{"input":"2 2\n1 0\n0 0","expected":"-1"},{"input":"5 5\n1 0 0 0 0\n1 0 0 1 1\n0 1 0 0 0\n0 0 0 0 1\n0 1 0 1 0","expected":"-1"},{"input":"5 5\n0 0 1 0 0\n0 0 0 0 0\n0 1 0 1 0\n0 0 0 0 1\n1 0 1 0 1","expected":"-1"},{"input":"3 3\n0 0 0\n1 0 0\n0 0 0","expected":"3"}]$j$::jsonb,
  $q$1 <= n <= 100$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Accenture']::text[], ARRAY['bfs','grid']::text[]);

-- 12 | medium | Rotting Oranges
SELECT pg_temp.seed_coding($q$Graphs$q$, 'medium', $q$Rotting Oranges$q$, $q$Cells hold 0 (empty), 1 (fresh orange) or 2 (rotten orange). Every minute, each fresh orange 4-directionally adjacent to a rotten one becomes rotten. Print the minutes until no fresh orange remains, or -1 if that never happens.

Input Format:
- grid: two integers r and c, then r lines of c space-separated integers

Output Format:
Print a single integer.

Example:
Input:
3 3
2 1 1
1 1 0
0 1 1
Output:
4$q$,
  $q$def oranges_rotting(grid: List[List[int]]) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef oranges_rotting(grid: List[List[int]]) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    rows, cols = int(next(it)), int(next(it))\n    grid = [[int(next(it)) for _ in range(cols)] for _ in range(rows)]\n    result = oranges_rotting(grid)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction orangesRotting(grid) {\n  // Write your solution here\n}\n\nconst gridRows = parseInt(next());\nconst gridCols = parseInt(next());\nconst grid = Array.from({ length: gridRows }, () => Array.from({ length: gridCols }, () => parseInt(next())));\nconst result = orangesRotting(grid);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int orangesRotting(int[][] grid) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int gridRows = scanner.nextInt(), gridCols = scanner.nextInt();\n        int[][] grid = new int[gridRows][gridCols];\n        for (int i = 0; i < gridRows; i++)\n            for (int j = 0; j < gridCols; j++) grid[i][j] = scanner.nextInt();\n        int result = orangesRotting(grid);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint orangesRotting(vector<vector<int>> grid) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int gridRows, gridCols;\n    cin >> gridRows >> gridCols;\n    vector<vector<int>> grid(gridRows, vector<int>(gridCols));\n    for (auto& row : grid) for (int& x : row) cin >> x;\n    auto result = orangesRotting(grid);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"3 3\n2 1 1\n1 1 0\n0 1 1","expected":"4"},{"input":"3 3\n2 1 1\n0 1 1\n1 0 1","expected":"-1"},{"input":"1 2\n0 2","expected":"0"},{"input":"4 4\n0 1 1 1\n1 1 0 2\n1 1 1 2\n1 1 0 1","expected":"4"},{"input":"5 5\n1 1 2 0 2\n2 1 1 1 1\n1 0 1 0 1\n1 2 2 1 1\n1 1 1 1 2","expected":"2"},{"input":"4 4\n1 1 0 2\n1 1 0 2\n1 1 0 2\n1 1 0 1","expected":"-1"}]$j$::jsonb,
  $q$1 <= rows, cols <= 10$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Accenture']::text[], ARRAY['bfs','grid']::text[]);

-- 13 | medium | Is Graph Bipartite?
SELECT pg_temp.seed_coding($q$Graphs$q$, 'medium', $q$Is Graph Bipartite?$q$, $q$Print true if the vertices of the undirected graph can be split into two groups so that every edge joins vertices from different groups. The graph may be disconnected.

Input Format:
- n: a single integer
- edges: two integers r and c, then r lines of c space-separated integers

Output Format:
Print true or false (lowercase).

Example:
Input:
4
4 2
0 1
1 2
2 3
3 0
Output:
true$q$,
  $q$def is_bipartite(n: int, edges: List[List[int]]) -> bool$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef is_bipartite(n: int, edges: List[List[int]]) -> bool:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    n = int(next(it))\n    rows, cols = int(next(it)), int(next(it))\n    edges = [[int(next(it)) for _ in range(cols)] for _ in range(rows)]\n    result = is_bipartite(n, edges)\n    print('true' if result else 'false')\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction isBipartite(n, edges) {\n  // Write your solution here\n}\n\nconst n = parseInt(next());\nconst edgesRows = parseInt(next());\nconst edgesCols = parseInt(next());\nconst edges = Array.from({ length: edgesRows }, () => Array.from({ length: edgesCols }, () => parseInt(next())));\nconst result = isBipartite(n, edges);\nconsole.log(result ? 'true' : 'false');\n","java":"import java.util.*;\n\npublic class Main {\n    static boolean isBipartite(int n, int[][] edges) {\n        // Write your solution here\n        return false;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int n = scanner.nextInt();\n        int edgesRows = scanner.nextInt(), edgesCols = scanner.nextInt();\n        int[][] edges = new int[edgesRows][edgesCols];\n        for (int i = 0; i < edgesRows; i++)\n            for (int j = 0; j < edgesCols; j++) edges[i][j] = scanner.nextInt();\n        boolean result = isBipartite(n, edges);\n        System.out.println(result ? \"true\" : \"false\");\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nbool isBipartite(int n, vector<vector<int>> edges) {\n    // Write your solution here\n    return false;\n}\n\nint main() {\n    int n;\n    cin >> n;\n    int edgesRows, edgesCols;\n    cin >> edgesRows >> edgesCols;\n    vector<vector<int>> edges(edgesRows, vector<int>(edgesCols));\n    for (auto& row : edges) for (int& x : row) cin >> x;\n    auto result = isBipartite(n, edges);\n    cout << (result ? \"true\" : \"false\") << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"4\n4 2\n0 1\n1 2\n2 3\n3 0","expected":"true"},{"input":"3\n3 2\n0 1\n1 2\n2 0","expected":"false"},{"input":"3\n0 2","expected":"true"},{"input":"6\n7 2\n0 3\n1 2\n3 5\n4 5\n2 5\n1 4\n1 5","expected":"false"},{"input":"7\n5 2\n0 2\n2 5\n0 1\n0 3\n4 5","expected":"true"},{"input":"6\n7 2\n3 5\n0 3\n2 5\n1 5\n0 2\n2 3\n3 4","expected":"false"}]$j$::jsonb,
  $q$1 <= n <= 100$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Accenture']::text[], ARRAY['bfs','coloring']::text[]);

-- 14 | medium | Network Delay Time
SELECT pg_temp.seed_coding($q$Graphs$q$, 'medium', $q$Network Delay Time$q$, $q$A signal is sent from node k in a directed weighted network of n nodes (1..n). times[i] = [u, v, w] means a signal takes w time to travel from u to v. Print the time for all nodes to receive the signal, or -1 if some node can't be reached.

Input Format:
- n: a single integer
- times: two integers r and c, then r lines of c space-separated integers
- k: a single integer

Output Format:
Print a single integer.

Example:
Input:
4
3 3
2 1 1
2 3 1
3 4 1
2
Output:
2$q$,
  $q$def network_delay_time(n: int, times: List[List[int]], k: int) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef network_delay_time(n: int, times: List[List[int]], k: int) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    n = int(next(it))\n    rows, cols = int(next(it)), int(next(it))\n    times = [[int(next(it)) for _ in range(cols)] for _ in range(rows)]\n    k = int(next(it))\n    result = network_delay_time(n, times, k)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction networkDelayTime(n, times, k) {\n  // Write your solution here\n}\n\nconst n = parseInt(next());\nconst timesRows = parseInt(next());\nconst timesCols = parseInt(next());\nconst times = Array.from({ length: timesRows }, () => Array.from({ length: timesCols }, () => parseInt(next())));\nconst k = parseInt(next());\nconst result = networkDelayTime(n, times, k);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int networkDelayTime(int n, int[][] times, int k) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int n = scanner.nextInt();\n        int timesRows = scanner.nextInt(), timesCols = scanner.nextInt();\n        int[][] times = new int[timesRows][timesCols];\n        for (int i = 0; i < timesRows; i++)\n            for (int j = 0; j < timesCols; j++) times[i][j] = scanner.nextInt();\n        int k = scanner.nextInt();\n        int result = networkDelayTime(n, times, k);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint networkDelayTime(int n, vector<vector<int>> times, int k) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int n;\n    cin >> n;\n    int timesRows, timesCols;\n    cin >> timesRows >> timesCols;\n    vector<vector<int>> times(timesRows, vector<int>(timesCols));\n    for (auto& row : times) for (int& x : row) cin >> x;\n    int k;\n    cin >> k;\n    auto result = networkDelayTime(n, times, k);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"4\n3 3\n2 1 1\n2 3 1\n3 4 1\n2","expected":"2"},{"input":"2\n1 3\n1 2 1\n1","expected":"1"},{"input":"2\n1 3\n1 2 1\n2","expected":"-1"},{"input":"5\n9 3\n5 3 8\n4 1 7\n1 2 8\n5 1 2\n1 5 1\n3 1 4\n2 4 1\n4 3 6\n1 3 1\n1","expected":"9"},{"input":"5\n7 3\n2 5 7\n3 4 9\n4 3 3\n3 1 7\n1 5 6\n4 1 9\n5 1 7\n1","expected":"-1"},{"input":"4\n5 3\n1 3 1\n2 3 9\n2 1 3\n4 3 7\n4 1 3\n1","expected":"-1"}]$j$::jsonb,
  $q$1 <= n <= 100; 1 <= w <= 100$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Accenture']::text[], ARRAY['dijkstra','heap']::text[]);

-- 15 | medium | Cheapest Flights Within K Stops
SELECT pg_temp.seed_coding($q$Graphs$q$, 'medium', $q$Cheapest Flights Within K Stops$q$, $q$flights[i] = [from, to, price] describes a one-way flight. Print the cheapest price from src to dst using at most k stops (intermediate cities), or -1 if impossible.

Input Format:
- n: a single integer
- flights: two integers r and c, then r lines of c space-separated integers
- src: a single integer
- dst: a single integer
- k: a single integer

Output Format:
Print a single integer.

Example:
Input:
4
5 3
0 1 100
1 2 100
2 0 100
1 3 600
2 3 200
0
3
1
Output:
700$q$,
  $q$def find_cheapest_price(n: int, flights: List[List[int]], src: int, dst: int, k: int) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef find_cheapest_price(n: int, flights: List[List[int]], src: int, dst: int, k: int) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    n = int(next(it))\n    rows, cols = int(next(it)), int(next(it))\n    flights = [[int(next(it)) for _ in range(cols)] for _ in range(rows)]\n    src = int(next(it))\n    dst = int(next(it))\n    k = int(next(it))\n    result = find_cheapest_price(n, flights, src, dst, k)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction findCheapestPrice(n, flights, src, dst, k) {\n  // Write your solution here\n}\n\nconst n = parseInt(next());\nconst flightsRows = parseInt(next());\nconst flightsCols = parseInt(next());\nconst flights = Array.from({ length: flightsRows }, () => Array.from({ length: flightsCols }, () => parseInt(next())));\nconst src = parseInt(next());\nconst dst = parseInt(next());\nconst k = parseInt(next());\nconst result = findCheapestPrice(n, flights, src, dst, k);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int findCheapestPrice(int n, int[][] flights, int src, int dst, int k) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int n = scanner.nextInt();\n        int flightsRows = scanner.nextInt(), flightsCols = scanner.nextInt();\n        int[][] flights = new int[flightsRows][flightsCols];\n        for (int i = 0; i < flightsRows; i++)\n            for (int j = 0; j < flightsCols; j++) flights[i][j] = scanner.nextInt();\n        int src = scanner.nextInt();\n        int dst = scanner.nextInt();\n        int k = scanner.nextInt();\n        int result = findCheapestPrice(n, flights, src, dst, k);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint findCheapestPrice(int n, vector<vector<int>> flights, int src, int dst, int k) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int n;\n    cin >> n;\n    int flightsRows, flightsCols;\n    cin >> flightsRows >> flightsCols;\n    vector<vector<int>> flights(flightsRows, vector<int>(flightsCols));\n    for (auto& row : flights) for (int& x : row) cin >> x;\n    int src;\n    cin >> src;\n    int dst;\n    cin >> dst;\n    int k;\n    cin >> k;\n    auto result = findCheapestPrice(n, flights, src, dst, k);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"4\n5 3\n0 1 100\n1 2 100\n2 0 100\n1 3 600\n2 3 200\n0\n3\n1","expected":"700"},{"input":"3\n3 3\n0 1 100\n1 2 100\n0 2 500\n0\n2\n1","expected":"200"},{"input":"3\n3 3\n0 1 100\n1 2 100\n0 2 500\n0\n2\n0","expected":"500"},{"input":"4\n6 3\n1 2 12\n1 3 47\n2 0 59\n0 1 31\n2 1 25\n3 1 32\n0\n3\n1","expected":"78"},{"input":"4\n9 3\n0 1 42\n0 3 32\n1 2 85\n3 0 65\n1 3 20\n1 0 85\n3 2 76\n3 1 77\n0 2 54\n0\n3\n1","expected":"32"},{"input":"5\n8 3\n3 2 30\n2 3 33\n4 2 48\n3 1 87\n2 1 62\n0 1 34\n0 4 45\n1 3 18\n0\n4\n2","expected":"45"}]$j$::jsonb,
  $q$1 <= n <= 100; 0 <= k < n$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon']::text[], ARRAY['bellman-ford','bfs']::text[]);

-- 16 | medium | Surrounded Regions
SELECT pg_temp.seed_coding($q$Graphs$q$, 'medium', $q$Surrounded Regions$q$, $q$The grid holds 1 (wall, 'X') and 0 (open, 'O'). Fill (change to 1) every region of 0s that is completely surrounded by 1s. A region touching the border of the grid is not surrounded and stays 0. Print the final grid.

Input Format:
- board: two integers r and c, then r lines of c space-separated integers

Output Format:
Print each row on its own line, values separated by single spaces.

Example:
Input:
4 4
1 1 1 1
1 0 0 1
1 1 0 1
1 0 1 1
Output:
1 1 1 1
1 1 1 1
1 1 1 1
1 0 1 1$q$,
  $q$def solve_regions(board: List[List[int]]) -> List[List[int]]$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef solve_regions(board: List[List[int]]) -> List[List[int]]:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    rows, cols = int(next(it)), int(next(it))\n    board = [[int(next(it)) for _ in range(cols)] for _ in range(rows)]\n    result = solve_regions(board)\n    print('\\n'.join(' '.join(map(str, row)) for row in result))\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction solveRegions(board) {\n  // Write your solution here\n}\n\nconst boardRows = parseInt(next());\nconst boardCols = parseInt(next());\nconst board = Array.from({ length: boardRows }, () => Array.from({ length: boardCols }, () => parseInt(next())));\nconst result = solveRegions(board);\nconsole.log(result.map((row) => row.join(' ')).join('\\n'));\n","java":"import java.util.*;\n\npublic class Main {\n    static int[][] solveRegions(int[][] board) {\n        // Write your solution here\n        return new int[0][];\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int boardRows = scanner.nextInt(), boardCols = scanner.nextInt();\n        int[][] board = new int[boardRows][boardCols];\n        for (int i = 0; i < boardRows; i++)\n            for (int j = 0; j < boardCols; j++) board[i][j] = scanner.nextInt();\n        int[][] result = solveRegions(board);\n        StringBuilder sb = new StringBuilder();\n        for (int[] row : result) {\n            for (int j = 0; j < row.length; j++) {\n                if (j > 0) sb.append(' ');\n                sb.append(row[j]);\n            }\n            sb.append('\\n');\n        }\n        System.out.print(sb);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nvector<vector<int>> solveRegions(vector<vector<int>> board) {\n    // Write your solution here\n    return {};\n}\n\nint main() {\n    int boardRows, boardCols;\n    cin >> boardRows >> boardCols;\n    vector<vector<int>> board(boardRows, vector<int>(boardCols));\n    for (auto& row : board) for (int& x : row) cin >> x;\n    auto result = solveRegions(board);\n    for (auto& row : result) {\n        for (size_t j = 0; j < row.size(); j++) {\n            if (j) cout << ' ';\n            cout << row[j];\n        }\n        cout << '\\n';\n    }\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"4 4\n1 1 1 1\n1 0 0 1\n1 1 0 1\n1 0 1 1","expected":"1 1 1 1\n1 1 1 1\n1 1 1 1\n1 0 1 1"},{"input":"1 1\n0","expected":"0"},{"input":"3 3\n1 1 1\n1 0 1\n1 1 1","expected":"1 1 1\n1 1 1\n1 1 1"},{"input":"6 4\n1 1 0 1\n1 1 0 0\n0 1 1 0\n1 0 0 0\n0 1 1 0\n0 0 0 1","expected":"1 1 0 1\n1 1 0 0\n0 1 1 0\n1 0 0 0\n0 1 1 0\n0 0 0 1"},{"input":"6 5\n1 1 1 0 1\n1 0 1 1 1\n0 1 1 1 1\n1 1 1 1 0\n0 1 1 1 1\n0 0 1 1 1","expected":"1 1 1 0 1\n1 1 1 1 1\n0 1 1 1 1\n1 1 1 1 0\n0 1 1 1 1\n0 0 1 1 1"},{"input":"5 6\n0 1 0 0 1 1\n1 1 1 0 0 1\n0 1 1 0 0 1\n1 1 1 0 0 1\n0 0 1 0 0 0","expected":"0 1 0 0 1 1\n1 1 1 0 0 1\n0 1 1 0 0 1\n1 1 1 0 0 1\n0 0 1 0 0 0"}]$j$::jsonb,
  $q$1 <= rows, cols <= 200$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon']::text[], ARRAY['dfs','grid']::text[]);

-- 17 | medium | Redundant Connection
SELECT pg_temp.seed_coding($q$Graphs$q$, 'medium', $q$Redundant Connection$q$, $q$An undirected graph on nodes 1..n was a tree, then one extra edge was added. Print the edge that, in input order, is the first one to close a cycle (equivalently, the last edge of the cycle that appears in the input).

Input Format:
- edges: two integers r and c, then r lines of c space-separated integers

Output Format:
Print the integers on one line, separated by single spaces.

Example:
Input:
3 2
1 2
1 3
2 3
Output:
2 3$q$,
  $q$def find_redundant_connection(edges: List[List[int]]) -> List[int]$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef find_redundant_connection(edges: List[List[int]]) -> List[int]:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    rows, cols = int(next(it)), int(next(it))\n    edges = [[int(next(it)) for _ in range(cols)] for _ in range(rows)]\n    result = find_redundant_connection(edges)\n    print(' '.join(map(str, result)))\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction findRedundantConnection(edges) {\n  // Write your solution here\n}\n\nconst edgesRows = parseInt(next());\nconst edgesCols = parseInt(next());\nconst edges = Array.from({ length: edgesRows }, () => Array.from({ length: edgesCols }, () => parseInt(next())));\nconst result = findRedundantConnection(edges);\nconsole.log(result.join(' '));\n","java":"import java.util.*;\n\npublic class Main {\n    static int[] findRedundantConnection(int[][] edges) {\n        // Write your solution here\n        return new int[0];\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int edgesRows = scanner.nextInt(), edgesCols = scanner.nextInt();\n        int[][] edges = new int[edgesRows][edgesCols];\n        for (int i = 0; i < edgesRows; i++)\n            for (int j = 0; j < edgesCols; j++) edges[i][j] = scanner.nextInt();\n        int[] result = findRedundantConnection(edges);\n        StringBuilder sb = new StringBuilder();\n        for (int i = 0; i < result.length; i++) {\n            if (i > 0) sb.append(' ');\n            sb.append(result[i]);\n        }\n        System.out.println(sb);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nvector<int> findRedundantConnection(vector<vector<int>> edges) {\n    // Write your solution here\n    return {};\n}\n\nint main() {\n    int edgesRows, edgesCols;\n    cin >> edgesRows >> edgesCols;\n    vector<vector<int>> edges(edgesRows, vector<int>(edgesCols));\n    for (auto& row : edges) for (int& x : row) cin >> x;\n    auto result = findRedundantConnection(edges);\n    for (size_t i = 0; i < result.size(); i++) {\n        if (i) cout << ' ';\n        cout << result[i];\n    }\n    cout << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"3 2\n1 2\n1 3\n2 3","expected":"2 3"},{"input":"5 2\n1 2\n2 3\n3 4\n1 4\n1 5","expected":"1 4"},{"input":"3 2\n1 2\n2 3\n1 3","expected":"1 3"},{"input":"6 2\n2 6\n2 3\n3 5\n1 6\n1 2\n2 4","expected":"1 2"},{"input":"7 2\n1 2\n2 3\n2 4\n5 6\n2 7\n3 5\n1 4","expected":"1 4"},{"input":"6 2\n1 2\n2 3\n2 6\n1 5\n2 4\n3 6","expected":"3 6"}]$j$::jsonb,
  $q$3 <= n <= 1000$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Accenture']::text[], ARRAY['union-find']::text[]);

-- 18 | medium | Minimum Spanning Tree Weight
SELECT pg_temp.seed_coding($q$Graphs$q$, 'medium', $q$Minimum Spanning Tree Weight$q$, $q$A connected, undirected weighted graph has n vertices (0..n-1). Print the total weight of its minimum spanning tree.

Input Format:
- n: a single integer
- edges: two integers r and c, then r lines of c space-separated integers

Output Format:
Print a single integer.

Example:
Input:
4
5 3
0 1 1
1 2 2
2 3 3
0 3 4
0 2 5
Output:
6$q$,
  $q$def mst_weight(n: int, edges: List[List[int]]) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef mst_weight(n: int, edges: List[List[int]]) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    n = int(next(it))\n    rows, cols = int(next(it)), int(next(it))\n    edges = [[int(next(it)) for _ in range(cols)] for _ in range(rows)]\n    result = mst_weight(n, edges)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction mstWeight(n, edges) {\n  // Write your solution here\n}\n\nconst n = parseInt(next());\nconst edgesRows = parseInt(next());\nconst edgesCols = parseInt(next());\nconst edges = Array.from({ length: edgesRows }, () => Array.from({ length: edgesCols }, () => parseInt(next())));\nconst result = mstWeight(n, edges);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int mstWeight(int n, int[][] edges) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int n = scanner.nextInt();\n        int edgesRows = scanner.nextInt(), edgesCols = scanner.nextInt();\n        int[][] edges = new int[edgesRows][edgesCols];\n        for (int i = 0; i < edgesRows; i++)\n            for (int j = 0; j < edgesCols; j++) edges[i][j] = scanner.nextInt();\n        int result = mstWeight(n, edges);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint mstWeight(int n, vector<vector<int>> edges) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int n;\n    cin >> n;\n    int edgesRows, edgesCols;\n    cin >> edgesRows >> edgesCols;\n    vector<vector<int>> edges(edgesRows, vector<int>(edgesCols));\n    for (auto& row : edges) for (int& x : row) cin >> x;\n    auto result = mstWeight(n, edges);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"4\n5 3\n0 1 1\n1 2 2\n2 3 3\n0 3 4\n0 2 5","expected":"6"},{"input":"2\n1 3\n0 1 9","expected":"9"},{"input":"3\n3 3\n0 1 4\n1 2 6\n0 2 5","expected":"9"},{"input":"5\n7 3\n0 1 8\n0 2 1\n2 3 9\n1 4 7\n2 4 3\n3 4 7\n1 3 5","expected":"16"},{"input":"6\n6 3\n0 1 8\n1 2 4\n1 3 8\n3 4 6\n1 5 3\n0 4 5","expected":"26"},{"input":"5\n6 3\n0 1 9\n0 2 8\n2 3 2\n0 4 1\n1 4 8\n2 4 4","expected":"15"}]$j$::jsonb,
  $q$2 <= n <= 1000; the graph is connected$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Infosys','Accenture']::text[], ARRAY['kruskal','union-find','greedy']::text[]);

-- 19 | medium | Count Paths in a DAG
SELECT pg_temp.seed_coding($q$Graphs$q$, 'medium', $q$Count Paths in a DAG$q$, $q$A directed acyclic graph has n vertices (0..n-1). Print the number of distinct paths from src to dst.

Input Format:
- n: a single integer
- edges: two integers r and c, then r lines of c space-separated integers
- src: a single integer
- dst: a single integer

Output Format:
Print a single integer.

Example:
Input:
4
4 2
0 1
0 2
1 3
2 3
0
3
Output:
2$q$,
  $q$def count_paths(n: int, edges: List[List[int]], src: int, dst: int) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef count_paths(n: int, edges: List[List[int]], src: int, dst: int) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    n = int(next(it))\n    rows, cols = int(next(it)), int(next(it))\n    edges = [[int(next(it)) for _ in range(cols)] for _ in range(rows)]\n    src = int(next(it))\n    dst = int(next(it))\n    result = count_paths(n, edges, src, dst)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction countPaths(n, edges, src, dst) {\n  // Write your solution here\n}\n\nconst n = parseInt(next());\nconst edgesRows = parseInt(next());\nconst edgesCols = parseInt(next());\nconst edges = Array.from({ length: edgesRows }, () => Array.from({ length: edgesCols }, () => parseInt(next())));\nconst src = parseInt(next());\nconst dst = parseInt(next());\nconst result = countPaths(n, edges, src, dst);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int countPaths(int n, int[][] edges, int src, int dst) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int n = scanner.nextInt();\n        int edgesRows = scanner.nextInt(), edgesCols = scanner.nextInt();\n        int[][] edges = new int[edgesRows][edgesCols];\n        for (int i = 0; i < edgesRows; i++)\n            for (int j = 0; j < edgesCols; j++) edges[i][j] = scanner.nextInt();\n        int src = scanner.nextInt();\n        int dst = scanner.nextInt();\n        int result = countPaths(n, edges, src, dst);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint countPaths(int n, vector<vector<int>> edges, int src, int dst) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int n;\n    cin >> n;\n    int edgesRows, edgesCols;\n    cin >> edgesRows >> edgesCols;\n    vector<vector<int>> edges(edgesRows, vector<int>(edgesCols));\n    for (auto& row : edges) for (int& x : row) cin >> x;\n    int src;\n    cin >> src;\n    int dst;\n    cin >> dst;\n    auto result = countPaths(n, edges, src, dst);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"4\n4 2\n0 1\n0 2\n1 3\n2 3\n0\n3","expected":"2"},{"input":"3\n3 2\n0 1\n1 2\n0 2\n0\n2","expected":"2"},{"input":"2\n1 2\n0 1\n0\n1","expected":"1"},{"input":"7\n9 2\n0 5\n0 6\n1 3\n1 4\n1 6\n2 4\n2 5\n3 6\n4 6\n0\n6","expected":"1"},{"input":"6\n11 2\n0 1\n0 2\n0 5\n1 3\n1 4\n1 5\n2 3\n2 5\n3 4\n3 5\n4 5\n0\n5","expected":"8"},{"input":"4\n6 2\n0 1\n0 2\n0 3\n1 2\n1 3\n2 3\n0\n3","expected":"4"}]$j$::jsonb,
  $q$1 <= n <= 1000; answer fits in 32 bits$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Infosys','Accenture']::text[], ARRAY['dag','dp','dfs']::text[]);

-- 20 | medium | Operations to Make Network Connected
SELECT pg_temp.seed_coding($q$Graphs$q$, 'medium', $q$Operations to Make Network Connected$q$, $q$There are n computers (0..n-1) joined by cables, connections[i] = [a, b]. In one operation you may move one existing cable to join any two computers. Print the minimum number of operations to connect all computers, or -1 if impossible.

Input Format:
- n: a single integer
- connections: two integers r and c, then r lines of c space-separated integers

Output Format:
Print a single integer.

Example:
Input:
4
3 2
0 1
0 2
1 2
Output:
1$q$,
  $q$def make_connected(n: int, connections: List[List[int]]) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef make_connected(n: int, connections: List[List[int]]) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    n = int(next(it))\n    rows, cols = int(next(it)), int(next(it))\n    connections = [[int(next(it)) for _ in range(cols)] for _ in range(rows)]\n    result = make_connected(n, connections)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction makeConnected(n, connections) {\n  // Write your solution here\n}\n\nconst n = parseInt(next());\nconst connectionsRows = parseInt(next());\nconst connectionsCols = parseInt(next());\nconst connections = Array.from({ length: connectionsRows }, () => Array.from({ length: connectionsCols }, () => parseInt(next())));\nconst result = makeConnected(n, connections);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int makeConnected(int n, int[][] connections) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int n = scanner.nextInt();\n        int connectionsRows = scanner.nextInt(), connectionsCols = scanner.nextInt();\n        int[][] connections = new int[connectionsRows][connectionsCols];\n        for (int i = 0; i < connectionsRows; i++)\n            for (int j = 0; j < connectionsCols; j++) connections[i][j] = scanner.nextInt();\n        int result = makeConnected(n, connections);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint makeConnected(int n, vector<vector<int>> connections) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int n;\n    cin >> n;\n    int connectionsRows, connectionsCols;\n    cin >> connectionsRows >> connectionsCols;\n    vector<vector<int>> connections(connectionsRows, vector<int>(connectionsCols));\n    for (auto& row : connections) for (int& x : row) cin >> x;\n    auto result = makeConnected(n, connections);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"4\n3 2\n0 1\n0 2\n1 2","expected":"1"},{"input":"6\n5 2\n0 1\n0 2\n0 3\n1 2\n1 3","expected":"2"},{"input":"6\n4 2\n0 1\n0 2\n0 3\n1 2","expected":"-1"},{"input":"6\n5 2\n0 5\n3 4\n2 5\n2 4\n0 1","expected":"0"},{"input":"6\n7 2\n1 4\n2 5\n1 2\n2 3\n0 3\n1 5\n3 4","expected":"0"},{"input":"6\n5 2\n2 4\n2 3\n1 3\n0 1\n0 3","expected":"1"}]$j$::jsonb,
  $q$1 <= n <= 10^5$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon','Infosys']::text[], ARRAY['union-find']::text[]);

-- 21 | hard | Word Ladder
SELECT pg_temp.seed_coding($q$Graphs$q$, 'hard', $q$Word Ladder$q$, $q$Transform beginWord into endWord by changing exactly one letter at a time; every intermediate word (and endWord) must be in the word list. Print the number of words in the shortest transformation sequence, counting beginWord and endWord, or 0 if none exists.

Input Format:
- begin_word: a single string (no spaces)
- end_word: a single string (no spaces)
- word_list: an integer n, then n space-separated strings

Output Format:
Print a single integer.

Example:
Input:
hit
cog
6
hot dot dog lot log cog
Output:
5$q$,
  $q$def ladder_length(begin_word: str, end_word: str, word_list: List[str]) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef ladder_length(begin_word: str, end_word: str, word_list: List[str]) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    begin_word = next(it)\n    end_word = next(it)\n    word_list = [next(it) for _ in range(int(next(it)))]\n    result = ladder_length(begin_word, end_word, word_list)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction ladderLength(begin_word, end_word, word_list) {\n  // Write your solution here\n}\n\nconst begin_word = next();\nconst end_word = next();\nconst word_list = Array.from({ length: parseInt(next()) }, () => next());\nconst result = ladderLength(begin_word, end_word, word_list);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int ladderLength(String begin_word, String end_word, String[] word_list) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String begin_word = scanner.next();\n        String end_word = scanner.next();\n        String[] word_list = new String[scanner.nextInt()];\n        for (int i = 0; i < word_list.length; i++) word_list[i] = scanner.next();\n        int result = ladderLength(begin_word, end_word, word_list);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint ladderLength(string begin_word, string end_word, vector<string> word_list) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    string begin_word;\n    cin >> begin_word;\n    string end_word;\n    cin >> end_word;\n    int word_listN;\n    cin >> word_listN;\n    vector<string> word_list(word_listN);\n    for (string& x : word_list) cin >> x;\n    auto result = ladderLength(begin_word, end_word, word_list);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"hit\ncog\n6\nhot dot dog lot log cog","expected":"5"},{"input":"hit\ncog\n5\nhot dot dog lot log","expected":"0"},{"input":"aa\nab\n1\nab","expected":"2"},{"input":"cba\nacc\n8\nacc cac bab cca ccc abc acb aac","expected":"4"},{"input":"bcb\nbaa\n8\nbaa aac aca aba bca bcc bcb cba","expected":"3"},{"input":"caa\ncba\n7\ncba cbc bba acc ccc bcc aba","expected":"2"}]$j$::jsonb,
  $q$1 <= length <= 10; all words have equal length$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon']::text[], ARRAY['bfs','strings']::text[]);

-- 22 | hard | Number of Ways to Arrive at Destination
SELECT pg_temp.seed_coding($q$Graphs$q$, 'hard', $q$Number of Ways to Arrive at Destination$q$, $q$A connected, undirected graph has n intersections (0..n-1) and roads [u, v, time]. Print the number of different shortest-time paths from intersection 0 to n-1, modulo 1000000007.

Input Format:
- n: a single integer
- roads: two integers r and c, then r lines of c space-separated integers

Output Format:
Print a single integer.

Example:
Input:
7
10 3
0 6 7
0 1 2
1 2 3
1 3 3
6 3 3
3 5 1
6 5 1
2 5 1
0 4 5
4 6 2
Output:
4$q$,
  $q$def count_paths_shortest(n: int, roads: List[List[int]]) -> int$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef count_paths_shortest(n: int, roads: List[List[int]]) -> int:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    n = int(next(it))\n    rows, cols = int(next(it)), int(next(it))\n    roads = [[int(next(it)) for _ in range(cols)] for _ in range(rows)]\n    result = count_paths_shortest(n, roads)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction countPathsShortest(n, roads) {\n  // Write your solution here\n}\n\nconst n = parseInt(next());\nconst roadsRows = parseInt(next());\nconst roadsCols = parseInt(next());\nconst roads = Array.from({ length: roadsRows }, () => Array.from({ length: roadsCols }, () => parseInt(next())));\nconst result = countPathsShortest(n, roads);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static int countPathsShortest(int n, int[][] roads) {\n        // Write your solution here\n        return 0;\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        int n = scanner.nextInt();\n        int roadsRows = scanner.nextInt(), roadsCols = scanner.nextInt();\n        int[][] roads = new int[roadsRows][roadsCols];\n        for (int i = 0; i < roadsRows; i++)\n            for (int j = 0; j < roadsCols; j++) roads[i][j] = scanner.nextInt();\n        int result = countPathsShortest(n, roads);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nint countPathsShortest(int n, vector<vector<int>> roads) {\n    // Write your solution here\n    return 0;\n}\n\nint main() {\n    int n;\n    cin >> n;\n    int roadsRows, roadsCols;\n    cin >> roadsRows >> roadsCols;\n    vector<vector<int>> roads(roadsRows, vector<int>(roadsCols));\n    for (auto& row : roads) for (int& x : row) cin >> x;\n    auto result = countPathsShortest(n, roads);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"7\n10 3\n0 6 7\n0 1 2\n1 2 3\n1 3 3\n6 3 3\n3 5 1\n6 5 1\n2 5 1\n0 4 5\n4 6 2","expected":"4"},{"input":"2\n1 3\n1 0 10","expected":"1"},{"input":"4\n4 3\n0 1 1\n0 2 1\n1 3 1\n2 3 1","expected":"2"},{"input":"8\n9 3\n0 1 3\n1 2 3\n0 3 1\n1 4 3\n1 5 3\n4 6 3\n5 7 2\n5 6 2\n3 7 3","expected":"1"},{"input":"7\n8 3\n0 1 1\n1 2 3\n2 3 3\n2 4 1\n3 5 2\n5 6 2\n1 6 1\n3 4 2","expected":"1"},{"input":"5\n7 3\n0 1 2\n1 2 3\n2 3 1\n0 4 1\n1 3 1\n3 4 3\n2 4 1","expected":"1"}]$j$::jsonb,
  $q$2 <= n <= 200$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon']::text[], ARRAY['dijkstra','counting']::text[]);

-- 23 | hard | Alien Dictionary
SELECT pg_temp.seed_coding($q$Graphs$q$, 'hard', $q$Alien Dictionary$q$, $q$Words are sorted in the dictionary of an alien language whose alphabet order is unknown. Derive the order of the letters that appear. When more than one order fits, print the lexicographically smallest (in normal alphabetical comparison). Print -1 if the ordering is contradictory.

Input Format:
- words: an integer n, then n space-separated strings

Output Format:
Print the resulting string.

Example:
Input:
5
wrt wrf er ett rftt
Output:
wertf$q$,
  $q$def alien_order(words: List[str]) -> str$q$, $j${"python":"import sys\nfrom typing import List, Optional\n\ndef alien_order(words: List[str]) -> str:\n    # Write your solution here\n    pass\n\n\ndef main():\n    it = iter(sys.stdin.read().split())\n    words = [next(it) for _ in range(int(next(it)))]\n    result = alien_order(words)\n    print(result)\n\n\nmain()\n","javascript":"const tokens = require('fs').readFileSync(0, 'utf8').split(/\\s+/).filter(Boolean);\nlet pos = 0;\nconst next = () => tokens[pos++];\n\nfunction alienOrder(words) {\n  // Write your solution here\n}\n\nconst words = Array.from({ length: parseInt(next()) }, () => next());\nconst result = alienOrder(words);\nconsole.log(String(result));\n","java":"import java.util.*;\n\npublic class Main {\n    static String alienOrder(String[] words) {\n        // Write your solution here\n        return \"\";\n    }\n\n    public static void main(String[] mainArgs) {\n        Scanner scanner = new Scanner(System.in);\n        String[] words = new String[scanner.nextInt()];\n        for (int i = 0; i < words.length; i++) words[i] = scanner.next();\n        String result = alienOrder(words);\n        System.out.println(result);\n    }\n}\n","cpp":"#include <bits/stdc++.h>\nusing namespace std;\n\nstring alienOrder(vector<string> words) {\n    // Write your solution here\n    return \"\";\n}\n\nint main() {\n    int wordsN;\n    cin >> wordsN;\n    vector<string> words(wordsN);\n    for (string& x : words) cin >> x;\n    auto result = alienOrder(words);\n    cout << result << endl;\n    return 0;\n}\n"}$j$::jsonb, $j$[{"input":"5\nwrt wrf er ett rftt","expected":"wertf"},{"input":"2\nz x","expected":"zx"},{"input":"3\nz x z","expected":"-1"},{"input":"2\nabc ab","expected":"-1"},{"input":"5\ncda bcf a ada d","expected":"cbadf"},{"input":"5\naf ab e c caa","expected":"aecfb"},{"input":"6\nd b bcb cfb fd fef","expected":"dbcef"}]$j$::jsonb,
  $q$1 <= n <= 100; lowercase letters$q$, 2000, 131072, ARRAY[71,63,62,54],
  ARRAY['Amazon']::text[], ARRAY['topological-sort','graph']::text[]);


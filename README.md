# Wipro LAB-1C — Collections and Enums

## Objective
Store and transform related data using `Array`, `Set`, `Dictionary`, and `enum`.

---

## Project Structure

```
Wipro-LAB-1C/
├── main.swift             ← Entry point — runs all 5 tasks with output
├── CollectionsDemo.swift  ← Tasks 1, 2, 3, 5 — Array, Set, Dictionary structs
├── Enums.swift            ← Task 4 — TaskPriority & OrderStatus enums
└── README.md              ← This file
```

---

## How to Run

**Option A — Swift CLI (macOS/Linux)**
```bash
swift main.swift CollectionsDemo.swift Enums.swift
```

**Option B — Xcode**
1. File → New → Project → Command Line Tool (Swift)
2. Replace generated files with the three `.swift` files.
3. Run (⌘R).

**Option C — Online**  
Paste in order (CollectionsDemo → Enums → main) at [swiftfiddle.com](https://swiftfiddle.com).

---

## Task Coverage

| # | Task | File | Key APIs Used |
|---|------|------|---------------|
| 1 | Array: add, remove, sort, filter, search | `CollectionsDemo.swift` | `append`, `remove(at:)`, `sorted()`, `filter`, `contains`, `firstIndex(of:)` |
| 2 | Set: deduplicate student IDs | `CollectionsDemo.swift` | `Set(array)`, `subtracting`, `intersection`, `union` |
| 3 | Dictionary: topper, below-threshold | `CollectionsDemo.swift` | `max(by:)`, `filter`, `removeValue(forKey:)`, subscript update |
| 4 | Enum with switch + associated values | `Enums.swift` | `enum`, `switch`, `CaseIterable`, `Comparable`, associated values |
| 5 | When to use each collection | `main.swift` Section 5 | Explanation table (see below) |

---

## When to Use Each Collection

| Collection | Best Used When | Example in This Lab |
|-----------|----------------|---------------------|
| `Array` | Order matters; duplicates allowed; index access needed | Ordered list of course names |
| `Set` | Uniqueness required; fast membership check; set algebra | Deduplicating student IDs |
| `Dictionary` | Key→value mapping; O(1) lookup by identifier | Student ID → marks |

**Rule of thumb:**
- "Need order?" → `Array`
- "Need uniqueness?" → `Set`
- "Need key→value?" → `Dictionary`

---

## Enum Design

### `TaskPriority` (raw value + Comparable + CaseIterable)
```swift
enum TaskPriority: Int, CaseIterable, Comparable {
    case low = 1 | medium = 2 | high = 3 | critical = 4
}
```
- `rawValue` enables `Comparable` sorting
- `CaseIterable` allows `allCases` iteration
- `switch` maps each case to a user-friendly label, action string, and SLA hours

### `OrderStatus` (associated values)
```swift
enum OrderStatus {
    case pending
    case confirmed(confirmationCode: String)
    case inProgress(completedModules: Int, totalModules: Int)
    case completed(grade: String)
    case cancelled(reason: String)
}
```
- Associated values carry context-specific data
- `switch` pattern-matching extracts and uses them directly

---

## Sample Output (Key Sections)

```
════════════════════════════════════════════════════════
  TASK 1 · Array — Course Management
════════════════════════════════════════════════════════
  Initial Courses [6]: ["Swift Programming", "Data Structures", ...]
  ➕ Added: 'Cloud Computing'
  ➕ Added: 'Cybersecurity'
  ⚠️  Cannot add an empty course name.
  🗑️  Removed: 'Web Technologies'
  ⚠️  'Physics' not found in list.
  Matches (keyword 'data'): Data Structures

════════════════════════════════════════════════════════
  TASK 2 · Set — Duplicate Student ID Removal
════════════════════════════════════════════════════════
  Raw IDs     [9]: [101, 102, 103, 101, 104, 102, 105, 103, 106]
  Unique IDs  [6]: [101, 102, 103, 104, 105, 106]
  Duplicates removed : 3

════════════════════════════════════════════════════════
  TASK 3 · Dictionary — Student Marks Gradebook
════════════════════════════════════════════════════════
  🏆 Topper: Student ID 107 with 95 marks
  Class average: 65.50
  ⚠️  ID 105 → 38 marks (needs support)
  ⚠️  ID 110 → 29 marks (needs support)

════════════════════════════════════════════════════════
  TASK 4 · Enums — Task Priority & Order Status
════════════════════════════════════════════════════════
  🟢 Low       → Schedule it for later in the week.    [SLA: 72h]
  🟡 Medium    → Plan to complete within 2 days.       [SLA: 48h]
  🟠 High      → Start today; deadline is near.        [SLA: 24h]
  🔴 Critical  → Drop everything — do it NOW.          [SLA: 4h]
```

---

## Test / Validation Table (10+ Cases)

| # | Operation | Input | Expected Output | Notes |
|---|-----------|-------|-----------------|-------|
| 1 | Array add | "Cloud Computing" | Added ✅ | Normal |
| 2 | Array add | "" (empty string) | Warning ⚠️ | Boundary — empty |
| 3 | Array remove | "Web Technologies" | Removed ✅ | Present |
| 4 | Array remove | "Physics" | Warning ⚠️ | Not in list |
| 5 | Array filter | keyword "data" | ["Data Structures"] | Case-insensitive |
| 6 | Array search | "iOS Development" | ✅ Yes | Present |
| 7 | Array search | "Blockchain" | ❌ No | Absent |
| 8 | Set dedup | [101,102,101,103] | Unique: [101,102,103] | 1 dup removed |
| 9 | Set intersection | A∩B | [104, 105] | Common students |
| 10 | Dict topper | marks dict | ID 107, 95 marks | max(by:) |
| 11 | Dict below 50 | threshold=50 | IDs 105(38), 110(29) | filter |
| 12 | Dict update | ID 105 re-exam=55 | Updated ✅ | Mutable dict |
| 13 | Dict remove | ID 999 | Warning ⚠️ | Key not found |
| 14 | Enum switch | .critical | "🔴 Critical — Drop everything" | Exact label |
| 15 | OrderStatus | .inProgress(3,8) | "🔄 3/8 modules — 37%" | Associated value |

---

*Submitted by: Shyam Dixit | Wipro LAB-1C*

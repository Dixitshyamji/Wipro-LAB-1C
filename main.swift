

import Foundation
func banner(_ title: String) {
    let line = String(repeating: "═", count: 56)
    print("\n\(line)")
    print("  \(title)")
    print(line)
}

func subheader(_ title: String) {
    print("\n  ── \(title) " + String(repeating: "─", count: max(0, 44 - title.count)))
}

banner("TASK 1 · Array — Course Management")

var cm = CourseManager()
cm.printAll(label: "Initial Courses")

subheader("Add courses")
cm.add("Cloud Computing")
cm.add("Cybersecurity")
cm.add("")                      

subheader("Remove a course")
cm.remove("Web Technologies")
cm.remove("Physics")/           

subheader("All courses after edits")
cm.printAll()

subheader("Sort alphabetically")
print("  Sorted: \(cm.sorted())")

subheader("Filter (keyword: 'data')")
let filtered = cm.filter(keyword: "data")
print("  Matches: \(filtered.isEmpty ? "None" : filtered.joined(separator: ", "))")

subheader("Search")
let searchTerms = ["iOS Development", "Blockchain"]
for term in searchTerms {
    print("  '\(term)' exists? \(cm.contains(term) ? "✅ Yes" : "❌ No")")
}

subheader("Iterate with index (map to uppercase)")
let upperCourses = cm.sorted().enumerated().map { "\($0.offset + 1). \($0.element.uppercased())" }
upperCourses.forEach { print("  \($0)") }


banner("TASK 2 · Set — Duplicate Student ID Removal")

let sectionA = StudentIDRegistry(rawIDs: [101, 102, 103, 101, 104, 102, 105, 103, 106])
let sectionB = StudentIDRegistry(rawIDs: [104, 107, 108, 104, 109, 105, 110])

subheader("Section A")
sectionA.report()

subheader("Section B")
sectionB.report()

subheader("Set Operations")
let onlyInA = sectionA.exclusiveIDs(comparedTo: sectionB)
let onlyInB = sectionB.exclusiveIDs(comparedTo: sectionA)
let inBoth  = sectionA.commonIDs(with: sectionB)
let allUnique = sectionA.uniqueIDs.union(sectionB.uniqueIDs)

print("  Only in A       : \(onlyInA.sorted())")
print("  Only in B       : \(onlyInB.sorted())")
print("  In both A & B   : \(inBoth.sorted())")
print("  All unique IDs  : \(allUnique.sorted()) [\(allUnique.count) students]")


banner("TASK 3 · Dictionary — Student Marks Gradebook")

var gradebook = Gradebook([
    101: 88,  102: 56,  103: 91,  104: 73,
    105: 38,  106: 62,  107: 95,  108: 44,
    109: 79,  110: 29
])

subheader("All student records")
gradebook.printAll()

subheader("Topper")
if let top = gradebook.topper {
    print("  🏆 Student ID \(top.id) with \(top.marks) marks")
}

subheader("Average marks")
print(String(format: "  Class average: %.2f", gradebook.average))

subheader("Students below threshold (50 marks)")
let below50 = gradebook.studentsBelowThreshold(50)
if below50.isEmpty {
    print("  None — all above threshold.")
} else {
    for (id, marks) in below50.sorted(by: { $0.key < $1.key }) {
        print(String(format: "    ⚠️  ID %03d → %d marks (needs support)", id, marks))
    }
}

subheader("Add / Update records")
gradebook.updateMarks(for: 111, marks: 83)   
gradebook.updateMarks(for: 105, marks: 55)   

subheader("Remove a student")
gradebook.remove(id: 108)
gradebook.remove(id: 999)                    

subheader("After edits — total students: \(gradebook.count)")
gradebook.printAll()


banner("TASK 4 · Enums — Task Priority & Order Status")

subheader("All TaskPriority levels (switch demo)")
for priority in TaskPriority.allCases.sorted() {
    print("  \(priority.label)  →  \(priority.action)  [SLA: \(priority.slaHours)h]")
}

subheader("LabTask objects using both enums")
let tasks: [LabTask] = [
    LabTask(title: "Submit LAB-1A Report",
            priority: .critical,
            status:   .pending),
    LabTask(title: "Complete Swift Playground",
            priority: .high,
            status:   .confirmed(confirmationCode: "WPR-2024-88")),
    LabTask(title: "Revise Data Structures",
            priority: .medium,
            status:   .inProgress(completedModules: 3, totalModules: 8)),
    LabTask(title: "Read Swift Documentation",
            priority: .low,
            status:   .completed(grade: "A+")),
    LabTask(title: "Watch OOP Lecture",
            priority: .medium,
            status:   .cancelled(reason: "Rescheduled to next sprint")),
]

for (i, task) in tasks.enumerated() {
    print("\n  [\(i + 1)]")
    task.describe()
}

subheader("Filter: only HIGH or CRITICAL tasks")
let urgent = tasks.filter { $0.priority >= .high }
print("  Urgent tasks (\(urgent.count)): \(urgent.map { $0.title }.joined(separator: ", "))")

subheader("Sort tasks by priority (highest first)")
let sorted = tasks.sorted { $0.priority > $1.priority }
sorted.forEach { print("  \($0.priority.label)  →  \($0.title)") }


banner("TASK 5 · When to Use Array vs Set vs Dictionary")

print("""

  ┌─────────────┬────────────────────────────────────────────────────┐
  │  Collection │  Best Used When …                                  │
  ├─────────────┼────────────────────────────────────────────────────┤
  │  Array      │  • Order matters (rank, sequence, playlist)        │
  │             │  • Duplicates are meaningful (exam attempts)       │
  │             │  • Index-based access needed                       │
  │             │  • Example: list of course names, student scores   │
  ├─────────────┼────────────────────────────────────────────────────┤
  │  Set        │  • Uniqueness must be enforced automatically       │
  │             │  • Fast membership testing (O(1))                  │
  │             │  • Set operations: union, intersection, difference │
  │             │  • Example: enrolled student IDs, tagged categories│
  ├─────────────┼────────────────────────────────────────────────────┤
  │  Dictionary │  • Key-value mapping with fast lookup by key (O(1))│
  │             │  • Relationship between two values (ID → marks)    │
  │             │  • No natural ordering needed                      │
  │             │  • Example: student ID → grade, course → credits  │
  └─────────────┴────────────────────────────────────────────────────┘

  Rule of thumb:
    "Need order?"       → Array
    "Need uniqueness?"  → Set
    "Need a key→value?" → Dictionary
""")

print("✅ LAB-1C Complete — Collections and Enums\n")

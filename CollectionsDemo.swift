// ============================================================
// CollectionsDemo.swift
// Wipro LAB-1C — Collections and Enums
//
// Covers Tasks 1, 2, 3, and 5:
//   Task 1 → Array of course names (add, remove, sort, filter, search)
//   Task 2 → Set for duplicate student ID removal
//   Task 3 → Dictionary mapping student IDs to marks
//   Task 5 → When to use Array vs Set vs Dictionary (explained inline + README)
// ============================================================

import Foundation

// ================================================================
// MARK: - TASK 1: Array of Course Names
// ================================================================

/// Manages a mutable list of course names.
/// WHY ARRAY? — Ordered, allows duplicates, supports index-based access.
struct CourseManager {

    private var courses: [String] = [
        "Swift Programming",
        "Data Structures",
        "iOS Development",
        "Machine Learning",
        "Web Technologies",
        "Database Systems"
    ]

    // ── Add a course ────────────────────────────────────────
    mutating func add(_ course: String) {
        guard !course.trimmingCharacters(in: .whitespaces).isEmpty else {
            print("  ⚠️  Cannot add an empty course name.")
            return
        }
        courses.append(course)
        print("  ➕ Added: '\(course)'")
    }

    // ── Remove a course by name ──────────────────────────────
    mutating func remove(_ course: String) {
        if let idx = courses.firstIndex(of: course) {
            courses.remove(at: idx)
            print("  🗑️  Removed: '\(course)'")
        } else {
            print("  ⚠️  '\(course)' not found in list.")
        }
    }

    // ── Sort alphabetically ──────────────────────────────────
    func sorted() -> [String] { courses.sorted() }

    // ── Filter: courses containing a keyword (case-insensitive) ─
    func filter(keyword: String) -> [String] {
        courses.filter { $0.lowercased().contains(keyword.lowercased()) }
    }

    // ── Search: check if a specific course exists ────────────
    func contains(_ course: String) -> Bool {
        courses.contains(course)
    }

    // ── Print all courses ────────────────────────────────────
    func printAll(label: String = "Courses") {
        print("  \(label) [\(courses.count)]: \(courses)")
    }

    var count: Int { courses.count }
    var all:   [String] { courses }
}

// ================================================================
// MARK: - TASK 2: Set for Duplicate Student ID Removal
// ================================================================

/// WHY SET? — Automatically enforces uniqueness; O(1) lookup; no guaranteed order.
struct StudentIDRegistry {

    /// Raw incoming IDs (may contain duplicates)
    let rawIDs: [Int]

    /// Deduplicated IDs using a Set
    var uniqueIDs: Set<Int> { Set(rawIDs) }

    var duplicateCount: Int { rawIDs.count - uniqueIDs.count }

    func report() {
        print("  Raw IDs     [\(rawIDs.count)]: \(rawIDs)")
        print("  Unique IDs  [\(uniqueIDs.count)]: \(uniqueIDs.sorted())")
        print("  Duplicates removed : \(duplicateCount)")
    }

    /// Students present in A but not in B
    func exclusiveIDs(comparedTo other: StudentIDRegistry) -> Set<Int> {
        uniqueIDs.subtracting(other.uniqueIDs)
    }

    /// Students common to both registries
    func commonIDs(with other: StudentIDRegistry) -> Set<Int> {
        uniqueIDs.intersection(other.uniqueIDs)
    }
}

// ================================================================
// MARK: - TASK 3: Dictionary — Student ID → Marks
// ================================================================

/// WHY DICTIONARY? — Key-value lookup; O(1) access by student ID; no ordering needed.
struct Gradebook {

    private var records: [Int: Int]   // [studentID: marks]

    init(_ records: [Int: Int]) {
        self.records = records
    }

    // ── Topper ───────────────────────────────────────────────
    var topper: (id: Int, marks: Int)? {
        guard let max = records.max(by: { $0.value < $1.value }) else { return nil }
        return (id: max.key, marks: max.value)
    }

    // ── Students below a threshold ───────────────────────────
    func studentsBelowThreshold(_ threshold: Int) -> [Int: Int] {
        records.filter { $0.value < threshold }
    }

    // ── Add or update a student's marks ─────────────────────
    mutating func updateMarks(for id: Int, marks: Int) {
        let action = records[id] == nil ? "Added" : "Updated"
        records[id] = marks
        print("  \(action) → ID \(id): \(marks) marks")
    }

    // ── Remove a student ────────────────────────────────────
    mutating func remove(id: Int) {
        if records.removeValue(forKey: id) != nil {
            print("  🗑️  Removed student ID \(id)")
        } else {
            print("  ⚠️  Student ID \(id) not found")
        }
    }

    // ── Stats ────────────────────────────────────────────────
    var average: Double {
        guard !records.isEmpty else { return 0 }
        return Double(records.values.reduce(0, +)) / Double(records.count)
    }

    func printAll() {
        for (id, marks) in records.sorted(by: { $0.key < $1.key }) {
            print(String(format: "    ID %03d → %3d marks", id, marks))
        }
    }

    var count: Int { records.count }
}

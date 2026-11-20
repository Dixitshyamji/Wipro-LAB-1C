

import Foundation


struct CourseManager {

    private var courses: [String] = [
        "Swift Programming",
        "Data Structures",
        "iOS Development",
        "Machine Learning",
        "Web Technologies",
        "Database Systems"
    ]

    mutating func add(_ course: String) {
        guard !course.trimmingCharacters(in: .whitespaces).isEmpty else {
            print("  ⚠️  Cannot add an empty course name.")
            return
        }
        courses.append(course)
        print("  ➕ Added: '\(course)'")
    }

    mutating func remove(_ course: String) {
        if let idx = courses.firstIndex(of: course) {
            courses.remove(at: idx)
            print("  🗑️  Removed: '\(course)'")
        } else {
            print("  ⚠️  '\(course)' not found in list.")
        }
    }

    func sorted() -> [String] { courses.sorted() }

    func filter(keyword: String) -> [String] {
        courses.filter { $0.lowercased().contains(keyword.lowercased()) }
    }

    func contains(_ course: String) -> Bool {
        courses.contains(course)
    }

    func printAll(label: String = "Courses") {
        print("  \(label) [\(courses.count)]: \(courses)")
    }

    var count: Int { courses.count }
    var all:   [String] { courses }
}


struct StudentIDRegistry {

    let rawIDs: [Int]

    var uniqueIDs: Set<Int> { Set(rawIDs) }

    var duplicateCount: Int { rawIDs.count - uniqueIDs.count }

    func report() {
        print("  Raw IDs     [\(rawIDs.count)]: \(rawIDs)")
        print("  Unique IDs  [\(uniqueIDs.count)]: \(uniqueIDs.sorted())")
        print("  Duplicates removed : \(duplicateCount)")
    }

    func exclusiveIDs(comparedTo other: StudentIDRegistry) -> Set<Int> {
        uniqueIDs.subtracting(other.uniqueIDs)
    }

    func commonIDs(with other: StudentIDRegistry) -> Set<Int> {
        uniqueIDs.intersection(other.uniqueIDs)
    }
}

.
struct Gradebook {

    private var records: [Int: Int]   

    init(_ records: [Int: Int]) {
        self.records = records
    }

    var topper: (id: Int, marks: Int)? {
        guard let max = records.max(by: { $0.value < $1.value }) else { return nil }
        return (id: max.key, marks: max.value)
    }

    func studentsBelowThreshold(_ threshold: Int) -> [Int: Int] {
        records.filter { $0.value < threshold }
    }

    mutating func updateMarks(for id: Int, marks: Int) {
        let action = records[id] == nil ? "Added" : "Updated"
        records[id] = marks
        print("  \(action) → ID \(id): \(marks) marks")
    }

    mutating func remove(id: Int) {
        if records.removeValue(forKey: id) != nil {
            print("  🗑️  Removed student ID \(id)")
        } else {
            print("  ⚠️  Student ID \(id) not found")
        }
    }

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

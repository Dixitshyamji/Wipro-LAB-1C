// ============================================================
// Enums.swift
// Wipro LAB-1C — Collections and Enums
//
// Task 4: enum for task priority AND order status
//         switch to display user-friendly labels + actions
// ============================================================

import Foundation

// ================================================================
// MARK: - Task Priority Enum
// ================================================================

/// Priority levels for academic/lab tasks.
enum TaskPriority: Int, CaseIterable, Comparable {
    case low      = 1
    case medium   = 2
    case high     = 3
    case critical = 4

    // User-friendly label
    var label: String {
        switch self {
        case .low:      return "🟢 Low"
        case .medium:   return "🟡 Medium"
        case .high:     return "🟠 High"
        case .critical: return "🔴 Critical"
        }
    }

    // Recommended action
    var action: String {
        switch self {
        case .low:      return "Schedule it for later in the week."
        case .medium:   return "Plan to complete within 2 days."
        case .high:     return "Start today; deadline is near."
        case .critical: return "Drop everything — do it NOW."
        }
    }

    // SLA in hours
    var slaHours: Int {
        switch self {
        case .low:      return 72
        case .medium:   return 48
        case .high:     return 24
        case .critical: return 4
        }
    }

    static func < (lhs: TaskPriority, rhs: TaskPriority) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}

// ================================================================
// MARK: - Order Status Enum (with associated values)
// ================================================================

/// Lifecycle states of a student course-enrollment order.
enum OrderStatus {
    case pending
    case confirmed(confirmationCode: String)
    case inProgress(completedModules: Int, totalModules: Int)
    case completed(grade: String)
    case cancelled(reason: String)

    // User-friendly label
    var label: String {
        switch self {
        case .pending:
            return "⏳ Pending"
        case .confirmed(let code):
            return "✅ Confirmed (Code: \(code))"
        case .inProgress(let done, let total):
            let pct = Int((Double(done) / Double(total)) * 100)
            return "🔄 In Progress (\(done)/\(total) modules — \(pct)%)"
        case .completed(let grade):
            return "🎓 Completed with Grade: \(grade)"
        case .cancelled(let reason):
            return "❌ Cancelled — \(reason)"
        }
    }

    // Next allowed transitions
    var nextSteps: String {
        switch self {
        case .pending:
            return "Awaiting admin confirmation."
        case .confirmed:
            return "Student can begin module 1."
        case .inProgress(let done, let total):
            return done < total ? "Continue to module \(done + 1)." : "Submit for final grading."
        case .completed:
            return "Download certificate from portal."
        case .cancelled:
            return "Re-enroll if still interested."
        }
    }
}

// ================================================================
// MARK: - Lab Task struct (uses both enums together)
// ================================================================

struct LabTask {
    let title:    String
    let priority: TaskPriority
    var status:   OrderStatus

    func describe() {
        print("  📋 Task  : \(title)")
        print("  Priority : \(priority.label) — SLA \(priority.slaHours)h")
        print("  Action   : \(priority.action)")
        print("  Status   : \(status.label)")
        print("  Next     : \(status.nextSteps)")
    }
}

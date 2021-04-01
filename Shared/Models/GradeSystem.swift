//
//  GradeSystem.swift
//  Grade Tracker
//
//  Created by Matthew Froggatt on 2021-03-31.
//

import Foundation

let twelvePointMap = GradeConversionMap(grades: [
    GradeRange(
        floor: nil,
        grade: 0
    ),
    GradeRange(
        floor: 50,
        grade: 1
    ),
    GradeRange(
        floor: 53,
        grade: 2
    ),
    GradeRange(
        floor: 57,
        grade: 3
    ),
    GradeRange(
        floor: 60,
        grade: 4
    ),
    GradeRange(
        floor: 63,
        grade: 5
    ),
    GradeRange(
        floor: 67,
        grade: 6
    ),
    GradeRange(
        floor: 70,
        grade: 7
    ),
    GradeRange(
        floor: 73,
        grade: 8
    ),
    GradeRange(
        floor: 77,
        grade: 9
    ),
    GradeRange(
        floor: 80,
        grade: 10
    ),
    GradeRange(
        floor: 85,
        grade: 11
    ),
    GradeRange(
        floor: 90,
        grade: 12
    )
])

let gradeFormatFunctions: [GradeSystem: (Decimal) -> String] = [
    .percentage: { percentageGrade in
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        return formatter
            .string(from: NSDecimalNumber(decimal: percentageGrade /
                    100))!
    },

    .twelvePoint: { percentageGrade in
        String(twelvePointMap[percentageGrade]!)
    }
]

enum GradeSystem {
    var formatFunction: (Decimal) -> String {
        gradeFormatFunctions[self] ?? { _ in "Not implemented yet" }
    }

    case percentage, twelvePoint
}

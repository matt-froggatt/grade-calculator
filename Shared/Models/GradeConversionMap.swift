//
//  GradeConversionMap.swift
//  Grade Tracker
//
//  Created by Matthew Froggatt on 2021-03-31.
//

import Foundation

struct GradeRange<T> {
    var range: Range<Decimal>
    var grade: T
}

struct GradeConversionMap<T> {
    var percentageRanges = [Range<Decimal>]()
    var grades = [T]()

    init(grades: [GradeRange<T>]) {
        for grade in grades {
            append(range: grade.range, grade: grade.grade)
        }
    }

    private func overlapsExisting(range: Range<Decimal>) -> Bool {
        for existingRange in percentageRanges
            where range.overlaps(existingRange) {
            return true
        }
        return false
    }

    private mutating func append(range: Range<Decimal>, grade: T) {
        // You can check for overlapping range here if you want
        if !overlapsExisting(range: range) {
            percentageRanges.append(range)
            grades.append(grade)
        }
    }

    subscript(value: Decimal) -> T? {
        for (i, range) in percentageRanges.enumerated() where range ~= value {
            return grades[i]
        }

        return nil
    }
}

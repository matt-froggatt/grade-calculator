//
//  GradeConversionMap.swift
//  Grade Tracker
//
//  Created by Matthew Froggatt on 2021-03-31.
//

import Foundation

private func overlappingFloors(f1: Decimal?, f2: Decimal?) -> Bool {
    return f1 == f2 || (f2 != nil && f1 != nil && f1! <= f2!)
}

struct GradeRange<T> {
    var floor: Decimal?
    var grade: T
}

struct GradeConversionMap<T> {
    var floors: [Decimal?]
    var grades: [T]

    init(grades: [GradeRange<T>]) {
        floors = [grades.first!.floor]
        self.grades = [grades.first!.grade]
        for grade in grades.dropFirst() {
            append(floor: grade.floor, grade: grade.grade)
        }
    }

    private func overlapsExisting(floor: Decimal?) -> Bool {
        for existingFloor in floors where overlappingFloors(f1: floor, f2: existingFloor) {
            return true
        }
        return false
    }

    private mutating func append(floor: Decimal?, grade: T) {
        if !overlapsExisting(floor: floor) {
            floors.append(floor)
            grades.append(grade)
        }
    }

    subscript(value: Decimal) -> T? {
        for (i, floor) in floors.reversed().enumerated() where floor == nil || value >= floor! {
            return grades[grades.count - i - 1]
        }

        return nil
    }
}

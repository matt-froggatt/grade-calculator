//
//  GradeConversionMap.swift
//  Grade Tracker
//
//  Created by Matthew Froggatt on 2021-03-31.
//

import Foundation

struct GradeRange<T> {
    var floor: Decimal?
    var grade: T
}

struct GradeConversionMap<T> {
    var floors: [Decimal?]
    var grades: [T]

    init(grades: [GradeRange<T>]) {
        self.floors = [grades.first!.floor]
        self.grades = [grades.first!.grade]
        for grade in grades.dropFirst() {
            append(floor: grade.floor, grade: grade.grade)
        }
    }

    private func overlapsExisting(floor: Decimal?) -> Bool {
        for existingFloor in floors
            where floor == existingFloor || (existingFloor != nil && floor != nil && floor! <= existingFloor!) {
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

//
//  Course.swift
//  Grade Tracker
//
//  Created by Matthew Froggatt on 2021-03-17.
//

import Foundation

struct Course: Identifiable {
    var id: Int
    var name: String
    var credits: Decimal
    var goal: Grade
    var school: School
    var assignments: [Assignment]

    var grade: Grade {
        var weightAchieved: Decimal = 0
        var weightLost: Decimal = 0

        assignments.forEach { assignment in
            if assignment.grade.percentage != nil {
                weightAchieved += assignment.grade.weightAchieved * assignment
                    .weight
                weightLost += assignment.grade.weightLost * assignment.weight
            }
        }

        return Grade(
            weightAchieved: weightAchieved / 100,
            weightLost: weightLost / 100
        )
    }
}

//
//  CourseModel.swift
//  Grade Tracker
//
//  Created by Matthew Froggatt on 2021-04-16.
//

import CoreData
import Foundation

class CourseModel: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var credits: Decimal
    @NSManaged var goal: GradeModel
    @NSManaged var schoolRawValue: String
    @NSManaged var assignments: [AssignmentModel]

    var school: School {
        get {
            let schoolValue = School(rawValue: schoolRawValue)

            if schoolValue == nil {
                return .NONE
            }
            return schoolValue!
        }

        set(newSchool) {
            schoolRawValue = newSchool.rawValue
        }
    }

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

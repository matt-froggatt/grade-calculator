//
//  CourseModel.swift
//  Grade Tracker
//
//  Created by Matthew Froggatt on 2021-04-16.
//

import CoreData
import Foundation

class CourseModel: NSManagedObject, Identifiable {
    @NSManaged var id: UUID
    @NSManaged var name: String
    @NSManaged private var nsCredits: NSDecimalNumber
    var credits: Decimal {
        get {
            nsCredits as Decimal
        }
        set(newCredits) {
            nsCredits = newCredits as NSDecimalNumber
        }
    }
    @NSManaged private var schoolRawValue: String
    var school: School {
        get {
            let schoolValue = School(rawValue: schoolRawValue as String)

            if schoolValue == nil {
                return .NONE
            }

            return schoolValue!
        }

        set(newSchool) {
            schoolRawValue = newSchool.rawValue
        }
    }
    @NSManaged var goal: GradeModel
    @NSManaged var assignments: Set<AssignmentModel>

    var grade: GradeModel {
        var weightAchieved: Decimal = 0
        var weightLost: Decimal = 0

        assignments.forEach { assignment in
            if assignment.grade.percentage != nil {
                weightAchieved += assignment.grade.weightAchieved * assignment
                    .weight
                weightLost += assignment.grade.weightLost * assignment.weight
            }
        }

        return GradeModel(
            context: PersistenceController.shared.container.viewContext,
            weightAchieved: weightAchieved / 100,
            weightLost: weightLost / 100
        )
    }

    convenience init(
        context: NSManagedObjectContext,
        name: String,
        credits: Decimal,
        goal: GradeModel,
        school: School,
        assignments: [AssignmentModel]
    ) {
        self.init(context: context)
        self.id = UUID()
        self.name = name
        self.credits = credits
        self.goal = goal
        self.school = school
        self.assignments = Set(assignments)
    }
}

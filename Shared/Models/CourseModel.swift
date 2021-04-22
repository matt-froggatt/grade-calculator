//
//  CourseModel.swift
//  Grade Tracker
//
//  Created by Matthew Froggatt on 2021-04-16.
//

import CoreData
import Foundation

class CourseModel: NSManagedObject, Identifiable {
    @NSManaged private var nsId: NSUUID
    var id: UUID {
        get {
            nsId as UUID
        }
        set(newId) {
            nsId = newId as NSUUID
        }
    }

    @NSManaged private var nsName: NSString
    var name: String {
        get {
            nsName as String
        }
        set(newName) {
            nsName = newName as NSString
        }
    }

    @NSManaged private var nsCredits: NSDecimalNumber
    var credits: Decimal {
        get {
            nsCredits as Decimal
        }
        set(newCredits) {
            nsCredits = newCredits as NSDecimalNumber
        }
    }

    @NSManaged private var nsSchoolRawValue: NSString
    var school: School {
        get {
            let schoolValue = School(rawValue: nsSchoolRawValue as String)

            if schoolValue == nil {
                return .NONE
            }
            return schoolValue!
        }

        set(newSchool) {
            nsSchoolRawValue = newSchool.rawValue as NSString
        }
    }

    @NSManaged var goal: GradeModel
    @NSManaged var assignments: [AssignmentModel]

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
            context: self.managedObjectContext!,
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
        self.name = name
        self.credits = credits
        self.goal = goal
        self.school = school
        self.assignments = assignments
    }
}

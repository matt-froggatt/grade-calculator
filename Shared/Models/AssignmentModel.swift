//
//  AssignmentModel.swift
//  Grade Tracker
//
//  Created by Matthew Froggatt on 2021-04-16.
//

import CoreData
import Foundation

class AssignmentModel: NSManagedObject, Identifiable {
    @NSManaged var nsId: NSUUID
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

    @NSManaged private var nsWeight: NSDecimalNumber
    var weight: Decimal {
        get {
            nsWeight as Decimal
        }
        set(newWeight) {
            nsWeight = newWeight as NSDecimalNumber
        }
    }

    @NSManaged var grade: GradeModel

    convenience init(
        context: NSManagedObjectContext,
        name: String,
        weight: Decimal,
        grade: GradeModel
    ) {
        self.init(context: context)
        self.name = name
        self.weight = weight
        self.grade = grade
        id = UUID()
    }
}

//
//  AssignmentModel.swift
//  Grade Tracker
//
//  Created by Matthew Froggatt on 2021-04-16.
//

import Foundation
import CoreData

class AssignmentModel: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var weight: Decimal
    @NSManaged var grade: GradeModel
}

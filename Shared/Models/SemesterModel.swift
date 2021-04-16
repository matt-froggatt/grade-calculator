//
//  SemesterModel.swift
//  Grade Tracker
//
//  Created by Matthew Froggatt on 2021-04-16.
//

import CoreData
import Foundation

class SemesterModel: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var courses: [CourseModel]
}

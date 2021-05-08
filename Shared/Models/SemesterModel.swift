//
//  SemesterModel.swift
//  Grade Tracker
//
//  Created by Matthew Froggatt on 2021-04-16.
//

import CoreData
import Foundation

class SemesterModel: NSManagedObject, Identifiable {
    @NSManaged var id: UUID
    @NSManaged var name: String
    @NSManaged var courses: Set<CourseModel>

    convenience init(context: NSManagedObjectContext, name: String, courses: [CourseModel]) {
        self.init(context: context)
        self.id = UUID()
        self.name = name
        self.courses = Set(courses)
    }
}

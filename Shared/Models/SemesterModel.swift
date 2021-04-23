//
//  SemesterModel.swift
//  Grade Tracker
//
//  Created by Matthew Froggatt on 2021-04-16.
//

import CoreData
import Foundation

class SemesterModel: NSManagedObject, Identifiable {
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
    @NSManaged private var nsCourses: Set<CourseModel>
    var courses: [CourseModel] {
        get {
            Array(nsCourses)
        }
        set(newCourses) {
            nsCourses = Set(newCourses)
        }
    }

    convenience init(context: NSManagedObjectContext, name: String, courses: [CourseModel]) {
        self.init(context: context)
        self.id = UUID()
        self.name = name
        self.courses = courses
    }
}

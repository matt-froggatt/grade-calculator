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

    // Using notification centre sucks, but IDK a better way
    @objc private func onCourseChange(_ notification: Notification) {
        objectWillChange.send() // should check if notification is applicable
    }

    private func registerObservation() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(onCourseChange),
            name: .NSManagedObjectContextDidSave,
            object: nil
        )
    }

    override func awakeFromFetch() {
        registerObservation()
    }

    override func awakeFromInsert() {
        registerObservation()
    }

    convenience init(context: NSManagedObjectContext, name: String, courses: [CourseModel]) {
        self.init(context: context)
        self.id = UUID()
        self.name = name
        self.courses = Set(courses)
    }
}

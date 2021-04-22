//
//  Persistence.swift
//  Shared
//
//  Created by Matthew Froggatt on 2021-03-09.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        let grades = [
            GradeModel(context: viewContext, percentage: 90),
            GradeModel(
                context: viewContext,
                weightAchieved: 25,
                weightLost: 30
            ),
            GradeModel(context: viewContext, weightAchieved: 0, weightLost: 0)
        ]
        let assignments = [
            AssignmentModel(
                context: viewContext,
                name: "Test With Grade",
                weight: 50,
                grade: grades[0]
            ),
            AssignmentModel(
                context: viewContext,
                name: "Test No Grade",
                weight: 50,
                grade: grades[2]
            )
        ]
        let courses = [
            CourseModel(
                context: viewContext,
                name: "Text Course",
                credits: 0.5,
                goal: grades[0],
                school: .UW,
                assignments: assignments
            )
        ]
        let semesters = [
            SemesterModel(context: viewContext, name: "Test", courses: courses)
        ]
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error
            // appropriately. fatalError() causes the application to generate a
            // crash log and terminate. You should not use this function in a
            // shipping application, although it may be useful during
            // development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentCloudKitContainer

    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "Grade_Tracker")
        if inMemory {
            container.persistentStoreDescriptions.first!
                .url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error
                // appropriately. fatalError() causes the application to
                // generate a crash log and terminate. You should not use this
                // function in a shipping application, although it may be useful
                // during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or
                   disallows writing.
                 * The persistent store is not accessible, due to permissions or
                   data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem
                 was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}

//
//  Home.swift
//  Grade Tracker
//
//  Created by Matthew Froggatt on 2021-03-18.
//

import CoreData
import SwiftUI

struct Home: View {
    var semesters: [Semester]
    var courses: [CourseModel]

    var body: some View {
        TabView {
            NavigationView {
                SingleSemesterCourseList(
                    courses: courses,
                    title: "Current Semester"
                )
            }
            .tabItem {
                Label("Courses", systemImage: "star")
            }
            NavigationView {
                SemesterList(semesters: semesters)
            }
            .tabItem {
                Label("Semesters", systemImage: "list.bullet")
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static let grades: [GradeModel] = (try? PersistenceController.preview
        .container
        .viewContext
        .fetch(NSFetchRequest(entityName: "GradeModel")) as [GradeModel]) ??
        []
    static let assignments: [AssignmentModel] = (try? PersistenceController
        .preview.container
        .viewContext
        .fetch(
            NSFetchRequest(entityName: "AssignmentModel")
        ) as [AssignmentModel]) ??
        []
    static let courses: [CourseModel] = (try? PersistenceController
        .preview.container
        .viewContext
        .fetch(
            NSFetchRequest(entityName: "CourseModel")
        ) as [CourseModel]) ??
        []

    static var previews: some View {
        Home(
            semesters: [
                Semester(
                    id: 1,
                    name: "Spring 2021",
                    courses: courses
                )
            ],
            courses: courses
        )
    }
}

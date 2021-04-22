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
    var courses: [Course]

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
    static let semesters: [Semester] = [
        Semester(
            id: 1,
            name: "Spring 2021",
            courses: [
                Course(
                    id: 1,
                    name: "CS 341",
                    credits: 0.5,
                    goal: grades[1],
                    school: .UW,
                    assignments: assignments
                )
            ]
        )
    ]
    private static let courses = semesters[0].courses

    static var previews: some View {
        Home(semesters: semesters, courses: courses)
    }
}

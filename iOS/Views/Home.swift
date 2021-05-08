//
//  Home.swift
//  Grade Tracker
//
//  Created by Matthew Froggatt on 2021-03-18.
//

import CoreData
import SwiftUI

struct Home: View {
    var semesters: [SemesterModel]

    var body: some View {
        TabView {
            NavigationView {
                if !semesters.isEmpty {
                    SingleSemesterCourseList(
                        semester: semesters[0]
                    )
                } else {
                    Text("No semesters to show")
                        .foregroundColor(.secondary)
                }
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
    static let semesters: [SemesterModel] = (try? PersistenceController
        .preview.container
        .viewContext
        .fetch(
            NSFetchRequest(entityName: "SemesterModel")
        ) as [SemesterModel]) ??
        []

    static var previews: some View {
        Home(
            semesters: semesters
        )
    }
}

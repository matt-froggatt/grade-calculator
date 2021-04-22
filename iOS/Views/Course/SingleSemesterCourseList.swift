//
//  CourseList.swift
//  Grade Tracker
//
//  Created by Matthew Froggatt on 2021-03-17.
//

import SwiftUI
import CoreData

struct SingleSemesterCourseList: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var showCourseSheet = false
    var courses: [Course]
    var title: String

    var body: some View {
        CourseList(direction: .vertical, courses: courses)
            .toolbar {
                AddButton {
                    showCourseSheet = true
                }
                .sheet(isPresented: $showCourseSheet) {
                    NavigationView {
                        CourseSheet(
                            name: "New Course",
                            credits: 0.5,
                            goal: GradeModel(context: viewContext, percentage: 90),
                            school: .UW
                        )
                    }
                }
            }
            .navigationTitle(Text(title))
    }
}

struct CurrentCourseList_Previews: PreviewProvider {
    static let grades: [GradeModel] = (try? PersistenceController.preview.container
        .viewContext.fetch(NSFetchRequest(entityName: "GradeModel")) as [GradeModel]) ?? []
    private static let courses = [
        Course(
            id: 1,
            name: "CS 341",
            credits: 0.5,
            goal: grades[0],
            school: .UW,
            assignments: []
        ),
        Course(
            id: 2,
            name: "BU 351",
            credits: 0.5,
            goal: grades[1],
            school: .WLU,
            assignments: []
        )
    ]
    static var previews: some View {
        NavigationView {
            SingleSemesterCourseList(courses: courses, title: "Preview")
        }
    }
}

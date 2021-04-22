//
//  CourseList.swift
//  Grade Tracker
//
//  Created by Matthew Froggatt on 2021-03-17.
//

import CoreData
import SwiftUI

struct SingleSemesterCourseList: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var showCourseSheet = false
    var courses: [CourseModel]
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
                            goal: GradeModel(
                                context: viewContext,
                                percentage: 90
                            ),
                            school: .UW
                        )
                    }
                }
            }
            .navigationTitle(Text(title))
    }
}

struct CurrentCourseList_Previews: PreviewProvider {
    static let grades: [GradeModel] = (try? PersistenceController.preview
        .container
        .viewContext
        .fetch(NSFetchRequest(entityName: "GradeModel")) as [GradeModel]) ??
        []
    static let courses: [CourseModel] = (try? PersistenceController
        .preview.container
        .viewContext
        .fetch(
            NSFetchRequest(entityName: "CourseModel")
        ) as [CourseModel]) ??
        []
    static var previews: some View {
        NavigationView {
            SingleSemesterCourseList(courses: courses, title: "Preview")
        }
    }
}

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

    @ObservedObject var semester: SemesterModel

    var body: some View {
        CourseList(
            semester: semester,
            direction: .vertical
        )
        .toolbar {
            AddButton {
                showCourseSheet = true
            }
        }
        .sheet(isPresented: $showCourseSheet) {
            NavigationView {
                CourseSheet(parentSemester: semester)
            }
        }
        .navigationTitle(Text(semester.name))
    }
}

struct CurrentCourseList_Previews: PreviewProvider {
    static let semesters: [SemesterModel] = (try? PersistenceController
        .preview.container
        .viewContext
        .fetch(
            NSFetchRequest(entityName: "SemesterModel")
        ) as [SemesterModel]) ??
        []
    static var previews: some View {
        NavigationView {
            SingleSemesterCourseList(
                semester: semesters[0]
            )
        }
    }
}

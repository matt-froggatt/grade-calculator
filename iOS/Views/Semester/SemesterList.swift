//
//  SemesterList.swift
//  Grade Tracker
//
//  Created by Matthew Froggatt on 2021-03-18.
//

import CoreData
import SwiftUI

struct SemesterList: View {
    @State private var showAddSemesterSheet = false
    var semesters: [SemesterModel]

    func onDelete(tmp _: IndexSet) {}

    var body: some View {
        List {
            ForEach(semesters) { semester in
                VStack(alignment: .leading) {
                    HStack {
                        NavigationLink(
                            destination: SingleSemesterCourseList(
                                courses: semester.courses,
                                title: semester.name
                            )
                        ) {
                            Text(semester.name)
                                .font(.headline)
                                .foregroundColor(.primary)
                                .padding(.leading)
                        }
                    }
                    CourseList(
                        direction: .horizontal,
                        courses: semester.courses
                    )
                }
                .listRowInsets(EdgeInsets())
                .padding(.vertical)
            }
            .onDelete(perform: onDelete)
        }
        .navigationTitle("All Semesters")
        .toolbar {
            AddButton {
                showAddSemesterSheet = true
            }
            .sheet(isPresented: $showAddSemesterSheet) {
                NavigationView {
                    SemesterSheet()
                }
            }
        }
    }
}

struct SemesterList_Previews: PreviewProvider {
    static let semesters: [SemesterModel] = (try? PersistenceController
        .preview.container
        .viewContext
        .fetch(
            NSFetchRequest(entityName: "SemesterModel")
        ) as [SemesterModel]) ??
        []

    static var previews: some View {
        NavigationView {
            SemesterList(
                semesters: semesters
            )
        }
    }
}

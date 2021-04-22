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
    var semesters: [Semester]

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
    static let grades: [GradeModel] = (try? PersistenceController.preview.container
        .viewContext.fetch(NSFetchRequest(entityName: "GradeModel")) as [GradeModel]) ?? []
    private static let semesters = [
        Semester(
            id: 1,
            name: "Spring 2021",
            courses: [
                Course(
                    id: 1,
                    name: "CS 341",
                    credits: 0.5,
                    goal: grades[0],
                    school: .UW,
                    assignments: []
                )
            ]
        )
    ]

    static var previews: some View {
        NavigationView {
            SemesterList(semesters: semesters)
        }
    }
}

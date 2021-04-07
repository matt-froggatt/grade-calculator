//
//  SemesterList.swift
//  Grade Tracker
//
//  Created by Matthew Froggatt on 2021-03-18.
//

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
    private static let semesters = [
        Semester(
            id: 1,
            name: "Spring 2021",
            courses: [
                Course(
                    id: 1,
                    name: "CS 341",
                    credits: 0.5,
                    goal: Grade(percentage: 90),
                    school: .UW,
                    assignments: []
                ),
                Course(
                    id: 2,
                    name: "BU 351",
                    credits: 0.5,
                    goal: Grade(percentage: 70),
                    school: .WLU,
                    assignments: []
                ),
                Course(
                    id: 3,
                    name: "CS 488",
                    credits: 0.5,
                    goal: Grade(percentage: 50),
                    school: .UW,
                    assignments: []
                ),
                Course(
                    id: 4,
                    name: "BU 411",
                    credits: 1.0,
                    goal: Grade(percentage: 80),
                    school: .WLU,
                    assignments: []
                ),
                Course(
                    id: 5,
                    name: "BU 234",
                    credits: 0.5,
                    goal: Grade(percentage: 10),
                    school: .WLU,
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

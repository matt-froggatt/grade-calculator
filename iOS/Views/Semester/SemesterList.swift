//
//  SemesterList.swift
//  Grade Tracker
//
//  Created by Matthew Froggatt on 2021-03-18.
//

import SwiftUI

struct SemesterList: View {
    @State private var showAddCourseSheet = false
    @State private var showAddSemesterSheet = false
    var semesters: [Semester]

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    Divider()
                        .padding(.leading)
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
                                    Spacer()
                                }
                                AddButton {
                                    showAddCourseSheet = true
                                }
                                .padding(.trailing)
                                .sheet(isPresented: $showAddCourseSheet) {
                                    NavigationView {
                                        CourseSheet(
                                            name: "New Course Name",
                                            credits: 0,
                                            goal: Grade(percentage: 0),
                                            school: School(name: .UW)
                                        )
                                    }
                                }
                            }
                            CourseList(direction: .horizontal, courses: semester.courses)
                            Divider()
                                .padding(.leading)
                        }
                    }
                }
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
                    grade: Grade(weightAchieved: 45, weightLost: 10),
                    goal: Grade(percentage: 90),
                    school: School(name: .UW),
                    assignments: []
                ),
                Course(
                    id: 2,
                    name: "BU 351",
                    credits: 0.5,
                    grade: Grade(weightAchieved: 35, weightLost: 20),
                    goal: Grade(percentage: 70),
                    school: School(name: .WLU),
                    assignments: []
                ),
                Course(
                    id: 3,
                    name: "CS 488",
                    credits: 0.5,
                    grade: Grade(weightAchieved: 90, weightLost: 10),
                    goal: Grade(percentage: 50),
                    school: School(name: .UW),
                    assignments: []
                ),
                Course(
                    id: 4,
                    name: "BU 411",
                    credits: 1.0,
                    grade: Grade(weightAchieved: 50, weightLost: 10),
                    goal: Grade(percentage: 80),
                    school: School(name: .WLU),
                    assignments: []
                ),
                Course(
                    id: 5,
                    name: "BU 234",
                    credits: 0.5,
                    grade: Grade(weightAchieved: 30, weightLost: 70),
                    goal: Grade(percentage: 10),
                    school: School(name: .WLU),
                    assignments: []
                )
            ]
        )
    ]

    static var previews: some View {
        SemesterList(semesters: semesters)
    }
}

//
//  CourseList.swift
//  Grade Tracker
//
//  Created by Matthew Froggatt on 2021-03-17.
//

import SwiftUI

struct SingleSemesterCourseList: View {
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
                            goal: Grade(percentage: 90),
                            school: .UW
                        )
                    }
                }
            }
            .navigationTitle(Text(title))
    }
}

struct CurrentCourseList_Previews: PreviewProvider {
    private static let courses = [
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
    static var previews: some View {
        NavigationView {
            SingleSemesterCourseList(courses: courses, title: "Preview")
        }
    }
}

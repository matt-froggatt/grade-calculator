//
//  CourseList.swift
//  Grade Tracker (iOS)
//
//  Created by Matthew Froggatt on 2021-03-30.
//

import SwiftUI
import SwipeCellSUI

struct CourseList: View {
    @State private var currentUserInteractionCellID: String?
    var direction: CourseListDirection
    var courses: [Course]

    func delete(at offsets: IndexSet) {
        print("delete \(offsets)")
    }

    enum CourseListDirection {
        case vertical, horizontal
    }

    var body: some View {
        switch direction {
        case .horizontal:
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(courses) { course in
                        NavigationLink(
                            destination: CourseDetail(course: course)
                        ) {
                            CourseCard(
                                courseName: course.name,
                                school: course.school,
                                credits: course.credits,
                                grade: course.grade,
                                goal: course.goal
                            )
                        }
                    }
                    .padding()
                }
            }
        case .vertical:
            GeometryReader { geometry in
                ScrollView(.vertical) {
                    LazyVStack {
                        ForEach(courses) { course in
                            NavigationLink(
                                destination: CourseDetail(course: course)
                            ) {
                                DeletableRow(
                                    availableWidth: geometry.size.width,
                                    item: String(course.id),
                                    onDelete: { (_: String) -> Void in },
                                    currentUserInteractionCellID: $currentUserInteractionCellID,
                                    content: {
                                        CourseCard(
                                            courseName: course.name,
                                            school: course.school,
                                            credits: course.credits,
                                            grade: course.grade,
                                            goal: course.goal
                                        )
                                        .padding()
                                    }
                                )
                            }
                        }
                    }
                }
            }
        }
    }
}

struct CourseList_Previews: PreviewProvider {
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
            CourseList(direction: .vertical, courses: courses)
        }
        NavigationView {
            CourseList(direction: .horizontal, courses: courses)
        }
    }
}

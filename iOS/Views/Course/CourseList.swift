//
//  CourseList.swift
//  Grade Tracker (iOS)
//
//  Created by Matthew Froggatt on 2021-03-30.
//

import CoreData
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
            CourseList(direction: .vertical, courses: courses)
        }
        NavigationView {
            CourseList(direction: .horizontal, courses: courses)
        }
    }
}

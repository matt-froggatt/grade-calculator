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
    var courses: [CourseModel]

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
                                    item: course.id.uuidString,
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
    static let courses: [CourseModel] = (try? PersistenceController
        .preview.container
        .viewContext
        .fetch(
            NSFetchRequest(entityName: "CourseModel")
        ) as [CourseModel]) ??
        []
    static var previews: some View {
        NavigationView {
            CourseList(direction: .vertical, courses: courses)
        }
        NavigationView {
            CourseList(direction: .horizontal, courses: courses)
        }
    }
}

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
    @Environment(\.managedObjectContext) var viewContext
    @State private var currentUserInteractionCellID: String?

    @ObservedObject var semester: SemesterModel
    var direction: CourseListDirection

    func removeCourse(id: String) {
        let course = semester.courses.first(where: { $0.id.uuidString == id })
        if course != nil {
            viewContext.delete(course!)
            do { try viewContext.save() } catch { fatalError("bruh, courses delete messed up") }
        }
    }

    enum CourseListDirection {
        case vertical, horizontal
    }

    var body: some View {
        switch direction {
        case .horizontal:
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(Array(semester.courses)) { course in
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
                        ForEach(Array(semester.courses)) { course in
                            NavigationLink(
                                destination: CourseDetail(course: course)
                            ) {
                                DeletableRow(
                                    availableWidth: geometry.size.width,
                                    item: course.id.uuidString,
                                    onDelete: removeCourse,
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
    static let semesters: [SemesterModel] = (try? PersistenceController
        .preview.container
        .viewContext
        .fetch(
            NSFetchRequest(entityName: "SemesterModel")
        ) as [SemesterModel]) ??
        []
    static var previews: some View {
        NavigationView {
            CourseList(semester: semesters[0], direction: .vertical)
        }
        NavigationView {
            CourseList(semester: semesters[0], direction: .horizontal)
        }
    }
}

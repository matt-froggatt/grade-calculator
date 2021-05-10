//
//  CourseDetail.swift
//  Grade Tracker
//
//  Created by Matthew Froggatt on 2021-03-18.
//

import CoreData
import SwiftUI

struct CourseDetail: View {
    @State private var assignmentDetailSheet: AssignmentModel?
    @State private var showSheet = false
    @ObservedObject var course: CourseModel

    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                CourseGradeInfo(
                    grade: course.grade,
                    goal: course.goal,
                    school: course.school
                )
                CourseInfo(course: course)
                AssignmentList(
                    selectedAssignment: $assignmentDetailSheet,
                    assignments: course.assignments,
                    parentCourse: course
                )
            }
            .navigationTitle(Text(course.name))
//            .sheet(isPresented: $showSheet) {
//                NavigationView {
//                    CourseSheet(showSheet: $showSheet, semester: course.semester)
//                }
//            }
            .sheet(item: $assignmentDetailSheet) { assignment in
                NavigationView {
                    AssignmentSheet(assignment: assignment)
                }
            }
            .toolbar {
                Button("Edit") {
                    showSheet = true
                }
            }
        }
    }

    // Helper Views
    // -----------------------------------------------------------------------------------------------------------------

    private struct CourseGradeInfo: View {
        var grade: GradeModel
        var goal: GradeModel
        var school: School

        var body: some View {
            VStack(alignment: .center) {
                Text(grade.format(school: school))
                    .font(.title)
                    .foregroundColor(.primary)
                Text("Goal: \(goal.format(school: school))")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                CourseProgress(grade: grade, goal: goal)
                    .padding(.vertical)
            }
            .padding(.horizontal)
        }
    }

    private struct CourseInfoEntry: View {
        var name: String
        var value: String

        var body: some View {
            HStack {
                Text(name)
                    .font(.headline)
                    .foregroundColor(.primary)
                Text(value)
                    .font(.body)
                    .foregroundColor(.primary)
            }
        }
    }

    private struct CourseInfo: View {
        var course: CourseModel

        var body: some View {
            VStack(alignment: .leading) {
                Text("Course Information")
                    .padding(.bottom, 5)

                CourseInfoEntry(
                    name: "Credits",
                    value: "\(NSDecimalNumber(decimal: course.credits))"
                )
                CourseInfoEntry(name: "School", value: course.school.name)
                CourseInfoEntry(
                    name: "Weight Achieved",
                    value: course.grade.format(
                        system: .percentage,
                        segment: .weightAchieved
                    )
                )
                CourseInfoEntry(
                    name: "Weight Lost",
                    value: course.grade.format(
                        system: .percentage,
                        segment: .weightLost
                    )
                )
                CourseInfoEntry(
                    name: "Goal",
                    value: course.goal.format(school: course.school)
                )
            }
            .padding(.horizontal)
        }
    }

    private struct AssignmentList: View {
        @State private var currentUserInteractionCellID: String?
        @Binding var selectedAssignment: AssignmentModel?
        @Environment(\.managedObjectContext) private var viewContext
        var assignments: [AssignmentModel]
        @ObservedObject var parentCourse: CourseModel

        func removeAssignment(id: String) {
            let assignment = parentCourse.assignments.first(where: { $0.id.uuidString == id })
            if assignment != nil {
                viewContext.delete(assignment!)
                do { try viewContext.save() } catch { fatalError("bruh, assignments delete messed up") }
            }
        }

        func addAssignment(assignment: AssignmentModel) {
            parentCourse.assignments.append(assignment)
            viewContext.insert(assignment)
            do { try viewContext.save() } catch { fatalError("bruh, assignment add messed up") }
        }

        var body: some View {
            GeometryReader { geometry in
                LazyVStack {
                    HStack {
                        Text("Assignments")
                        Spacer()
                        AddButton {
                            let newAssignment = AssignmentModel(
                                context: viewContext,
                                name: "New Assignment",
                                weight: 0,
                                grade: GradeModel(context: viewContext, percentage: nil)
                            )
                            addAssignment(assignment: newAssignment)
                            selectedAssignment = newAssignment
                        }
                    }
                    .padding([.horizontal, .top])
                    ForEach(assignments) { assignment in
                        Button(
                            action: { selectedAssignment = assignment },
                            label: {
                                DeletableRow(
                                    availableWidth: geometry.size.width,
                                    item: assignment.id.uuidString,
                                    onDelete: removeAssignment,
                                    currentUserInteractionCellID: $currentUserInteractionCellID,
                                    content: {
                                        AssignmentCard(
                                            name: assignment.name,
                                            weight: assignment.weight,
                                            grade: assignment.grade
                                        )
                                        .padding()
                                    }
                                )
                            }
                        )
                    }
                }
            }
        }
    }
}

struct CourseDetail_Previews: PreviewProvider {
    static let courses: [CourseModel] = (try? PersistenceController
        .preview.container
        .viewContext
        .fetch(
            NSFetchRequest(entityName: "CourseModel")
        ) as [CourseModel]) ??
        []
    static var previews: some View {
        NavigationView {
            CourseDetail(course: courses[0])
        }
    }
}

//
//  CourseDetail.swift
//  Grade Tracker
//
//  Created by Matthew Froggatt on 2021-03-18.
//

import SwiftUI

struct CourseDetail: View {
    @State private var assignmentDetailSheet: Assignment?
    @State private var showSheet = false
    var course: Course

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
                    assignments: course.assignments
                )
            }
            .navigationTitle(Text(course.name))
            .sheet(isPresented: $showSheet) {
                NavigationView {
                    CourseSheet(
                        name: course.name,
                        credits: course.credits,
                        goal: course.goal,
                        school: course.school
                    )
                }
            }
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
        var grade: Grade
        var goal: Grade
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
        var course: Course

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
        @Binding var selectedAssignment: Assignment?
        var assignments: [Assignment]

        var body: some View {
            LazyVStack {
                HStack {
                    Text("Assignments")
                    Spacer()
                    AddButton {
                        selectedAssignment = Assignment(
                            id: 99,
                            name: "New Assignment",
                            weight: 0,
                            grade: Grade()
                        )
                    }
                }
                .padding([.horizontal, .top])
                ForEach(assignments) { assignment in
                    Button(
                        action: { selectedAssignment = assignment },
                        label: {
                            DeletableRow(
                                availableWidth: 385,
                                item: String(assignment.id),
                                deletionCallback: { _ in },
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

struct CourseDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CourseDetail(
                course: Course(
                    id: 1,
                    name: "CS 251",
                    credits: 0.5,
                    goal: Grade(percentage: 80),
                    school: .UW,
                    assignments: [
                        Assignment(
                            id: 1,
                            name: "Test 1",
                            weight: 5,
                            grade: Grade()
                        ),
                        Assignment(
                            id: 2,
                            name: "Test 2",
                            weight: 10,
                            grade: Grade(percentage: 95)
                        )
                    ]
                )
            )
        }
    }
}

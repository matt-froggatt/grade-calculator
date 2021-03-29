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
        List {
            VStack(alignment: .center) {
                Text(course.grade.format(school: course.school))
                    .font(.title)
                    .foregroundColor(.primary)
                Text("Goal: \(course.goal.format(school: course.school))")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                CourseProgress(grade: course.grade, goal: course.goal)
                    .padding(.top)
            }
            .padding(.bottom)
            
            Section(header: Text("Course Information")) {
                HStack {
                    Text("Credits")
                        .font(.headline)
                        .foregroundColor(.primary)
                    Text("\(NSDecimalNumber(decimal: course.credits))")
                        .font(.body)
                        .foregroundColor(.primary)
                    
                }
                HStack {
                    Text("School")
                        .font(.headline)
                        .foregroundColor(.primary)
                    Text("\(course.school.formatName())")
                        .font(.body)
                        .foregroundColor(.primary)
                    
                }
                HStack {
                    Text("Goal")
                        .font(.headline)
                        .foregroundColor(.primary)
                    Text("\(course.grade.format(school: course.school))")
                        .font(.body)
                        .foregroundColor(.primary)
                }
            }
            
            Section(header:
                        HStack {
                            Text("Assignments")
                            Spacer()
                            AddButton {
                                assignmentDetailSheet = Assignment(id: 99, name: "New Assignment", weight: 0, grade: nil)
                            }
                        }) {
                ForEach(course.assignments) { assignment in
                    ZStack {
                        AssignmentCard(
                            name: assignment.name,
                            weight: assignment.weight,
                            grade: assignment.grade
                        )
                        .sheet(item: $assignmentDetailSheet, content: { item in
                            NavigationView {
                                AssignmentSheet(assignment: item)
                            }
                        })
                        .padding()
                        NavigationLink(destination: AssignmentSheet(assignment: assignment)){
                            EmptyView()
                        }
                        .opacity(0)
                        .buttonStyle(PlainButtonStyle())
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .listRowInsets(EdgeInsets())
                    .background(Color(.systemBackground))
                }
                .onDelete(perform: delete)
            }
        }
        .navigationTitle(Text(course.name))
        .sheet(isPresented: $showSheet, content: {
            NavigationView {
                CourseSheet(
                    name: course.name,
                    credits: course.credits,
                    goal: course.goal,
                    school: course.school
                )
            }
        })
        .toolbar {
            Button("Edit") {
                showSheet = true
            }
        }
    }
    
    func delete(at offsets: IndexSet) {
        print("delete \(offsets)")
    }
}

struct CourseDetail_Previews: PreviewProvider {
    static var previews: some View {
        CourseDetail(
            course: Course(
                id: 1,
                name: "CS 251",
                credits: 0.5,
                grade: Grade(weightAchieved: 30, weightLost: 10),
                goal: Grade(percentage: 80),
                school: School(name: .UW),
                assignments: [
                    Assignment(id: 1, name: "Test 1", weight: 5),
                    Assignment(id: 2, name: "Test 2", weight: 10, grade: Grade(percentage: 95))
                ]
            )
        )
    }
}

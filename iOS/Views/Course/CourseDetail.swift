//
//  CourseDetail.swift
//  Grade Tracker
//
//  Created by Matthew Froggatt on 2021-03-18.
//

import SwiftUI

struct CourseDetail: View {
    @State private var assignmentDetailSheet: Assignment?
    var course: Course
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    
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
                    
                    Spacer()
                }
                
                Text("Course Information")
                    .font(.headline)
                    .foregroundColor(.primary)
                Text("Credits: \(NSDecimalNumber(decimal: course.credits))")
                    .font(.body)
                    .foregroundColor(.primary)
                Text("School: \(course.school.formatName())")
                    .font(.body)
                    .foregroundColor(.primary)
                    .padding(.bottom)
                
                Text("Assignments")
                    .font(.headline)
                    .foregroundColor(.primary)
                LazyVStack(spacing: 15) {
                    ForEach(course.assignments) { assignment in
                        Button(action: {
                            assignmentDetailSheet = assignment
                        }) {
                            AssignmentCard(name: assignment.name, weight: assignment.weight, grade: assignment.grade)
                        }
                        .sheet(item: $assignmentDetailSheet) { assignment in
                            NavigationView  {
                                AssignmentSheet(assignment: assignment)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
            }
        }
        .padding(.horizontal)
        .navigationTitle(Text(course.name))
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

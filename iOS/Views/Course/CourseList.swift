//
//  CourseList.swift
//  Grade Tracker (iOS)
//
//  Created by Matthew Froggatt on 2021-03-30.
//

import SwiftUI

struct CourseList: View {
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
                LazyHStack(spacing: 15) {
                    NavigationLink(destination: CourseDetail(course: courses[0])) {
                        CourseCard(
                            courseName: courses[0].name,
                            school: courses[0].school,
                            credits: courses[0].credits,
                            grade: courses[0].grade,
                            goal: courses[0].goal
                        )
                    }
                    .padding(.leading)
                    ForEach(courses[1...]) { course in
                        NavigationLink(destination: CourseDetail(course: course)) {
                            CourseCard(
                                courseName: course.name,
                                school: course.school,
                                credits: course.credits,
                                grade: course.grade,
                                goal: course.goal
                            )
                        }
                    }
                }
                .padding(.vertical)
            }
        case .vertical:
            List {
                ForEach(courses) { course in
                    ZStack {
                        CourseCard(
                            courseName: course.name,
                            school: course.school,
                            credits: course.credits,
                            grade: course.grade,
                            goal: course.goal
                        )
                        .padding()
                        NavigationLink(destination: CourseDetail(course: course)) {
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
    }
}

struct CourseList_Previews: PreviewProvider {
    private static let courses = [
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
    static var previews: some View {
        CourseList(direction: .vertical, courses: courses)
        CourseList(direction: .horizontal, courses: courses)
    }
}

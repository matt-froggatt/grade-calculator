//
//  Home.swift
//  Grade Tracker
//
//  Created by Matthew Froggatt on 2021-03-18.
//

import SwiftUI

struct Home: View {
    var semesters: [Semester]
    var courses: [Course]

    var body: some View {
        TabView {
            NavigationView {
                SingleSemesterCourseList(
                    courses: courses,
                    title: "Current Semester"
                )
            }
            .tabItem {
                Label("Courses", systemImage: "star")
            }
            NavigationView {
                SemesterList(semesters: semesters)
            }
            .tabItem {
                Label("Semesters", systemImage: "list.bullet")
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    private static let semesters = [
        Semester(
            id: 1,
            name: "Spring 2021",
            courses: [
                Course(
                    id: 1,
                    name: "CS 341",
                    credits: 0.5,
                    goal: Grade(percentage: 90),
                    school: .UW,
                    assignments: [
                        Assignment(
                            id: 1,
                            name: "Test 1",
                            weight: 15,
                            grade: Grade(weightAchieved: 0, weightLost: 0)
                        ),
                        Assignment(
                            id: 2,
                            name: "Test 2",
                            weight: 30,
                            grade: Grade(percentage: 15)
                        )
                    ]
                ),
                Course(
                    id: 2,
                    name: "BU 351",
                    credits: 0.5,
                    goal: Grade(percentage: 70),
                    school: .WLU,
                    assignments: [
                        Assignment(
                            id: 1,
                            name: "Test 1",
                            weight: 26,
                            grade: Grade(percentage: 63)
                        ),
                        Assignment(
                            id: 2,
                            name: "Test 2",
                            weight: 30,
                            grade: Grade(percentage: 63)
                        )
                    ]
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
                    assignments: [
                        Assignment(
                            id: 1,
                            name: "Test 1",
                            weight: 26,
                            grade: Grade(percentage: 95)
                        ),
                        Assignment(
                            id: 2,
                            name: "Test 2",
                            weight: 30,
                            grade: Grade(percentage: 100)
                        )
                    ]
                ),
                Course(
                    id: 5,
                    name: "BU 234",
                    credits: 0.5,
                    goal: Grade(percentage: 10),
                    school: .WLU,
                    assignments: [
                        Assignment(
                            id: 1,
                            name: "Test 1",
                            weight: 15,
                            grade: Grade(percentage: 0)
                        ),
                        Assignment(
                            id: 2,
                            name: "Test 2",
                            weight: 50,
                            grade: Grade(percentage: 0)
                        )
                    ]
                )
            ]
        )
    ]

    private static let courses = semesters[0].courses

    static var previews: some View {
        Home(semesters: semesters, courses: courses)
    }
}

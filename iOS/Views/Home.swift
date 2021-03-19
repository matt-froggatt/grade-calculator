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
            CurrentCourseList(courses: courses)
                .tabItem {
                    Label("Courses", systemImage: "star")
                }
            SemesterList(semesters: semesters)
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
            courses:[
                Course(
                    id: 1,
                    name: "CS 341",
                    credits: 0.5,
                    grade: Grade(weightAchieved: 45, weightLost: 10),
                    goal: Grade(percentage: 90),
                    school: School(name: .UW),
                    assignments: [
                        Assignment(id: 1, name: "Test 1", weight: 15),
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
        )
    ]
    
    private static let courses = semesters[0].courses
    
    static var previews: some View {
        Home(semesters: semesters, courses: courses)
    }
}

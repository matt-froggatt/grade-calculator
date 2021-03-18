//
//  CourseList.swift
//  Grade Tracker
//
//  Created by Matthew Froggatt on 2021-03-17.
//

import SwiftUI

struct HorizontalCourseList: View {
    var courses: [Course]
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(courses) { course in
                    NavigationLink(destination: CourseDetail(course: course)){
                        CourseCard(
                            courseName: course.name,
                            school: course.school,
                            credits: course.credits,
                            grade: course.grade,
                            goal: course.goal
                        )
                        .padding([.vertical, .trailing])
                    }
                }
            }
        }
    }
}

struct HorizontalCourseList_Previews: PreviewProvider {
    private static let courses = [
        Course(
            id: 1,
            name: "CS 341",
            credits: 0.5,
            grade: Grade(weightAchieved: 45, weightLost: 10),
            goal: Grade(percentage: 90),
            school: School(name: .UW)
        ),
        Course(
            id: 2,
            name: "BU 351",
            credits: 0.5,
            grade: Grade(weightAchieved: 35, weightLost: 20),
            goal: Grade(percentage: 70),
            school: School(name: .WLU)
        ),
        Course(
            id: 3,
            name: "CS 488",
            credits: 0.5,
            grade: Grade(weightAchieved: 90, weightLost: 10),
            goal: Grade(percentage: 50),
            school: School(name: .UW)
        ),
        Course(
            id: 4,
            name: "BU 411",
            credits: 1.0,
            grade: Grade(weightAchieved: 50, weightLost: 10),
            goal: Grade(percentage: 80),
            school: School(name: .WLU)
        ),
        Course(
            id: 5,
            name: "BU 234",
            credits: 0.5,
            grade: Grade(weightAchieved: 30, weightLost: 70),
            goal: Grade(percentage: 10),
            school: School(name: .WLU)
        )
    ]
    static var previews: some View {
        HorizontalCourseList(courses: courses)
        
    }
}

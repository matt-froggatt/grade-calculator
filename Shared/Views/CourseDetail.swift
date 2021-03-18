//
//  CourseDetail.swift
//  Grade Tracker
//
//  Created by Matthew Froggatt on 2021-03-18.
//

import SwiftUI

struct CourseDetail: View {
    var course: Course
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
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
                school: School(name: .UW)
            )
        )
    }
}

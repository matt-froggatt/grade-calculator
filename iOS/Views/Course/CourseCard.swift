//
//  ClassCard.swift
//  Grade Tracker
//
//  Created by Matthew Froggatt on 2021-03-17.
//

import SwiftUI

struct CourseCard: View {
    var courseName: String
    var school: School
    var credits: Decimal
    var grade: Grade
    var goal: Grade

    var body: some View {
        Card {
            VStack {
                HStack(alignment: .center) {
                    VStack(alignment: .leading) {
                        Text(courseName)
                            .foregroundColor(.primary)
                            .font(.title)
                        Text(
                            "\(school.name) - \(NSDecimalNumber(decimal: credits)) credits"
                        )
                        .foregroundColor(.secondary)
                        .font(.subheadline)
                    }

                    Spacer()

                    Text(grade.format(school: school))
                        .foregroundColor(.primary)
                        .font(.title)
                }

                CourseProgress(grade: grade, goal: goal)
            }
            .padding()
        }
    }
}

struct CourseCard_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CourseCard(
                courseName: "CS 246",
                school: .UW,
                credits: 0.5,
                grade: Grade(weightAchieved: 40, weightLost: 10),
                goal: Grade(percentage: 90)
            )
            CourseCard(
                courseName: "BU 251",
                school: .WLU, credits: 0.5,
                grade: Grade(weightAchieved: 60, weightLost: 10),
                goal: Grade(percentage: 85)
            )
        }
        .padding()
    }
}

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
        ZStack {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .stroke(Color.gray)
            
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    VStack(alignment: .leading) {
                        Text(courseName)
                            .foregroundColor(.primary)
                            .font(.title)
                        Text("\(school.formatName()) - \(NSDecimalNumber(decimal: credits)) credits")
                            .foregroundColor(.secondary)
                            .font(.subheadline)
                    }
                    
                    Spacer()
                    
                    Text(grade.format(school: school))
                        .foregroundColor(.primary)
                        .font(.title)
                }
                .padding(.bottom)
                
                CourseProgress(grade: grade, goal: goal)
            }
            .padding(.horizontal)
        }
        .frame(height: 150)
    }
}

struct CourseCard_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CourseCard(
                courseName: "CS 246",
                school: School(name: .UW),
                credits: 0.5,
                grade: Grade(weightAchieved: 40, weightLost: 10),
                goal: Grade(percentage: 90)
            )
            CourseCard(
                courseName: "BU 251",
                school: School(name: .WLU), credits: 0.5,
                grade: Grade(weightAchieved: 60, weightLost: 10),
                goal: Grade(percentage: 85)
            )
        }
        .padding()
    }
}

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
    var credits: Double
    var grade: Grade
    var goal: Grade
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color.blue)
                .shadow(radius: 5)
            
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text(courseName)
                            .foregroundColor(.white)
                            .font(.title)
                        Text("\(school.formatName()) - \(credits.removeZerosFromEnd()) credits")
                            .foregroundColor(.white)
                            .opacity(0.5)
                            .font(.subheadline)
                    }
                    
                    Spacer()
                    
                    Text(grade.format(school: school))
                        .foregroundColor(.white)
                        .font(.title)
                }
                .padding(.bottom)
                
                CourseProgress(marksReceived: grade.weightAchieved, marksLost: grade.weightLost, goal: goal.percentage)
            }
            .padding()
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

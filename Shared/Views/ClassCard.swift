//
//  ClassCard.swift
//  Grade Tracker
//
//  Created by Matthew Froggatt on 2021-03-17.
//

import SwiftUI

struct ClassCard: View {
    var className: String
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
                        Text(className)
                            .foregroundColor(.white)
                            .font(.title)
                        Text("\(school.getFormattedSchoolName()) - \(credits.removeZerosFromEnd()) credits")
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

struct ClassCard_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ClassCard(className: "CS 246", school: School(schoolName: .UW), credits: 0.5, grade: Grade(weightAchieved: 40, weightLost: 10), goal: Grade(percentage: 90))
            ClassCard(className: "BU 251", school: School(schoolName: .WLU), credits: 0.5, grade: Grade(weightAchieved: 60, weightLost: 10), goal: Grade(percentage: 85))
        }
        .padding()
    }
}

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
    
    var body: some View {
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
                
                Text(grade.getFormattedGrade(school: school))
                    .foregroundColor(.white)
                    .font(.title)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                    .fill(Color.blue)
        )
        .shadow(radius: 5)
    }
}

struct ClassCard_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ClassCard(className: "CS 246", school: School(schoolName: .UW), credits: 0.5, grade: Grade(percentageValue: 95))
            ClassCard(className: "BU 251", school: School(schoolName: .WLU), credits: 0.5, grade: Grade(percentageValue: 86))
        }
        .padding()
    }
}

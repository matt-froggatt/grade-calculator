//
//  CourseProgress.swift
//  Grade Tracker
//
//  Created by Matthew Froggatt on 2021-03-17.
//

import SwiftUI


struct MarksReceivedProgress: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        ProgressView(configuration)
            .background(Color.clear)
            .shadow(radius: 0)
            .accentColor(.green)
    }
}

struct MarksLostProgress: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        ProgressView(configuration)
            .background(Color.gray)
            .shadow(radius: 0)
            .accentColor(.red)
    }
}

struct CourseProgress: View {
    var grade: Grade
    var goal: Grade
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(grade.formattedWeightAchieved())
                    .foregroundColor(.green)
                
                Spacer()
                
                Text(grade.formattedWeightLost())
                    .foregroundColor(.red)
                
                Spacer()
                
                Text(goal.formattedPercentage())
                    .foregroundColor(.yellow)
            }
            .padding(.horizontal)
            .font(.footnote)
            
            
            ZStack {
                ProgressView(value: ((grade.weightAchieved + grade.weightLost) as NSDecimalNumber).doubleValue, total: 100)
                    .progressViewStyle(MarksLostProgress())
                ProgressView(value: (grade.weightAchieved as NSDecimalNumber).doubleValue, total: 100)
                    .progressViewStyle(MarksReceivedProgress())
                GeometryReader { geometry in
                    Capsule()
                        .offset(
                            x: CGFloat((goal.percentage as NSDecimalNumber).doubleValue / 100) * geometry.size.width,
                            y: 0
                        )
                        .foregroundColor(.yellow)
                        .frame(width: 5)
                }
                .frame(height: 20)
            }
            .padding(.vertical, -5)
        }
    }
}

struct CourseProgress_Previews: PreviewProvider {
    static var previews: some View {
        CourseProgress(
            grade: Grade(weightAchieved: 35, weightLost: 5),
            goal: Grade(percentage: 80)
        )
    }
}

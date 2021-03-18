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
    var marksReceived: Double
    var marksLost: Double
    var goal: Double
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("\(marksReceived.removeZerosFromEnd())%")
                    .foregroundColor(.green)
                
                Spacer()
                
                Text("\(marksLost.removeZerosFromEnd())%")
                    .foregroundColor(.red)
                
                Spacer()
                
                Text("\(goal.removeZerosFromEnd())%")
                    .foregroundColor(.yellow)
            }
            .padding(.horizontal)
            .font(.footnote)
            
            
            ZStack {
                ProgressView(value: marksLost + marksReceived, total: 100)
                    .progressViewStyle(MarksLostProgress())
                ProgressView(value: marksReceived, total: 100)
                    .progressViewStyle(MarksReceivedProgress())
                GeometryReader { geometry in
                    Capsule()
                        .offset(
                            x: CGFloat(goal / 100) * geometry.size.width,
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
        CourseProgress(marksReceived: 40, marksLost: 20, goal: 90)
    }
}

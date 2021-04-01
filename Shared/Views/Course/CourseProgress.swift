//
//  CourseProgress.swift
//  Grade Tracker
//
//  Created by Matthew Froggatt on 2021-03-17.
//

import SwiftUI

struct CourseProgress: View {
    var grade: Grade
    var goal: Grade

    var body: some View {
        let cgfloatWeightAchieved =
            CGFloat(truncating: NSDecimalNumber(decimal: grade.weightAchieved))
        let cgfloatWeightLost =
            CGFloat(truncating: NSDecimalNumber(decimal: grade.weightLost))
        let cgfloatMaxWeight =
            CGFloat(truncating: NSDecimalNumber(decimal: grade.maxWeight))

        VStack(alignment: .leading) {
            HStack {
                Text(grade
                    .format(system: .percentage, segment: .weightAchieved))
                    .foregroundColor(.green)

                Spacer()

                Text(grade.format(system: .percentage, segment: .weightLost))
                    .foregroundColor(.red)

                Spacer()

                Text(goal.format(system: .percentage, segment: .overall))
                    .foregroundColor(.yellow)
            }
            .padding(.horizontal)
            .font(.footnote)

            ZStack(alignment: .leading) {
                ProgressCapsule()
                    .accentColor(.gray)
                ProgressCapsule(
                    progress: cgfloatWeightAchieved + cgfloatWeightLost,
                    total: cgfloatMaxWeight
                )
                .accentColor(.red)
                ProgressCapsule(
                    progress: cgfloatWeightAchieved,
                    total: cgfloatMaxWeight
                )
                .accentColor(.green)

                GeometryReader { geometry in
                    Capsule()
                        .offset(
                            x: CGFloat(
                                NSDecimalNumber(
                                    decimal: goal.percentage!
                                ).doubleValue / 100
                            ) * geometry.size.width,
                            y: 0
                        )
                        .foregroundColor(.yellow)
                        .frame(width: 5)
                        .shadow(radius: 2)
                }
            }
            .frame(height: 20)
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

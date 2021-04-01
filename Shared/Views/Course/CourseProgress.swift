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
        let cgfloatWeightAchieved = CGFloat(truncating: NSDecimalNumber(decimal: grade.weightAchieved))
        let cgfloatWeightLost = CGFloat(truncating: NSDecimalNumber(decimal: grade.weightLost))
        let cgfloatMaxWeight = CGFloat(truncating: NSDecimalNumber(decimal: grade.maxWeight))

        VStack(alignment: .leading) {
            HStack {
                Text(grade.format(system: .percentage, segment: .weightAchieved))
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

            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(Color.gray)
                        .frame(
                            width: geometry.size.width,
                            height: geometry.size.height / 2
                        )
                    Capsule()
                        .fill(Color.red)
                        .frame(
                            width: geometry.size.width
                                * ((cgfloatWeightAchieved + cgfloatWeightLost)
                                    / cgfloatMaxWeight),
                            height: geometry.size.height / 2
                        )
                    Capsule()
                        .fill(Color.green)
                        .frame(
                            width: geometry.size.width *
                                (cgfloatWeightAchieved / cgfloatMaxWeight),
                            height: geometry.size.height / 2
                        )

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
                }
            }
            .frame(height: 20)
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

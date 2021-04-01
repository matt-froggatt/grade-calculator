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
        let cgfloatGoalPercentage =
            CGFloat(truncating: NSDecimalNumber(decimal: goal.weightAchieved))
        let percentageWeightAchieved: String = grade.format(
            system: .percentage,
            segment: .weightAchieved
        )
        let percentageWeightLost: String = grade.format(
            system: .percentage,
            segment: .weightLost
        )
        let goalPercentage: String = grade.format(
            system: .percentage,
            segment: .weightLost
        )

        VStack(alignment: .leading) {
            HStack {
                Text(percentageWeightAchieved)
                    .foregroundColor(.green)

                Spacer()

                Text(percentageWeightLost)
                    .foregroundColor(.red)

                Spacer()

                Text(goalPercentage)
                    .foregroundColor(.yellow)
            }
            .padding(.horizontal)
            .font(.footnote)

            MultiProgressBar(
                progress1: cgfloatWeightAchieved,
                progress2: cgfloatWeightLost,
                total: cgfloatMaxWeight,
                barHeight: 10,
                indicatedPosition: cgfloatGoalPercentage,
                indicatorHeight: 20
            )
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

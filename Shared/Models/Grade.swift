//
//  Grade.swift
//  Grade Tracker
//
//  Created by Matthew Froggatt on 2021-03-17.
//

import Foundation

struct Grade {
    let maxWeight: Decimal = 100
    var weightAchieved: Decimal
    var weightLost: Decimal
    var percentage: Decimal? {
        get {
            if weightAchieved.isZero, weightLost.isZero {
                return nil
            }

            return (weightAchieved * 100.0) / (weightAchieved + weightLost)
        }
        set(newPercentage) {
            if newPercentage != nil {
                weightAchieved = newPercentage!
                weightLost = maxWeight - newPercentage!
            } else {
                weightAchieved = 0
                weightLost = 0
            }
        }
    }

    enum Segment {
        case overall, weightAchieved, weightLost
    }

    init(percentage: Decimal) {
        weightAchieved = percentage
        weightLost = maxWeight - weightAchieved
    }

    init(weightAchieved: Decimal, weightLost: Decimal) {
        self.weightAchieved = weightAchieved
        self.weightLost = weightLost
    }

    private func segmentAsPercentage(segment: Segment) -> Decimal? {
        var temp: Decimal?

        switch segment {
        case .overall:
            temp = percentage
        case .weightAchieved:
            temp = weightAchieved
        case .weightLost:
            temp = weightLost
        }

        return temp != nil && temp! < 0 ? nil : temp
    }

    func format(system: GradeSystem, segment: Segment = .overall) -> String {
        let percentageGrade = segmentAsPercentage(segment: segment)

        if percentageGrade == nil {
            return ""
        }

        return system.formatFunction(percentageGrade!)
    }

    func format(school: School, segment: Segment = .overall) -> String {
        format(system: school.gradingSystem, segment: segment)
    }
}

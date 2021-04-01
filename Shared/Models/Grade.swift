//
//  Grade.swift
//  Grade Tracker
//
//  Created by Matthew Froggatt on 2021-03-17.
//

import Foundation

let twelvePointMap = GradeConversionMap(grades: [
    GradeRange(
        floor: nil,
        grade: 0
    ),
    GradeRange(
        floor: 50,
        grade: 1
    ),
    GradeRange(
        floor: 53,
        grade: 2
    ),
    GradeRange(
        floor: 57,
        grade: 3
    ),
    GradeRange(
        floor: 60,
        grade: 4
    ),
    GradeRange(
        floor: 63,
        grade: 5
    ),
    GradeRange(
        floor: 67,
        grade: 6
    ),
    GradeRange(
        floor: 70,
        grade: 7
    ),
    GradeRange(
        floor: 73,
        grade: 8
    ),
    GradeRange(
        floor: 77,
        grade: 9
    ),
    GradeRange(
        floor: 80,
        grade: 10
    ),
    GradeRange(
        floor: 85,
        grade: 11
    ),
    GradeRange(
        floor: 90,
        grade: 12
    )
])

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

    enum System {
        var formatFunction: (Decimal) -> String {
            switch self {
            case .percentage:
                return { percentageGrade in
                    let formatter = NumberFormatter()
                    formatter.numberStyle = .percent
                    return formatter
                        .string(from: NSDecimalNumber(decimal: percentageGrade /
                                100))!
                }

            case .twelvePoint:
                return { percentageGrade in
                    String(twelvePointMap[percentageGrade]!)
                }
            }
        }

        case percentage, twelvePoint
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

    func format(system: System, segment: Segment = .overall) -> String {
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

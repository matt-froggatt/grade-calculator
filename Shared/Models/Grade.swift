//
//  Grade.swift
//  Grade Tracker
//
//  Created by Matthew Froggatt on 2021-03-17.
//

import Foundation

let twelvePointMap = GradeConversionMap(grades: [
    GradeRange(
        range: 0 ..< 50,
        grade: 0
    ),
    GradeRange(
        range: 50 ..< 53,
        grade: 1
    ),
    GradeRange(
        range: 53 ..< 57,
        grade: 2
    ),
    GradeRange(
        range: 57 ..< 60,
        grade: 3
    ),
    GradeRange(
        range: 60 ..< 63,
        grade: 4
    ),
    GradeRange(
        range: 63 ..< 67,
        grade: 5
    ),
    GradeRange(
        range: 67 ..< 70,
        grade: 6
    ),
    GradeRange(
        range: 70 ..< 73,
        grade: 7
    ),
    GradeRange(
        range: 73 ..< 77,
        grade: 8
    ),
    GradeRange(
        range: 77 ..< 80,
        grade: 9
    ),
    GradeRange(
        range: 80 ..< 85,
        grade: 10
    ),
    GradeRange(
        range: 85 ..< 90,
        grade: 11
    ),
    GradeRange(
        range: 90 ..< 101,
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

    private func segmentAsTwelvePoint(segment: Segment) -> Int? {
        let currentMark = segmentAsPercentage(segment: segment)

        if currentMark == nil {
            return nil
        }

        print(twelvePointMap[currentMark!] as Any)

        return twelvePointMap[currentMark!]
    }

    private func formattedTwelvePoint(segment: Segment) -> String {
        let displayTwelvePoint = segmentAsTwelvePoint(segment: segment)
        if displayTwelvePoint == nil {
            return ""
        }

        return String(displayTwelvePoint!)
    }

    private func formattedPercentage(segment: Segment) -> String {
        let displayPercentage = segmentAsPercentage(segment: segment)
        if displayPercentage == nil {
            return ""
        }

        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        return formatter
            .string(from: NSDecimalNumber(decimal: displayPercentage! / 100))!
    }

    func format(system: System, segment: Segment = .overall) -> String {
        switch system {
        case .twelvePoint:
            return formattedTwelvePoint(segment: segment)
        case .percentage:
            return formattedPercentage(segment: segment)
        }
    }

    func format(school: School, segment: Segment = .overall) -> String {
        format(system: school.gradingSystem, segment: segment)
    }
}

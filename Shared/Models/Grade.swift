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

    init(percentage: Decimal) {
        weightAchieved = percentage
        weightLost = maxWeight - weightAchieved
    }

    init(weightAchieved: Decimal, weightLost: Decimal) {
        self.weightAchieved = weightAchieved
        self.weightLost = weightLost
    }

    private var twelvePoint: Int? {
        let currentMark = percentage

        if currentMark == nil {
            return nil
        }

        switch currentMark! {
        case 0..<50:
            return 0
        case 50..<53:
            return 1
        case 53..<57:
            return 2
        case 57..<60:
            return 3
        case 60..<63:
            return 4
        case 63..<67:
            return 5
        case 67..<70:
            return 6
        case 70..<73:
            return 7
        case 73..<77:
            return 8
        case 77..<80:
            return 9
        case 80..<85:
            return 10
        case 85..<90:
            return 11
        default:
            return 12
        }
    }

    var percentage: Decimal? {
        get {
            if weightAchieved == 0 && weightLost == 0 {
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

    func format(school: School) -> String {
        switch school.gradingSystem {
        case System.twelvePoint:
            let displayGrade = twelvePoint
            return displayGrade == nil ? "" : String(displayGrade!)
        default:
            return formattedPercentage()
        }
    }

    func formattedWeightLost() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        return formatter.string(from: NSDecimalNumber(decimal: weightLost / 100))!
    }

    func formattedWeightAchieved() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        return formatter.string(from: NSDecimalNumber(decimal: weightAchieved / 100))!
    }

    func formattedPercentage() -> String {
        let displayPercentage = percentage
        if percentage == nil {
            return ""
        }

        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        return formatter.string(from: NSDecimalNumber(decimal: displayPercentage! / 100))!
    }

    enum System {
        case percentage
        case twelvePoint
    }
}

//
//  Grade.swift
//  Grade Tracker
//
//  Created by Matthew Froggatt on 2021-03-17.
//

import Foundation

// TODO return print value with only two decimal places

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
    
    private var twelvePoint: Int {
        get {
            let currentMark = percentage
            
            if currentMark >= 90 { return 12 }
            else if currentMark >= 85 { return 11 }
            else if currentMark >= 80 { return 10 }
            else if currentMark >= 77 { return 9 }
            else if currentMark >= 73 { return 8 }
            else if currentMark >= 70 { return 7 }
            else if currentMark >= 67 { return 6 }
            else if currentMark >= 63 { return 5 }
            else if currentMark >= 60 { return 4 }
            else if currentMark >= 57 { return 3 }
            else if currentMark >= 53 { return 2 }
            else if currentMark >= 50 { return 1 }
            
            return 0
            
        }
    }
    
    var percentage: Decimal {
        get {
            return (weightAchieved * 100.0) / (weightAchieved + weightLost)
        }
        set(newPercentage) {
            weightAchieved = newPercentage
            weightLost = maxWeight - newPercentage
        }
    }
    
    func format(school: School) -> String {
        switch school.gradingSystem {
        case System.twelvePoint:
            return "\(twelvePoint)"
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
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        return formatter.string(from: NSDecimalNumber(decimal: percentage / 100))!
    }
    
    enum System {
        case percentage
        case twelvePoint
    }
}

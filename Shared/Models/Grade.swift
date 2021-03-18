//
//  Grade.swift
//  Grade Tracker
//
//  Created by Matthew Froggatt on 2021-03-17.
//

import Foundation

struct Grade {
    let maxWeight: Double = 100
    var weightAchieved: Double
    var weightLost: Double
    
    init(percentage: Double) {
        weightAchieved = percentage
        weightLost = maxWeight - weightAchieved
    }
    
    init(weightAchieved: Double, weightLost: Double) {
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
    
    var percentage: Double {
        get {
            return (weightAchieved * 100.0) / (weightAchieved + weightLost)
        }
    }
    
    func format(school: School) -> String {
        switch school.gradingScheme {
        case System.twelvePoint:
            return "\(twelvePoint)"
        default:
            return "\(percentage.removeZerosFromEnd())%"
        }
    }
    
    enum System {
        case percentage
        case twelvePoint
    }
}

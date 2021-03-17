//
//  Grade.swift
//  Grade Tracker
//
//  Created by Matthew Froggatt on 2021-03-17.
//

import Foundation

struct Grade {
    var percentageValue: Double
    
    func getFormattedGrade(school: School) -> String {
        switch school.gradingScheme {
        case GradingScheme.twelvePoint:
            var grade = 0
            
            if percentageValue >= 90 { grade = 12 }
            else if percentageValue >= 85 { grade = 11 }
            else if percentageValue >= 80 { grade = 10 }
            else if percentageValue >= 77 { grade = 9 }
            else if percentageValue >= 73 { grade = 8 }
            else if percentageValue >= 70 { grade = 7 }
            else if percentageValue >= 67 { grade = 6 }
            else if percentageValue >= 63 { grade = 5 }
            else if percentageValue >= 60 { grade = 4 }
            else if percentageValue >= 57 { grade = 3 }
            else if percentageValue >= 53 { grade = 2 }
            else if percentageValue >= 50 { grade = 1 }
            
            return "\(grade)"
        default:
            return "\(percentageValue.removeZerosFromEnd())%"
        }
    }
    
    enum GradingScheme {
        case percentage
        case twelvePoint
    }
}

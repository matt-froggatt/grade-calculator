//
//  Schools.swift
//  Grade Tracker
//
//  Created by Matthew Froggatt on 2021-03-17.
//

import Foundation

struct School {
    var schoolName: SchoolName
    var gradingScheme: Grade.GradingScheme
    
    init(schoolName: SchoolName) {
        self.schoolName = schoolName
        switch schoolName {
        case SchoolName.WLU:
            gradingScheme = .twelvePoint
        default:
            gradingScheme = .percentage
        }
    }
    
    func getFormattedSchoolName() -> String {
        return schoolName.rawValue
    }
    
    enum SchoolName: String {
        case WLU = "WLU"
        case UW = "UW"
    }
}

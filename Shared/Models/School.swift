//
//  Schools.swift
//  Grade Tracker
//
//  Created by Matthew Froggatt on 2021-03-17.
//

import Foundation

struct School {
    var name: SchoolName
    var gradingSystem: GradeSystem

    init(name: SchoolName) {
        self.name = name
        switch name {
        case SchoolName.WLU:
            gradingSystem = .twelvePoint
        default:
            gradingSystem = .percentage
        }
    }

    func formatName() -> String {
        name.rawValue
    }

    enum SchoolName: String {
        case WLU
        case UW
    }
}

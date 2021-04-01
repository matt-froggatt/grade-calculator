//
//  Schools.swift
//  Grade Tracker
//
//  Created by Matthew Froggatt on 2021-03-17.
//

import Foundation

private let schoolGradeSystems: [School: GradeSystem] = [
    .UW: .percentage,
    .WLU: .twelvePoint
]

enum School: String {
    var gradeSystem: GradeSystem {
        return schoolGradeSystems[self] ?? .unsupported
    }

    var name: String {
        return self.rawValue
    }

    case UW, WLU
}

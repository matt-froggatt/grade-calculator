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
        schoolGradeSystems[self] ?? .unsupported
    }

    var name: String {
        rawValue
    }

    case NONE = "", UW, WLU
}

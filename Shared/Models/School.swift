//
//  Schools.swift
//  Grade Tracker
//
//  Created by Matthew Froggatt on 2021-03-17.
//

import Foundation

private let schoolGradeSystems: [School: GradeSystem] = [
    .none: .percentage,
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

    case none = "None", UW = "Waterloo", WLU = "Laurier"
}

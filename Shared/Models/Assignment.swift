//
//  Assignment.swift
//  Grade Tracker
//
//  Created by Matthew Froggatt on 2021-03-18.
//

import Foundation

struct Assignment: Identifiable {
    var id: Int
    var name: String
    var weight: Decimal
    var grade: GradeModel
}

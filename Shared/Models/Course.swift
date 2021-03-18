//
//  Course.swift
//  Grade Tracker
//
//  Created by Matthew Froggatt on 2021-03-17.
//

import Foundation

struct Course: Identifiable {
    var id: Int
    var name: String
    var credits: Double
    var grade: Grade
    var goal: Grade
    var school: School
}

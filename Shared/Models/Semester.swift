//
//  Semester.swift
//  Grade Tracker
//
//  Created by Matthew Froggatt on 2021-03-18.
//

import Foundation

struct Semester: Identifiable {
    var id: Int
    var name: String
    var courses: [CourseModel]
}

//
//  GradeModel.swift
//  Grade Tracker
//
//  Created by Matthew Froggatt on 2021-04-16.
//

import Foundation
import CoreData

class GradeModel: NSManagedObject {
    let maxWeight: Decimal = 100
    @NSManaged var weightAchieved: Decimal
    @NSManaged var weightLost: Decimal
    var percentage: Decimal? {
    get {
        if weightAchieved.isZero, weightLost.isZero {
            return nil
        }

        return (weightAchieved * 100.0) / (weightAchieved + weightLost)
    }
    set(newPercentage) {
        if newPercentage != nil {
            weightAchieved = newPercentage!
            weightLost = maxWeight - newPercentage!
        } else {
            weightAchieved = 0
            weightLost = 0
        }
    }
}
    enum Segment {
        case overall, weightAchieved, weightLost
    }

    private func segmentAsPercentage(segment: Segment) -> Decimal? {
        switch segment {
        case .overall:
            return percentage
        case .weightAchieved:
            return weightAchieved
        case .weightLost:
            return weightLost
        }
    }

    func format(system: GradeSystem, segment: Segment = .overall) -> String {
        let percentageGrade = segmentAsPercentage(segment: segment)
        return percentageGrade == nil ? "" : system
            .formatFunction(percentageGrade!)
    }

    func format(school: School, segment: Segment = .overall) -> String {
        format(system: school.gradeSystem, segment: segment)
    }
}

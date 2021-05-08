//
//  GradeModel.swift
//  Grade Tracker
//
//  Created by Matthew Froggatt on 2021-04-16.
//

import CoreData
import Foundation

class GradeModel: NSManagedObject {
    let maxWeight: Decimal = 100

    @NSManaged private var nsWeightAchieved: Decimal
    var weightAchieved: Decimal {
        get {
//            nsWeightAchieved as Decimal
            0
        }
        set(newWeightAchieved) {
//            nsWeightAchieved = newWeightAchieved as Decimal
        }
    }
    @NSManaged private var nsWeightLost: Decimal
    var weightLost: Decimal {
        get {
//            nsWeightLost as Decimal
            0
        }
        set(newWeightLost) {
//            nsWeightLost = newWeightLost as Decimal
        }
    }
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

    convenience init(
        context: NSManagedObjectContext,
        percentage grade: Decimal?
    ) {
        self.init(
            context: context
        )
        percentage = grade
    }

    convenience init(
        context: NSManagedObjectContext,
        weightAchieved: Decimal,
        weightLost: Decimal
    ) {
        self.init(
            context: context
        )
        self.weightAchieved = weightAchieved
        self.weightLost = weightLost
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

//
//  ClassCard.swift
//  Grade Tracker
//
//  Created by Matthew Froggatt on 2021-03-17.
//

import SwiftUI
import CoreData

struct CourseCard: View {
    var courseName: String
    var school: School
    var credits: Decimal
    var grade: GradeModel
    var goal: GradeModel

    var body: some View {
        Card {
            VStack {
                HStack(alignment: .center) {
                    VStack(alignment: .leading) {
                        Text(courseName)
                            .foregroundColor(.primary)
                            .font(.title)
                        Text(
                            "\(school.name) - \(NSDecimalNumber(decimal: credits)) credits"
                        )
                        .foregroundColor(.secondary)
                        .font(.subheadline)
                    }

                    Spacer()

                    Text(grade.format(school: school))
                        .foregroundColor(.primary)
                        .font(.title)
                }

                CourseProgress(grade: grade, goal: goal)
            }
            .padding()
        }
    }
}

struct CourseCard_Previews: PreviewProvider {
    static let grades: [GradeModel] = (try? PersistenceController.preview.container
        .viewContext.fetch(NSFetchRequest(entityName: "GradeModel")) as [GradeModel]) ?? []
    static var previews: some View {
        VStack {
            CourseCard(
                courseName: "CS 246",
                school: .UW,
                credits: 0.5,
                grade: grades[0],
                goal: grades[1]
            )
            CourseCard(
                courseName: "BU 251",
                school: .WLU, credits: 0.5,
                grade: grades[0],
                goal: grades[1]
            )
        }
        .padding()
    }
}

//
//  AssignmentCard.swift
//  Grade Tracker
//
//  Created by Matthew Froggatt on 2021-03-18.
//

import SwiftUI
import CoreData

struct AssignmentCard: View {
    var name: String
    var weight: Decimal
    var grade: GradeModel

    var body: some View {
        Card {
            VStack {
                HStack(alignment: .center) {
                    VStack(alignment: .leading) {
                        Text(name)
                            .foregroundColor(.primary)
                            .font(.title)
                        Text("Weight - \(NSDecimalNumber(decimal: weight))")
                            .foregroundColor(.secondary)
                            .font(.subheadline)
                    }

                    Spacer()

                    Text(grade.format(system: .percentage))
                        .foregroundColor(.primary)
                        .font(.title)
                }
            }
            .padding()
        }
    }
}

struct AssignmentCard_Previews: PreviewProvider {
    static let grades: [GradeModel] = (try? PersistenceController.preview.container
        .viewContext.fetch(NSFetchRequest(entityName: "GradeModel")) as [GradeModel]) ?? []
    static var previews: some View {
        VStack {
            AssignmentCard(
                name: "Test Assignment",
                weight: 5.0,
                grade: grades[0]
            )
            AssignmentCard(
                name: "Test Assignment",
                weight: 5.0,
                grade: GradeModel()
            )
        }
    }
}

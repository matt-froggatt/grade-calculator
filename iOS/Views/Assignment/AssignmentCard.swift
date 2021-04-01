//
//  AssignmentCard.swift
//  Grade Tracker
//
//  Created by Matthew Froggatt on 2021-03-18.
//

import SwiftUI

struct AssignmentCard: View {
    var name: String
    var weight: Decimal
    var grade: Grade?

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

                    if grade != nil {
                        Text(grade!.format(system: .percentage))
                            .foregroundColor(.primary)
                            .font(.title)
                    }
                }
            }
            .padding()
        }
    }
}

struct AssignmentCard_Previews: PreviewProvider {
    static var previews: some View {
        AssignmentCard(
            name: "Test Assignment",
            weight: 5.0,
            grade: Grade(percentage: 95)
        )
    }
}

//
//  AssignmentDetail.swift
//  Grade Tracker
//
//  Created by Matthew Froggatt on 2021-03-19.
//

import Combine
import CoreData
import SwiftUI

struct AssignmentSheet: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var numerator: Decimal = 0
    @State private var denominator: Decimal = 100
    @State private var weight: Decimal = 0
    @State private var name: String = ""
    @State var assignment: AssignmentModel

    var body: some View {
        Form {
            Section {
                FormEntry(label: "Name") {
                    TextField("Name", text: $assignment.name)
                }

                FormEntry(label: "Grade") {
                    DecimalField(message: "Mark", number: $numerator)
                        .multilineTextAlignment(.trailing)
                    Text("/").font(.subheadline).foregroundColor(.secondary)
                    DecimalField(message: "Total", number: $denominator)
                }

                FormEntry(label: "Weight") {
                    DecimalField(message: "Weight", number: $assignment.weight)
                        .multilineTextAlignment(.trailing)
                    Text("%").font(.subheadline).foregroundColor(.secondary)
                }
            }

            Section {
                Button("Submit") {
                    assignment.grade.percentage = numerator * 100 / denominator
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
        .onAppear {
            if assignment.grade.percentage != nil {
                numerator = assignment.grade.percentage! * 100
            }
        }
        .navigationTitle(Text(assignment.name))
        .toolbar {
            Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct AssignmentSheet_Previews: PreviewProvider {
    static let grades: [GradeModel] = (try? PersistenceController.preview
        .container
        .viewContext
        .fetch(NSFetchRequest(entityName: "GradeModel")) as [GradeModel]) ??
        []
    static let assignments: [AssignmentModel] = (try? PersistenceController
        .preview.container
        .viewContext
        .fetch(
            NSFetchRequest(entityName: "AssignmentModel")
        ) as [AssignmentModel]) ??
        []
    static var previews: some View {
        NavigationView {
            AssignmentSheet(assignment: assignments[0])
        }

        NavigationView {
            AssignmentSheet(assignment: assignments[1])
        }
    }
}

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
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) private var presentationMode
    @State private var numerator: Decimal = 0
    @State private var denominator: Decimal = 100
    @State private var weight: Decimal = 0
    @State private var name: String = "Assignment Name"
    @ObservedObject var assignmentToUpdate: AssignmentModel

    var body: some View {
        Form {
            Section {
                FormEntry(label: "Name") {
                    TextField("Name", text: $name)
                }

                FormEntry(label: "Grade") {
                    DecimalField(message: "Mark", number: $numerator)
                        .multilineTextAlignment(.trailing)
                    Text("/").font(.subheadline).foregroundColor(.secondary)
                    DecimalField(message: "Total", number: $denominator)
                }

                FormEntry(label: "Weight") {
                    DecimalField(message: "Weight", number: $weight)
                        .multilineTextAlignment(.trailing)
                    Text("%").font(.subheadline).foregroundColor(.secondary)
                }
            }

            Section {
                Button("Submit") {
                    assignmentToUpdate.name = name
                    assignmentToUpdate.weight = weight
                    assignmentToUpdate.grade.percentage = numerator * 100 / denominator
                    do { try viewContext.save() } catch { fatalError("bruh, assignment modify messed up") }
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
        .onAppear {
            name = assignmentToUpdate.name
            weight = assignmentToUpdate.weight
            if assignmentToUpdate.grade.percentage != nil {
                numerator = assignmentToUpdate.grade.percentage!
            }
        }
        .navigationTitle(Text(name))
        .toolbar {
            Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct AssignmentSheet_Previews: PreviewProvider {
    static let assignments: [AssignmentModel] = (try? PersistenceController
        .preview.container
        .viewContext
        .fetch(
            NSFetchRequest(entityName: "AssignmentModel")
        ) as [AssignmentModel]) ??
        []
    static var previews: some View {
        NavigationView {
            AssignmentSheet(assignmentToUpdate: assignments[0])
        }

        NavigationView {
            AssignmentSheet(assignmentToUpdate: assignments[1])
        }
    }
}

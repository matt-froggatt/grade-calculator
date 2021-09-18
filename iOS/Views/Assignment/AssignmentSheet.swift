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
    private var createdCourse = false
    private var course: CourseModel?
    private var assignment: AssignmentModel?

    init (assignmentToUpdate: AssignmentModel) {
        assignment = assignmentToUpdate
    }

    init (parentCourse: CourseModel) {
        course = parentCourse
    }

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
                    assert((assignment == nil || course == nil) && (assignment != nil || course != nil),
                           "Assignment updated and created simultaneously or nothing happeninig???")
                    if assignment == nil && course != nil {
                        let tmpAssignment = AssignmentModel(
                            context: viewContext,
                            name: name,
                            weight: weight,
                            grade: GradeModel(context: viewContext, percentage: numerator * 100 / denominator)
                        )
                        course?.assignments.insert(tmpAssignment)
                        viewContext.insert(tmpAssignment)
                    } else {
                        assignment!.grade.percentage = numerator * 100 / denominator
                        assignment!.name = name
                        assignment!.weight = weight
                    }
                    do { try viewContext.save() } catch { fatalError("bruh, assignment modify messed up") }
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
        .onAppear {
            if assignment != nil {
                name = assignment!.name
                weight = assignment!.weight
                if assignment!.grade.percentage != nil {
                    numerator = assignment!.grade.percentage!
                }
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

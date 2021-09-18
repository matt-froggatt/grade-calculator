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
    @ObservedObject var course: CourseModel
    var assignmentToUpdate: AssignmentModel?

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
                    var assignment: AssignmentModel
                    if assignmentToUpdate == nil {
                        assignment = AssignmentModel(
                            context: viewContext,
                            name: name,
                            weight: weight,
                            grade: GradeModel(context: viewContext, percentage: numerator * 100 / denominator)
                        )
                        course.assignments.insert(assignment)
                        viewContext.insert(assignment)
                    } else {
                        assignment = assignmentToUpdate!
                        assignment.name = name
                        assignment.weight = weight
                        assignment.grade.percentage = numerator * 100 / denominator
                    }
                    do { try viewContext.save() } catch { fatalError("bruh, assignment modify messed up") }
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
        .onAppear {
            if assignmentToUpdate != nil {
                name = assignmentToUpdate!.name
                weight = assignmentToUpdate!.weight
                if assignmentToUpdate!.grade.percentage != nil {
                    numerator = assignmentToUpdate!.grade.percentage!
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
    static let courses: [CourseModel] = (try? PersistenceController
        .preview.container
        .viewContext
        .fetch(
            NSFetchRequest(entityName: "CourseModel")
        ) as [CourseModel]) ??
        []
    static var previews: some View {
        NavigationView {
            AssignmentSheet(course: courses[0])
        }

        NavigationView {
            AssignmentSheet(course: courses[1])
        }
    }
}

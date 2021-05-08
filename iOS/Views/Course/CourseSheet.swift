//
//  CourseSheet.swift
//  Grade Tracker
//
//  Created by Matthew Froggatt on 2021-03-22.
//

import CoreData
import SwiftUI

struct CourseSheet: View {
    @Environment(\.managedObjectContext) var viewContext
    @State private var name: String = "Course Name"
    @State private var credits: Decimal = 0.5
    @State private var goal = GradeModel()
    @State private var school: School = .NONE
    @Binding var showSheet: Bool
    @ObservedObject var semester: SemesterModel

    private func addCourse() {
        let newCourse = CourseModel(
            context: viewContext,
            name: name,
            credits: credits,
            goal: goal,
            school: school,
            assignments: []
        )
        viewContext.insert(newCourse)
        semester.courses.insert(newCourse)
        do { try viewContext.save() } catch { fatalError("bruh") }
    }

    var body: some View {
        Form {
            Section {
                FormEntry(label: "Name") {
                    TextField("Name", text: $name)
                }

                FormEntry(label: "Credits") {
                    DecimalField(message: "Credits", number: $credits)
                }
                .onAppear {
                    goal = GradeModel(context: viewContext, percentage: 100)
                }

//                FormEntry(label: "Goal") {
//                    DecimalField(
//                        message: "Goal",
//                        number: Binding($goal.percentage)!
//                    )
//                    .multilineTextAlignment(.trailing)
//                    .fixedSize()
//                    Text("%").font(.subheadline).foregroundColor(.secondary)
//                }
            }

            Section {
                Button("Submit") {
                    addCourse()
                    showSheet = false
                }
            }
        }
        .navigationTitle(Text(name))
        .toolbar {
            Button("Cancel") {
                showSheet = false
            }
        }
    }
}

struct CourseSheet_Previews: PreviewProvider {
    static let semesters: [SemesterModel] = (try? PersistenceController
        .preview.container
        .viewContext
        .fetch(
            NSFetchRequest(entityName: "SemesterModel")
        ) as [SemesterModel]) ??
        []
    static var previews: some View {
        CourseSheet(
            showSheet: .constant(true), semester: semesters[0]
        )
    }
}

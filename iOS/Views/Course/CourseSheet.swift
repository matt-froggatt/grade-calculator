//
//  CourseSheet.swift
//  Grade Tracker
//
//  Created by Matthew Froggatt on 2021-03-22.
//

import CoreData
import SwiftUI

struct CourseSheet: View {
    @Environment(\.presentationMode) var presentationMode
    @State var name: String
    @State var credits: Decimal
    @State var goal: GradeModel
    @State var school: School

    var body: some View {
        Form {
            Section {
                FormEntry(label: "Name") {
                    TextField("Name", text: $name)
                }

                FormEntry(label: "Credits") {
                    DecimalField(message: "Credits", number: $credits)
                }

                FormEntry(label: "Goal") {
                    DecimalField(
                        message: "Goal",
                        number: Binding($goal.percentage)!
                    )
                    .multilineTextAlignment(.trailing)
                    .fixedSize()
                    Text("%").font(.subheadline).foregroundColor(.secondary)
                }
            }

            Section {
                Button("Submit") {
                    presentationMode.wrappedValue.dismiss()
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

struct CourseSheet_Previews: PreviewProvider {
    static let grades: [GradeModel] = (try? PersistenceController.preview.container
        .viewContext.fetch(NSFetchRequest(entityName: "GradeModel")) as [GradeModel]) ?? []
    static var previews: some View {
        CourseSheet(
            name: "CS 251",
            credits: 0.5,
            goal: grades[1],
            school: .UW
        )
    }
}

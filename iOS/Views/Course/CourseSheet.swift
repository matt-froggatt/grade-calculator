//
//  CourseSheet.swift
//  Grade Tracker
//
//  Created by Matthew Froggatt on 2021-03-22.
//

import SwiftUI

struct CourseSheet: View {
    @Environment(\.presentationMode) var presentationMode
    @State var name: String
    @State var credits: Decimal
    @State var goal: Grade
    @State var school: School

    var body: some View {
        Form {
            Section {
                HStack {
                    Text("Name").font(.headline)
                    TextField("Name", text: $name)
                }
                HStack {
                    Text("Credits").font(.headline)
                    DecimalField(message: "Credits", number: $credits)
                }

                HStack {
                    Text("Goal").font(.headline)
                    DecimalField(message: "Goal", number: Binding($goal.percentage)!)
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
    static var previews: some View {
        CourseSheet(
            name: "CS 251",
            credits: 0.5,
            goal: Grade(percentage: 80),
            school: School(name: .UW)
        )
    }
}

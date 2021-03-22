//
//  AssignmentDetail.swift
//  Grade Tracker
//
//  Created by Matthew Froggatt on 2021-03-19.
//

import SwiftUI
import Combine

struct AssignmentSheet: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var numerator: Decimal = 0
    @State private var denominator: Decimal = 100
    @State private var weight: Decimal = 0
    @State private var name: String = ""
    @State var assignment: Assignment
    
    var body: some View {
        Form {
            Section {
                HStack {
                    Text("Name")
                    TextField("Name", text: $assignment.name)
                        .onAppear {
                            if assignment.grade != nil {
                                numerator = assignment.grade!.percentage
                            }
                        }
                }
                HStack {
                    Text("Grade")
                    DecimalField(message: "numerator", number: $numerator)
                    Text("/")
                    DecimalField(message: "denominator", number: $denominator)
                }
                
                HStack {
                    Text("Weight")
                    DecimalField(message: "Percentage", number: $assignment.weight)
                    Text("%")
                }
            }
            
            Section {
                Button("Submit") {
                    presentationMode.wrappedValue.dismiss()
                }
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
    static var previews: some View {
        AssignmentSheet(assignment: Assignment(id: 1, name: "Assignment with grade", weight: 10, grade: Grade(percentage: 50)))
        AssignmentSheet(assignment: Assignment(id: 1, name: "Assignment without grade", weight: 10))
    }
}

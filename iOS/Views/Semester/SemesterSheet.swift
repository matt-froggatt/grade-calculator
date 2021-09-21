//
//  SemesterSheet.swift
//  Grade Tracker
//
//  Created by Matthew Froggatt on 2021-03-22.
//

import Combine
import CoreData
import SwiftUI

struct SemesterSheet: View {
    private static let terms = ["Fall", "Winter", "Spring"]
    @State private var termSelection = terms[0]
    @State private var year = String(Calendar.current.component(.year, from: Date()))

    @Environment(\.managedObjectContext) var viewContext: NSManagedObjectContext

    @Binding var showSheet: Bool

    private func addSemester() {
        let newSemester = SemesterModel(
            context: viewContext,
            name: "\(year) \(termSelection)",
            courses: []
        )
        viewContext.insert(newSemester)
        do { try viewContext.save() } catch { fatalError("bruh") }
    }

    var body: some View {
        Form {
            Section {
                FormEntry(label: "Year") {
                    TextField("Year", text: $year)
                        .keyboardType(.numberPad)
                        .onReceive(Just(year), perform: { newValue in
                            let filtered = newValue.filter { "0123456789".contains($0) }
                            if filtered != newValue {
                                self.year = filtered
                            }
                        })
                }
                FormEntry(label: "Term") {
                    Picker(selection: $termSelection, label: Text("Term")) {
                        ForEach(SemesterSheet.terms, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }

            Section {
                Button("Submit") {
                    addSemester()
                    showSheet = false
                }
            }
        }
        .navigationTitle(Text("\(year) \(termSelection)"))
        .toolbar {
            Button("Cancel") {
                showSheet = false
            }
        }
    }
}

struct SemesterSheet_Previews: PreviewProvider {
    static var previews: some View {
        SemesterSheet(showSheet: .constant(true))
    }
}

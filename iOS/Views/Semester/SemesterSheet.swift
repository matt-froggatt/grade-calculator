//
//  SemesterSheet.swift
//  Grade Tracker
//
//  Created by Matthew Froggatt on 2021-03-22.
//

import CoreData
import SwiftUI

struct SemesterSheet: View {
    private static let years = Array(Array(2000 ... 2040).reversed())
    private static let terms = ["Fall", "Winter", "Spring"]

    @State private var yearSelection = years[0]
    @State private var termSelection = terms[0]
    @State private var showYearPicker = false

    @Environment(\.managedObjectContext) var viewContext: NSManagedObjectContext

    @Binding var showSheet: Bool

    private struct YearPicker: View {
        @Binding var showYearPicker: Bool
        @Binding var yearSelection: Int

        var body: some View {
            if showYearPicker {
                VStack {
                    Picker(selection: $yearSelection, label: Text("Year")) {
                        ForEach(SemesterSheet.years, id: \.self) {
                            Text(String($0))
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                }
                Button("Ok") {
                    showYearPicker = false
                }
            }
        }
    }

    private func addSemester() {
        let newSemester = SemesterModel(
            context: viewContext,
            name: "\(yearSelection) \(termSelection)",
            courses: []
        )
        viewContext.insert(newSemester)
        do { try viewContext.save() } catch { fatalError("bruh") }
    }

    var body: some View {
        Form {
            Section {
                FormEntry(label: "Term") {
                    Picker(selection: $termSelection, label: Text("Term")) {
                        ForEach(SemesterSheet.terms, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                FormEntry(label: "Year") {
                    Button(String(yearSelection)) {
                        showYearPicker = !showYearPicker
                    }
                }
                YearPicker(
                    showYearPicker: $showYearPicker,
                    yearSelection: $yearSelection
                )
            }

            Section {
                Button("Submit") {
                    addSemester()
                    showSheet = false
                }
            }
        }
        .navigationTitle(Text("\(termSelection) \(String(yearSelection))"))
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

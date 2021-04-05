//
//  SemesterSheet.swift
//  Grade Tracker
//
//  Created by Matthew Froggatt on 2021-03-22.
//

import SwiftUI

struct SemesterSheet: View {
    private static let years = Array(Array(2000 ... 2020).reversed())
    private static let terms = ["Fall", "Winter", "Spring"]
    @Environment(\.presentationMode) var presentationMode
    @State private var yearSelection = years[0]
    @State private var termSelection = terms[0]
    @State private var showYearPicker = false

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
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
        .navigationTitle(Text("\(termSelection) \(String(yearSelection))"))
        .toolbar {
            Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct SemesterSheet_Previews: PreviewProvider {
    static var previews: some View {
        SemesterSheet()
    }
}

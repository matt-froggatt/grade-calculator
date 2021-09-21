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
    @Environment(\.presentationMode) private var presentationMode
    @State private var name: String = "Course Name"
    @State private var credits: Decimal = 0.5
    @State private var goalPercentage: Decimal = 100
    @State private var school: School = .none
    private var semester: SemesterModel?
    private var course: CourseModel?

    init(courseToUpdate: CourseModel) {
        course = courseToUpdate
    }

    init(parentSemester: SemesterModel) {
        semester = parentSemester
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

                FormEntry(label: "Goal") {
                    DecimalField(
                        message: "Goal",
                        number: $goalPercentage
                    )
                    .multilineTextAlignment(.trailing)
                    .fixedSize()
                    Text("%").font(.subheadline).foregroundColor(.secondary)
                }

                FormEntry(label: "School") {
                    Picker(selection: $school, label: Text("School")) {
                        ForEach(School.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }

            Section {
                Button("Submit") {
                    assert((semester == nil || course == nil) && (semester != nil || course != nil),
                           "Course updated and created simultaneously or nothing happening???")
                    if course == nil && semester != nil {
                        let tmpCourse = CourseModel(
                            context: viewContext,
                            name: name,
                            credits: credits,
                            goal: GradeModel(
                                context: viewContext,
                                percentage: goalPercentage
                            ),
                            school: school,
                            assignments: []
                        )
                        semester?.courses.insert(tmpCourse)
                        viewContext.insert(tmpCourse)
                    } else {
                        course?.goal.percentage = goalPercentage
                        course?.name = name
                        course?.credits = credits
                        course?.school = school
                    }
                    do { try viewContext.save() } catch { fatalError("bruh, course modify messed up") }
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
        .onAppear {
            if course != nil {
                name = course!.name
                credits = course!.credits
                school = course!.school
                if course!.goal.percentage != nil {
                    goalPercentage = course!.goal.percentage!
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
    static let semesters: [SemesterModel] = (try? PersistenceController
        .preview.container
        .viewContext
        .fetch(
            NSFetchRequest(entityName: "SemesterModel")
        ) as [SemesterModel]) ??
        []
    static var previews: some View {
        CourseSheet(parentSemester: semesters[0])
    }
}

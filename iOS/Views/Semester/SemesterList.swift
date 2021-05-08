//
//  SemesterList.swift
//  Grade Tracker
//
//  Created by Matthew Froggatt on 2021-03-18.
//

import CoreData
import SwiftUI

struct SemesterList: View {
    @Environment(\.managedObjectContext) var viewContext
    @State private var showAddSemesterSheet = false
    var semesters: [SemesterModel]

    func removeSemesters(at offsets: IndexSet) {
        for index in offsets {
            let semester = semesters[index]
            viewContext.delete(semester)
            do { try viewContext.save() } catch { fatalError("bruh, semesters delete messed up") }
        }
    }

    var body: some View {
        List {
            ForEach(semesters) { semester in
                VStack(alignment: .leading) {
                    HStack {
                        NavigationLink(
                            destination: SingleSemesterCourseList(semester: semester)
                        ) {
                            Text(semester.name)
                                .font(.headline)
                                .foregroundColor(.primary)
                                .padding(.leading)
                        }
                    }
                    CourseList(
                        semester: semester,
                        direction: .horizontal
                    )
                }
                .listRowInsets(EdgeInsets())
                .padding(.vertical)
            }
            .onDelete(perform: removeSemesters)
        }
        .listStyle(PlainListStyle())
        .navigationTitle("All Semesters")
        .toolbar {
            AddButton {
                showAddSemesterSheet = true
            }
        }
        .sheet(isPresented: $showAddSemesterSheet) {
            NavigationView {
                SemesterSheet(showSheet: $showAddSemesterSheet)
            }
        }
    }
}

struct SemesterList_Previews: PreviewProvider {
    static let semesters: [SemesterModel] = (try? PersistenceController
        .preview.container
        .viewContext
        .fetch(
            NSFetchRequest(entityName: "SemesterModel")
        ) as [SemesterModel]) ??
        []

    static var previews: some View {
        NavigationView {
            SemesterList(
                semesters: semesters
            )
        }
    }
}

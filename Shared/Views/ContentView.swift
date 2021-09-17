//
//  ContentView.swift
//  Shared
//
//  Created by Matthew Froggatt on 2021-03-09.
//

import CoreData
import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: SemesterModel.entity(),
        sortDescriptors: []
    ) private var semesters: FetchedResults<SemesterModel>

    private func useSemesters() -> [SemesterModel] {
        return Array(semesters)
    }

    var body: some View {
        Home(
            semesters: useSemesters()
        )
//        List {
//            ForEach(items) { item in
//                Text("Item at \(item.timestamp!, formatter: itemFormatter)")
//            }
//            .onDelete(perform: deleteItems)
//        }
//        .toolbar {
//            #if os(iOS)
//                EditButton()
//            #endif
//
//            Button(action: addItem) {
//                Label("Add Item", systemImage: "plus")
//            }
//        }
    }

    private func addItem() {
        withAnimation {
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error
                // appropriately. fatalError() causes the application to
                // generate a crash log and terminate. You should not use this
                // function in a shipping application, although it may be useful
                // during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets _: IndexSet) {
        withAnimation {
//            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error
                // appropriately. fatalError() causes the application to
                // generate a crash log and terminate. You should not use this
                // function in a shipping application, although it may be useful
                // during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(
            \.managedObjectContext,
            PersistenceController.preview.container.viewContext
        )
    }
}

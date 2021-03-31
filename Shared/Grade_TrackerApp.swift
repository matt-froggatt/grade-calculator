//
//  Grade_TrackerApp.swift
//  Shared
//
//  Created by Matthew Froggatt on 2021-03-09.
//

import SwiftUI

@main
struct Grade_TrackerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(
                    \.managedObjectContext,
                    persistenceController.container.viewContext
                )
        }
    }
}

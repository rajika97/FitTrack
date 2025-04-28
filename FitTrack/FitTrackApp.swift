//
//  FitTrackApp.swift
//  FitTrack
//
//  Created by Rajika Chathuranga on 2025-04-28.
//

import SwiftUI

@main
struct FitTrackApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

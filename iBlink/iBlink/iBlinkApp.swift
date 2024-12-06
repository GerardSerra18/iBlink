//
//  iBlinkApp.swift
//  iBlink
//
//  Created by Gerard Serra Rodríguez on 6/12/24.
//

import SwiftUI

@main
struct iBlinkApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

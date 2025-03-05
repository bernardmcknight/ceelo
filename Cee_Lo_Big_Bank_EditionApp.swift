//
//  Cee_Lo_Big_Bank_EditionApp.swift
//  Cee-Lo Big Bank Edition
//
//  Created by Bishop Mcknight on 3/4/25.
//

import SwiftUI

@main
struct Cee_Lo_Big_Bank_EditionApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

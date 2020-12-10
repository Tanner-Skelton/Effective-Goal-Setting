//
//  Effective_Goal_SettingApp.swift
//  Effective-Goal-Setting
//
//  Created by Tanner Skelton on 12/10/20.
//

import SwiftUI

@main
struct Effective_Goal_SettingApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

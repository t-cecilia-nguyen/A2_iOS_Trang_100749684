//
//  A2_iOS_Trang_100749684App.swift
//  A2_iOS_Trang_100749684
//
//  Created by Trang Nguyen on 2025-03-25.
//

import SwiftUI

@main
struct A2_iOS_Trang_100749684App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

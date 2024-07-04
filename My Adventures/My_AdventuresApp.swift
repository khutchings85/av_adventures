//
//  My_AdventuresApp.swift
//  My Adventures
//
//  Created by Kyle Hutchings on 6/14/24.
//

import SwiftUI
import SwiftData

@main
struct My_AdventuresApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: JournalEntry.self)
    }
}

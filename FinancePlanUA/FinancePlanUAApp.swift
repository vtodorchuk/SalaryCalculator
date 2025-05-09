//
//  FinancePlanUAApp.swift
//  FinancePlanUA
//
//  Created by Vlady Todorchuk on 09.05.2025.
//

import SwiftUI
import SwiftData

@main
struct FinancePlanUAApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Allocation.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}

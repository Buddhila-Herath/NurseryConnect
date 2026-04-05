//
//  kidsappApp.swift
//  kidsapp
//
//  Created by Supun Liyanage on 3/20/26.
//

import SwiftUI
import SwiftData

@main
struct kidsappApp: App {
    let container: ModelContainer
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(container)
        }
    }
    
    init() {
        do {
            container = try ModelContainer(for: Child.self, DiaryEntry.self)
            
            // Seed sample data on first launch
            Task { @MainActor in
                SampleData.shared.seed(modelContext: container.mainContext)
            }
        } catch {
            fatalError("Failed to initialize SwiftData container: \(error)")
        }
    }
}

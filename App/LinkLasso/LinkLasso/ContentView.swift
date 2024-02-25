//
//  ContentView.swift
//  LinkLasso
//
//  Created by Drew Markel on 2/10/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        TabView {
            HomeTabView()
                .tabItem { Label("Home", systemImage: "house") }
            HistoryTabView()
                .tabItem { Label("History", systemImage: "clock") }
            SettingsTabView()
                .tabItem { Label("Settings", systemImage: "gear") }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: HistoryEntry.self, configurations: config)
        
        return ContentView()
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container")
    }
}

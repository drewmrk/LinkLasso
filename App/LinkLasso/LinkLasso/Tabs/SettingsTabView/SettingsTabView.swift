//
//  SettingsTabView.swift
//  LinkLasso
//
//  Created by Drew Markel on 2/10/24.
//

import SwiftUI
import SwiftData

struct SettingsTabView: View {
    var body: some View {
        NavigationStack {
            Form {
                Section("History") {
                    ToggleHistoryView()
                    ClearHistoryButtonView()
                }
                Section("Server") {
                    ServerSettingsView()
                }
                .navigationTitle("Settings")
            }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: HistoryEntry.self, configurations: config)
        
        return SettingsTabView()
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container")
    }
}

//
//  HistoryTabView.swift
//  LinkLasso
//
//  Created by Drew Markel on 2/10/24.
//

import SwiftUI
import SwiftData

struct HistoryTabView: View {
    @AppStorage("isHistoryEnabled") private var isHistoryEnabled = true
    @Query private var history: [HistoryEntry]
    
    var body: some View {
        NavigationStack {
            HistoryListViewComponent(isHistoryEnabled: isHistoryEnabled, history: history.reversed())
            .navigationTitle("History")
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: HistoryEntry.self, configurations: config)
        
        return HistoryTabView()
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container")
    }
}

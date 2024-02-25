//
//  HistoryListViewComponent.swift
//  LinkLasso
//
//  Created by Drew Markel on 2/16/24.
//

import SwiftUI
import SwiftData

struct HistoryListViewComponent: View {
    private var isHistoryEnabled = true
    private var history: [HistoryEntry] = []
    
    init(isHistoryEnabled: Bool, history: [HistoryEntry]) {
        self.isHistoryEnabled = isHistoryEnabled
        self.history = history
    }
    
    var body: some View {
        if self.isHistoryEnabled {
            if !self.history.isEmpty {
                List(self.history) { entry in
                    HistoryListViewEntryComponent(shortenedURL: entry.shortenedURL, fullURL: entry.fullURL)
                }
            } else {
                Text("There is no history")
            }
        } else {
            Text("The history is not enabled")
        }
    }
}

#Preview("History disabled") {
    HistoryListViewComponent(isHistoryEnabled: false, history: [])
}

#Preview("History enabled, no history entries") {
    HistoryListViewComponent(isHistoryEnabled: true, history: [])
}

#Preview("History enabled, some history entries") {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: HistoryEntry.self, configurations: config)
        
        return HistoryListViewComponent(
            isHistoryEnabled: true, history: [HistoryEntry(fullURL: "superlongurl.com", shortenedURL: "shorter"), HistoryEntry(fullURL: "superlongurl.com", shortenedURL: "shorter")])
        .modelContainer(container)
    } catch {
        fatalError("Failed to create model container")
    }
}

//
//  ClearHistoryAlertView.swift
//  LinkLasso
//
//  Created by Drew Markel on 2/24/24.
//

import SwiftUI
import SwiftData

struct ClearHistoryButtonView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var history: [HistoryEntry]
    @State private var showAlert = false
    
    var body: some View {
        Button("Clear history", role: .destructive, action: {self.showAlert = true})
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Are you sure you want to clear the history?"),
                      message: Text("This cannot be undone"),
                      primaryButton: .default(Text("Cancel")),
                      secondaryButton: .destructive(Text("Delete"),
                                                    action: {self.clearHistory()})
                )
            }
    }
    
    private func clearHistory() {
        for historyEntry in history {
            modelContext.delete(historyEntry)
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: HistoryEntry.self, configurations: config)
        
        return ClearHistoryButtonView()
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container")
    }
}

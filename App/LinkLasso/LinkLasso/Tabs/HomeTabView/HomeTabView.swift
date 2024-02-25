//
//  HomeTabView.swift
//  LinkLasso
//
//  Created by Drew Markel on 2/10/24.
//

import SwiftUI
import SwiftData

struct HomeTabView: View {
    @AppStorage("isHistoryEnabled") private var isHistoryEnabled = true
    @Query private var history: [HistoryEntry]
    
    var body: some View {
        NavigationStack {
            VStack {
                ShortenURLFormView()
                Text("Recent History")
                    .font(.largeTitle.weight(.medium))
                HistoryListViewComponent(isHistoryEnabled: isHistoryEnabled,
                                         history: Array(history.reversed().prefix(3)))
                    .navigationTitle("Shorten a URL")
                Spacer()
            }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: HistoryEntry.self, configurations: config)
        
        return HomeTabView()
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container")
    }
}

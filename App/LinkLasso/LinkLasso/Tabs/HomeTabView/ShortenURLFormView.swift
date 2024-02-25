//
//  ShortenURLFormView.swift
//  LinkLasso
//
//  Created by Drew Markel on 2/17/24.
//

import SwiftUI
import SwiftData

struct ShortenURLFormView: View {
    @AppStorage("isHistoryEnabled") private var isHistoryEnabled = true
    @Environment(\.modelContext) private var modelContext
    @State private var fullURL = ""
    
    var body: some View {
        VStack {
            TextField("Type or paste a URL", text: self.$fullURL)
                .autocapitalization(.none)
                .keyboardType(.URL)
                .textFieldStyle(.roundedBorder)
                .padding()
                .font(.title3)
            ShortenButtonView(fullURL: self.$fullURL)
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: HistoryEntry.self, configurations: config)
        
        return ShortenURLFormView()
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container")
    }
}

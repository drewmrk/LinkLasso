//
//  ShortenButtonView.swift
//  LinkLasso
//
//  Created by Drew Markel on 2/24/24.
//

import SwiftUI
import SwiftData

struct ShortenButtonView: View {
    @AppStorage("isHistoryEnabled") private var isHistoryEnabled = true
    @AppStorage("serverURL") private var serverURL = ""
    @Environment(\.modelContext) private var modelContext
    @Binding public var fullURL: String
    @State private var response: ShorteningServiceResponse = ShorteningServiceResponse(successful: false, shortenedURL: "")
    @State private var errorOccurred = false
    @State private var errorMessage = ""
    
    var body: some View {
        Button {
            Task {
                await self.shortenURLAction()
            }
        } label: {
            Text("Shorten")
                .frame(maxWidth: .infinity)
                .font(.title2)
        }
        .alert(isPresented: self.$errorOccurred) {
            Alert(title: Text("Error"), 
                  message: Text("An error occurred while shortening the URL: \(self.errorMessage)"))
        }
        .disabled(self.fullURL == "" || self.serverURL == "")
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.roundedRectangle)
        .tint(Color.orange)
        .padding()
    }
    
    private func shortenURLAction() async {
        do {
            self.response = try await ShorteningService.shortenURL(serverURL: self.serverURL, urlToShorten: self.fullURL)
            
            if self.response.successful {
                modelContext.insert(HistoryEntry(fullURL: self.fullURL,
                                                 shortenedURL: self.response.shortenedURL))
            } else {
                self.errorOccurred = true
            }
        } catch {
            self.errorOccurred = true
            self.errorMessage = "\(error)"
        }
    }
}

#Preview("Button Enabled") {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: HistoryEntry.self, configurations: config)
        
        @State var fullURL = "Test"
        
        return ShortenButtonView(fullURL: $fullURL)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container")
    }
}

#Preview("Button disabled") {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: HistoryEntry.self, configurations: config)
        
        @State var fullURL = ""
        
        return ShortenButtonView(fullURL: $fullURL)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container")
    }
}

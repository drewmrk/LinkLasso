//
//  HistoryListViewEntryComponent.swift
//  LinkLasso
//
//  Created by Drew Markel on 2/17/24.
//

import SwiftUI

struct HistoryListViewEntryComponent: View {
    private var shortenedURL = ""
    private var fullURL = ""
    private var createdURL: URL?
    
    init(shortenedURL: String, fullURL: String) {
        self.shortenedURL = shortenedURL
        self.fullURL = fullURL
        self.createdURL = URL(string: self.shortenedURL)
    }
    
    var body: some View {
        if (self.createdURL != nil) {
            VStack(alignment: .leading) {
                Link(destination: self.createdURL!, label: {Text(self.shortenedURL)})
                Text(self.fullURL)
                    .font(.footnote)
            }
        }
    }
}

#Preview {
    VStack {
        HistoryListViewEntryComponent(shortenedURL: "g.gg", fullURL: "google.com")
    }
}

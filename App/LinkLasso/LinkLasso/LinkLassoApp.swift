//
//  LinkLassoApp.swift
//  LinkLasso
//
//  Created by Drew Markel on 2/10/24.
//

import SwiftUI

@main
struct LinkLassoApp: App {
    init() {
        
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: HistoryEntry.self)
    }
}

//
//  ToggleHistoryView.swift
//  LinkLasso
//
//  Created by Drew Markel on 2/24/24.
//

import SwiftUI

struct ToggleHistoryView: View {
    @AppStorage("isHistoryEnabled") private var isHistoryEnabled = true
    
    var body: some View {
        Toggle("History", isOn: $isHistoryEnabled)
    }
}

#Preview {
    ToggleHistoryView()
}

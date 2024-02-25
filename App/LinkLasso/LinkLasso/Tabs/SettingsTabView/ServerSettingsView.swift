//
//  ShorteningServerSettingsView.swift
//  LinkLasso
//
//  Created by Drew Markel on 2/24/24.
//

import SwiftUI

struct ServerSettingsView: View {
    @AppStorage("serverURL") private var serverURL = ""
    
    var body: some View {
        TextField("Server URL", text: self.$serverURL)
            .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
            .keyboardType(.URL)
    }
}

#Preview {
    ServerSettingsView()
}

//
//  ShorteningServiceRequest.swift
//  LinkLasso
//
//  Created by Drew Markel on 2/16/24.
//

import Foundation

class ShorteningServiceRequest: Encodable {
    public let fullURL: String
    
    init(fullURL: String) {
        self.fullURL = fullURL
    }
}

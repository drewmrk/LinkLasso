//
//  ShorteningServiceResponse.swift
//  LinkLasso
//
//  Created by Drew Markel on 2/16/24.
//

import Foundation

class ShorteningServiceResponse: Decodable {
    public let successful: Bool
    public let shortenedURL: String
    
    init(successful: Bool, shortenedURL: String) {
        self.successful = successful
        self.shortenedURL = shortenedURL
    }
}

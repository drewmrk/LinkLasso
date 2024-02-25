//
//  HistoryEntry.swift
//  LinkLasso
//
//  Created by Drew Markel on 2/11/24.
//

import Foundation
import SwiftData

@Model
final class HistoryEntry {
    public let fullURL: String
    public let shortenedURL: String

    init(fullURL: String, shortenedURL: String) {
        self.fullURL = fullURL
        self.shortenedURL = shortenedURL
    }
}

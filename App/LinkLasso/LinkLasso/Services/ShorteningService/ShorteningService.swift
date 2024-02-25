//
//  ShorteningService.swift
//  LinkLasso
//
//  Created by Drew Markel on 2/15/24.
//

import Foundation

final class ShorteningService {
    public static func shortenURL(serverURL: String, urlToShorten: String) async throws -> ShorteningServiceResponse {
        let (request, requestBody) = try! ShorteningService.buildRequest(serverURL: serverURL, url: urlToShorten)
        let (responseBody, _) = try await URLSession.shared.upload(for: request, from: requestBody)
        
        return try JSONDecoder().decode(ShorteningServiceResponse.self, from: responseBody)
    }
    
    private static func buildRequest(serverURL: String, url: String) throws -> (URLRequest, Data) {
        var request = URLRequest(url: URL(string: serverURL)!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let requestBody = try JSONEncoder().encode(ShorteningServiceRequest(fullURL: url))
        request.httpBody = requestBody
        
        return (request, requestBody)
    }
}

//
//  APIService.swift
//  Endxiety
//
//  Created by Manuel Yoseph Ray on 17/07/24.
//

import Foundation
class APIService {
    static let shared = APIService()
    private init() {}
    
    func fetchRandomQuote(category: String) async throws -> Quote {
        var components = URLComponents(string: "https://api.api-ninjas.com/v1/quotes")
        components?.queryItems = [URLQueryItem(name: "category", value: category)]
        
        guard let url = components?.url else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.setValue("AJqfAHwd3iuNlgcQhQiJhA==oLr0CId5tmeAnb0f", forHTTPHeaderField: "X-Api-Key")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let quotes = try JSONDecoder().decode([Quote].self, from: data)
        
        guard let quote = quotes.first else {
            throw NSError(domain: "QuoteError", code: 0, userInfo: [NSLocalizedDescriptionKey: "No quote found"])
        }
        
        return quote
    }
}

//
//  QuoteViewModel.swift
//  Endxiety
//
//  Created by Manuel Yoseph Ray on 17/07/24.
//

import Foundation

@MainActor
class QuoteViewModel: ObservableObject {
    @Published var quote: Quote?
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var selectedCategory = "inspirational"
    
    let categories = ["faith", "future", "inspirational", "happiness", "life", "love", "success", "wisdom"]
    
    func fetchQuote() {
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                quote = try await APIService.shared.fetchRandomQuote(category: selectedCategory)
            } catch {
                errorMessage = error.localizedDescription
            }
            isLoading = false
        }
    }
}

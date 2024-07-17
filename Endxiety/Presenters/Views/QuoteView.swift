//
//  QuoteView.swift
//  Endxiety
//
//  Created by Ali Haidar on 11/07/24.
//

import SwiftUI

struct QuoteView: View {
    @StateObject private var quoteViewModel = QuoteViewModel()
    
    var body: some View {
        NavigationLink {
            MainView().navigationTitle(LocalizedStringKey("My Notes"))
        }label: {
            VStack(spacing:20){
                Spacer()
                if quoteViewModel.isLoading {
                    ProgressView()
                } else if let quote = quoteViewModel.quote {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(quote.quote)
                            .font(.title2)
                            .foregroundColor(.black)
                            .italic()
                        Text("- \(quote.author)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding()
                } else if let error = quoteViewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                }
                Spacer()
                Text("Tap anywhere to exit")
                
            }
                .onAppear {
                    quoteViewModel.fetchQuote()
                }
        }.navigationBarBackButtonHidden()
            
    }
}

#Preview {
    QuoteView()
}

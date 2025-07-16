//
//  ErrorView.swift
//  CatAPI
//
//  Created by Glenn Karlo Manguiat on 6/5/25.
//

import SwiftUI

struct ErrorView: View {
    @ObservedObject var breedFetcher: BreedFetcher
    
    var body: some View {
        VStack {
            Text(breedFetcher.errorMessage ?? "")
            
            Button {
                breedFetcher.fetchAllBreeds()
            } label: {
                Text("Try again")
            }
        }
        
    }
}

#Preview {
    ErrorView(breedFetcher: BreedFetcher())
}

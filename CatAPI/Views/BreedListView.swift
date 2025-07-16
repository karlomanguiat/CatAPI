//
//  BreedListView.swift
//  CatAPI
//
//  Created by Glenn Karlo Manguiat on 6/5/25.
//

import SwiftUI

struct BreedListView: View {
    let breeds: [Breed]
    
    @State private var searchText: String = ""
    
    var filteredBreeds: [Breed] {
        guard !searchText.isEmpty else {
            return breeds
        }
        
        return breeds.filter {
            $0.name.lowercased().contains(searchText.lowercased())
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredBreeds) { breed in
                    NavigationLink {
                        BreedDetailView(breed: breed)
                    } label: {
                        BreedRow(breed: breed)
                    }
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Favorite Cats")
            .searchable(text: $searchText)
        }
    }
}

#Preview {
    BreedListView(breeds: BreedFetcher.successState().breeds)
}

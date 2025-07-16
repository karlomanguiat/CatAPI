//
//  BreedDetailView.swift
//  CatAPI
//
//  Created by Glenn Karlo Manguiat on 6/6/25.
//

import SwiftUI

struct BreedDetailView: View {
    let breed: Breed
    let imageSize: CGFloat = 300
    var body: some View {
        ScrollView {
            VStack {
                if breed.image != nil {
                    AsyncImage(url: URL(string: breed.image!.url!)) { phase in
                        if let image = phase.image {
                            image.resizable()
                                .scaledToFit()
                                .frame(width: imageSize, height: imageSize)
                                .clipped()
                        } else if phase.error != nil {
                            Color.gray
                                .frame(height: imageSize)
                        } else {
                            ProgressView()
                                .frame(height: imageSize)
                        }
                    }
                } else {
                    Color.gray.frame(height: imageSize)
                }
                VStack(alignment: .leading, spacing: 15) {
                    Text(breed.name)
                        .font(.headline)
                    Text(breed.temperament)
                        .font(.footnote)
                    Text(breed.breedExplanation)
                    
                    if breed.isHairless {
                        Text("Hairless")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Text("Energy Level")
                        Spacer()
                        
                        ForEach(1..<6) { id in
                            Image(systemName: "star.fill")
                                .foregroundColor(breed.energyLevel >= id ? .yellow : .gray)
                            
                        }
                    }
                    Spacer()
                }
                .padding()
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

#Preview {
    BreedDetailView(breed: Breed.example())
}

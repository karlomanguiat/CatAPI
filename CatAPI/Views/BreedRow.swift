//
//  BreedRow.swift
//  CatAPI
//
//  Created by Glenn Karlo Manguiat on 6/6/25.
//

import SwiftUI

struct BreedRow: View {
    let breed: Breed
    let imageSize: CGFloat = 100
    
    var body: some View {
        HStack {
            if breed.image != nil {
                AsyncImage(url: URL(string: breed.image!.url!)) { phase in
                    if let image = phase.image {
                        image.resizable()
                            .scaledToFill()
                            .frame(width: imageSize, height: imageSize)
                            .clipped()
                    } else if phase.error != nil {
                        Color.gray
                            .frame(width: imageSize, height: imageSize)
                    } else {
                        ProgressView()
                            .frame(width: imageSize, height: imageSize)
                    }
                }
            } else {
                Color.gray.frame(width: imageSize, height: imageSize)
            }
            VStack(alignment: .leading, spacing: 5) {
                Text(breed.name)
                    .font(.headline)
                Text(breed.temperament)
            }
        }
    }
}

#Preview {
    BreedRow(breed: Breed.exampleAgain())
        .previewLayout(.fixed(width: 300.0, height: 200.0))
}

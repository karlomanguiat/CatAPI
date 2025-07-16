//
//  LoadingView.swift
//  CatAPI
//
//  Created by Glenn Karlo Manguiat on 6/5/25.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            ProgressView()
            Text("Getting the cats...")
                .foregroundColor(.gray)
        }
        
    }
}

#Preview {
    LoadingView()
}

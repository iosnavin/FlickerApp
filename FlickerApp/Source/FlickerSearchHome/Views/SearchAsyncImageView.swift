//
//  SearchAsyncImageView.swift
//  FlickerApp
//
//  Created by Naveen Reddy on 09/07/24.
//

import Foundation
import SwiftUI

struct CustomAsyncImage: View {
    let url: URL
    @State private var image: UIImage?
    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else {
                ProgressView()
            }
        }
        .task {
            do {
                self.image = try await ImageLoader.shared.loadImage(from: url)
            } catch {
                print("Error loading image: \(error.localizedDescription)")
            }
        }
    }
}

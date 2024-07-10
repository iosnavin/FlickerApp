//
//  ImageLoader.swift
//  FlickerApp
//
//  Created by Naveen Reddy on 09/07/24.
//

import Foundation
import UIKit

protocol ImageLoading {
    func loadImage(from url: URL) async throws -> UIImage
}

class ImageLoader: ImageLoading {
    static let shared = ImageLoader()
    private let cache = NSCache<NSURL, UIImage>()
    
    private init() {}
    
    func loadImage(from url: URL) async throws -> UIImage {
        if let cachedImage = cache.object(forKey: url as NSURL) {
            return cachedImage
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        guard let image = UIImage(data: data) else {
            throw ImageLoadingError.invalidImageData
        }
        
        cache.setObject(image, forKey: url as NSURL)
        return image
    }
    
    func clearCache() {
        cache.removeAllObjects()
    }
}


enum ImageLoadingError: Error {
    case invalidImageData
}

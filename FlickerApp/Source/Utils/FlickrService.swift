//
//  FlickrService.swift
//  FlickerApp
//
//  Created by Naveen Reddy on 09/07/24.
//

import Foundation

struct FlickrService {
    static let shared = FlickrService()
    private let apiKey = "8403cf097563c866bb1e7b9a59249692"
    private let baseURL = "https://api.flickr.com/services/rest/"
    
    func searchPhotos(query: String) async throws -> FlickrResponse {
        let urlString = "\(baseURL)?method=flickr.photos.search&api_key=\(apiKey)&format=json&nojsoncallback=1&text=\(query)&per_page=10"

        guard let url = URL(string: urlString) else {
            throw FlickrAPIError.invalidURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode)
            else {
                throw FlickrAPIError.invalidResponse
            }
            
            do {
                return try JSONDecoder().decode(FlickrResponse.self, from: data)
            } catch {
                throw FlickrAPIError.decodingError(error)
            }
        } catch {
            throw FlickrAPIError.networkError(error)
        }
    }
}

//
//  FlickrAPIError.swift
//  FlickerApp
//
//  Created by Naveen Reddy on 09/07/24.
//

import Foundation

enum FlickrAPIError: Error, LocalizedError {
    case invalidURL
    case networkError(Error)
    case invalidResponse
    case decodingError(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL provided was invalid."
        case .networkError(let error):
            return "A network error occurred: \(error.localizedDescription)"
        case .invalidResponse:
            return "The server response was invalid."
        case .decodingError(let error):
            return "Failed to decode the response: \(error.localizedDescription)"
        }
    }
}

//
//  MockFlickrService.swift
//  FlickerAppTests
//
//  Created by Naveen Reddy on 09/07/24.
//

import Foundation
@testable import FlickerApp

protocol FlickrServiceProtocol {
    var service: FlickrService {get set}
    func searchPhotos(query: String) async throws -> FlickrResponse
}

class MockFlickrService: FlickrServiceProtocol {
    var service = FlickrService.shared
    func searchPhotos(query: String) async throws -> FlickrResponse {
        return try await service.searchPhotos(query: "city")
    }
}

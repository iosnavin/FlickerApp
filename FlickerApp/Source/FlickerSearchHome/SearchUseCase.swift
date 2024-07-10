//
//  SearchUseCase.swift
//  FlickerApp
//
//  Created by Naveen Reddy on 09/07/24.
//

import Foundation

protocol FlickerServiceUsecase {
    func search(with query: String) async throws -> FlickrResponse
}

struct FlickerServiceUseCaseImpl: FlickerServiceUsecase {
    private let service = FlickrService.shared
    func search(with query: String) async throws -> FlickrResponse {
        return try await service.searchPhotos(query: query)
    }
}


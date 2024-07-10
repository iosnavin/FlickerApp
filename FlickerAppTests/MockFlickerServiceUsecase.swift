//
//  MockFlickerServiceUsecase.swift
//  FlickerAppTests
//
//  Created by Naveen Reddy on 09/07/24.
//

import Foundation
@testable import FlickerApp

class MockFlickerServiceUsecase: FlickerServiceUsecase {
    func search(with query: String) async throws -> FlickrResponse {
        return FlickrResponse(photos: .init(photo: [.init(id: "12", title: "23", farm: 1, server: "", secret: "")]))
    }
}

class MockErrorFlickerServiceUsecase: FlickerServiceUsecase {
    func search(with query: String) async throws -> FlickrResponse {
        throw FlickerServiceError.failed
    }
}

enum FlickerServiceError: Error {
    case failed
}

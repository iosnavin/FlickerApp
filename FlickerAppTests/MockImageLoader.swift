//
//  MockImageLoader.swift
//  FlickerAppTests
//
//  Created by Naveen Reddy on 09/07/24.
//

import XCTest
@testable import FlickerApp

final class ImageLoaderTests: XCTestCase {
    
    // Mock URL and Image Data
    private let validURL = URL(string: "https://example.com/image.jpg")!
    private let invalidURL = URL(string: "https://example.com/invalid_image.jpg")!
    
    // MARK: - Test loadImage Function with MockImageLoader
    
    func testLoadImageSuccess() {
        let expectation = XCTestExpectation(description: "Image loaded successfully")
        let mockLoader: ImageLoading = MockImageLoader()
        
        Task {
            do {
                let image = try await mockLoader.loadImage(from: validURL)
                XCTAssertNotNil(image, "Image should not be nil")
                expectation.fulfill()
            } catch {
                XCTFail("Failed to load image: \(error)")
            }
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testLoadImageInvalidData() {
        let expectation = XCTestExpectation(description: "Invalid image data handling")
        let mockLoader: ImageLoading = MockErrrorImageLoader()
        Task {
            do {
                _ = try await mockLoader.loadImage(from: invalidURL)
                XCTFail("Expected loadImage to throw ImageLoadingError.invalidImageData")
            } catch {
                guard let imageError = error as? ImageLoadingError else {
                    XCTFail("Expected ImageLoadingError.invalidImageData, got \(error)")
                    return
                }
                XCTAssertEqual(imageError, ImageLoadingError.invalidImageData, "Expected ImageLoadingError.invalidImageData")
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 1.0)
    }
}


class MockImageLoader: ImageLoading {
    func loadImage(from url: URL) async throws -> UIImage {
        guard let image = UIImage(named: "mockImage") else {
            throw ImageLoadingError.invalidImageData
        }
        return image
    }
}

class MockErrrorImageLoader: ImageLoading {
    func loadImage(from url: URL) async throws -> UIImage {
        throw ImageLoadingError.invalidImageData
    }
}

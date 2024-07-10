//
//  FlickerHomeViewModelTests.swift
//  FlickerAppTests
//
//  Created by Naveen Reddy on 09/07/24.
//

import XCTest
@testable import FlickerApp

final class FlickerHomeViewModelTests: XCTestCase {
    @MainActor func testSearchPhotosSuccess() {
        let viewModel = FlickerHomeViewModel(usecase: MockFlickerServiceUsecase())
        viewModel.searchPhotos(query: "nature")
        XCTAssertEqual(viewModel.state, .loading, "ViewModel state should be loading")
        // Simulate asynchronous operation completion
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertEqual(viewModel.state, .finished(Photo.mockedArray), "ViewModel state should be finished with mock photo")
        }
    }
    
    @MainActor 
    func testSearchPhotosFailure() {
        let viewModel = FlickerHomeViewModel(usecase: MockErrorFlickerServiceUsecase())
        viewModel.searchPhotos(query: "invalid")
        XCTAssertEqual(viewModel.state, .loading, "ViewModel state should be loading")
        // Simulate asynchronous operation completion
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertEqual(viewModel.state, .error("The operation couldn’t be completed. (MockError error 500.)"), "ViewModel state should be error")
        }
    }
}

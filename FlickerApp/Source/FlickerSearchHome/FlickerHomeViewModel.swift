//
//  FlickerHomeViewModel.swift
//  FlickerApp
//
//  Created by Naveen Reddy on 09/07/24.
//

import Foundation
import Combine

@MainActor
class FlickerHomeViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var state: SearchState<[Photo]> = .none
    @Published var cachedPhotos: FlickrResponse?
    
    private let usecase: FlickerServiceUsecase
    private var cancellables = Set<AnyCancellable>()
    
    init(usecase: FlickerServiceUsecase = FlickerServiceUseCaseImpl()) {
        self.usecase = usecase
        self.getRandomKeyword()
        
        $searchText
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .sink { [weak self] text in
                self?.searchPhotos(query: text)
            }
            .store(in: &cancellables)
    }
    
    func searchPhotos(query: String) {
        guard !query.isEmpty else {
            state = .none
            return
        }
        
        state = .loading
        
        performSearch(query: query)
    }
    
    private func performSearch(query: String) {
        Task {
            do {
                let response = try await usecase.search(with: query)
                state = .finished(response.photos.photo)
                cachedPhotos = response
            } catch {
                state = .error(error.localizedDescription)
            }
        }
    }
    
    private func getRandomKeyword() {
        let randomKeywords = ["nature", "city", "food", "travel", "animals"]
        searchText = randomKeywords.randomElement() ?? ""
    }
}



//
//  State.swift
//  FlickerApp
//
//  Created by Naveen Reddy on 09/07/24.
//

import Foundation

enum SearchState<T>: Equatable where T: Equatable {
    case none
    case loading
    case finished(T)
    case error(String)
    
    static func == (lhs: SearchState<T>, rhs: SearchState<T>) -> Bool {
        switch (lhs, rhs) {
        case (.none, .none):
            return true
        case (.loading, .loading):
            return true
        case let (.finished(leftData), .finished(rightData)):
            return leftData == rightData
        case let (.error(leftMessage), .error(rightMessage)):
            return leftMessage == rightMessage
        default:
            return false
        }
    }
}

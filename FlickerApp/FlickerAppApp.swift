//
//  FlickerAppApp.swift
//  FlickerApp
//
//  Created by Naveen Reddy on 09/07/24.
//

import SwiftUI

@main
struct FlickerAppApp: App {
    var body: some Scene {
        WindowGroup {
            FlickerHomeView(viewModel: .init(usecase: FlickerServiceUseCaseImpl()))
        }
    }
}




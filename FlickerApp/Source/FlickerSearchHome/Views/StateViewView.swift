//
//  StateViewView.swift
//  FlickerApp
//
//  Created by Naveen Reddy on 09/07/24.
//

import SwiftUI

struct StateViewView: View {
    let imageName: String
    let title: String
    let text: String
    var type: StateType = .info
    
    enum StateType {
        case danger
        case info
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: Space.medium) {
            Image(systemName: imageName)
                .font(.largeTitle)
                .foregroundColor(type == .danger ? .red : .yellow )
                .repeatingBounceAnimation()
            
            Text(title)
                .font(.headline)
            
            Text(text)
                .multilineTextAlignment(.center)
                .lineLimit(3)
                .font(.callout)
                .foregroundColor(.gray)
        }
        .padding(Space.large)
    }
}

struct StateViewView_Previews: PreviewProvider {
    static var previews: some View {
        StateViewView(imageName: "", title: strings.searchExploreCardTitle, text: strings.searchExploreCardSubTitle)
    }
}

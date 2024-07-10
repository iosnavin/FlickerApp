//
//  CardView.swift
//  FlickerApp
//
//  Created by Naveen Reddy on 09/07/24.
//

import SwiftUI

struct CardView<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 5)
                content
            }
        }
        .frame(maxWidth: .infinity)
    }
}

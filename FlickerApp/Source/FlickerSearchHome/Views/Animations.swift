//
//  Animations.swift
//  FlickerApp
//
//  Created by Naveen Reddy on 09/07/24.
//

import Foundation
import SwiftUI

struct BounceAnimationModifier: ViewModifier {
    @State private var scale: CGFloat = 1.0
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(scale)
            .onAppear {
                withAnimation(Animation.interpolatingSpring(stiffness: 100, damping: 10)) {
                    self.scale = 2.5 // Scale up
                }
            }
            .onDisappear {
                withAnimation {
                    self.scale = 1.0 // Reset scale when disappear
                }
            }
    }
}

extension View {
    func bounceAnimation() -> some View {
        self.modifier(BounceAnimationModifier())
    }
    
    func repeatingBounceAnimation() -> some View {
        self.modifier(RepeatingBounceAnimationModifier())
    }
    
}

struct RepeatingBounceAnimationModifier: ViewModifier {
    @State private var scale: CGFloat = 1.0
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(scale)
            .onAppear {
                bounceAnimation()
            }
    }
    
    private func bounceAnimation() {
        let animation = Animation.interpolatingSpring(stiffness: 100, damping: 10)
        withAnimation(animation) {
            self.scale = 1.2 // Scale up
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation(animation) {
                self.scale = 1.0 // Scale down
            }
            
            // Repeat the animation
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                bounceAnimation()
            }
        }
    }
}

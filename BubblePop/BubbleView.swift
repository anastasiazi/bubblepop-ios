//
//  BubbleView.swift
//  BubblePop
//
//  Created by Anastasiia on 8/17/23.
//

import Foundation
import SwiftUI

struct BubbleView: View {
    @Binding var bubble: Bubble // <-- Use @Binding to reflect changes in the parent view

    var body: some View {
        ZStack {
            // Main bubble with gradient
            Circle()
                .fill(LinearGradient(gradient: Gradient(colors: [bubble.color.opacity(0.2), bubble.color]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 70 * bubble.scale, height: 70 * bubble.scale)  // Adjust for bubble size and scale
                .overlay(
                    Circle().stroke(Color.white.opacity(0.3), lineWidth: 2)  // This line adds the border
                    )
            // Add a shine or reflection effect to the bubble
            Circle()
                .fill(LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.5), Color.clear]), startPoint: .top, endPoint: .bottom))
                .frame(width: 30 * bubble.scale, height: 30 * bubble.scale) // Adjust for scale
                .offset(x: -10, y: -10)
        }
        .position(bubble.position)
        .shadow(color: Color.white.opacity(0.2), radius: 5, x: -5, y: -5)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 5, y: 5)
        .opacity(0.8) // Add some overall transparency
                .onAppear() {
                    withAnimation(.linear(duration: 5.0)) { // Adjust duration as needed
                        self.bubble.position = bubble.targetPosition
                    }
                }
    }
}

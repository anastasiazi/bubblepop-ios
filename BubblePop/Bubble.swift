//
//  Bubble.swift
//  BubblePop
//
//  Created by Anastasiia on 8/17/23.
//

import Foundation
import SwiftUI

struct Bubble {
    var id: UUID = UUID()
    var position: CGPoint
    var targetPosition: CGPoint
    var color: Color
    var scale: CGFloat = 1.0 // <-- Add this property
}

//
//  GameViewModel.swift
//  BubblePop
//
//  Created by Anastasiia on 8/17/23.
//


import Foundation
import SwiftUI
import AVFoundation

class GameViewModel: ObservableObject {
    @Published var gameStarted: Bool = false
    @Published var bubbles: [Bubble] = []
    @Published var score: Int = 0 // This will track the current score
    @Published var gameWon: Bool = false

    var bubbleSpeedDuration: Double = 5.0 // This will represent the current speed of bubble movement

    var gameTimer: Timer?
        var tickCounter: Int = 0  // To control the creation rate of bubbles

    func startGame() {
            gameStarted = true
            createBubble() // Initially create a bubble when the game starts
        }
    
    

    func endGame() {
        gameTimer?.invalidate()
        gameTimer = nil
        gameStarted = false
        // Additional cleanup if necessary
    }

    // Generates a random bubble
        func createBubble() {
            let xPos = CGFloat.random(in: 0...UIScreen.main.bounds.width)
            let bubble = Bubble(position: CGPoint(x: xPos, y: UIScreen.main.bounds.height + 100),
                                targetPosition: CGPoint(x: xPos, y: -200),
                                color: Color.random)
            bubbles.append(bubble)
            
            // Schedule the next bubble creation
            DispatchQueue.main.asyncAfter(deadline: .now() + bubbleSpeedDuration / 10.0) {
                self.createBubble()
            }
        }


    
    // Deletes bubbles that are out of screen bounds
    func deleteOutOfBoundBubbles() {
        bubbles = bubbles.filter { $0.position.y - 100 > 0 } // Check if the bottom of the bubble is still on the screen
    }

    
    // Pop bubbles
    func popBubble(id: UUID) {
        if let index = bubbles.firstIndex(where: { $0.id == id }) {
            withAnimation {
                bubbles[index].scale = 0.0
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.bubbles.remove(at: index)
            }
        }
        
        score += 1
        
        // Check if the score is a multiple of 15
        if score % 15 == 0 {
            bubbleSpeedDuration *= 0.9 // Decrease duration by 10% (increase speed)
        }
        
        score += 1

            if score == 50 {
                gameWon = true
                gameStarted = false
            }
    }
    
    // Play the pop sound effect
    func playPopSound() {
        let path = Bundle.main.path(forResource: "pop.mp3", ofType: nil)!
        let url = URL(fileURLWithPath: path)

        do {
            let sound = try AVAudioPlayer(contentsOf: url)
            sound.play()
        } catch {
            print("Couldn't load the sound file")
        }
    }
}

extension Color {
    static var random: Color {
        let red = Double.random(in: 0..<1)
        let green = Double.random(in: 0..<1)
        let blue = Double.random(in: 0..<1)
        return Color(red: red, green: green, blue: blue)
    }
}

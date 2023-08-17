//
//  ContentView.swift
//  BubblePop
//
//  Created by Anastasiia on 8/17/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var game = GameViewModel()
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.5), Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all) // This will make the gradient cover the entire view.

            
            if game.gameStarted {
                // The game view
                ForEach(game.bubbles, id: \.id) { bubble in
                    BubbleView(bubble: Binding(
                        get: { bubble },
                        set: { newBubble in
                            if let index = game.bubbles.firstIndex(where: { $0.id == newBubble.id }) {
                                game.bubbles[index] = newBubble
                            }
                        }
                    ))
                    .onTapGesture {
                        withAnimation {
                            game.popBubble(id: bubble.id)
                        }
                    }
                }

            } else if !game.gameWon {
                // The start button
                Button(action: {
                    game.startGame()
                }) {
                    Text("Start")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .padding(.horizontal, 50)
                        .padding(.vertical, 20)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color.purple, Color.pink]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                .clipShape(RoundedRectangle(cornerRadius: 50))
                        )
                        .foregroundColor(.white)
                        .cornerRadius(50)
                        .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 20)
                }
            }
            if game.gameStarted {
                    VStack {
                        HStack {
                            Spacer() // Pushes the score to the right side
                            Text("Score: \(game.score)")
                                .font(.title)
                                .fontWeight(.heavy)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                                .background(
                                    LinearGradient(gradient: Gradient(colors: [Color.purple, Color.pink]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                )
                                .foregroundColor(.white)
                                .cornerRadius(20)
                                .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 10)
                                .padding([.top, .trailing], 20)
                        }
                        Spacer() // Pushes the score to the top side
                    }
                }
            if game.gameWon {
                VStack {
                    Button(action: {}) {
                        Text("Hooray!")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .padding(.horizontal, 50)
                            .padding(.vertical, 20)
                            .background(
                                LinearGradient(gradient: Gradient(colors: [Color.purple, Color.yellow]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                    .clipShape(RoundedRectangle(cornerRadius: 50))
                            )
                            .foregroundColor(.white)
                            .cornerRadius(50)
                            .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 20)
                    }

                    Button(action: {
                        game.score = 0
                        game.gameWon = false
                        game.startGame()
                    }) {
                        Text("Play Again")
                            .font(.title2)
                            .fontWeight(.heavy)
                            .padding(.horizontal, 40)
                            .padding(.vertical, 15)
                            .background(
                                LinearGradient(gradient: Gradient(colors: [Color.purple, Color.yellow]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                    .clipShape(RoundedRectangle(cornerRadius: 50))
                            )
                            .foregroundColor(.white)
                            .cornerRadius(50)
                            .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 20)
                    }
                    .padding(.top, 10)
                }
            }

        }
    }
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}

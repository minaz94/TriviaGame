//
//  GameSetupView.swift
//  TriviaGame
//
//  Created by Mina on 3/26/24.
//

import SwiftUI

struct GameSetupView: View {
    
    @EnvironmentObject var viewModel: GameViewModel
    
    @State private var isNavigatingToGameView: Bool = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .ignoresSafeArea()
                .foregroundStyle(.yellow.opacity(0.2))
            VStack {
                Text("Trivia Game")
                    .font(.custom("menlo", size: 30))
                    .foregroundStyle(.olive)
                    .bold()
                    .padding(.top)
                Spacer()
                
                BubbleView(imageName: "brown-speech-bubbles", gameSetting: NumberOfQuestions())
                    .padding(.trailing, 150)
                
                BubbleView(imageName: "brown-speech-bubbles-right", gameSetting: Difficulty())
                    .padding(.leading, 150)
                
                BubbleView(imageName: "brown-speech-bubbles", gameSetting: AnswerType())
                    .padding(.trailing, 150)
                
                BubbleView(imageName: "brown-speech-bubbles-right", gameSetting: CategoryType())
                    .padding(.leading, 150)
                
                BubbleView(imageName: "brown-speech-bubbles", gameSetting: TimeDuration())
                    .padding(.trailing, 150)
                
                Spacer()
                Button(action: {
                    Task {
                        try await viewModel.getTrivia()
                        isNavigatingToGameView = true
                    }
                }, label: {
                    Text("Play")
                        .font(.custom("menlo", size: 30))
                        .bold()
                        .frame(width: 300)
                        .padding()
                        .background(.olive)
                        .foregroundStyle(.yellow.gradient)
                        .clipShape(.capsule)
                })
                .shadow(radius: 4)
            }
            
        }
        .navigationDestination(isPresented: $isNavigatingToGameView) {
            GameView()
        }

    }
}

#Preview {
    GameSetupView()
        .environmentObject(GameViewModel())
}

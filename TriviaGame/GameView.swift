//
//  GameView.swift
//  TriviaGame
//
//  Created by Mina on 3/26/24.
//

import SwiftUI

struct GameView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var viewModel: GameViewModel
    @State private var remainingSeconds = 0
    @State private var selectedIndex: Int = 0
    @State private var selectedAnswer: String = ""
    @State private var hasAnswered: Bool = false
    
    @State private var shouldShowAlert: Bool = false

    var body: some View {
        ZStack {
            Rectangle()
                .ignoresSafeArea()
                .foregroundStyle(.yellow.opacity(0.2))
            VStack {
                HStack {
                    Spacer()
                    Label(timeString(remainingSeconds), systemImage: "clock")
                        .padding(.trailing)
                        .font(.custom("menlo", size: 30))
                        .onAppear {
                            remainingSeconds = (Int(viewModel.timeDuration) ?? 0) * 60
                            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                                if shouldShowAlert {
                                    timer.invalidate()
                                }
                                else if remainingSeconds > 0 {
                                    remainingSeconds -= 1
                                } else {
                                    //Finish Game
                                    timer.invalidate()
                                    DispatchQueue.main.async {
                                        shouldShowAlert = true
                                    }
                                }
                            }
                        }
                }
                QuestionBubble(questionText: viewModel.fetchedTrivia?.results[selectedIndex].question ?? "No Question")
                    .padding(.bottom)
                Text("Choose an answer:")
                    .font(.custom("menlo", size: 17))
                    .foregroundStyle(.black)
                    .padding()
                List(viewModel.fetchedTrivia?.results[selectedIndex].allAnswers ?? [], id: \.self) { answer in
                    Button(action: {
                        selectedAnswer = answer
                        hasAnswered = true
                    }, label: {
                        Text(answer.formatted)
                            .font(.custom("menlo", size: selectedAnswer == answer ? 20 : 17))
                    })
                    .listRowBackground(Color.clear)
                    .foregroundStyle(selectedAnswer == answer ? .olive : .black)
                    .bold(selectedAnswer == answer)
                }
                .listStyle(PlainListStyle())
                .background(.clear)
                
                Button(action: {
                    if hasAnswered {
                        
                        if selectedIndex < (viewModel.fetchedTrivia?.results.count ?? 0) - 1 {
                            if selectedAnswer == viewModel.fetchedTrivia?.results[selectedIndex].correctAnswer {
                                viewModel.score += 1
                            }
                            selectedIndex += 1
                        } else {
                            if selectedAnswer == viewModel.fetchedTrivia?.results[selectedIndex].correctAnswer {
                                viewModel.score += 1
                            }
                            shouldShowAlert = true
                        }
                        
                        
                        hasAnswered = false
                        selectedAnswer = ""
                    }
                }, label: {
                    Text(selectedIndex == (viewModel.fetchedTrivia?.results.count ?? 0) - 1 ? "Finish" : "Next")
                        .font(.custom("menlo", size: 30))
                        .bold()
                        .frame(width: 300)
                        .padding()
                        .background(hasAnswered ? .olive : .olive.opacity(0.7))
                        .foregroundStyle(.yellow.gradient)
                        .clipShape(.capsule)
                })
                .disabled(!hasAnswered)
                .alert(remainingSeconds == 0 ? "Time is up!" : "Finished!", isPresented: $shouldShowAlert) {
                    Button("Ok") {
                        dismiss()
                        viewModel.score = 0
                        viewModel.answerType = AnswerType.defaultSetting
                        viewModel.difficulty = Difficulty.defaultSetting
                        viewModel.numberOfQuestions = NumberOfQuestions.defaultSetting
                        viewModel.timeDuration = TimeDuration.defaultSetting
                        viewModel.categoryType = CategoryType.defaultSetting
                    }
                } message: {
                    Text("score: \(viewModel.score) out of \(viewModel.fetchedTrivia?.results.count ?? 0)")
                }

            }
            
            
        }
        .navigationBarBackButtonHidden()
    }
    
    func timeString(_ totalSeconds: Int) -> String {
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

#Preview {
    GameView()
        .environmentObject(GameViewModel())
}

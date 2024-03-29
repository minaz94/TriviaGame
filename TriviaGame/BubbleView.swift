//
//  BubbleView.swift
//  TriviaGame
//
//  Created by Mina on 3/26/24.
//

import SwiftUI

struct BubbleView: View {
    
    @State var imageName: String
    @State var gameSetting: GameSetting
    
    @EnvironmentObject var viewModel: GameViewModel
    
    var body: some View {
        ZStack {
            Image(imageName)
                .resizable()
                .foregroundStyle(.gray.opacity(0.3))
                .frame(width: 200, height: 100)
                .shadow(radius: 4)
            Menu {
                ForEach(gameSetting.options, id: \.self) { option in
                    Button(action: {
                        switch gameSetting {
                        case is AnswerType:
                            viewModel.answerType = option
                        case is Difficulty:
                            viewModel.difficulty = option
                        case is NumberOfQuestions:
                            viewModel.numberOfQuestions = option
                        case is TimeDuration:
                            viewModel.timeDuration = option
                        case is CategoryType:
                            viewModel.categoryType = option
                        default:
                            break
                        }
                    }, label: {
                        if gameSetting is TimeDuration {
                            if option == "1" {
                                Text("\(option) minute")
                            } else {
                                Text("\(option) minutes")
                            }
                        } else {
                            Text(option)
                        }
                    })
                }
            } label: {
                VStack {
                    HStack {
                        Text(gameSetting.labelText)
                            .font(.custom("menlo", size: 17))
                            .foregroundStyle(.black)
                        Image(systemName: "chevron.down")
                            .tint(.black)
                    }
                    .padding(.bottom, 5)
                    switch gameSetting {
                    case is AnswerType:
                        Text("\(viewModel.answerType)")
                            .font(.custom("menlo", size: 10))
                            .foregroundStyle(.olive)
                    case is Difficulty:
                        Text("\(viewModel.difficulty)")
                            .font(.custom("menlo", size: 10))
                            .foregroundStyle(.olive)
                    case is NumberOfQuestions:
                        Text("\(viewModel.numberOfQuestions)")
                            .font(.custom("menlo", size: 10))
                            .foregroundStyle(.olive)
                    case is TimeDuration:
                        if viewModel.timeDuration == "1" {
                            Text("\(viewModel.timeDuration) minute")
                                .font(.custom("menlo", size: 10))
                                .foregroundStyle(.olive)
                        } else {
                            Text("\(viewModel.timeDuration) minutes")
                                .font(.custom("menlo", size: 10))
                                .foregroundStyle(.olive)
                        }
                    case is CategoryType:
                        Text("\(viewModel.categoryType)")
                            .font(.custom("menlo", size: 8))
                            .foregroundStyle(.olive)
                    default:
                        Text("option")
                    }
                }
                .padding(.bottom)
            }

        }
    }
}

#Preview {
    BubbleView(imageName: "bubble.fill", gameSetting: NumberOfQuestions())
        .environmentObject(GameViewModel())
}

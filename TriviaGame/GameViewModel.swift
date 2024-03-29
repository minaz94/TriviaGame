//
//  GameViewModel.swift
//  TriviaGame
//
//  Created by Mina on 3/26/24.
//

import Foundation

@MainActor
class GameViewModel: ObservableObject {
    
    @Published var answerType = AnswerType.defaultSetting
    @Published var difficulty = Difficulty.defaultSetting
    @Published var numberOfQuestions = NumberOfQuestions.defaultSetting
    @Published var timeDuration = TimeDuration.defaultSetting
    @Published var categoryType = CategoryType.defaultSetting
    
    @Published var score = 0
    @Published var fetchedTrivia: Trivia?

    func getTrivia() async throws {
        guard var url = URL(string: "https://opentdb.com/api.php?amount=\(numberOfQuestions)") else { return }
        
        if answerType != AnswerType.defaultSetting {
            let queryTypeItem = URLQueryItem(name: "type", value: answerType.mapAnswerText())
            url.append(queryItems: [queryTypeItem])
        }
        
        if difficulty != Difficulty.defaultSetting {
            let queryDiffItem = URLQueryItem(name: "difficulty", value: difficulty.lowercased())
            url.append(queryItems: [queryDiffItem])
        }
        
        if categoryType != CategoryType.defaultSetting {
            let queryCategoryItem = URLQueryItem(name: "category", value: categoryType.mapCategoryID())
            url.append(queryItems: [queryCategoryItem])
        }
                
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let trivia = try decoder.decode(Trivia.self, from: data)
 
            trivia.results.forEach { result in
                result.allAnswers = ((result.incorrectAnswers ?? []) + [result.correctAnswer ?? "Error"]).shuffled()
            }
            
            fetchedTrivia = trivia
        
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
}

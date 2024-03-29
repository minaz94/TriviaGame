//
//  Question.swift
//  TriviaGame
//
//  Created by Mina on 3/26/24.
//

import Foundation

class Trivia: Decodable {
    let results: [Result]
}

class Result: Decodable {
    let type: String?
    let difficulty: String?
    let category: String?
    let question: String?
    let correctAnswer: String?
    let incorrectAnswers: [String]?
    
    var allAnswers: [String]?
}

protocol GameSetting {
    var labelText: String { get set }
    var options: [String] { get set }
}

struct AnswerType: GameSetting {
    var labelText: String = "Answer Type"
    
    static let defaultSetting = "Any Type"
    
    var options: [String] = [
        "Any Type",
        "True/False",
        "Multiple Choice"
    ]
}

struct Difficulty: GameSetting {
    var labelText: String = "Difficulty"
    
    static let defaultSetting = "Any Difficulty"

    var options: [String] = [
        "Any Difficulty",
        "Easy",
        "Medium",
        "Hard"
    ]
}

struct CategoryType: GameSetting {
    var labelText: String = "Category"
    
    static let defaultSetting = "Any Category"

    var options: [String] = [
        "Any Category",
        "General Knowledge",
        "Entertainment: Books",
        "Entertainment: Film",
        "Entertainment: Music",
        "Entertainment: Musicals & Theatres",
        "Entertainment: Television",
        "Entertainment: Video Games",
        "Entertainment: Board Games",
        "Science & Nature",
        "Science: Computers",
        "Science: Mathematics",
        "Mythology",
        "Sports",
        "Geography",
        "History",
        "Politics",
        "Art",
        "Celebrities",
        "Animals",
        "Vehicles",
        "Entertainment: Comics",
        "Science: Gadgets",
        "Entertainment: Japanese Anime & Manga",
        "Entertainment: Cartoon & Animations"
    ]
    
}

extension String {
    
    var formatted: AttributedString {
        do {
            return try AttributedString(markdown: self)
        } catch {
            print("Error setting formattedQuestion: \(error)")
            return AttributedString(stringLiteral: self)
        }
    }
    
    func mapAnswerText() -> String {
        switch self {
        case "True/False": return "boolean"
        case "Multiple Choice": return "multiple"
        default: return self
        }
    }
    
    func mapCategoryID() -> String {
        switch self {
        case "General Knowledge": return "9"
        case "Entertainment: Books": return "10"
        case "Entertainment: Film": return "11"
        case "Entertainment: Music": return "12"
        case "Entertainment: Musicals & Theatres": return "13"
        case "Entertainment: Television": return "14"
        case "Entertainment: Video Games": return "15"
        case "Entertainment: Board Games": return "16"
        case "Science & Nature": return "17"
        case "Science: Computers": return "18"
        case "Science: Mathematics": return "19"
        case "Mythology": return "20"
        case "Sports": return "21"
        case "Geography": return "22"
        case "History": return "23"
        case "Politics": return "24"
        case "Art": return "25"
        case "Celebrities": return "26"
        case "Animals": return "27"
        case "Vehicles": return "28"
        case "Entertainment: Comics": return "29"
        case "Science: Gadgets": return "30"
        case "Entertainment: Japanese Anime & Manga": return "31"
        case "Entertainment: Cartoon & Animations": return "32"
        default: return "0"
        }
    }
}

struct TimeDuration: GameSetting {
    var labelText: String = "Time Duration"
    
    static let defaultSetting = "1"

    var options: [String] = [
        "1",
        "2",
        "3",
        "4",
        "5"
    ]
}

struct NumberOfQuestions: GameSetting {
    var labelText: String = "# of Questions"
    
    static let defaultSetting = "5"

    var options: [String] = [
        "5",
        "10",
        "15",
        "20",
        "25",
        "30",
        "35",
        "40",
        "45",
        "50"
    ]
}


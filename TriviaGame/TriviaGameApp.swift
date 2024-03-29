//
//  TriviaGameApp.swift
//  TriviaGame
//
//  Created by Mina on 3/26/24.
//

import SwiftUI

@main
struct TriviaGameApp: App {
    
    @StateObject var gameViewModel = GameViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                GameSetupView()
            }
            .environmentObject(gameViewModel)
            .navigationBarBackButtonHidden()
        }
    }
}

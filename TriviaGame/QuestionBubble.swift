//
//  QuestionBubble.swift
//  TriviaGame
//
//  Created by Mina on 3/27/24.
//

import SwiftUI

struct QuestionBubble: View {
    
    @State var screenWidth = UIScreen.main.bounds.width
    
    var questionText: String = "nfaihsbfhaef sejhfiawehfiahwef weiufhaiowuehfiawe faweifhiaweuhfoaew"
    
    var body: some View {
        ZStack {
            Image("bigBrownBubble")
                .resizable()
                .frame(width: screenWidth - 50, height: 250)
                .shadow(radius: 4)
            HStack {
                Text(questionText.formatted)
                    .font(.custom("menlo", size: 20))
                    .padding(.leading, 50)
                    .padding(.trailing, 100)
                    .lineLimit(nil)
                Spacer()
            }
        }
    }
}

#Preview {
    QuestionBubble()
}

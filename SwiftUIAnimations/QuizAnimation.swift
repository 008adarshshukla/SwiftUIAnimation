//
//  QuizAnimation.swift
//  SwiftUIAnimations
//
//  Created by Adarsh Shukla on 11/04/23.
//

import SwiftUI

struct QuizAnimation: View {
    
    @State private var question: Question = Question(question: "First Question", answers: ["first", "second", "third", "fourth"], correctAnswerIndex: 2)
    @State private var tappedIndex: Int? = nil
    @State private var isOptionSelected: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(question.question)
            Spacer()
            
            VStack {
                ForEach(0...3, id: \.self) { index in
                    HStack {
                        Text(question.answers[index])
                        Spacer()
                        if index == question.correctAnswerIndex {
                            Image(systemName: "checkmark.circle")
                                .opacity(tappedIndex == question.correctAnswerIndex || isOptionSelected ? 1 : 0)
                        }
                        else {
                            Image(systemName: "xmark.circle")
                                .opacity(tappedIndex == index ? 1 : 0)
                        }
                    }
                    .padding()
                    .background {
                        Capsule()
                            .foregroundColor(.white)
                            .shadow(radius: 5)
                    }
                    .onTapGesture {
                        tappedIndex = index
                        isOptionSelected = true
                    }
                }
            }
        }
        
    }
}

struct QuizAnimation_Previews: PreviewProvider {
    static var previews: some View {
        QuizAnimation()
    }
}

struct Question {
    let question: String
    let answers: [String]
    let correctAnswerIndex: Int
}

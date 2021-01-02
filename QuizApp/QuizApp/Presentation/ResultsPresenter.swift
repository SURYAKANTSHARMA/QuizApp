//
//  ResultPresenter.swift
//  QuizAppTests
//
//  Created by SuryaKant Sharma on 31/12/20.
//

import Foundation
import QuizEngine

struct ResultsPresenter {
    
    let result: Result<Question<String>, [String]>
    let orderQuestion: [Question<String>]
    let correctAnswers: [Question<String>: [String]]
    var title: String {
        return "Result"
    }
    var summary: String {
        "You got \(result.score)/\(result.answers.count) correct"
    }
    
    var presentableAnswers: [PresentableAnswer] {
        orderQuestion.map { question in
            guard let correctAnswer = correctAnswers[question], let userAnswer = result.answers[question] else {
                fatalError("Couldn't find correct answer for question: \(question)")
            }
            
            return presentableAnswer(question: question, userAnswer: userAnswer, correctAnswer: correctAnswer)
        }
    }
    
    private func presentableAnswer(question: Question<String>, userAnswer: [String], correctAnswer: [String]) -> PresentableAnswer {
        let wrongAnswer = correctAnswer == userAnswer ? nil : userAnswer.joined(separator: ",")
        switch question {
        case .singleAnswer(let value), .multipleAnswer(let value) :
            return PresentableAnswer(question: value, answer: formattedAnswer(correctAnswer), wrongAnswer: wrongAnswer)
        }
    }
    
    private func formattedAnswer(_ answer: [String]) -> String {
        answer.joined(separator:  ",")
    }
}

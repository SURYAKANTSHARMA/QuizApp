//
//  iOSViewControllerFactory.swift
//  QuizApp
//
//  Created by SuryaKant Sharma on 30/12/20.
//

import UIKit
import QuizEngine

class iOSViewControllerFactory: ViewControllerFactory {
        
    private let options: Dictionary<Question<String>, [String]>
    private let questions: [Question<String>]
    private let correctAnswer: Dictionary<Question<String>, [String]>
    
    init(questions: [Question<String>], options: Dictionary<Question<String>, [String]>, correctAnswer: Dictionary<Question<String>, [String]>) {
        self.questions = questions
        self.options = options
        self.correctAnswer = correctAnswer
    }
    
    func questionViewController(for question: Question<String>, answer: @escaping ([String]) -> Void) -> UIViewController {
        guard let options = self.options[question] else {
            fatalError("Couldn't find options for question: \(question)")
        }
        switch question {
        case .singleAnswer(let value):
            return questionViewController(question: question, value: value, options: options, allowMultipleSelection: false, answerCallback: answer)
            
        case .multipleAnswer(let value):
            let vc = questionViewController(question: question, value: value, options: options, allowMultipleSelection: true, answerCallback: answer)
            return vc
        }
    }
    
    private func questionViewController(question: Question<String>, value: String, options: [String], allowMultipleSelection: Bool, answerCallback: @escaping ([String]) -> Void) -> QuestionViewController {
        let controller = QuestionViewController(question: value , options: options, allowMultipleSelection: allowMultipleSelection, selection: answerCallback)
        let presenter = QuestionPresenter(questions: questions, question: question)
        controller.title = presenter.title
        return controller
    }
    
    func resultViewController(for result: Result<Question<String>, [String]>) -> UIViewController {
        let resultPresenter = ResultsPresenter(result: result, orderQuestion: questions, correctAnswers: correctAnswer)
        let controller = ResultViewController(summary: resultPresenter.summary, answers: resultPresenter.presentableAnswers)
        controller.title = resultPresenter.title
        return controller
    }
}

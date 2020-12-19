//
//  Router.swift
//  QuizEngine
//
//  Created by SuryaKant Sharma on 19/12/20.
//

import Foundation

public protocol Router {
    associatedtype Answer
    associatedtype Question: Hashable
    typealias AnswerCallback = (Answer) -> Void
    func routeTo(question: Question, answerCallback: @escaping (Answer) -> Void)
    func routeTo(result: Result<Question, Answer>)
}
